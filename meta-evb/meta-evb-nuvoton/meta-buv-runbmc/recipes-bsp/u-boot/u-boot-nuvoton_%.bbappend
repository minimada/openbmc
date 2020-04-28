FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-nuvoton:"

UBOOT_MAKE_TARGET_append = " DEVICE_TREE=${UBOOT_DEVICETREE}"

SRCREV = "5041f37616bfa9dca56ef4a193405def9369a18d"
SRC_URI_append = " file://fixed_phy.cfg"
