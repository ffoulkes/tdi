# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

add_library(tdi_json_parser SHARED
  tdi_cjson.cpp
  tdi_info_parser.cpp
  tdi_learn_info.cpp
  tdi_table_info.cpp
)

target_include_directories(tdi_json_parser PUBLIC
  $<BUILD_INTERFACE:${TDI_INCLUDE_DIR}>
  $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(tdi_json_parser PUBLIC
  cjson
  target_sys
)

set_target_version(tdi_json_parser)

set_target_properties(tdi_json_parser PROPERTIES INSTALL_RPATH "$ORIGIN")

if(TDI_GTEST)
  add_subdirectory(tests)
endif()
