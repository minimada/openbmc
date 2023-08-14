FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

TEST_BB = "bootblock.bin"
SRC_URI:append = " file://${TEST_BB}"

do_deploy:append() {
    install -D -m 644 ${WORKDIR}/${TEST_BB} ${DEPLOYDIR}/${BB_TIP}
}
