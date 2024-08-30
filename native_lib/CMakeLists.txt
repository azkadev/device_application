cmake_minimum_required(VERSION 3.16)

project(device_application_library VERSION 0.0.1 LANGUAGES C CXX)
set(CMAKE_CXX_STANDARD 20)
 
message(STATUS "START COMPILE PACKAGE_TEMPLATE")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")

set(device_application_shared_dir "lib")
set(device_application_exe_dir "bin")
set(prefix_shared_library "lib")
 

if (ANDROID)
 set(package_shared_extension "_${ANDROID_ARCH_NAME}.so")
 set(package_exe_extension "")
 set(package_name "device_application_${ANDROID_ARCH_NAME}")
elseif (WIN32)
 set(package_shared_extension ".dll")
 set(package_exe_extension ".exe") 
 set(package_name "device_application")
elseif (APPLE)
 set(package_shared_extension ".dylib")
 set(package_exe_extension "") 
 set(package_name "device_application")
else()
 set(package_shared_extension ".so")
 set(package_exe_extension "") 
 set(package_name "device_application")
endif()


add_library(device_application_shared SHARED device_application.cpp)
add_executable(device_application_exe device_application.cpp)

set_target_properties(device_application_shared PROPERTIES 
  LIBRARY_OUTPUT_DIRECTORY "${device_application_shared_dir}"
  PREFIX "${prefix_shared_library}"
  OUTPUT_NAME "${package_name}"
)

set_target_properties(device_application_exe PROPERTIES 
  RUNTIME_OUTPUT_DIRECTORY "${device_application_exe_dir}"
  OUTPUT_NAME "${package_name}"
)

if (WIN32)
 set_target_properties(device_application_shared PROPERTIES
  WINDOWS_EXPORT_ALL_SYMBOLS ON
)
endif (WIN32)
 
add_custom_command(
  TARGET device_application_shared POST_BUILD 
  COMMAND ${CMAKE_STRIP} --strip-debug --strip-unneeded "${device_application_shared_dir}/${prefix_shared_library}device_application${package_shared_extension}"
)

add_custom_command(
  TARGET device_application_exe POST_BUILD 
  COMMAND ${CMAKE_STRIP} --strip-debug --strip-unneeded "${device_application_exe_dir}/device_application${package_exe_extension}" 
)

 