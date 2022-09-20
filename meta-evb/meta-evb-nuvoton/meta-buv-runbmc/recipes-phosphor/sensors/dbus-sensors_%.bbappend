FILESEXTRAPATHS:prepend:buv-runbmc := "${THISDIR}/${PN}:"

SRC_URI:append:buv-runbmc = " \
    file://0001-intrusionsensor-Add-polling-event-status-by-sysfs.patch \
    file://0002-Add-gpiodigital-sensor.patch \
    "

PACKAGECONFIG:append:buv-runbmc = " gpiosensor eventsensor"
PACKAGECONFIG[gpiosensor] = "-Ddig-gpio=enabled, -Ddig-gpio=disabled"
PACKAGECONFIG[eventsensor] = "-Ddisc-event=enabled, -Ddisc-event=disabled"

SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'gpiosensor', \
                                               'xyz.openbmc_project.gpiosensor.service', \
                                               '', d)}"
SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'eventsensor', \
                                               'xyz.openbmc_project.eventsensor.service', \
                                               '', d)}"
