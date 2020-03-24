FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-nuvoton:"

SRCREV = "a92a440e2ef910880103a8cda7d09dae00a2b2af"

SRC_URI_append = " file://buv_dts.patch"
