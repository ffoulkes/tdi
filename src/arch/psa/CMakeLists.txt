# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

add_library(tdi_psa SHARED
  c_frontend/psa_table_key_c.cpp
  #psa_target.cpp
)

target_link_libraries(tdi_psa PUBLIC tdi)
