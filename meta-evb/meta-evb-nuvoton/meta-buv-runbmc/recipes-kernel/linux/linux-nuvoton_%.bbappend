FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/linux-nuvoton:"

# change default revision info
KBRANCH := "Poleg-5.4-OpenBMC"
KSRC := "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH}"
LINUX_VERSION := "5.4.16"
SRCREV = "83e5d2e1593b3bc1ff35e5028c8f2c77a8222c5b"

SRC_URI_append_buv-runbmc = " file://buv-runbmc.cfg"
SRC_URI_append_buv-runbmc = " \
  file://0001-dts-nuvoton-add-buv-runbmc-support.patch \
  file://0002-move_emc_message_debug.patch \
  file://0003-Revert-mtd-spi-nor-fix-options-for-mx66l51235f.patch \
  "
