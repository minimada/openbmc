FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-nuvoton:"

UBOOT_MAKE_TARGET_append = " DEVICE_TREE=${UBOOT_DEVICETREE}"

SRCREV = "3359dc08a0678791d360ae43b754ffa2453f8987"
SRC_URI_append = " file://fixed_phy.cfg"
SRC_URI_append = " file://0001-u-boot-gfx-test.patch"
