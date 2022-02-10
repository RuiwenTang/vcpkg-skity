
vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
FEATURES
    vulkan  VULKAN_BACKEND
)

set(REF v0.1.1-beta)
set(HEAD_REF main)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO RuiwenTang/Skity
  REF ${REF}
  SHA512 6a9990aeee55236499299207fa2bdacb2c404a76fd77b4143f16690adb2c88d81ec25468bb8a7b9ce3249fe40f6519c76d5c081ce5f39294505f3e1902b6bbec
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