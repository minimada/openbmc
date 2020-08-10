FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/u-boot-nuvoton:"

UBOOT_MAKE_TARGET_append_buv-runbmc = " DEVICE_TREE=${UBOOT_DEVICETREE}"

SRCREV_buv-runbmc = "3359dc08a0678791d360ae43b754ffa2453f8987"
SRC_URI_append_buv-runbmc = " file://fixed_phy.cfg"
SRC_URI_append_buv-runbmc = " file://0001-u-boot-gfx-test.patch"
