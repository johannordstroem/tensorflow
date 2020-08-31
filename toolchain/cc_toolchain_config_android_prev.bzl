# NEW
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
# NEW
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

all_link_actions = [ # NEW
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "/externaldisk/data/dev/sdk/android-ndk-r20/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang",
        ),
        tool_path(
            name = "ld",
            path = "/externaldisk/data/dev/sdk/android-ndk-r20/toolchains/llvm/prebuilt/linux-x86_64/bin/lld",
        ),
        tool_path(
            name = "ar",
            path = "/externaldisk/data/dev/sdk/android-ndk-r20/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/bin/false",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "nm",
            path = "/bin/false",
        ),
        tool_path(
            name = "objdump",
            path = "/bin/false",
        ),
        tool_path(
            name = "strip",
            path = "/bin/false",
        ),
]

    features = [ # NEW
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-stdlib=libc++",
                                "-fuse-ld=lld",
                                "-L/externaldisk/data/dev/sdk/android-ndk-r20//toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/28",
                                "-Wl,-rpath,/externaldisk/data/dev/sdk/android-ndk-r20//toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/28",
                                "-lc++",
                                "-lm",
                                "-v",
                                "-llog",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
        feature(
            name = "default_compile_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-stdlib=libc++"
                            ],
                        ),
                    ]),
                ),
            ],
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features, # NEW
        cxx_builtin_include_directories = [
            "/externaldisk/data/dev/sdk/android-ndk-r20/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/8.0.7/include",
            "/externaldisk/data/dev/sdk/android-ndk-r20/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include",
            "/externaldisk/data/dev/sdk/android-ndk-r20/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/local/include/"
        ],
        toolchain_identifier = "local",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "arm64_v8a",
        target_libc = "unknown",
        compiler = "clang",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
)

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)