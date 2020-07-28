FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-nuvoton:"

UBOOT_MAKE_TARGET_append = " DEVICE_TREE=${UBOOT_DEVICETREE}"

SRCREV = "a9238ef9d47b8a68c0c9513fdfc8588a114b0313"
SRC_URI_append = " file://fixed_phy.cfg"
SRC_URI_append = " file://0001-u-boot-gfx-test.patch"
