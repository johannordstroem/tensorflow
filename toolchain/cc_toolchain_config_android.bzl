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

all_compiler_actions = [ # NEW
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.c_compile,
]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "/externaldisk/data/dev/sdk/llvm-8.0/host/x86_64/Release/bin/clang-8",
        ),
        tool_path(
            name = "ld",
            path = "/externaldisk/data/dev/sdk/llvm-8.0/host/x86_64/Release/bin/ld",
        ),
        tool_path(
            name = "ar",
            path = "/externaldisk/data/dev/sdk/llvm-8.0/host/x86_64/Release/bin/llvm-ar",
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
                                "-L/externaldisk/data/dev/sdk/aosp/android-10.0.0/lib",
                                "-lc++",
                                "-lm",
                                "-fPIC",
                                "-frtti",
                                "-fexceptions",
                                "-flto=thin",
                                "-Xclang",
                                "-mnoexecstack",
                                "--target=armv7-linux-androideabi",
                                "--sysroot=/externaldisk/data/dev/sdk/aosp/android-10.0.0/sysroot/",
                                "-mcpu=generic",
                                "-v",
                                "-llog",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
        feature(
            name = "default_compiler_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_compiler_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-stdlib=libc++",
                                "--sysroot=/externaldisk/data/dev/sdk/aosp/android-10.0.0/sysroot",
                                "--target=armv7-linux-androideabi",
                                "-fPIC",
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
        builtin_sysroot = "/externaldisk/data/dev/sdk/aosp/android-10.0.0/sysroot",
        cxx_builtin_include_directories = [
            "/externaldisk/data/dev/sdk/llvm-8.0/host/x86_64/Release/lib/clang/8.0.1/include/c++/v1",
            "/externaldisk/data/dev/sdk/aosp/android-10.0.0/sysroot/usr/include/arm-linux-androideabi",
            "/externaldisk/data/dev/sdk/aosp/android-10.0.0/sysroot/usr/include",
            "/externaldisk/data/dev/sdk/llvm-8.0/host/x86_64/Release/lib/clang/8.0.1/include/"
        ],
        toolchain_identifier = "local",
        host_system_name = "local",
        target_system_name = "armeabi-v7a",
        target_cpu = "armeabi-v7a",
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