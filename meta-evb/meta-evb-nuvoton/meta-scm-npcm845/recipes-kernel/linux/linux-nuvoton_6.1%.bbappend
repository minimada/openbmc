FILESEXTRAPATHS:prepend := "${THISDIR}/linux-nuvoton:"

SRC_URI:append:scm-npcm845 = " file://nuvoton-npcm845-scm.dts;subdir=git/arch/${ARCH}/boot/dts/nuvoton "
SRC_URI:append:scm-npcm845 = " file://0001-kernel-scm-dts.patch"
#SRC_URI:append:scm-npcm845 = " file://m1120-c219b.dts;subdir=git/arch/${ARCH}/boot/dts/nuvoton"
#SRC_URI:append:scm-npcm845 = " file://0001-kernel-m1120-dts.patch"
SRC_URI:append:scm-npcm845 = " file://0002-rtl8211f-customized-led.patch"
SRC_URI:append:scm-npcm845 = " file://scm-npcm845.cfg"
SRC_URI:append:scm-npcm845 = " file://enable-v4l2.cfg"

SRC_URI:append:scm-npcm845 = " file://0006-Add-DVO-slew-rate-and-remove-smb11-default-pinctrl.patch"
