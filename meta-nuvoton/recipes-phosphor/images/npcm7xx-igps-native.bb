LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"


SRC_URI = "	\
		git://github.com/nuvoton-israel/igps;protocol=git;name=igps; \
		git://github.com/nuvoton-israel/bingo;protocol=git;name=bingo;destsuffix=git/bingo \
		git://github.com/nuvoton-israel/sign-it;protocol=git;name=signit;destsuffix=git/signit\
		git://github.com/nuvoton-israel/uart-update-tool;protocol=git;name=uut;destsuffix=git/uut \
		file://001-igps-remove-sudo.patch \
		file://0001-add-current-path-for-runbmc.patch \
"

SRCREV_FORMAT = "igps_bingo_signit_uut"
SRCREV_igps = "311e0ee44b63341bd5760c72bb94daef2a8f87c2"
SRCREV_bingo = "4f102ff7851da9fd11965857edd1b3046c187b7a"
SRCREV_signit = "74b3fea803b0cdb194ffe9c237e03194620c1ee3"
SRCREV_uut = "172f280658cb4654bf4d1a16c00df4f7c6c6e7dd"

S = "${WORKDIR}/git"

do_compile() {
    oe_runmake -C bingo
    oe_runmake -C signit
    oe_runmake -C uut
}

IGPS_DEST_DIR = "${D}${bindir}/igps"

do_install () {

	install -d ${IGPS_DEST_DIR}
	cp -R ./*  ${IGPS_DEST_DIR}

	install bingo/deliverables/linux/Release/bingo ${IGPS_DEST_DIR}/ImageGeneration
	rm -rf ${IGPS_DEST_DIR}/bingo/

	install signit/deliverables/linux/release/signit ${IGPS_DEST_DIR}/ImageGeneration
	rm -rf ${IGPS_DEST_DIR}/signit/

	install uut/release/Uartupdatetool ${IGPS_DEST_DIR}/ImageProgramming
	rm -rf ${IGPS_DEST_DIR}/uut/
}

inherit native
