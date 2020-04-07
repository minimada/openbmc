FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = "a386041c45fa11b4f7f066f07b0f4446c1daaee1"
SRC_URI_append = " file://fw_env.config"

do_install_append () {
	install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}
