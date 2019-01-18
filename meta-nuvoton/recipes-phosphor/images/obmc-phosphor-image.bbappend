FLASH_UBOOT_OFFSET = "0"
FLASH_KERNEL_OFFSET = "2048"
FLASH_UBI_OFFSET = "${FLASH_KERNEL_OFFSET}"
FLASH_ROFS_OFFSET = "7680"
FLASH_RWFS_OFFSET = "30720"

# UBI volume sizes in KB unless otherwise noted.
FLASH_UBI_RWFS_SIZE = "6144"
FLASH_UBI_RWFS_TXT_SIZE = "6MiB"

UBOOT_MERGED_SUFFIX = "${UBOOT_SUFFIX}.merged"

IGPS_DIR = "${STAGING_DIR_NATIVE}/${bindir}/igps"
IGPS_INPUTS_DIR = "${IGPS_DIR}/ImageGeneration/inputs"
IGPS_OUTPUTS_BASIC_DIR  = "${IGPS_DIR}/ImageGeneration/output_binaries/Basic"
IGPS_OUTPUTS_SECURE_DIR = "${IGPS_DIR}/ImageGeneration/output_binaries/Secure"
IGPS_OUTPUT_MERGED_BIN = "${IGPS_OUTPUTS_BASIC_DIR}/mergedBootBlockAndUboot.bin"

do_prepare_merged_bb_uboot () {

	# take Nuvoton's EB inputs
	python ${IGPS_DIR}/UpdateInputsBinaries_RunBMC.py

	# override bootblock and u-boot with the images built by openbmc
	cp ${DEPLOY_DIR_IMAGE}/Poleg_bootblock.bin     ${IGPS_INPUTS_DIR}/
	cp ${DEPLOY_DIR_IMAGE}/u-boot.${UBOOT_SUFFIX}  ${IGPS_INPUTS_DIR}/

	# generate merged bootblock and u-boot image (including their headers)
	python ${IGPS_DIR}/GenerateAll.py

	# get the merged image
	cp ${IGPS_OUTPUT_MERGED_BIN} ${DEPLOY_DIR_IMAGE}/u-boot.${UBOOT_MERGED_SUFFIX}
}
do_prepare_merged_bb_uboot[depends] += " \
        u-boot-fw-utils-nuvoton:do_populate_sysroot \
        u-boot-nuvoton:do_deploy          \
        npcm750-bootblock:do_deploy                 \
        npcm7xx-igps-native:do_populate_sysroot     "

addtask do_prepare_merged_bb_uboot


do_make_ubi_append() {

	# Concatenate the uboot and ubi partitions
	mk_nor_image ${IMGDEPLOYDIR}/${IMAGE_NAME}.ubi.mtd ${FLASH_SIZE}
	dd bs=1k conv=notrunc seek=${FLASH_UBOOT_OFFSET} \
		if=${DEPLOY_DIR_IMAGE}/u-boot.${UBOOT_MERGED_SUFFIX} \
		of=${IMGDEPLOYDIR}/${IMAGE_NAME}.ubi.mtd
}
do_make_ubi[depends] += "${PN}:do_prepare_merged_bb_uboot"


do_generate_static_append () {

    _append_image(os.path.join(d.getVar('DEPLOY_DIR_IMAGE', True),
                               'u-boot.%s' % d.getVar('UBOOT_MERGED_SUFFIX',True)),
                  int(d.getVar('FLASH_UBOOT_OFFSET', True)),
                  int(d.getVar('FLASH_KERNEL_OFFSET', True)))
}
do_generate_static[depends] += "${PN}:do_prepare_merged_bb_uboot"


make_image_links_append () {
	# link image-u-boot under obmc-phosphor-image folder to u-boot.bin.merged
	ln -sf ${DEPLOY_DIR_IMAGE}/u-boot.${UBOOT_MERGED_SUFFIX} image-u-boot
}
make_image_links[depends] += "${PN}:do_prepare_merged_bb_uboot"


do_mk_static_symlinks_append () {
	# link image-u-boot under deploy folder to u-boot.bin.merged
	ln -sf u-boot.${UBOOT_MERGED_SUFFIX} ${IMGDEPLOYDIR}/image-u-boot
}
do_mk_static_symlinks[depends] += "${PN}:do_prepare_merged_bb_uboot"
