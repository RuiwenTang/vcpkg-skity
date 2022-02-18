
vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
FEATURES
    vulkan  VULKAN_BACKEND
)

set(REF 9d42b5433170cdccca799c987906c017da852558)
set(HEAD_REF main)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO RuiwenTang/Skity
  REF ${REF}
  SHA512 b68cb0795b3a765eaa957359f44cdbc54358dd0c4fba38deb7cd894af55779b313ca92e4435189588f895671cb9f397ecbca7035ccf81eb91ba0ce0c78b5b36d
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