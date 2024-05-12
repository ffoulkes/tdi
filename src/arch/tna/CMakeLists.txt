# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

add_library(tdi_tna SHARED
  tna_init.cpp
  #tna_table_key.cpp
  tna_target.cpp
)

target_link_libraries(tdi_tna PUBLIC tdi)

set_target_properties(tdi_tna PROPERTIES INSTALL_RPATH "$ORIGIN")

set_target_version(tdi_tna)
