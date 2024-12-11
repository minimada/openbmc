FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

#SRC_URI:append = " file://0001-pldm-pldmtool-add-netid-parameter-support.patch

DEPENDS += "libbej"
SRC_URI:append = " file://rde_pldm.patch file://rded_resid.patch"

SYSTEMD_SERVICE:${PN} += "rded.service"
SYSTEMD_SERVICE:${PN} += "rde_fan_sensor.service"
