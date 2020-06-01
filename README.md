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
3. Follow the [NPCM7xx_OpenBMC_Programming.pdf](https://github.com/Nuvoton-Israel/nuvoton-info/blob/master/npcm7xx-poleg/evaluation-board/sw_deliverables/NPCM7xx_OpenBMC_Programming.pdf) chapter 2.2.2 programming topic to program BMC firmware. Additionally, please download the igps tool version 2.1.12 from [igps](https://github.com/Nuvoton-Israel/igps)

## OpenBMC Development

The OpenBMC community maintains a set of tutorials new users can go through
to get up to speed on OpenBMC development out
[here](https://github.com/openbmc/docs/blob/master/development/README.md)

## Build Validation and Testing
Commits submitted by members of the OpenBMC GitHub community are compiled and
tested via our [Jenkins](https://openpower.xyz/) server.  Commits are run
through two levels of testing.  At the repository level the makefile `make
check` directive is run.  At the system level, the commit is built into a
firmware image and run with an arm-softmmu QEMU model against a barrage of
[CI tests](https://openpower.xyz/job/openbmc-test-qemu-ci/).

Commits submitted by non-members do not automatically proceed through CI
testing. After visual inspection of the commit, a CI run can be manually
performed by the reviewer.

Automated testing against the QEMU model along with supported systems are
performed.  The OpenBMC project uses the
[Robot Framework](http://robotframework.org/) for all automation.  Our
complete test repository can be found
[here](https://github.com/openbmc/openbmc-test-automation).

## Submitting Patches
Support of additional hardware and software packages is always welcome.
Please follow the [contributing guidelines](https://github.com/openbmc/docs/blob/master/CONTRIBUTING.md)
when making a submission.  It is expected that contributions contain test
cases.

## Bug Reporting
[Issues](https://github.com/openbmc/openbmc/issues) are managed on
GitHub.  It is recommended you search through the issues before opening
a new one.

## Questions

First, please do a search on the internet. There's a good chance your question
has already been asked.

For general questions, please use the openbmc tag on
[Stack Overflow](https://stackoverflow.com/questions/tagged/openbmc).
Please review the [discussion](https://meta.stackexchange.com/questions/272956/a-new-code-license-the-mit-this-time-with-attribution-required?cb=1)
on Stack Overflow licensing before posting any code.

For technical discussions, please see [contact info](#contact) below for IRC and
mailing list information. Please don't file an issue to ask a question. You'll
get faster results by using the mailing list or IRC.

## Features of OpenBMC

**Feature List**
* Host management: Power, Cooling, LEDs, Inventory, Events, Watchdog
* Full IPMI 2.0 Compliance with DCMI
* Code Update Support for multiple BMC/BIOS images
* Web-based user interface
* REST interfaces
* D-Bus based interfaces
* SSH based SOL
* Remote KVM
* Hardware Simulation
* Automated Testing
* User management
* Virtual media

**Features In Progress**
* OpenCompute Redfish Compliance
* Verified Boot

**Features Requested but need help**
* OpenBMC performance monitoring


## Finding out more

Dive deeper into OpenBMC by opening the
[docs](https://github.com/openbmc/docs) repository.

## Technical Steering Committee

The Technical Steering Committee (TSC) guides the project. Members are:

 * Brad Bishop (chair), IBM
 * Nancy Yuen, Google
 * Sai Dasari, Facebook
 * James Mihm, Intel
 * Sagar Dharia, Microsoft
 * Supreeth Venkatesh, Arm

## Contact
- Mail: openbmc@lists.ozlabs.org [https://lists.ozlabs.org/listinfo/openbmc](https://lists.ozlabs.org/listinfo/openbmc)
- IRC: #openbmc on freenode.net
- Riot: [#openbmc:matrix.org](https://riot.im/app/#/room/#openbmc:matrix.org)
