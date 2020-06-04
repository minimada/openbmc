FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/${PN}:"
  
SRC_URI_append_buv-runbmc = " file://config-buv-nuvoton.json"
SRC_URI_append_buv-runbmc = " file://fan-default-speed.sh"
SRC_URI_append_buv-runbmc = " file://phosphor-pid-control.service"
SRC_URI_append_buv-runbmc = " file://fan-reboot-control.service"
SRC_URI_append_buv-runbmc = " file://fan-boot-control.service"

FILES_${PN}_append_buv-runbmc = " ${bindir}/fan-default-speed.sh"
FILES_${PN}_append_buv-runbmc = " ${datadir}/swampd/config.json"

RDEPENDS_${PN} += "bash"


SYSTEMD_SERVICE_${PN}_append_buv-runbmc = " phosphor-pid-control.service"
SYSTEMD_SERVICE_${PN}_append_buv-runbmc = " fan-reboot-control.service"
SYSTEMD_SERVICE_${PN}_append_buv-runbmc = " fan-boot-control.service"


do_install_append_buv-runbmc() {
    install -d ${D}/${bindir}
    install -m 0755 ${WORKDIR}/fan-default-speed.sh ${D}/${bindir}

    install -d ${D}${datadir}/swampd
    install -m 0644 -D ${WORKDIR}/config-buv-nuvoton.json \
        ${D}${datadir}/swampd/config.json

    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/phosphor-pid-control.service \
        ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/fan-reboot-control.service \
        ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/fan-boot-control.service \
        ${D}${systemd_unitdir}/system
}



