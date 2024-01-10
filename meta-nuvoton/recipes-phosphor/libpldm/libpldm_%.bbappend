FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

#PACKAGECONFIG = "abi-development"

SRC_URI:append:nuvoton = " file://0006-libpldm-fix-pldmtool-cmd-fail-issue.patch"
SRC_URI:append:nuvoton = " \
    file://0001-libpldm-Convert-to-the-kernel-MCTP-socket-interface.patch \
    file://0001-Add-PLDM-Base-discovery-command-sequence-library.patch \
    file://0001-Add-support-for-handling-the-PLDM-base-discovery-res.patch \
    file://0002-Add-support-for-network-id-in-pldm_send-and-pldm_rec.patch \
    file://0003-Add-encoders-and-decoders-for-RDE-support.patch \
    file://0004-Add-support-for-RDE-Discovery-Negotiate-and-Medium-p.patch \
    file://0005-Add-support-for-dictionary-extraction-for-resources.patch \
    file://0006-Fix-memory-issue-in-rde.patch \
"
