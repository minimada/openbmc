SUMMARY = "Nuvoton NPCM8XX bootloader"
DESCRIPTION = "Put boot images to one signed boot loader"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

IGPS_BRANCH ?= "main"
SRC_URI = " \
    git://github.com/Nuvoton-Israel/igps-npcm8xx;branch=${IGPS_BRANCH};protocol=https \
    file://config_replacer.py \
"
SRCREV = "d1a2b585de580028a74fda4b90729cc5192bc28f"
S = "${WORKDIR}/git"

DEPENDS = " \
    npcm8xx-tip-fw npcm8xx-bootblock trusted-firmware-a optee-os \
    u-boot-nuvoton npcm7xx-bingo-native openssl-native \
"
inherit obmc-phosphor-utils
inherit python3native deploy
FILE_FMT = "file://{}"

# Sign keys, replace them for production
KEYS = "skmt_ecc_key_0.der skmt_ecc_key_1.der"
# Configuration files
CSVS = "registers_bootblock.csv"
CONFS = "${KEYS} ${CSVS} settings.json"
SRC_URI += "${@compose_list(d, 'FILE_FMT', 'CONFS')}"

IGPS_DIR = "${S}"
INPUT_FOLDER = "${IGPS_DIR}/py_scripts/ImageGeneration/inputs"
KEY_FOLDER = "${IGPS_DIR}/py_scripts/ImageGeneration/keys/openssl"
CSV_FOLDER = "${INPUT_FOLDER}/registers"

TIP_BIN   = "Kmt_TipFwL0_Skmt_TipFwL1.bin"
BB_BIN    = "arbel_a35_bootblock.bin"
BB_NO_TIP_BIN = "arbel_a35_bootblock_no_tip.bin"
BL31_BIN  = "bl31.bin"
OPTEE_BIN = "tee.bin"
UBOOT_BIN = "u-boot.bin"
COMBO1 = "${BB_BIN} ${BL31_BIN} ${OPTEE_BIN} ${UBOOT_BIN}"
BOOTLOADER = "Kmt_TipFwL0_Skmt_TipFwL1_BootBlock_BL31_Tee_uboot.bin"

do_configure() {
    cd ${WORKDIR}
    echo ${INPUT_FOLDER}
    # keys
    install -d ${KEY_FOLDER}
    cp -v ${KEYS} ${KEY_FOLDER}

    # csv files
    install -d ${CSV_FOLDER}
    cp -v ${CSVS} ${CSV_FOLDER}

    # images
    cd ${DEPLOY_DIR_IMAGE}
    cp -v ${COMBO1} ${INPUT_FOLDER}

    # combo0
    if [ "${TIP_IMAGE}" = "True" ]; then
        cp -v ${TIP_BIN} ${INPUT_FOLDER}
    else
        cp -v ${BB_NO_TIP_BIN} ${INPUT_FOLDER}
    fi

    # replace settings for XML and key setting
    cd ${IGPS_DIR}
    python3 ../config_replacer.py ../settings.json
}

do_compile() {
    cd ${IGPS_DIR}/py_scripts/ImageGeneration
    install -d output_binaries/tmp
    install -d inputs/key_input
    python3 ${IGPS_DIR}/py_scripts/GenerateAll.py openssl
}

do_deploy() {
    OUT="${IGPS_DIR}/py_scripts/ImageGeneration/output_binaries"
    install -d ${DEPLOYDIR}
    if [ "${TIP_IMAGE}" = "True" ];then
        install -m 644 ${OUT}/Secure/${BOOTLOADER} ${DEPLOYDIR}/u-boot.bin.merged
    else
        install -m 644 ${OUT}/Basic/${BOOTLOADER} ${DEPLOYDIR}/u-boot.bin.merged
    fi
}
addtask deploy before do_build after do_compile
PACKAGE_ARCH = "${MACHINE_ARCH}"
