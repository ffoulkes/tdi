# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

find_package(Doxygen)
if(NOT Doxygen_FOUND)
  message(WARNING
    "Doxygen is needed to build the documentation. Please install doxygen.")
  return()
endif()

set(DOXYFILE ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

# Value of the Doxygen INPUT parameter
set(DOXYGEN_INPUT ${TDI_INCLUDE_DIR}/tdi)

configure_file(Doxyfile.in ${DOXYFILE} @ONLY)

add_custom_target(
  doc-tdi
  COMMAND
    ${DOXYGEN_EXECUTABLE} ${DOXYFILE}
  WORKING_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT
    "Generating TDI Doxygen"
  VERBATIM
)

set_target_properties(doc-tdi PROPERTIES EXCLUDE_FROM_ALL TRUE)

install(
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/html
  DESTINATION ${CMAKE_INSTALL_DOCDIR}
  OPTIONAL
)

install(
  DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/latex
  DESTINATION ${CMAKE_INSTALL_DOCDIR}
  OPTIONAL
)
