# Copyright 2021-2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

include(CTest)
ENABLE_TESTING()

add_executable(tdi_json_utest
  main.cpp
  tdi_info_test.cpp
)

target_compile_options(tdi_json_utest PRIVATE
  -Wno-error
  -Wno-maybe-uninitialized
  -Wno-unused-but-set-variable
  -Wno-unused-parameter
  -Wno-unused-variable
)

target_compile_definitions(tdi_json_utest PRIVATE
  "-DJSONDIR=\"${CMAKE_CURRENT_SOURCE_DIR}/tdi_json_files\""
)

target_include_directories(tdi_json_utest PRIVATE
  ${CMAKE_SOURCE_DIR}/src/targets
)

target_link_libraries(tdi_json_utest
  gtest  # gtest_main
  gmock
  tdi
)

add_test(
  NAME TDI-JSON-UTEST
  COMMAND tdi_json_utest
)
