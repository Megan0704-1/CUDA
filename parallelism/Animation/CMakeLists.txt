cmake_minimum_required(VERSION 3.15)

project(cpu_animation)

find_package(CUDA REQUIRED)
enable_language(CUDA)

find_package(OpenGL REQUIRED)
find_package(GLEW REQUIRED)
list(APPEND CMAKE_PREFIX_PATH "/usr/lib/x86_64-linux-gnu/cmake/glfw3")
find_package(glfw3 REQUIRED)
find_package(GLUT REQUIRED)

FILE(GLOB C_SOURCE *.c)
FILE(GLOB CUDA_SOURCE *.cu)

set(CMAKE_C_FLAGS "-g -Wall")

set_source_files_properties(${C_SOURCE} PROPERTIES LANGUAGE C)
set_source_files_properties(${CUDA_SOURCE} PROPERTIES LANGUAGE CUDA)

foreach(SOURCE ${C_SOURCE})
    get_filename_component(TARGET_NAME ${SOURCE} NAME_WE)
    add_executable(${TARGET_NAME} ${SOURCE})
endforeach()

foreach(SOURCE ${CUDA_SOURCE})
    get_filename_component(TARGET_NAME ${SOURCE} NAME_WE)
    add_executable(${TARGET_NAME} ${SOURCE})
    target_include_directories(${TARGET_NAME} PRIVATE ${OPENGL_INCLUDE_DIRS} ${GLEW_INCLUDE_DIRS} ${GLFW3_INCLUDE_DIRS} ${GLUT_INCLUDE_DIRS})
    target_link_libraries(${TARGET_NAME} PRIVATE ${OPENGL_LIBRARIES} ${GLEW_LIBRARIES} ${GLFW3_LIBRARIES} ${GLUT_LIBRARIES})
endforeach()
