# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.15)

project(libtdi VERSION 1.1.0 LANGUAGES CXX)

#-----------------------------------------------------------------------
# Modules
#-----------------------------------------------------------------------
include(CMakePrintHelpers)
include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(SetTargetVersion)

#-----------------------------------------------------------------------
# Packages
#-----------------------------------------------------------------------
find_package(targetsys)
if(NOT targetsys_FOUND)
  message(FATAL_ERROR "Could not find targetsys package")
endif()

find_package(targetutils)
if(NOT targetutils_FOUND)
  message(FATAL_ERROR "Could not find targetutils package")
endif()

#-----------------------------------------------------------------------
# Build
#-----------------------------------------------------------------------
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 11)
set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(CMAKE_BUILD_TYPE "RelWithDebInfo")

set(TDI_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)

if(TDI_GTEST)
  add_subdirectory(third-party/googletest)
endif()

set(C_CXX_FLAGS "-Wall -Wextra -Werror -Wshadow -Wpedantic -Wno-missing-field-initializers ")
set(CMAKE_SHARED_LINKER_FLAGS "-Wl,-z,defs")

if(COVERAGE)
  set(C_CXX_FLAGS "${C_CXX_FLAGS} --coverage")
endif()
set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS}   ${C_CXX_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${C_CXX_FLAGS}")

add_subdirectory(src)

option(BUILD_DOCS "Enable Doxygen generation target" FALSE)

if(BUILD_DOCS)
  add_subdirectory(docs)
endif()

#-----------------------------------------------------------------------
# Install
#-----------------------------------------------------------------------
install(
  TARGETS tdi tdi_pna tdi_psa tdi_tna
  COMPONENT tdi
  ARCHIVE DESTINATION ${CMAKE_INCLUDE_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INCLUDE_LIBDIR}
)

install(
  DIRECTORY include/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
