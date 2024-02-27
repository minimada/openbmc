UBOOT_BINARY := "u-boot.${UBOOT_SUFFIX}"
MERGED_SUFFIX = "merged"
UBOOT_SUFFIX:append = ".${MERGED_SUFFIX}"

FIT_KERNEL_COMP_ALG:df-obmc-static-norootfs = "gzip"
FIT_KERNEL_COMP_ALG_EXTENSION:df-obmc-static-norootfs = ".gz"

# link images for we only need to flash partial image with idea name
do_generate_ext4_tar:append() {
    cd ${DEPLOY_DIR_IMAGE}
    ln -sf ${UBOOT_BINARY}.${MERGED_SUFFIX} image-u-boot
    ln -sf ${DEPLOY_DIR_IMAGE}/${FLASH_KERNEL_IMAGE} image-kernel
    ln -sf ${S}/ext4/${IMAGE_LINK_NAME}.${FLASH_EXT4_BASETYPE}.zst image-rofs
    ln -sf ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.rwfs.${FLASH_EXT4_OVERLAY_BASETYPE} image-rwfs
    ln -sf ${IMAGE_NAME}.wic.gz image-emmc.gz
}

do_generate_static[depends] += "npcm8xx-bootloader:do_deploy"
do_generate_static_norootfs[depends] += "npcm8xx-bootloader:do_deploy"
do_generate_ext4_tar[depends] += "npcm8xx-bootloader:do_deploy"

# Include the full bootblock and u-boot in the final static image
python do_generate_static:append() {
    _append_image(os.path.join(d.getVar('DEPLOY_DIR_IMAGE', True),
                               'u-boot.%s' % d.getVar('UBOOT_SUFFIX',True)),
                  int(d.getVar('FLASH_UBOOT_OFFSET', True)),
                  int(d.getVar('FLASH_KERNEL_OFFSET', True)))
}

do_make_ubi:append() {
    # Concatenate the uboot and ubi partitions
    dd bs=1k conv=notrunc seek=${FLASH_UBOOT_OFFSET} \
        if=${DEPLOY_DIR_IMAGE}/u-boot.${UBOOT_SUFFIX} \
        of=${IMGDEPLOYDIR}/${IMAGE_NAME}.ubi.mtd
}

