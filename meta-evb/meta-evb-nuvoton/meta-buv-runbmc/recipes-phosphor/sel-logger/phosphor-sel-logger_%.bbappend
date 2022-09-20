FILESEXTRAPATHS:prepend:buv-runbmc := "${THISDIR}/${PN}:"

PACKAGECONFIG:append:buv-runbmc = " log-threshold log-alarm log-pulse log-watchdog"
SRC_URI:append:buv-runbmc = " \
    file://0001-Add-discrete-event-support.patch \
    "
