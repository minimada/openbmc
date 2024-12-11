FILESEXTRAPATHS:prepend:nuvoton := "${THISDIR}/${PN}:"

SRC_URI:append:nuvoton = " \
  file://0001-bmcweb-Add-RDE-Device-aggregation-support.patch \
  file://0002-bmcweb-Add-dbus-interface-calls-to-RDEd.patch \
  file://0003-bmcweb-send-payload-to-RDE-devices-for-POST-operatio.patch \
  file://0004-aggregation-add-rde-support-test.patch \
"
EXTRA_OEMESON:append:nuvoton = " -Dredfish-aggregation='enabled'"
