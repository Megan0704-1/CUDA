cmake_minimum_required(VERSION 3.15)

set(TARGET_NAME RayTracing)
project(${TARGET_NAME}-app LANGUAGES CXX CUDA)

find_package(CUDA REQUIRED)
enable_language(CUDA)

find_package(OpenGL REQUIRED)
find_package(GLEW REQUIRED)
list(APPEND CMAKE_PREFIX_PATH "/usr/lib/x86_64-linux-gnu/cmake/glfw3")
find_package(glfw3 REQUIRED)
find_package(GLUT REQUIRED)

include_directories(${OPENGL_INCLUDE_DIRS} ${GLEW_INCLUDE_DIRS} ${GLFW3_INCLUDE_DIRS} ${GLUT_INCLUDE_DIRS})
get_filename_component(RT_ROOT ${CMAKE_CURRENT_LIST_DIR} ABSOLUTE)

add_library(Sphere ${RT_ROOT}/src/Sphere.cu)
set_target_properties(Sphere PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

add_executable(${TARGET_NAME} ${RT_ROOT}/src/RayTrace.cu)
add_executable(${TARGET_NAME}_constMem ${RT_ROOT}/src/gpuRayTrace.cu)

set_target_properties(${TARGET_NAME} PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
set_target_properties(${TARGET_NAME}_constMem PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

target_link_libraries(${TARGET_NAME} PRIVATE ${OPENGL_LIBRARIES} ${GLEW_LIBRARIES} ${GLFW3_LIBRARIES} ${GLUT_LIBRARIES} Sphere)
target_link_libraries(${TARGET_NAME}_constMem PRIVATE ${OPENGL_LIBRARIES} ${GLEW_LIBRARIES} ${GLFW3_LIBRARIES} ${GLUT_LIBRARIES} Sphere)
