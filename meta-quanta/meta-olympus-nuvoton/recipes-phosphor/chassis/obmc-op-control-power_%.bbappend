FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRCREV = "e32e33784a1883ee4528b17617df14f3114b0f5e"

SRC_URI_append_olympus-nuvoton = " file://0001-meta-olympus-nuvoton-op-pwrctl-enable-server-power-co.patch"
