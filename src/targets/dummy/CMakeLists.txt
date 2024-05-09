# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

add_library(tdi_dummy SHARED
  tdi_dummy_init.cpp
  c_frontend/tdi_dummy_init_c.cpp
)

target_link_libraries(tdi_dummy PUBLIC tdi_tna)

