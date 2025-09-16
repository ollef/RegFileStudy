load("@bazel-orfs//toolchains/scala:chisel.bzl", "chisel_library")
load(":study.bzl", "study")

LATENCIES = [i for i in range(11)]

INFO = {
    "name": "64x64 multiplier",
    "stage": "synth",
    "study": [
        {
            "name": "Multiplier_{i}_{retime}".format(
                i = i,
                retime = retime,
            ),
            "top": "Multiplier_{i}".format(
                i = i,
            ),
            "width": 64,
            "latency": i,
            "retime": retime,
        }
        for i in LATENCIES
        for retime in [
            1,
            0,
        ]
    ],
}

py_binary(
    name = "plot_reg2reg",
    srcs = ["plot_reg2reg.py"],
    deps = [
        "@regfilestudy-pip//matplotlib",
        "@regfilestudy-pip//pyyaml",
        "@regfilestudy-pip//scipy",
    ],
)

study(
    name = "multiplier",
    info = INFO,
    module = "Multiplier",
    scala_files = glob(["src/main/scala/**/*.scala"]),
)

chisel_library(
    name = "hardfloat",
    srcs = [
        "@berkeley_hardfloat//:hardfloat/src/main/scala/AddRecFN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/CompareRecFN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/INToRecFN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/MulRecFN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/RecFNToIN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/RecFNToRecFN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/RoundAnyRawFNToRecFN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/common.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/fNFromRecFN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/primitives.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/rawFloatFromFN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/rawFloatFromIN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/rawFloatFromRecFN.scala",
        "@berkeley_hardfloat//:hardfloat/src/main/scala/recFNFromFN.scala",
    ],
    visibility = ["//visibility:public"],
)

MULTIPLIER_INFO = {
    "name": "FPU",
    "stage": "synth",
    "study": [
        {
            "name": "FloatingPointUnit_{i}_{retime}".format(
                i = i,
                retime = retime,
            ),
            "top": "FloatingPointUnit_{i}".format(
                i = i,
            ),
            "width": 64,
            "latency": i,
            "retime": retime,
        }
        for i in LATENCIES
        for retime in [
            1,
            0,
        ]
    ],
}

study(
    name = "fpu",
    info = MULTIPLIER_INFO,
    module = "FloatingPointUnit",
    scala_files = glob(["src/main/scala/**/*.scala"]),
)

XLS_FP_MULTIPLIER_INFO = {
    "name": "XLS floating point multiplier",
    "stage": "synth",
    "study": [
        {
            "name": "XLSFloatingPointMultiplier_{i}_{retime}".format(
                i = i,
                retime = retime,
            ),
            "top": "XLSFloatingPointMultiplier_{i}".format(
                i = i,
            ),
            "width": 64,
            "latency": i,
            "retime": retime,
        }
        for i in LATENCIES
        for retime in [
            1,
            0,
        ]
    ],
}

study(
    name = "xls_fp_mul",
    info = XLS_FP_MULTIPLIER_INFO,
    module = "XLSFloatingPointMultiplier",
    scala_files = glob(["src/main/scala/**/*.scala"]),
    verilog_files = ["fp64mul_{latency}.v".format(latency = latency) for latency in LATENCIES],
)

genrule(
    name = "fp64mul_ir",
    srcs = ["fp64mul.x"],
    outs = ["fp64mul.ir"],
    cmd = """
IR_CONVERTER=$(location @xls//:ir_converter)
RUNFILES_DIR=$${IR_CONVERTER}.runfiles/+_repo_rules+xls
$${IR_CONVERTER} $(location fp64mul.x) --top=fp64mul --dslx_stdlib_path=$${RUNFILES_DIR}/xls/dslx/stdlib > $@
""",
    tools = ["@xls//:ir_converter"],
)

genrule(
    name = "fp64mul_opt_ir",
    srcs = ["fp64mul.ir"],
    outs = ["fp64mul.opt.ir"],
    cmd = "$(location @xls//:opt_main) $(location fp64mul.ir) > $@",
    tools = ["@xls//:opt_main"],
)

[genrule(
    name = "fp64mul_{latency}_v".format(latency = latency),
    srcs = ["fp64mul.opt.ir"],
    outs = ["fp64mul_{latency}.v".format(latency = latency)],
    cmd = "$(location @xls//:codegen_main) $(location fp64mul.opt.ir) {flag} --delay_model=asap7 --module_name=XLSFloatingPointMultiplier_{latency}_core > $@".format(
        flag = "--generator=combinational" if latency == 0 else "--pipeline_stages={latency}".format(latency = latency),
        latency = latency,
    ),
    tools = ["@xls//:codegen_main"],
) for latency in LATENCIES]

filegroup(
    name = "chiselfiles",
    srcs = glob(["**/*.scala"]),
    tags = ["manual"],
    visibility = ["//visibility:public"],
)
