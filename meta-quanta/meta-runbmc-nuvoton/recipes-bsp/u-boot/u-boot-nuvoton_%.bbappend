FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

UBRANCH = "runbmc_mdio"
SRC_URI = "git://github.com/Nuvoton-Israel/u-boot.git;branch=${UBRANCH}"
SRCREV = "06da240fe661091fbe318d60336273754d8d4b0a"

SRC_URI += "file://0001-libfdt-fix-libfdt-header-conflicts-between-UBoot-and.patch"
SRC_URI += "file://RunBMC-nuvoton-U-boot-setup.patch"
