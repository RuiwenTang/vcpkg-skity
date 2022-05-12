
vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
FEATURES
    vulkan  VULKAN_BACKEND
)

set(REF 39257bfb9a42d1776de2d2bf1d7de04d290f579f)
set(HEAD_REF main)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO RuiwenTang/Skity
  REF ${REF}
  SHA512 86e6cd1218d66241d898328cc7138a4c6d4f4a20cf89f00340af0d8862bc7d2cbe3a1ae8badd32a48beaf2d7af1e13b7f37c94d2d2ea41d244356c81db95fda6
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