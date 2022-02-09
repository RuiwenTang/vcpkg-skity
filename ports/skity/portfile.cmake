
vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
FEATURES
    vulkan  VULKAN_BACKEND
)

set(REF v0.1.0-beta)
set(HEAD_REF master)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO RuiwenTang/Skity
  REF ${REF}
  SHA512 b2d29fa85fcb3373e489398731485470fb995cbe9005bf747bf5bef7742ef1b246ea68837831723345bf4cde72e1a42d7328b653a391a538c52d438829d28b55
  HEAD_REF ${HEAD_REF}
)

# vcpkg_from_github or vcpkg_from_git don't download submodules and get rid of the .git folder
# restore it and update submodules

# vcpkg_from_github or vcpkg_from_git don't download submodules and get rid of the .git folder
# restore it and update submodules

if(NOT EXISTS "${SOURCE_PATH}/.git")
    message(STATUS "Updating submodules")

    if(VCPKG_USE_HEAD_VERSION)
        set(CLONE_REF ${HEAD_REF})
    else()
        set(CLONE_REF ${REF})
    endif()

    vcpkg_find_acquire_program(GIT)

    set(COMMANDS
        "${GIT} clone --depth 1 --branch ${CLONE_REF} --bare https://github.com/RuiwenTang/Skity.git .git"
        "${GIT} config core.bare false"
        "${GIT} reset --hard"
        "${GIT} submodule update --init --recursive --depth=1"
    )

    foreach(COMMAND ${COMMANDS})
        separate_arguments(COMMAND)
        vcpkg_execute_required_process(
            ALLOW_IN_DOWNLOAD_MODE
            COMMAND ${COMMAND}
            WORKING_DIRECTORY ${SOURCE_PATH}
            LOGNAME update-submodules
        )
    endforeach()
endif()

vcpkg_configure_cmake(
  SOURCE_PATH "${SOURCE_PATH}"
  PREFER_NINJA
  OPTIONS
    ${FEATURE_OPTIONS}
    -DENABLE_LOG=OFF
    -DBUILD_EXAMPLE=OFF
    -DBUILD_TEST=OFF
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