cmake_minimum_required(VERSION 3.15)

project(VecAdd)

find_package(CUDA REQUIRED)
enable_language(CUDA)

file(GLOB C_SOURCE *.c)
file(GLOB CUDA_SOURCE *.cu)

set_source_files_properties(${C_SOURCE} PROPERTIES LANGUAGE C)
set_source_files_properties(${CUDA_SOURCE} PROPERTIES LANGUAGE CUDA)

set(CMAKE_C_FLAGS "-g -Wall")

foreach(SOURCE ${C_SOURCE})
    get_filename_component(TARGET_NAME ${SOURCE} NAME_WE)
    message(STATUS "target name: " ${TARGET_NAME})
    add_executable(${TARGET_NAME} ${SOURCE})
endforeach()

foreach(SOURCE ${CUDA_SOURCE})
    get_filename_component(TARGET_NAME ${SOURCE} NAME_WE)
    message(STATUS "target name: " ${TARGET_NAME})
    add_executable(${TARGET_NAME} ${SOURCE})
endforeach()
