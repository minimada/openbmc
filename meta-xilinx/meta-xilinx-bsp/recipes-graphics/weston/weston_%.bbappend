FILESEXTRAPATHS_prepend_zynqmp := "${THISDIR}/files:"

SRC_URI_append_zynqmp = " file://0001-gl-renderer.c-Use-gr-egl_config-to-create-pbuffer-su.patch \
                          file://0001-libweston-Remove-substitute-format-for-ARGB8888.patch \
			"
