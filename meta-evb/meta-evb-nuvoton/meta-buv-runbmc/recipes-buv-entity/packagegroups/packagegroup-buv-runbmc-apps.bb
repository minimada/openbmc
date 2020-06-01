SUMMARY = "OpenBMC for BUV Nuvoton system - Applications"
PR = "r1"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = " \
        ${PN}-fans \
        ${PN}-flash \
        ${PN}-system \
        "

# PROVIDES += "virtual/obmc-fan-mgmt"
# PROVIDES += "virtual/obmc-flash-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"

# RPROVIDES_${PN}-fans += "virtual-obmc-fan-mgmt"
# RPROVIDES_${PN}-flash += "virtual-obmc-flash-mgmt"
RPROVIDES_${PN}-system += "virtual-obmc-system-mgmt"

# SUMMARY_${PN}-fans = "BUV NUVOTON Fans"
# RDEPENDS_${PN}-fans = " \
#        "

# SUMMARY_${PN}-flash = "BUV NUVOTON Flash"
# RDEPENDS_${PN}-flash = " \
#        "

SUMMARY_${PN}-system = "BUV NUVOTON System"
RDEPENDS_${PN}-system = " \
        entity-manager \
        obmc-ikvm \
        obmc-console \
        dhcpcd \
        phosphor-ipmi-fru \
        phosphor-sel-logger \
        phosphor-ipmi-blobs \
        intel-ipmi-oem \
        ipmitool \
        phosphor-image-signing \
        e2fsprogs-mke2fs \
        "
