
set(REF 0e7211ea82924434d9e2cbdc53d5da47e91d2d67)
set(HEAD_REF refactor/cmake_config_install)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO RuiwenTang/yoga
  REF ${REF}
  SHA512 f339346989d8646e4bf831317b9ee83159984d624c0cb5cec8cb73f7618ec5959addc9e76f746315b6a23e9b7a27161c107332b8b0ada6f9c5264eb947a5cd1f
  HEAD_REF ${HEAD_REF}
)

vcpkg_configure_cmake(
  SOURCE_PATH "${SOURCE_PATH}"
  PREFER_NINJA
)

vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_fixup_cmake_targets(
  CONFIG_PATH lib/cmake/yoga
  TARGET_PATH share/yoga
)

file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright
)