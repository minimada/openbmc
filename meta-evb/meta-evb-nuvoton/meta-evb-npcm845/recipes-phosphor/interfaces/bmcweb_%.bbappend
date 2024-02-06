FILESEXTRAPATHS:append:evb-npcm845 := "${THISDIR}/${PN}:"
inherit entity-utils

# Enable Redfish DBUS log/Journal support
EXTRA_OEMESON:append:evb-npcm845 = " ${@entity_enabled(d, '-Dredfish-bmc-journal=enabled', '-Dredfish-dbus-log=enabled')}"

# Enable TFTP
EXTRA_OEMESON:append:evb-npcm845  = " -Dinsecure-tftp-update=enabled"

# Increase body limit for FW size
EXTRA_OEMESON:append:evb-npcm845  = " -Dhttp-body-limit=65"

# Enable dbus rest API /xyz/
EXTRA_OEMESON:append:evb-npcm845 = " -Drest=enabled"

# Enalbe sensors
EXTRA_OEMESON:append:evb-npcm845 = " -Dredfish-new-powersubsystem-thermalsubsystem=enabled"

# Enable debug
EXTRA_OEMESON:append:evb-npcm845 = " -Dbmcweb-logging=enabled"

# RDE test
EXTRA_OEMESON:append:evb-npcm845 = " -Dredfish-aggregation=enabled"
SRC_URI:append:evb-npcm845 = " \
    file://0001-bmcweb-Add-RDE-Device-aggregation-support.patch \
    file://0002-bmcweb-Add-dbus-interface-calls-to-RDEd.patch \
    file://0003-bmcweb-send-payload-to-RDE-devices-for-POST-operatio.patch \
"
