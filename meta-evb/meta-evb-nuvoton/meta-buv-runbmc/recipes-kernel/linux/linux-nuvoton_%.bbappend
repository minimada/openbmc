FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

# change default revision info
KBRANCH := "Poleg-5.4-OpenBMC"
KSRC := "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH}"
LINUX_VERSION := "5.4.16"
SRCREV = "317aef891ad9d3d054e8f8999be2897bf4b23505"

SRC_URI_append = " file://buv-runbmc.cfg"
SRC_URI_append = " \
  file://0001-dts-nuvoton-add-buv-runbmc-support.patch \
  file://0002-move_emc_message_debug.patch \
  file://0003-Revert-mtd-spi-nor-fix-options-for-mx66l51235f.patch \
  file://0004-extend-rofs-for-64MB-SPI.patch \
  file://0005-add-seven_seg_gpio.patch \
  file://0006-misc-Character-device-driver.patch \
  "
