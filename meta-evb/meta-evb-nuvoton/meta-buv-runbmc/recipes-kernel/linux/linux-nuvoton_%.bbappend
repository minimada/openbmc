FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/linux-nuvoton:"

# change default revision info
KBRANCH := "Poleg-5.4-OpenBMC"
KSRC := "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH}"
LINUX_VERSION := "5.4.16"
SRCREV = "f6219927edd20940e75239da743e5fe249a19473"

SRC_URI_append_buv-runbmc = " file://buv-runbmc.cfg"
SRC_URI_append_buv-runbmc = " \
  file://0001-dts-nuvoton-add-buv-runbmc-support.patch \
  file://0002-move-emc-debug-message-to-dev_dbg.patch \
  file://0003-Revert-mtd-spi-nor-fix-options-for-mx66l51235f.patch \
  file://0004-add-seven_seg_gpio.patch \
  file://0005-misc-Character-device-driver.patch \
  file://0006-driver-SPI-add-w25q01jv-support.patch \
  "
