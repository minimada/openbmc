FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

#PATCHTOOL = "git"
#SRC_URI:append = " file://0001-Add-libbej-encoder-wrapper-for-C.patch"
SRC_URI:append = " file://0002-Add-encoder-json-offset-support.patch"
