# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

add_library(tdi_pna SHARED
  pna_init.cpp
  pna_target.cpp
)

target_link_libraries(tdi_pna PUBLIC tdi)

set_target_properties(tdi_pna PROPERTIES INSTALL_RPATH "$ORIGIN")

set_target_version(tdi_pna)
