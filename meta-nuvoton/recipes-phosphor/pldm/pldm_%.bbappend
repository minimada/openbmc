FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DEPENDS += "libbej nlohmann-json"

SYSTEMD_SERVICE:${PN} += "rded.service"
SYSTEMD_SERVICE:${PN} += "rde_fan_sensor.service"

SRC_URI:append = " file://0002-pldm-fix-pldmtool-cmd-fail-issue.patch"
SRC_URI:append = " file://0001-Add-MCTP-Kernel-support.patch"
SRC_URI:append = " file://0002-Add-RDE-Daemon-support-to-commuicate-over-MCTP.patch"
SRC_URI:append = " file://0003-Add-RDE-Reactor-code-with-MCTP-setup.patch"
SRC_URI:append = " file://0004-Add-PLDM-Base-requester-state-machine-and-getTID-PLDM-Base-requester.patch"
SRC_URI:append = " file://0005-pldm-Add-PLDM-Base-requester-state-machine-getTypes-Commands-and-Version.patch"

SRC_URI:append = " file://0006-Add-support-for-RDE-discovery-and-PDR-Dictionary-ext.patch"
SRC_URI:append = " file://0007-Enable-RDE-Operation-in-PLDM.patch"
SRC_URI:append = " file://0009-Add-rde_fan_sensor-daemon.patch"
SRC_URI:append = " file://0010-Add-generic-patching-support-in-rded.patch"
SRC_URI:append = " file://0011-Fix-memory-issues-for-rded.patch"
SRC_URI:append = " file://0012-Update-rde-resource-map.patch"
SRC_URI:append = " file://0013-pldm-Fix-build-error.patch"
