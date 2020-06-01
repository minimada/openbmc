FILESEXTRAPATHS_append_buv-runbmc := "${THISDIR}/${PN}:"

DEPENDS_append_buv-runbmc = " phosphor-dbus-interfaces"

SRC_URI_append_buv-runbmc = " file://0001-add-event-log-support.patch"
SRC_URI_append_buv-runbmc = " file://xyz.openbmc_project.Logging.IPMI.service"

# Enable threshold monitoring
EXTRA_OECMAKE_append = " -DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON \
    -DREDFISH_LOG_MONITOR_EVENTS_LOG=ON \
"

do_install_append_buv-runbmc() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/xyz.openbmc_project.Logging.IPMI.service \
        ${D}${systemd_unitdir}/system
}
