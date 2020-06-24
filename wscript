top = "."
out = "out"
charts = ["firefly", "grocy", "lib", "registry", "tasmoadmin"]


def configure(conf):
    conf.env.HELM = conf.find_program("helm")[0]


def build(bld):
    ch = bld.cmd_and_log("ls charts", quiet=True)
    for chart in ch.split():
        bld.exec_command([
            bld.env.HELM,
            "package",
            "-u",
            "charts/" + chart,
            "--destination",
            "out/charts"
        ])


def test(tst):
    tst.exec_command("helm lint charts/*")
    ch = tst.cmd_and_log("ls charts", quiet=True)
    for chart in ch.split():
        tst.exec_command([
            "helm",
            "lint",
            "charts/" + chart
        ])
