FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/${PN}:"
FILES_${PN} += " /lib/*"
RDEPENDS_${PN} += "bash"
SRCREV = "bf002b46d5fb2f176fb22e48c6f1172bc970e17d"

SRC_URI_append_buv-runbmc = " \
		file://postcode-7seg.service \
			"

SNOOP_DEVICE = "npcm7xx-lpc-bpc0"
SERVICE_FILE = "postcode-7seg.service lpcsnoop.service"
EXTRA_OECONF_append_buv-runbmc = " \
			--enable-7seg=yes \
				"

do_install_append_buv-runbmc() {

     install -m 0644 ${WORKDIR}/postcode-7seg.service \
            ${D}${systemd_unitdir}/system
     rm ${D}${systemd_unitdir}/system/postcode-7seg@.service
}
