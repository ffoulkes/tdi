# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.15)

project(tdi VERSION 1.1.0 LANGUAGES CXX)

#-----------------------------------------------------------------------
# Modules
#-----------------------------------------------------------------------
include(CMakePackageConfigHelpers)
include(CMakePrintHelpers)
include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(SetTargetVersion)

#-----------------------------------------------------------------------
# Packages
#-----------------------------------------------------------------------
find_package(targetsys REQUIRED CONFIG)
message(STATUS "Found targetsys version ${targetsys_VERSION}")

find_package(cJSON REQUIRED CONFIG)
message(STATUS "Found cJSON version ${cJSON_VERSION}")

if(TDI_GTEST)
  find_package(GTest REQUIRED)
  message(STATUS "Found googletest version ${gtest_VERSION}")
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

set(C_CXX_FLAGS "-Wall -Wextra -Werror -Wshadow -Wpedantic -Wno-missing-field-initializers ")
set(CMAKE_SHARED_LINKER_FLAGS "-Wl,-z,defs")

if(COVERAGE)
  set(C_CXX_FLAGS "${C_CXX_FLAGS} --coverage")
endif()
set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS}   ${C_CXX_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${C_CXX_FLAGS}")

add_subdirectory(src)

option(BUILD_DOCS "Enable Doxygen generation" FALSE)

if(BUILD_DOCS)
  add_subdirectory(docs)
endif()

#-----------------------------------------------------------------------
# Install
#-----------------------------------------------------------------------
# EXPORT parameter value
set(EXPORTNAME tdi)

# cmake config file prefix
set(EXPORTSTEM tdi)

install(
  TARGETS tdi tdi_json_parser tdi_pna tdi_psa tdi_tna
  EXPORT ${EXPORTNAME}
  COMPONENT tdi
  ARCHIVE DESTINATION ${CMAKE_INCLUDE_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INCLUDE_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(
  DIRECTORY include/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
  DIRECTORY tdi_python/
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/python
  FILES_MATCHING PATTERN "*.py"
)

#-----------------------------------------------------------------------
# CMake configuration file
#-----------------------------------------------------------------------
install(
  EXPORT ${EXPORTNAME}
  FILE ${EXPORTSTEM}-targets.cmake
  NAMESPACE tdi::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${EXPORTSTEM}
)

configure_package_config_file(
  cmake/${EXPORTSTEM}-config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/${EXPORTSTEM}-config.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${EXPORTSTEM}
)

install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${EXPORTSTEM}-config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${EXPORTSTEM}-config-version.cmake
  COMPONENT
    tdi
  DESTINATION
    ${CMAKE_INSTALL_LIBDIR}/cmake/${EXPORTSTEM}
)

write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/${EXPORTSTEM}-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)
