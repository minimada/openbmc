FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

#SRC_URI:append = " file://0001-libpldm-add-netid-parameter-support.patch"
SRC_URI:append = " file://rde_libpldm.patch"
