FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

KBRANCH = "Poleg-4.19.16-OpenBMC"
LINUX_VERSION = "4.19.16"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH}"
SRCREV = "a7561a86f63ad03aa2e1f225ad79d07a3024d50b"

SRC_URI += "file://runbmc-nuvoton.cfg"
SRC_URI += "file://0001-add-runbmc-dts.patch"
SRC_URI += "file://0002-nbd-fix-reconnect.patch"
SRC_URI += "file://npcm-FIU-evb-3-4-addr.patch"
SRC_URI += "file://0001-i2c-patch.patch"
