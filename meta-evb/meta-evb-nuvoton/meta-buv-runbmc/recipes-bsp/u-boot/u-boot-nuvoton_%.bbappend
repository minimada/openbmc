FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-nuvoton:"

SRCREV = "a386041c45fa11b4f7f066f07b0f4446c1daaee1"

SRC_URI_append = " file://buv_dts.patch"
