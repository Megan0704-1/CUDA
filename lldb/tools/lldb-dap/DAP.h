//===-- DAP.h ---------------------------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLDB_TOOLS_LLDB_DAP_DAP_H
#define LLDB_TOOLS_LLDB_DAP_DAP_H

#include <cstdio>
#include <iosfwd>
#include <map>
#include <optional>
#include <thread>

#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/StringMap.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/Threading.h"
#include "llvm/Support/raw_ostream.h"

#include "lldb/API/SBAttachInfo.h"
#include "lldb/API/SBCommandInterpreter.h"
#include "lldb/API/SBCommandReturnObject.h"
#include "lldb/API/SBDebugger.h"
#include "lldb/API/SBEvent.h"
#include "lldb/API/SBFormat.h"
#include "lldb/API/SBLaunchInfo.h"
#include "lldb/API/SBTarget.h"
#include "lldb/API/SBThread.h"

#include "ExceptionBreakpoint.h"
#include "FunctionBreakpoint.h"
#include "IOStream.h"
#include "InstructionBreakpoint.h"
#include "ProgressEvent.h"
#include "SourceBreakpoint.h"

#define VARREF_LOCALS (int64_t)1
#define VARREF_GLOBALS (int64_t)2
#define VARREF_REGS (int64_t)3
#define VARREF_FIRST_VAR_IDX (int64_t)4
#define NO_TYPENAME "<no-type>"

namespace lldb_dap {

typedef llvm::DenseMap<uint32_t, SourceBreakpoint> SourceBreakpointMap;
typedef llvm::StringMap<FunctionBreakpoint> FunctionBreakpointMap;
typedef llvm::DenseMap<lldb::addr_t, InstructionBreakpoint>
    InstructionBreakpointMap;

enum class OutputType { Console, Stdout, Stderr, Telemetry };

/// Buffer size for handling output events.
constexpr uint64_t OutputBufferSize = (1u << 12);

enum DAPBroadcasterBits {
  eBroadcastBitStopEventThread = 1u << 0,
  eBroadcastBitStopProgressThread = 1u << 1
};

typedef void (*RequestCallback)(DAP &dap, const llvm::json::Object &command);
typedef void (*ResponseCallback)(llvm::Expected<llvm::json::Value> value);

enum class PacketStatus {
  Success = 0,
  EndOfFile,
  JSONMalformed,
  JSONNotObject
};

enum class ReplMode { Variable = 0, Command, Auto };

struct Variables {
  /// Variable_reference start index of permanent expandable variable.
  static constexpr int64_t PermanentVariableStartIndex = (1ll << 32);

  lldb::SBValueList locals;
  lldb::SBValueList globals;
  lldb::SBValueList registers;

  int64_t next_temporary_var_ref{VARREF_FIRST_VAR_IDX};
  int64_t next_permanent_var_ref{PermanentVariableStartIndex};

  /// Variables that are alive in this stop state.
  /// Will be cleared when debuggee resumes.
  llvm::DenseMap<int64_t, lldb::SBValue> referenced_variables;
  /// Variables that persist across entire debug session.
  /// These are the variables evaluated from debug console REPL.
  llvm::DenseMap<int64_t, lldb::SBValue> referenced_permanent_variables;

  /// Check if \p var_ref points to a variable that should persist for the
  /// entire duration of the debug session, e.g. repl expandable variables
  static bool IsPermanentVariableReference(int64_t var_ref);

  /// \return a new variableReference.
  /// Specify is_permanent as true for variable that should persist entire
  /// debug session.
  int64_t GetNewVariableReference(bool is_permanent);

  /// \return the expandable variable corresponding with variableReference
  /// value of \p value.
  /// If \p var_ref is invalid an empty SBValue is returned.
  lldb::SBValue GetVariable(int64_t var_ref) const;

  /// Insert a new \p variable.
  /// \return variableReference assigned to this expandable variable.
  int64_t InsertVariable(lldb::SBValue variable, bool is_permanent);

