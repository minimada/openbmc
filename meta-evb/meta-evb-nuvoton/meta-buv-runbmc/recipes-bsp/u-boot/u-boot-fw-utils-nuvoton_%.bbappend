FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/${PN}:"

SRC_URI_append_buv-runbmc = " file://fw_env.config"

do_install_append_buv-runbmc () {
	install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}
