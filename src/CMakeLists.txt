# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

add_subdirectory(c_frontend)

add_library(tdi SHARED
  tdi_init.cpp
  tdi_info.cpp
  tdi_target.cpp
  tdi_table.cpp
  tdi_table_data.cpp
  tdi_table_key.cpp
  tdi_learn.cpp
  #tdi_cjson.cpp
  #tdi_info_impl.cpp
  #tdi_table_info.cpp
  tdi_utils.cpp
  $<TARGET_OBJECTS:c_frontend_o>
)

target_include_directories(tdi PUBLIC
  $<BUILD_INTERFACE:${TDI_INCLUDE_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(tdi PUBLIC target_utils
  target_sys
  tdi_json_parser
)

set_target_version(tdi)

add_subdirectory(arch)
add_subdirectory(targets/dummy)
add_subdirectory(tdi_json_parser)
