SUMMARY = "Nuvoton NPCM8XX bootloader"
DESCRIPTION = "Put boot images to one signed boot loader"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

IGPS_BRANCH ?= "main"
SRC_URI = " \
    git://github.com/Nuvoton-Israel/igps-npcm8xx;branch=${IGPS_BRANCH};protocol=https \
"
SRC_URI += " \
    file://0001-Add-SA-pre-signed-combo0-support.patch \
    file://0002-config_replacer-add-comment-in-settings-support.patch"
SRCREV = "e40802335270a2af6744d9160c7eae15b5777217"

S = "${WORKDIR}/git"

DEPENDS = " \
    npcm8xx-tip-fw npcm8xx-bootblock trusted-firmware-a optee-os \
    u-boot-nuvoton npcm7xx-bingo-native openssl-native \
"
inherit obmc-phosphor-utils
inherit python3native deploy
FILE_FMT = "file://{}"

# Sign keys, replace them for production
KEYS ?= "skmt_ecc_key_0.der skmt_ecc_key_1.der"
# Configuration files
CSVS ?= "registers_bootblock.csv"
SETTINGS ?= "settings.json"
CONFS ?= "${KEYS} ${CSVS} ${SETTINGS}"
SRC_URI += "${@compose_list(d, 'FILE_FMT', 'CONFS')}"

IGPS_DIR = "${S}"
INPUT_FOLDER = "${IGPS_DIR}/py_scripts/ImageGeneration/inputs"
KEY_FOLDER = "${IGPS_DIR}/py_scripts/ImageGeneration/keys/openssl"
CSV_FOLDER = "${INPUT_FOLDER}/registers"

# combo 0
#TIP_BIN   = "Kmt_TipFwL0_Skmt_TipFwL1.bin"
#SA_TIP_BIN = "SA_Kmt_TipFwL0.bin"
# combo 1
BB_BIN = "arbel_a35_bootblock"
BB_BIN .= "${@'_no_tip.bin' if d.getVar("TIP_IMAGE") != 'True' else '.bin'}"
BL31_BIN  = "bl31.bin"
OPTEE_BIN = "tee.bin"
UBOOT_BIN = "u-boot.bin"
# outout binary
TIP_OUT_BIN = "Kmt_TipFwL0_Skmt_TipFwL1_BootBlock_BL31_Tee_uboot.bin"
NO_TIP_OUT_BIN = "image_no_tip.bin"
SA_NO_TIP_OUT_BIN = "image_no_tip_SA.bin"
BOOTLOADER = "u-boot.bin.merged"

do_configure() {
    cd ${WORKDIR}
    echo ${INPUT_FOLDER}
    # keys
    install -d ${KEY_FOLDER}
    if [ -n "${KEYS}" ];then
        cp -v ${KEYS} ${KEY_FOLDER}
    fi

    # csv files
    install -d ${CSV_FOLDER}
    if [ -n ${CSVS} ];then
        cp -v ${CSVS} ${CSV_FOLDER}
    fi

    # copy Openbmc built images
    cd ${DEPLOY_DIR_IMAGE}
    cp -v ${BB_BIN} ${BL31_BIN} ${OPTEE_BIN} ${UBOOT_BIN} ${INPUT_FOLDER}

    # change customized settings for XML and key setting
    if [ -n ${SETTINGS} ];then
        cd ${IGPS_DIR}
        python3 ${IGPS_DIR}/py_scripts/ImageGeneration/config_replacer.py ../${SETTINGS}
    fi
}

do_compile() {
    cd ${IGPS_DIR}/py_scripts/ImageGeneration
    install -d output_binaries/tmp
    install -d inputs/key_input
    if [ "${TIP_IMAGE}" = "True" ] || [ "${SA_TIP_IMAGE}" = "True" ];then
      # Do not sign combo0 image again
      python3 ${IGPS_DIR}/py_scripts/GenerateAll.py openssl ${DEPLOY_DIR_IMAGE}
    else
      # for No TIP, we can run IGPS script directly
      python3 ${IGPS_DIR}/py_scripts/GenerateAll.py openssl
    fi
}

do_deploy() {
    OUT="${IGPS_DIR}/py_scripts/ImageGeneration/output_binaries"
    install -d ${DEPLOYDIR}
    if [ "${SA_TIP_IMAGE}" = "True" ];then
        install -m 644 ${OUT}/Secure/${SA_NO_TIP_OUT_BIN} ${DEPLOYDIR}/${BOOTLOADER}
    elif [ "${TIP_IMAGE}" = "True" ];then
        install -m 644 ${OUT}/Secure/${TIP_OUT_BIN} ${DEPLOYDIR}/${BOOTLOADER}
    else
        install -m 644 ${OUT}/Basic/${NO_TIP_OUT_BIN} ${DEPLOYDIR}/${BOOTLOADER}
    fi
}
addtask deploy before do_build after do_compile
PACKAGE_ARCH = "${MACHINE_ARCH}"
