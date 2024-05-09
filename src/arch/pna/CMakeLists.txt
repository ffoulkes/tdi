# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

add_library(tdi_pna SHARED
  pna_init.cpp
  pna_target.cpp
)

target_link_libraries(tdi_pna PUBLIC tdi)