  /// Clear all scope variables and non-permanent expandable variables.
  void Clear();
};

struct StartDebuggingRequestHandler : public lldb::SBCommandPluginInterface {
  DAP &dap;
  explicit StartDebuggingRequestHandler(DAP &d) : dap(d) {};
  bool DoExecute(lldb::SBDebugger debugger, char **command,
                 lldb::SBCommandReturnObject &result) override;
};

struct ReplModeRequestHandler : public lldb::SBCommandPluginInterface {
  DAP &dap;
  explicit ReplModeRequestHandler(DAP &d) : dap(d) {};
  bool DoExecute(lldb::SBDebugger debugger, char **command,
                 lldb::SBCommandReturnObject &result) override;
};

struct SendEventRequestHandler : public lldb::SBCommandPluginInterface {
  DAP &dap;
  explicit SendEventRequestHandler(DAP &d) : dap(d) {};
  bool DoExecute(lldb::SBDebugger debugger, char **command,
                 lldb::SBCommandReturnObject &result) override;
};

struct DAP {
  llvm::StringRef debug_adaptor_path;
  InputStream input;
  OutputStream output;
  lldb::SBDebugger debugger;
  lldb::SBTarget target;
  Variables variables;
  lldb::SBBroadcaster broadcaster;
  std::thread event_thread;
  std::thread progress_event_thread;
  std::unique_ptr<std::ofstream> log;
  llvm::StringMap<SourceBreakpointMap> source_breakpoints;
  FunctionBreakpointMap function_breakpoints;
  InstructionBreakpointMap instruction_breakpoints;
  std::optional<std::vector<ExceptionBreakpoint>> exception_breakpoints;
  llvm::once_flag init_exception_breakpoints_flag;
  std::vector<std::string> pre_init_commands;
  std::vector<std::string> init_commands;
  std::vector<std::string> pre_run_commands;
  std::vector<std::string> post_run_commands;
  std::vector<std::string> exit_commands;
  std::vector<std::string> stop_commands;
  std::vector<std::string> terminate_commands;
  // Map step in target id to list of function targets that user can choose.
  llvm::DenseMap<lldb::addr_t, std::string> step_in_targets;
  // A copy of the last LaunchRequest or AttachRequest so we can reuse its
  // arguments if we get a RestartRequest.
  std::optional<llvm::json::Object> last_launch_or_attach_request;
  lldb::tid_t focus_tid;
  bool disconnecting = false;
  llvm::once_flag terminated_event_flag;
  bool stop_at_entry;
  bool is_attach;
  bool enable_auto_variable_summaries;
  bool enable_synthetic_child_debugging;
  bool display_extended_backtrace;
  // The process event thread normally responds to process exited events by
  // shutting down the entire adapter. When we're restarting, we keep the id of
  // the old process here so we can detect this case and keep running.
  lldb::pid_t restarting_process_id;
  bool configuration_done_sent;
  std::map<std::string, RequestCallback, std::less<>> request_handlers;
  bool waiting_for_run_in_terminal;
  ProgressEventReporter progress_event_reporter;
  // Keep track of the last stop thread index IDs as threads won't go away
  // unless we send a "thread" event to indicate the thread exited.
  llvm::DenseSet<lldb::tid_t> thread_ids;
  uint32_t reverse_request_seq;
  std::mutex call_mutex;
  std::map<int /* request_seq */, ResponseCallback /* reply handler */>
      inflight_reverse_requests;
  ReplMode repl_mode;
  std::string command_escape_prefix = "`";
  lldb::SBFormat frame_format;
  lldb::SBFormat thread_format;
  // This is used to allow request_evaluate to handle empty expressions
  // (ie the user pressed 'return' and expects the previous expression to
  // repeat). If the previous expression was a command, this string will be
  // empty; if the previous expression was a variable expression, this string
  // will contain that expression.
  std::string last_nonempty_var_expression;

  DAP(llvm::StringRef path, ReplMode repl_mode);
  ~DAP();
  DAP(const DAP &rhs) = delete;
  void operator=(const DAP &rhs) = delete;
  ExceptionBreakpoint *GetExceptionBreakpoint(const std::string &filter);
  ExceptionBreakpoint *GetExceptionBreakpoint(const lldb::break_id_t bp_id);

  // Serialize the JSON value into a string and send the JSON packet to
  // the "out" stream.
  void SendJSON(const llvm::json::Value &json);

  std::string ReadJSON();

  void SendOutput(OutputType o, const llvm::StringRef output);

  void SendProgressEvent(uint64_t progress_id, const char *message,
                         uint64_t completed, uint64_t total);

  void __attribute__((format(printf, 3, 4)))
  SendFormattedOutput(OutputType o, const char *format, ...);

  static int64_t GetNextSourceReference();

  ExceptionBreakpoint *GetExceptionBPFromStopReason(lldb::SBThread &thread);

  lldb::SBThread GetLLDBThread(const llvm::json::Object &arguments);

  lldb::SBFrame GetLLDBFrame(const llvm::json::Object &arguments);

  llvm::json::Value CreateTopLevelScopes();

  void PopulateExceptionBreakpoints();

