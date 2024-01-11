#ifndef __glut_h__
#define __glut_h__

/* Copyright (c) Mark J. Kilgard, 1994, 1995, 1996, 1998. */

/* This program is freely distributable without licensing fees  and is
 *    provided without guarantee or warrantee expressed or  implied. This
 *       program is -not- in the public domain. */

#if defined(_WIN32)

/* GLUT 3.7 now tries to avoid including <windows.h>
 *    to avoid name space pollution, but Win32's <GL/gl.h> 
 *       needs APIENTRY and WINGDIAPI defined properly. */
# if 0
   /* This would put tons of macros and crap in our clean name space. */
#  define  WIN32_LEAN_AND_MEAN
#  include <windows.h>
# else
   /* XXX This is from Win32's <windef.h> */
#  ifndef APIENTRY
#   define GLUT_APIENTRY_DEFINED
#   if (_MSC_VER >= 800) || defined(_STDCALL_SUPPORTED) || defined(__BORLANDC__) || defined(__LCC__)
#    define APIENTRY    __stdcall
#   else
#    define APIENTRY
#   endif
#  endif
   /* XXX This is from Win32's <winnt.h> */
#  ifndef CALLBACK
#   if (defined(_M_MRX000) || defined(_M_IX86) || defined(_M_ALPHA) || defined(_M_PPC)) && !defined(MIDL_PASS) || defined(__LCC__)
#    define CALLBACK __stdcall
#   else
#    define CALLBACK
#   endif
#  endif
   /* XXX Hack for lcc compiler.  It doesn't support __declspec(dllimport), just __stdcall. */
#  if defined( __LCC__  )
#   undef WINGDIAPI
#   define WINGDIAPI __stdcall
#  else
   /* XXX This is from Win32's <wingdi.h> and <winnt.h> */
#   ifndef WINGDIAPI
#    define GLUT_WINGDIAPI_DEFINED
#    define WINGDIAPI __declspec(dllimport)
#   endif
#  endif
   /* XXX This is from Win32's <ctype.h> */
#  ifndef _WCHAR_T_DEFINED
typedef unsigned short wchar_t;
#   define _WCHAR_T_DEFINED
#  endif
# endif

/* To disable automatic library usage for GLUT, define GLUT_NO_LIB_PRAGMA
 *    in your compile preprocessor options. */
# if !defined(GLUT_BUILDING_LIB) && !defined(GLUT_NO_LIB_PRAGMA)
#  pragma comment (lib, "winmm.lib")      /* link with Windows MultiMedia lib */
/* To enable automatic SGI OpenGL for Windows library usage for GLUT,
 *    define GLUT_USE_SGI_OPENGL in your compile preprocessor options.  */
#  ifdef GLUT_USE_SGI_OPENGL
#   pragma comment (lib, "opengl.lib")    /* link with SGI OpenGL for Windows lib */
#   pragma comment (lib, "glu.lib")       /* link with SGI OpenGL Utility lib */
#   pragma comment (lib, "glut.lib")      /* link with Win32 GLUT for SGI OpenGL lib */
#  else
#   pragma comment (lib, "opengl32.lib")  /* link with Microsoft OpenGL lib */
#   pragma comment (lib, "glu32.lib")     /* link with Microsoft OpenGL Utility lib */
#   pragma comment (lib, "glut32.lib")    /* link with Win32 GLUT lib */
#  endif
# endif

/* To disable supression of annoying warnings about floats being promoted
 *    to doubles, define GLUT_NO_WARNING_DISABLE in your compile preprocessor
 *       options. */
# ifndef GLUT_NO_WARNING_DISABLE
#  pragma warning (disable:4244)  /* Disable bogus VC++ 4.2 conversion warnings. */
#  pragma warning (disable:4305)  /* VC++ 5.0 version of above warning. */
# endif

/* Win32 has an annoying issue where there are multiple C run-time
 *    libraries (CRTs).  If the executable is linked with a different CRT
 *       from the GLUT DLL, the GLUT DLL will not share the same CRT static
 *          data seen by the executable.  In particular, atexit callbacks registered
 *             in the executable will not be called if GLUT calls its (different)
 *                exit routine).  GLUT is typically built with the
 *                   "/MD" option (the CRT with multithreading DLL support), but the Visual
 *                      C++ linker default is "/ML" (the single threaded CRT).
 *
 *                         One workaround to this issue is requiring users to always link with
 *                            the same CRT as GLUT is compiled with.  That requires users supply a
 *                               non-standard option.  GLUT 3.7 has its own built-in workaround where
 *                                  the executable's "exit" function pointer is covertly passed to GLUT.
 *                                     GLUT then calls the executable's exit function pointer to ensure that
 *                                        any "atexit" calls registered by the application are called if GLUT
 *                                           needs to exit.
 *
 *                                              Note that the __glut*WithExit routines should NEVER be called directly.
 *                                                 To avoid the atexit workaround, #define GLUT_DISABLE_ATEXIT_HACK. */

