FILESEXTRAPATHS_prepend_buv-entity := "${THISDIR}/${PN}:"

SRC_URI_append_buv-entity = " \
    file://0001-add-Unit-property-in-Value-interface.patch \
    file://0002-add-Scale-d-bus-interface-property.patch \
    "
