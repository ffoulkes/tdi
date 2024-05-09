# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

add_library(c_frontend_o OBJECT
  tdi_info_c.cpp
  tdi_init_c.cpp
  # tdi_learn_c.cpp
  tdi_session_c.cpp
  tdi_state_c.cpp
  tdi_table_attributes_c.cpp
  tdi_table_c.cpp
  tdi_table_data_c.cpp
  tdi_table_info_c.cpp
  tdi_table_key_c.cpp
  tdi_table_notifications_c.cpp
  tdi_table_operations_c.cpp
)

target_include_directories(c_frontend_o PRIVATE ${TDI_INCLUDE_DIR})

target_link_libraries(c_frontend_o target_sys)
