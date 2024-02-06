FILESEXTRAPATHS:append:buv-runbmc := "${THISDIR}/${PN}:"

SRC_URI:append:buv-runbmc = " file://rde_resp.patch"
