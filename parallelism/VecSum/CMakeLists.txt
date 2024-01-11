cmake_minimum_required(VERSION 3.15)

project(VecSum)

find_package(CUDA REQUIRED)
enable_language(CUDA)

file(GLOB C_SOURCE *.c)
file(GLOB CUDA_SOURCE *.cu)

# separate compilation flags for C and CUDA
set_source_files_properties(${C_SOURCE} PROPERTIES LANGUAGE C)
set_source_files_properties(${CUDA_SOURCE} PROPERTIES LANGUAGE CUDA)

foreach(SOURCE_FILE ${C_SOURCE})
    get_filename_component(TARGET_NAME ${SOURCE_FILE} NAME_WE)
    message(STATUS "target name = ${TARGET_NAME}")
    add_executable(${TARGET_NAME} ${SOURCE_FILE})
endforeach()

foreach(SOURCE_FILE ${CUDA_SOURCE})
    get_filename_component(TARGET_NAME ${SOURCE_FILE} NAME_WE)
    message(STATUS "target name = ${TARGET_NAME}")
    add_executable(${TARGET_NAME} ${SOURCE_FILE})
endforeach()
