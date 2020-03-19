FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_buv-runbmc = " file://buv-runbmc.cfg"
SRC_URI_append_buv-runbmc = " file://0001-dts-nuvoton-add-buv-runbmc-support.patch"
