SRC_URI_append_df-phosphor-mmc = " file://u-boot-emmc.cfg"
SRC_URI_append_df-phosphor-mmc = " file://u-boot-env-emmc.txt"

UBOOT_ENV_SIZE_df-phosphor-mmc = "0x40000"
UBOOT_ENV_df-phosphor-mmc = "u-boot-env"
UBOOT_ENV_SUFFIX_df-phosphor-mmc = "bin"
UBOOT_ENV_TXT_df-phosphor-mmc = "u-boot-env-emmc.txt"

do_compile_append() {
    if [ -n "${UBOOT_ENV}" ]
    then
        # Generate redundant environment image
        ${B}/tools/mkenvimage -s ${UBOOT_ENV_SIZE} -p 0 -o ${WORKDIR}/${UBOOT_ENV_BINARY} ${WORKDIR}/${UBOOT_ENV_TXT}
    fi
}
