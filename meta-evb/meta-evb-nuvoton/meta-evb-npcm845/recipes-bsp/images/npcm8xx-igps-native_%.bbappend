FILESEXTRAPATHS:prepend := "${THISDIR}/npcm8xx-igps:"
#SRC_URI:append = " file://UbootHeader_A1.xml"
SRC_URI:append = " file://BootBlockAndHeader_${DEVICE_GEN}_${IGPS_MACHINE}.xml"
do_install:append() {
    # install ${WORKDIR}/UbootHeader_${DEVICE_GEN}.xml ${DEST}
    install ${WORKDIR}/BootBlockAndHeader_${DEVICE_GEN}_${IGPS_MACHINE}.xml ${DEST}
}
