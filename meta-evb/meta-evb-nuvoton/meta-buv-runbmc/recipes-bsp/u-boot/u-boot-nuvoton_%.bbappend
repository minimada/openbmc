FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-nuvoton:"

UBOOT_MAKE_TARGET_append = " DEVICE_TREE=${UBOOT_DEVICETREE}"

SRCREV = "d8d5c229f7c9ed4976948671df810e8743112a4b"
SRC_URI_append = " file://fixed_phy.cfg"
