FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/${PN}:"
SRCREV = "bf002b46d5fb2f176fb22e48c6f1172bc970e17d"

inherit obmc-phosphor-systemd
SYSTEMD_SERVICE_${PN}_append_buv-runbmc = " postcode-7seg.service"
EXTRA_OECONF_append_buv-runbmc = " --enable-7seg=yes"
