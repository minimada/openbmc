FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = "0f7019df1ecf905c72378dc9a3dcab625bb142b7"
SRC_URI += "file://0001-add-kvm-handler.patch"
SRC_URI += "file://0002-add-vm-handler.patch"
SRC_URI += "file://0001-meta-evb-npcm750-Add-support-for-LDAP-login.patch"
SRC_URI += "file://0001-meta-evb-npcm750-Add-user-password-update-support-fo.patch"
