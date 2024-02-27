FILESEXTRAPATHS:prepend:evb-npcm845 := "${THISDIR}/files:"

SRC_URI:append = " file://${BB_TIP}"
do_deploy:append () {
    install -D -m 644 ${WORKDIR}/${BB_TIP} ${DEPLOYDIR}/${BB_TIP}
}