  /// Attempt to determine if an expression is a variable expression or
  /// lldb command using a heuristic based on the first term of the
  /// expression.
  ///
  /// \param[in] frame
  ///     The frame, used as context to detect local variable names
  /// \param[inout] expression
  ///     The expression string. Might be modified by this function to
  ///     remove the leading escape character.
  /// \param[in] partial_expression
  ///     Whether the provided `expression` is only a prefix of the
  ///     final expression. If `true`, this function might return
  ///     `ReplMode::Auto` to indicate that the expression could be
  ///     either an expression or a statement, depending on the rest of
  ///     the expression.
  /// \return the expression mode
  ReplMode DetectReplMode(lldb::SBFrame frame, std::string &expression,
                          bool partial_expression);

  /// \return
  ///   \b false if a fatal error was found while executing these commands,
  ///   according to the rules of \a LLDBUtils::RunLLDBCommands.
  bool RunLLDBCommands(llvm::StringRef prefix,
                       llvm::ArrayRef<std::string> commands);

  llvm::Error RunAttachCommands(llvm::ArrayRef<std::string> attach_commands);
  llvm::Error RunLaunchCommands(llvm::ArrayRef<std::string> launch_commands);
  llvm::Error RunPreInitCommands();
  llvm::Error RunInitCommands();
  llvm::Error RunPreRunCommands();
  void RunPostRunCommands();
  void RunStopCommands();
  void RunExitCommands();
  void RunTerminateCommands();

  /// Create a new SBTarget object from the given request arguments.
  /// \param[in] arguments
  ///     Launch configuration arguments.
  ///
  /// \param[out] error
  ///     An SBError object that will contain an error description if
  ///     function failed to create the target.
  ///
  /// \return
  ///     An SBTarget object.
  lldb::SBTarget CreateTargetFromArguments(const llvm::json::Object &arguments,
                                           lldb::SBError &error);

  /// Set given target object as a current target for lldb-dap and start
  /// listeing for its breakpoint events.
  void SetTarget(const lldb::SBTarget target);

  const std::map<std::string, RequestCallback> &GetRequestHandlers();

  PacketStatus GetNextObject(llvm::json::Object &object);
  bool HandleObject(const llvm::json::Object &object);

  llvm::Error Loop();

  /// Send a Debug Adapter Protocol reverse request to the IDE.
  ///
  /// \param[in] command
  ///   The reverse request command.
  ///
  /// \param[in] arguments
  ///   The reverse request arguements.
  ///
  /// \param[in] callback
  ///   A callback to execute when the response arrives.
  void SendReverseRequest(llvm::StringRef command, llvm::json::Value arguments,
                          ResponseCallback callback);

  /// Registers a callback handler for a Debug Adapter Protocol request
  ///
  /// \param[in] request
  ///     The name of the request following the Debug Adapter Protocol
  ///     specification.
  ///
  /// \param[in] callback
  ///     The callback to execute when the given request is triggered by the
  ///     IDE.
  void RegisterRequestCallback(std::string request, RequestCallback callback);

  /// Debuggee will continue from stopped state.
  void WillContinue() { variables.Clear(); }

  /// Poll the process to wait for it to reach the eStateStopped state.
  ///
  /// Wait for the process hit a stopped state. When running a launch with
  /// "launchCommands", or attach with  "attachCommands", the calls might take
  /// some time to stop at the entry point since the command is asynchronous. We
  /// need to sync up with the process and make sure it is stopped before we
  /// proceed to do anything else as we will soon be asked to set breakpoints
  /// and other things that require the process to be stopped. We must use
  /// polling because "attachCommands" or "launchCommands" may or may not send
  /// process state change events depending on if the user modifies the async
  /// setting in the debugger. Since both "attachCommands" and "launchCommands"
  /// could end up using any combination of LLDB commands, we must ensure we can
  /// also catch when the process stops, so we must poll the process to make
  /// sure we handle all cases.
  ///
  /// \param[in] seconds
  ///   The number of seconds to poll the process to wait until it is stopped.
  ///
  /// \return Error if waiting for the process fails, no error if succeeds.
  lldb::SBError WaitForProcessToStop(uint32_t seconds);

  void SetFrameFormat(llvm::StringRef format);

  void SetThreadFormat(llvm::StringRef format);

  InstructionBreakpoint *GetInstructionBreakpoint(const lldb::break_id_t bp_id);

  InstructionBreakpoint *GetInstructionBPFromStopReason(lldb::SBThread &thread);

private:
  // Send the JSON in "json_str" to the "out" stream. Correctly send the
  // "Content-Length:" field followed by the length, followed by the raw
  // JSON bytes.
  void SendJSON(const std::string &json_str);
};

} // namespace lldb_dap

#endif