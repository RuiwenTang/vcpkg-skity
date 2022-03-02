
vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
FEATURES
    vulkan  VULKAN_BACKEND
)

set(REF fa714adece361975cb0889deb36484af2d00c7df)
set(HEAD_REF main)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO RuiwenTang/Skity
  REF ${REF}
  SHA512 38270232febbeda1426a4df1428cb2843b876b01ff50c6a04c23fbb78562c82ea1112a550330d537b48ec85b99fb1c7d9000a03cae2fb4071e3f544e85169573
  HEAD_REF ${HEAD_REF}
)

vcpkg_configure_cmake(
  SOURCE_PATH "${SOURCE_PATH}"
  PREFER_NINJA
  OPTIONS
    ${FEATURE_OPTIONS}
    -DENABLE_LOG=OFF
    -DBUILD_EXAMPLE=OFF
    -DBUILD_TEST=OFF
    -DSKITY_VCPKG=ON
)

vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_fixup_cmake_targets(
  CONFIG_PATH lib/cmake/skity
  TARGET_PATH share/skity
)

file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright
)