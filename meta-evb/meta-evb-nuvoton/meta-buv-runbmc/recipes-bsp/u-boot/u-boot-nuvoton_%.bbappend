FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/u-boot-nuvoton:"

UBOOT_MAKE_TARGET_append_buv-runbmc = " DEVICE_TREE=${UBOOT_DEVICETREE}"

SRCREV_buv-runbmc = "a9238ef9d47b8a68c0c9513fdfc8588a114b0313"
SRC_URI_append_buv-runbmc = " file://fixed_phy.cfg"
SRC_URI_append_buv-runbmc = " file://0001-u-boot-gfx-test.patch"
