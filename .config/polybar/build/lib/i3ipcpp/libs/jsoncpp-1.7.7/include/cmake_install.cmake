# Install script for directory: /home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/json" TYPE FILE FILES
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/allocator.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/assertions.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/autolink.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/config.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/features.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/forwards.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/json.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/reader.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/value.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/version.h"
    "/home/andrew/.config/polybar/lib/i3ipcpp/libs/jsoncpp-1.7.7/include/json/writer.h"
    )
endif()

