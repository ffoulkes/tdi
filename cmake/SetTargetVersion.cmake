# Copyright 2024 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

option(SEMVER "Enable semantic versioning of libraries" ON)

function(set_target_version TARGET)
  if(SEMVER)
    set_target_properties(${TARGET} PROPERTIES
      VERSION ${PROJECT_VERSION}
      SOVERSION ${PROJECT_VERSION_MAJOR}
    )
  endif()
endfunction()
