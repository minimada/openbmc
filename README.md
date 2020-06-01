# OpenBMC

[![Build Status](https://openpower.xyz/buildStatus/icon?job=openbmc-build)](https://openpower.xyz/job/openbmc-build/)

The OpenBMC project can be described as a Linux distribution for embedded
devices that have a BMC; typically, but not limited to, things like servers,
top of rack switches or RAID appliances. The OpenBMC stack uses technologies
such as [Yocto](https://www.yoctoproject.org/),
[OpenEmbedded](https://www.openembedded.org/wiki/Main_Page),
[systemd](https://www.freedesktop.org/wiki/Software/systemd/), and
[D-Bus](https://www.freedesktop.org/wiki/Software/dbus/) to allow easy
customization for your server platform.


## Setting up your OpenBMC project

### 1) Prerequisite
- Ubuntu 14.04

```
sudo apt-get install -y git build-essential libsdl1.2-dev texinfo gawk chrpath diffstat
```

- Fedora 28

```
sudo dnf install -y git patch diffstat texinfo chrpath SDL-devel bitbake \
    rpcgen perl-Thread-Queue perl-bignum perl-Crypt-OpenSSL-Bignum
sudo dnf groupinstall "C Development Tools and Libraries"
```
### 2) Download the source
```
git clone https://github.com/NTC-CCBG/openbmc.git
cd openbmc
```

### 3) Target your hardware
Any build requires an environment variable known as `TEMPLATECONF` to be set
to a hardware target.
You can see all of the known targets with
`find meta-* -name local.conf.sample`. Choose the hardware target and
then move to the next step. Additional examples can be found in the
[OpenBMC Cheatsheet](https://github.com/openbmc/docs/blob/master/cheatsheet.md)

Machine | TEMPLATECONF
--------|---------
Nuvoton BUV | ```meta-evb/meta-evb-nuvoton/meta-buv-runbmc/conf```
Palmetto | ```meta-ibm/meta-palmetto/conf```
Zaius| ```meta-ingrasys/meta-zaius/conf```
Witherspoon| ```meta-ibm/meta-witherspoon/conf```
Romulus| ```meta-ibm/meta-romulus/conf```


As an example target Romulus
```
export TEMPLATECONF=meta-ibm/meta-romulus/conf
```

### 4) Build

```
. openbmc-env
bitbake obmc-phosphor-image
```

Additional details can be found in the [docs](https://github.com/openbmc/docs)
repository.

### 5) build images

After building finished the built Images will found at: <OpenBMC_folder>/build/tmp/deploy/images/buv-runbmc/ The relevant images to use to upload the OpenBMC on the Nuvoton BUV are:

1. image-bmc - The entire 64MB image including BootBlock, u-boot, linux kernel and file system, can be programmed into the beginning of flash
2. image-u-boot - Includes only BootBlock and u-boot and their headers can be programmed into the beginning of flash
3. image-kernel - FIT image that includes linux kernel, device tree and an initial file system, can be loaded to the linux area in flash
4. image-rofs - Main (and large) OpenBMC file system, can be loaded to the rofs area in flash

### 6) Programming the images

For programming the OpenBMC to the Nuvoton BUV platform, there are two ways to update BMC firmware. First, update BMC firmware image via OpenBMC web interface or RESTful API. Second, flash image via UART. In normal case we suggest user use the first method to update BMC firmware. User can follow the [firmware update readme](https://github.com/Nuvoton-Israel/openbmc/tree/runbmc/meta-quanta/meta-olympus-nuvoton#bmc-firmware-update) to upgrade BMC firmware.

Or program BMC firmware via UART by following instructions:
1. Enable BMC program mode, connect BUV J1701 pin4 and pin8
2. usb micro usb to connect J2006
3. Follow the [NPCM7xx_OpenBMC_Programming.pdf](https://github.com/Nuvoton-Israel/nuvoton-info/blob/master/npcm7xx-poleg/evaluation-board/sw_deliverables/NPCM7xx_OpenBMC_Programming.pdf) chapter 2.2.2 programming topic to program BMC firmware. Additionally, please download the igps tool version 2.1.12 from [IGPS](https://github.com/Nuvoton-Israel/igps)

### 7) OpenBMC user login

After the OpenBMC boot please enter the following login and password:
```
Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro) 0.1.0 buv-runbmc ttyS0

buv-runbmc login:root
Password: 0penBmc (first letter zero and not capital o)
```

### 8) Enabled features

[Olympus RunBMC Platform](https://github.com/Nuvoton-Israel/openbmc/tree/runbmc/meta-quanta/meta-olympus-nuvoton)

[BUV RunBMC Platform](https://github.com/NTC-CCBG/openbmc/tree/buv-dev/meta-evb/meta-evb-nuvoton/meta-buv-runbmc)


## Contact
- Mail: openbmc@lists.ozlabs.org [https://lists.ozlabs.org/listinfo/openbmc](https://lists.ozlabs.org/listinfo/openbmc)
- IRC: #openbmc on freenode.net
- Riot: [#openbmc:matrix.org](https://riot.im/app/#/room/#openbmc:matrix.org)
