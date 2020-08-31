package(default_visibility = ["//visibility:public"])

cc_toolchain_suite(
    name = "clang_suite",
    toolchains = {
        "arm64-v8a": ":arm64_v8a_toolchain",
        "armeabi-v7a": ":armeabi_toolchain",
        "k8": ":k8_toolchain",
    },
)

filegroup(name = "empty")

cc_toolchain(
    name = "arm64_v8a_toolchain",
    toolchain_identifier = "arm64_v8a_toolchain",
    toolchain_config = ":arm64_v8a_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

load(":cc_toolchain_config.bzl", "cc_toolchain_config")
cc_toolchain_config(name = "arm64_v8a_toolchain_config")

cc_toolchain(
    name = "armeabi_toolchain",
    toolchain_identifier = "armeabi_toolchain",
    toolchain_config = ":armeabi_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

load(":cc_toolchain_config_android.bzl", "cc_toolchain_config")
cc_toolchain_config(name = "armeabi_toolchain_config")

cc_toolchain(
    name = "k8_toolchain",
    toolchain_identifier = "k8_toolchain",
    toolchain_config = ":k8_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

load(":cc_toolchain_config_linux.bzl", "cc_toolchain_config")
cc_toolchain_config(name = "k8_toolchain_config")