/* XXX This is from Win32's <process.h> */
# if !defined(_MSC_VER) && !defined(__cdecl)
   /* Define __cdecl for non-Microsoft compilers. */
#  define __cdecl
#  define GLUT_DEFINED___CDECL
# endif
# ifndef _CRTIMP
#  ifdef _NTSDK
    /* Definition compatible with NT SDK */
#   define _CRTIMP
#  else
    /* Current definition */
#   ifdef _DLL
#    define _CRTIMP __declspec(dllimport)
#   else
#    define _CRTIMP
#   endif
#  endif
#  define GLUT_DEFINED__CRTIMP
# endif

/* GLUT API entry point declarations for Win32. */
# ifdef GLUT_BUILDING_LIB
#  define GLUTAPI __declspec(dllexport)
# else
#  ifdef _DLL
#   define GLUTAPI __declspec(dllimport)
#  else
#   define GLUTAPI extern
#  endif
# endif

/* GLUT callback calling convention for Win32. */
# define GLUTCALLBACK __cdecl

#endif  /* _WIN32 */

#include <GL/gl.h>
#include <GL/glu.h>

#ifdef __cplusplus
extern "C" {
#endif

#if defined(_WIN32)
# ifndef GLUT_BUILDING_LIB
    extern _CRTIMP void __cdecl exit(int);
# endif
#else
    /* non-Win32 case. */
    /* Define APIENTRY and CALLBACK to nothing if we aren't on Win32. */
# define APIENTRY
# define GLUT_APIENTRY_DEFINED
# define CALLBACK
    /* Define GLUTAPI and GLUTCALLBACK as below if we aren't on Win32. */
# define GLUTAPI extern
# define GLUTCALLBACK
    /* Prototype exit for the non-Win32 case (see above). */
    extern void exit(int);
#endif

    /**
     *  GLUT API revision history:
     *   
     *    GLUT_API_VERSION is updated to reflect incompatible GLUT
     *     API changes (interface changes, semantic changes, deletions,
     *      or additions).
     *       
     *        GLUT_API_VERSION=1  First public release of GLUT.  11/29/94
     *
     *         GLUT_API_VERSION=2  Added support for OpenGL/GLX multisampling,
     *          extension.  Supports new input devices like tablet, dial and button
     *           box, and Spaceball.  Easy to query OpenGL extensions.
     *
     *            GLUT_API_VERSION=3  glutMenuStatus added.
     *
     *             GLUT_API_VERSION=4  glutInitDisplayString, glutWarpPointer,
     *              glutBitmapLength, glutStrokeLength, glutWindowStatusFunc, dynamic
     *               video resize subAPI, glutPostWindowRedisplay, glutKeyboardUpFunc,
     *                glutSpecialUpFunc, glutIgnoreKeyRepeat, glutSetKeyRepeat,
     *                 glutJoystickFunc, glutForceJoystickFunc (NOT FINALIZED!).
     *                 **/
#ifndef GLUT_API_VERSION  /* allow this to be overriden */
#define GLUT_API_VERSION3
#endif

    /**     
     *  GLUT implementation revision history:
     *   
     *    GLUT_XLIB_IMPLEMENTATION is updated to reflect both GLUT
     *     API revisions and implementation revisions (ie, bug fixes).
     *
     *      GLUT_XLIB_IMPLEMENTATION=1  mjk's first public release of
     *       GLUT Xlib-based implementation.  11/29/94
     *
     *        GLUT_XLIB_IMPLEMENTATION=2  mjk's second public release of
     *         GLUT Xlib-based implementation providing GLUT version 2 
     *          interfaces.
     *
     *           GLUT_XLIB_IMPLEMENTATION=3  mjk's GLUT 2.2 images. 4/17/95
     *
     *            GLUT_XLIB_IMPLEMENTATION=4  mjk's GLUT 2.3 images. 6/?/95
     *
     *             GLUT_XLIB_IMPLEMENTATION=5  mjk's GLUT 3.0 images. 10/?/95
     *
     *              GLUT_XLIB_IMPLEMENTATION=7  mjk's GLUT 3.1+ with glutWarpPoitner.  7/24/96
     *
     *               GLUT_XLIB_IMPLEMENTATION=8  mjk's GLUT 3.1+ with glutWarpPoitner
     *                and video resize.  1/3/97
     *
     *                 GLUT_XLIB_IMPLEMENTATION=9 mjk's GLUT 3.4 release with early GLUT 4 routines.
     *
     *                  GLUT_XLIB_IMPLEMENTATION=11 Mesa 2.5's GLUT 3.6 release.
     *
     *                   GLUT_XLIB_IMPLEMENTATION=12 mjk's GLUT 3.6 release with early GLUT 4 routines + signal handling.
     *
     *                    GLUT_XLIB_IMPLEMENTATION=13 mjk's GLUT 3.7 beta with GameGLUT support.
     *
     *                     GLUT_XLIB_IMPLEMENTATION=14 mjk's GLUT 3.7 beta with f90gl friend interface.
     *
     *                      GLUT_XLIB_IMPLEMENTATION=15 mjk's GLUT 3.7 beta sync'ed with Mesa <GL/glut.h>
     *                      **/
#ifndef GLUT_XLIB_IMPLEMENTATION  /* Allow this to be overriden. */
#define GLUT_XLIB_IMPLEMENTATION15
#endif

    /* Display mode bit masks. */
#define GLUT_RGB0
#define G               LUT_RGBAGLUT_RGB
#define GLUT_INDEX1
#define GLUT_SINGLE0
#def                                    ine GLUT_DOUBLE2
#define GLUT_ACCUM4
#define GLUT_ALPHA8
#defi                                   ne GLUT_DEPTH16
#define GLUT_STENCIL32
#if (GLUT_API_VERSION >= 2                      )
#define GLUT_MULTISAMPLE128
#define GLUT_STEREO256
#endif
#if (G                  LUT_API_VERSION >= 3)
#define GLUT_LUMINANCE512
#endif

    /* Mouse but            tons. */
#define GLUT_LEFT_BUTTON0
#define GLUT_MIDDLE_BUTTON1
#def                ine GLUT_RIGHT_BUTTON2

    /* Mouse button  state. */
#define GLUT_DOWN                   0
#define GLUT_UP1

#if (GLUT_API_VERSION >= 2)
    /* function keys                */
#define GLUT_KEY_F11
#define GLUT_KEY_F22
#define GLUT_KEY_F3                                 3
#define GLUT_KEY_F44
#define GLUT_KEY_F55
#define GLUT_KEY_F6                                 6
#define GLUT_KEY_F77
#define GLUT_KEY_F88
#define GLUT_KEY_F                      99
#define GLUT_KEY_F1010
#define GLUT_KEY_F1111
#define GLUT_                                   KEY_F1212
    /* directional keys */
#define GLUT_KEY_LEFT100
#define                      GLUT_KEY_UP101
#define GLUT_KEY_RIGHT102
#define GLUT_KEY_DOWN                                   103
#define GLUT_KEY_PAGE_UP104
#define GLUT_KEY_PAGE_DOWN105
#def                ine GLUT_KEY_HOME106
#define GLUT_KEY_END107
#define GLUT_KEY_INS                        ERT108
#endif

    /* Entry/exit  state. */
#define GLUT_LEFT0
#defin                      e GLUT_ENTERED1

    /* Menu usage  state. */
#define GLUT_MENU_NOT_IN_U          SE0
#define GLUT_MENU_IN_USE1

    /* Visibility  state. */
#define GLU             T_NOT_VISIBLE0
#define GLUT_VISIBLE1

    /* Window status  state. */
                        #define GLUT_HIDDEN0
#define GLUT_FULLY_RETAINED1
#define GLUT_PAR                    TIALLY_RETAINED2
#define GLUT_FULLY_COVERED3

    /* Color index compon               ent selection values. */
#define GLUT_RED0
#define GLUT_GREEN1
#d                      efine GLUT_BLUE2

#if defined(_WIN32)
    /* Stroke font constants (use           these in GLUT program). */
#define GLUT_STROKE_ROMAN((void*)0)
#defin      e GLUT_STROKE_MONO_ROMAN((void*)1)

    /* Bitmap font constants (use the       se in GLUT program). */
#define GLUT_BITMAP_9_BY_15((void*)2)
#define      GLUT_BITMAP_8_BY_13((void*)3)
#define GLUT_BITMAP_TIMES_ROMAN_10((v           oid*)4)
#define GLUT_BITMAP_TIMES_ROMAN_24((void*)5)
#if (GLUT_API_VER   SION >= 3)
#define GLUT_BITMAP_HELVETICA_10((void*)6)
#define GLUT_BIT    MAP_HELVETICA_12((void*)7)
#define GLUT_BITMAP_HELVETICA_18((void*)8)      
#endif
#else
    /* Stroke font opaque addresses (use constants instead in source code). */
    GLUTAPI void *glutStrokeRoman;
    GLUTAPI void *glutStrokeMonoRoman;

    /* Stroke font constants (use these in GLUT program). */
#define GLUT_STROKE_ROMAN(&glutStrokeRoman)
#define GLUT_       STROKE_MONO_ROMAN(&glutStrokeMonoRoman)

    /* Bitmap font opaque addres        ses (use constants instead in source code). */
    GLUTAPI void *glutBitmap9By15;
    GLUTAPI void *glutBitmap8By13;
    GLUTAPI void *glutBitmapTimesRoman10;
    GLUTAPI void *glutBitmapTimesRoman24;
    GLUTAPI void *glutBitmapHelvetica10;
    GLUTAPI void *glutBitmapHelvetica12;
    GLUTAPI void *glutBitmapHelvetica18;

    /* Bitmap font constants (use these in GLUT program). */
#define GLUT_BITMAP_9_BY_15(&glutBitmap9By15)
#define GLUT_BITMAP_8_BY_       13(&glutBitmap8By13)
#define GLUT_BITMAP_TIMES_ROMAN_10(&glutBitmapT         imesRoman10)
#define GLUT_BITMAP_TIMES_ROMAN_24(&glutBitmapTimesRoman2   4)
#if (GLUT_API_VERSION >= 3)
#define GLUT_BITMAP_HELVETICA_10(&glutB itmapHelvetica10)
#define GLUT_BITMAP_HELVETICA_12(&glutBitmapHelvetic    a12)
#define GLUT_BITMAP_HELVETICA_18(&glutBitmapHelvetica18)
#endif
#   endif

    /* glutGet parameters. */
#define GLUT_WINDOW_X((GLenum) 100)         
#define GLUT_WINDOW_Y((GLenum) 101)
#define GLUT_WINDOW_WIDTH((GL                   enum) 102)
#define GLUT_WINDOW_HEIGHT((GLenum) 103)
#define GLUT_WIND       OW_BUFFER_SIZE((GLenum) 104)
#define GLUT_WINDOW_STENCIL_SIZE((GLenu         m) 105)
#define GLUT_WINDOW_DEPTH_SIZE((GLenum) 106)
#define GLUT_WIN        DOW_RED_SIZE((GLenum) 107)
#define GLUT_WINDOW_GREEN_SIZE((GLenum)                 108)
#define GLUT_WINDOW_BLUE_SIZE((GLenum) 109)
#define GLUT_WINDOW_        ALPHA_SIZE((GLenum) 110)
#define GLUT_WINDOW_ACCUM_RED_SIZE((GLenum)          111)
#define GLUT_WINDOW_ACCUM_GREEN_SIZE((GLenum) 112)
#define GLUT_   WINDOW_ACCUM_BLUE_SIZE((GLenum) 113)
#define GLUT_WINDOW_ACCUM_ALPHA_S   IZE((GLenum) 114)
#define GLUT_WINDOW_DOUBLEBUFFER((GLenum) 115)
#def        ine GLUT_WINDOW_RGBA((GLenum) 116)
#define GLUT_WINDOW_PARENT((GLen                um) 117)
#define GLUT_WINDOW_NUM_CHILDREN((GLenum) 118)
#define GLUT_W  INDOW_COLORMAP_SIZE((GLenum) 119)
#if (GLUT_API_VERSION >= 2)
#define     GLUT_WINDOW_NUM_SAMPLES((GLenum) 120)
#define GLUT_WINDOW_STEREO((G               Lenum) 121)
#endif
#if (GLUT_API_VERSION >= 3)
#define GLUT_WINDOW_CURSOR((GLenum) 122)
#endif
#define GLUT_SCREEN_WIDTH((GLenum) 200)
#defi               ne GLUT_SCREEN_HEIGHT((GLenum) 201)
#define GLUT_SCREEN_WIDTH_MM((G             Lenum) 202)
#define GLUT_SCREEN_HEIGHT_MM((GLenum) 203)
#define GLUT_       MENU_NUM_ITEMS((GLenum) 300)
#define GLUT_DISPLAY_MODE_POSSIBLE((GLe         num) 400)
#define GLUT_INIT_WINDOW_X((GLenum) 500)
#define GLUT_INIT_      WINDOW_Y((GLenum) 501)
#define GLUT_INIT_WINDOW_WIDTH((GLenum) 502)                
#define GLUT_INIT_WINDOW_HEIGHT((GLenum) 503)
#define GLUT_INIT_DISP      LAY_MODE((GLenum) 504)
#if (GLUT_API_VERSION >= 2)
#define GLUT_ELAPS      ED_TIME((GLenum) 700)
#endif
#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_        IMPLEMENTATION >= 13)
#define GLUT_WINDOW_FORMAT_ID((GLenum) 123)
#en     dif

#if (GLUT_API_VERSION >= 2)
    /* glutDeviceGet parameters. */
#define GLUT_HAS_KEYBOARD((GLenum) 600)
#define GLUT_HAS_MOUSE((GLenum) 601)
#                   define GLUT_HAS_SPACEBALL((GLenum) 602)
#define GLUT_HAS_DIAL_AND_BUT       TON_BOX((GLenum) 603)
#define GLUT_HAS_TABLET((GLenum) 604)
#define              GLUT_NUM_MOUSE_BUTTONS((GLenum) 605)
#define GLUT_NUM_SPACEBALL_BUTT     ONS((GLenum) 606)
#define GLUT_NUM_BUTTON_BOX_BUTTONS((GLenum) 607)
#       define GLUT_NUM_DIALS((GLenum) 608)
#define GLUT_NUM_TABLET_BUTTONS                 ((GLenum) 609)
#endif
#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 13)
#define GLUT_DEVICE_IGNORE_KEY_REPEAT   ((GLenum) 610)
#define GLUT_DEVICE_KEY_REPEAT          ((GLenum) 611)
#define GLUT_HAS_JOYSTICK((GLenum) 612)
#define GLUT_OWNS_JOYSTICK((GLenum) 613)
#define              GLUT_JOYSTICK_BUTTONS((GLenum) 614)
#define GLUT_JOYSTICK_AXES((GL              enum) 615)
#define GLUT_JOYSTICK_POLL_RATE((GLenum) 616)
#endif

#if         (GLUT_API_VERSION >= 3)
    /* glutLayerGet parameters. */
#define GLUT_OVERLAY_POSSIBLE           ((GLenum) 800)
#define GLUT_LAYER_IN_USE((GLenum) 801)     
#define GLUT_HAS_OVERLAY((GLenum) 802)
#define GLUT_TRANSPARENT_INDE       X((GLenum) 803)
#define GLUT_NORMAL_DAMAGED((GLenum) 804)
#define G               LUT_OVERLAY_DAMAGED((GLenum) 805)

#if (GLUT_API_VERSION >= 4 || GLUT      _XLIB_IMPLEMENTATION >= 9)
    /* glutVideoResizeGet parameters. */
#define GLUT_VIDEO_RESIZE_POSSIBLE((GLenum) 900)
#define GLUT_VIDEO_RESIZE_IN_USE((GLenum) 90        1)
#define GLUT_VIDEO_RESIZE_X_DELTA((GLenum) 902)
#define GLUT_VIDEO_ RESIZE_Y_DELTA((GLenum) 903)
#define GLUT_VIDEO_RESIZE_WIDTH_DELTA((G        Lenum) 904)
#define GLUT_VIDEO_RESIZE_HEIGHT_DELTA((GLenum) 905)
#defi   ne GLUT_VIDEO_RESIZE_X((GLenum) 906)
#define GLUT_VIDEO_RESIZE_Y((G              Lenum) 907)
#define GLUT_VIDEO_RESIZE_WIDTH((GLenum) 908)
#define GLU     T_VIDEO_RESIZE_HEIGHT((GLenum) 909)
#endif

    /* glutUseLayer parameters  . */
#define GLUT_NORMAL((GLenum) 0)
#define GLUT_OVERLAY((GLenum                        ) 1)

    /* glutGetModifiers return mask. */
#define GLUT_ACTIVE_SHIFT               1
#define GLUT_ACTIVE_CTRL                2
#define GLUT_ACTIVE_ALT                 4

    /* glutSetCursor parameters. */
    /* Basic arrows. */
#define GLUT_CURSOR_RIGHT_ARROW0
#define GLUT_CURSOR     _LEFT_ARROW1
    /* Symbolic cursor shapes. */
#define GLUT_CURSOR_INFO                2
#define GLUT_CURSOR_DESTROY3
#define GLUT_CURSOR_HELP4
#define GL              UT_CURSOR_CYCLE5
#define GLUT_CURSOR_SPRAY6
#define GLUT_CURSOR_WAI             T7
#define GLUT_CURSOR_TEXT8
#define GLUT_CURSOR_CROSSHAIR9
    /* Di                       rectional cursors. */
#define GLUT_CURSOR_UP_DOWN10
#define GLUT_CURS       OR_LEFT_RIGHT11
    /* Sizing cursors. */
#define GLUT_CURSOR_TOP_SIDE1               2
#define GLUT_CURSOR_BOTTOM_SIDE13
#define GLUT_CURSOR_LEFT_SIDE14             
#define GLUT_CURSOR_RIGHT_SIDE15
#define GLUT_CURSOR_TOP_LEFT_CORNER         16
#define GLUT_CURSOR_TOP_RIGHT_CORNER17
#define GLUT_CURSOR_BOTTOM_ RIGHT_CORNER18
#define GLUT_CURSOR_BOTTOM_LEFT_CORNER19
    /* Inherit fr       om parent window. */
#define GLUT_CURSOR_INHERIT100
    /* Blank cursor.        */
#define GLUT_CURSOR_NONE101
    /* Fullscreen crosshair (if available)      . */
#define GLUT_CURSOR_FULL_CROSSHAIR102
#endif

    /* GLUT initializat ion sub-API. */
    GLUTAPI void APIENTRY glutInit(int *argcp, char **argv);
#if defined(_WIN32) && !defined(GLUT_DISABLE_ATEXIT_HACK)
    GLUTAPI void APIENTRY __glutInitWithExit(int *argcp, char **argv, void (__cdecl *exitfunc)(int));
#ifndef GLUT_BUILDING_LIB
    static void APIENTRY glutInit_ATEXIT_HACK(int *argcp, char **argv) { __glutInitWithExit(argcp, argv, exit);  }
#define glutInit glutInit_ATEXIT_HACK
#endif
#endif
    GLUTAPI void APIENTRY glutInitDisplayMode(unsigned int mode);
#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 9)
    GLUTAPI void APIENTRY glutInitDisplayString(const char *string);
#endif
    GLUTAPI void APIENTRY glutInitWindowPosition(int x, int y);
    GLUTAPI void APIENTRY glutInitWindowSize(int width, int height);
    GLUTAPI void APIENTRY glutMainLoop(void);

    /* GLUT window sub-API. */
    GLUTAPI int APIENTRY glutCreateWindow(const char *title);
#if defined(_WIN32) && !defined(GLUT_DISABLE_ATEXIT_HACK)
    GLUTAPI int APIENTRY __glutCreateWindowWithExit(const char *title, void (__cdecl *exitfunc)(int));
#ifndef GLUT_BUILDING_LIB
    static int APIENTRY glutCreateWindow_ATEXIT_HACK(const char *title) { return __glutCreateWindowWithExit(title, exit);  }
#define glutCreateWindow glutCreateWindow_ATEXIT_HACK
#endif
#endif
    GLUTAPI int APIENTRY glutCreateSubWindow(int win, int x, int y, int width, int height);
    GLUTAPI void APIENTRY glutDestroyWindow(int win);
    GLUTAPI void APIENTRY glutPostRedisplay(void);
#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 11)
    GLUTAPI void APIENTRY glutPostWindowRedisplay(int win);
#endif
    GLUTAPI void APIENTRY glutSwapBuffers(void);
    GLUTAPI int APIENTRY glutGetWindow(void);
    GLUTAPI void APIENTRY glutSetWindow(int win);
    GLUTAPI void APIENTRY glutSetWindowTitle(const char *title);
    GLUTAPI void APIENTRY glutSetIconTitle(const char *title);
    GLUTAPI void APIENTRY glutPositionWindow(int x, int y);
    GLUTAPI void APIENTRY glutReshapeWindow(int width, int height);
    GLUTAPI void APIENTRY glutPopWindow(void);
    GLUTAPI void APIENTRY glutPushWindow(void);
    GLUTAPI void APIENTRY glutIconifyWindow(void);
    GLUTAPI void APIENTRY glutShowWindow(void);
    GLUTAPI void APIENTRY glutHideWindow(void);
#if (GLUT_API_VERSION >= 3)
    GLUTAPI void APIENTRY glutFullScreen(void);
    GLUTAPI void APIENTRY glutSetCursor(int cursor);
#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 9)
    GLUTAPI void APIENTRY glutWarpPointer(int x, int y);
#endif

    /* GLUT overlay sub-API. */
    GLUTAPI void APIENTRY glutEstablishOverlay(void);
    GLUTAPI void APIENTRY glutRemoveOverlay(void);
    GLUTAPI void APIENTRY glutUseLayer(GLenum layer);
    GLUTAPI void APIENTRY glutPostOverlayRedisplay(void);
#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 11)
    GLUTAPI void APIENTRY glutPostWindowOverlayRedisplay(int win);
#endif
    GLUTAPI void APIENTRY glutShowOverlay(void);
    GLUTAPI void APIENTRY glutHideOverlay(void);
#endif

    /* GLUT menu sub-API. */
    GLUTAPI int APIENTRY glutCreateMenu(void (GLUTCALLBACK *func)(int));
#if defined(_WIN32) && !defined(GLUT_DISABLE_ATEXIT_HACK)
    GLUTAPI int APIENTRY __glutCreateMenuWithExit(void (GLUTCALLBACK *func)(int), void (__cdecl *exitfunc)(int));
#ifndef GLUT_BUILDING_LIB
    static int APIENTRY glutCreateMenu_ATEXIT_HACK(void (GLUTCALLBACK *func)(int)) { return __glutCreateMenuWithExit(func, exit);  }
#define glutCreateMenu glutCreateMenu_ATEXIT_HACK
#endif
#endif
    GLUTAPI void APIENTRY glutDestroyMenu(int menu);
    GLUTAPI int APIENTRY glutGetMenu(void);
    GLUTAPI void APIENTRY glutSetMenu(int menu);
    GLUTAPI void APIENTRY glutAddMenuEntry(const char *label, int value);
    GLUTAPI void APIENTRY glutAddSubMenu(const char *label, int submenu);
    GLUTAPI void APIENTRY glutChangeToMenuEntry(int item, const char *label, int value);
    GLUTAPI void APIENTRY glutChangeToSubMenu(int item, const char *label, int submenu);
    GLUTAPI void APIENTRY glutRemoveMenuItem(int item);
    GLUTAPI void APIENTRY glutAttachMenu(int button);
    GLUTAPI void APIENTRY glutDetachMenu(int button);

    /* GLUT window callback sub-API. */
    GLUTAPI void APIENTRY glutDisplayFunc(void (GLUTCALLBACK *func)(void));
    GLUTAPI void APIENTRY glutReshapeFunc(void (GLUTCALLBACK *func)(int width, int height));
    GLUTAPI void APIENTRY glutKeyboardFunc(void (GLUTCALLBACK *func)(unsigned char key, int x, int y));
    GLUTAPI void APIENTRY glutMouseFunc(void (GLUTCALLBACK *func)(int button, int state, int x, int y));
    GLUTAPI void APIENTRY glutMotionFunc(void (GLUTCALLBACK *func)(int x, int y));
    GLUTAPI void APIENTRY glutPassiveMotionFunc(void (GLUTCALLBACK *func)(int x, int y));
    GLUTAPI void APIENTRY glutEntryFunc(void (GLUTCALLBACK *func)(int state));
    GLUTAPI void APIENTRY glutVisibilityFunc(void (GLUTCALLBACK *func)(int state));
    GLUTAPI void APIENTRY glutIdleFunc(void (GLUTCALLBACK *func)(void));
    GLUTAPI void APIENTRY glutTimerFunc(unsigned int millis, void (GLUTCALLBACK *func)(int value), int value);
    GLUTAPI void APIENTRY glutMenuStateFunc(void (GLUTCALLBACK *func)(int state));
#if (GLUT_API_VERSION >= 2)
    GLUTAPI void APIENTRY glutSpecialFunc(void (GLUTCALLBACK *func)(int key, int x, int y));
    GLUTAPI void APIENTRY glutSpaceballMotionFunc(void (GLUTCALLBACK *func)(int x, int y, int z));
    GLUTAPI void APIENTRY glutSpaceballRotateFunc(void (GLUTCALLBACK *func)(int x, int y, int z));
    GLUTAPI void APIENTRY glutSpaceballButtonFunc(void (GLUTCALLBACK *func)(int button, int state));
    GLUTAPI void APIENTRY glutButtonBoxFunc(void (GLUTCALLBACK *func)(int button, int state));
    GLUTAPI void APIENTRY glutDialsFunc(void (GLUTCALLBACK *func)(int dial, int value));
    GLUTAPI void APIENTRY glutTabletMotionFunc(void (GLUTCALLBACK *func)(int x, int y));
    GLUTAPI void APIENTRY glutTabletButtonFunc(void (GLUTCALLBACK *func)(int button, int state, int x, int y));
#if (GLUT_API_VERSION >= 3)
    GLUTAPI void APIENTRY glutMenuStatusFunc(void (GLUTCALLBACK *func)(int status, int x, int y));
    GLUTAPI void APIENTRY glutOverlayDisplayFunc(void (GLUTCALLBACK *func)(void));
#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 9)
    GLUTAPI void APIENTRY glutWindowStatusFunc(void (GLUTCALLBACK *func)(int state));
#endif
#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 13)
    GLUTAPI void APIENTRY glutKeyboardUpFunc(void (GLUTCALLBACK *func)(unsigned char key, int x, int y));
    GLUTAPI void APIENTRY glutSpecialUpFunc(void (GLUTCALLBACK *func)(int key, int x, int y));
    GLUTAPI void APIENTRY glutJoystickFunc(void (GLUTCALLBACK *func)(unsigned int buttonMask, int x, int y, int z), int pollInterval);
#endif
#endif
#endif

    /* GLUT color index sub-API. */
    GLUTAPI void APIENTRY glutSetColor(int, GLfloat red, GLfloat green, GLfloat blue);
    GLUTAPI GLfloat APIENTRY glutGetColor(int ndx, int component);
    GLUTAPI void APIENTRY glutCopyColormap(int win);

    /* GLUT state retrieval sub-API. */
    GLUTAPI int APIENTRY glutGet(GLenum type);
    GLUTAPI int APIENTRY glutDeviceGet(GLenum type);
#if (GLUT_API_VERSION >= 2)
    /* GLUT extension support sub-API */
    GLUTAPI int APIENTRY glutExtensionSupported(const char *name);
#endif
#if (GLUT_API_VERSION >= 3)
    GLUTAPI int APIENTRY glutGetModifiers(void);
    GLUTAPI int APIENTRY glutLayerGet(GLenum type);
#endif

    /* GLUT font sub-API */
    GLUTAPI void APIENTRY glutBitmapCharacter(void *font, int character);
    GLUTAPI int APIENTRY glutBitmapWidth(void *font, int character);
    GLUTAPI void APIENTRY glutStrokeCharacter(void *font, int character);
    GLUTAPI int APIENTRY glutStrokeWidth(void *font, int character);
#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 9)
    GLUTAPI int APIENTRY glutBitmapLength(void *font, const unsigned char *string);
    GLUTAPI int APIENTRY glutStrokeLength(void *font, const unsigned char *string);
#endif

    /* GLUT pre-built models sub-API */
    GLUTAPI void APIENTRY glutWireSphere(GLdouble radius, GLint slices, GLint stacks);
    GLUTAPI void APIENTRY glutSolidSphere(GLdouble radius, GLint slices, GLint stacks);
    GLUTAPI void APIENTRY glutWireCone(GLdouble base, GLdouble height, GLint slices, GLint stacks);
    GLUTAPI void APIENTRY glutSolidCone(GLdouble base, GLdouble height, GLint slices, GLint stacks);
    GLUTAPI void APIENTRY glutWireCube(GLdouble size);
    GLUTAPI void APIENTRY glutSolidCube(GLdouble size);
    GLUTAPI void APIENTRY glutWireTorus(GLdouble innerRadius, GLdouble outerRadius, GLint sides, GLint rings);
    GLUTAPI void APIENTRY glutSolidTorus(GLdouble innerRadius, GLdouble outerRadius, GLint sides, GLint rings);
    GLUTAPI void APIENTRY glutWireDodecahedron(void);
    GLUTAPI void APIENTRY glutSolidDodecahedron(void);
    GLUTAPI void APIENTRY glutWireTeapot(GLdouble size);
    GLUTAPI void APIENTRY glutSolidTeapot(GLdouble size);
    GLUTAPI void APIENTRY glutWireOctahedron(void);
    GLUTAPI void APIENTRY glutSolidOctahedron(void);
    GLUTAPI void APIENTRY glutWireTetrahedron(void);
    GLUTAPI void APIENTRY glutSolidTetrahedron(void);
    GLUTAPI void APIENTRY glutWireIcosahedron(void);
    GLUTAPI void APIENTRY glutSolidIcosahedron(void);

#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 9)
    /* GLUT video resize sub-API. */
    GLUTAPI int APIENTRY glutVideoResizeGet(GLenum param);
    GLUTAPI void APIENTRY glutSetupVideoResizing(void);
    GLUTAPI void APIENTRY glutStopVideoResizing(void);
    GLUTAPI void APIENTRY glutVideoResize(int x, int y, int width, int height);
    GLUTAPI void APIENTRY glutVideoPan(int x, int y, int width, int height);

    /* GLUT debugging sub-API. */
    GLUTAPI void APIENTRY glutReportErrors(void);
#endif

#if (GLUT_API_VERSION >= 4 || GLUT_XLIB_IMPLEMENTATION >= 13)
    /* GLUT device control sub-API. */
    /* glutSetKeyRepeat modes. */
#define GLUT_KEY_REPEAT_OFF0
#define GLUT_KEY_REPEAT_ON1
#define GLUT_KEY                _REPEAT_DEFAULT2

    /* Joystick button masks. */
#define GLUT_JOYSTICK_      BUTTON_A1
#define GLUT_JOYSTICK_BUTTON_B2
#define GLUT_JOYSTICK_BUT               TON_C4
#define GLUT_JOYSTICK_BUTTON_D8

    GLUTAPI void APIENTRY glutI             gnoreKeyRepeat(int ignore);
    GLUTAPI void APIENTRY glutSetKeyRepeat(int repeatMode);
    GLUTAPI void APIENTRY glutForceJoystickFunc(void);

    /* GLUT game mode sub-API. */
    /* glutGameModeGet. */
#define GLUT_GAME_MODE_ACTIVE           ((GLenum) 0)
#define GLUT_GAME_MODE_POSSIBLE         ((GLenum) 1)
#define GLUT_GAME_MODE_WIDTH            ((GLenum) 2)
#define GLUT_GAME_MODE_HEIGHT           ((GLenum) 3)
#define GLUT_GAME_MODE_PIXEL_DEPTH      ((GLenum) 4)
#define GLUT_GAME_MODE_REFRESH_RATE     ((GLenum) 5)
#define GLUT_GAME_MODE_DISPLAY_CHANGED  ((GLenum) 6)

    GLUTAPI void APIENTRY glutGameModeString(const char *string);
    GLUTAPI int APIENTRY glutEnterGameMode(void);
    GLUTAPI void APIENTRY glutLeaveGameMode(void);
    GLUTAPI int APIENTRY glutGameModeGet(GLenum mode);
#endif

#ifdef __cplusplus
    
}

#endif

#ifdef GLUT_APIENTRY_DEFINED
# undef GLUT_APIENTRY_DEFINED
# undef APIENTRY
#endif

#ifdef GLUT_WINGDIAPI_DEFINED
# undef GLUT_WINGDIAPI_DEFINED
# undef WINGDIAPI
#endif

#ifdef GLUT_DEFINED___CDECL
# undef GLUT_DEFINED___CDECL
# undef __cdecl
#endif

#ifdef GLUT_DEFINED__CRTIMP
# undef GLUT_DEFINED__CRTIMP
# undef _CRTIMP
#endif

#endif                  /* __glut_h__ */
