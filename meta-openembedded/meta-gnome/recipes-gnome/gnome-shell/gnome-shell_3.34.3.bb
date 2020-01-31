SUMMARY = "GNOME Shell is the graphical shell of the GNOME desktop environment"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

GNOMEBASEBUILDCLASS = "meson"

inherit gnomebase gsettings gettext gobject-introspection features_check upstream-version-is-even bash-completion

REQUIRED_DISTRO_FEATURES = "x11 polkit systemd pam"

DEPENDS = " \
    libxml2-native \
    sassc-native \
    gtk+3 \
    mutter \
    evolution-data-server \
    gcr \
    gjs \
    gnome-autoar \
    polkit \
    libcroco \
    startup-notification \
    ibus \
    gsettings-desktop-schemas \
"

GTKDOC_MESON_OPTION = "gtk_doc"

# gobject-introspection is mandatory and cannot be configured
REQUIRED_DISTRO_FEATURES += "gobject-introspection-data"
UNKNOWN_CONFIGURE_WHITELIST_append = " introspection"

SRC_URI[archive.md5sum] = "a0f7d78f57616076890f0e3b7f12196a"
SRC_URI[archive.sha256sum] = "2474bef386c5a47d7be285aa22e24125c46ba5f860a25a1a36a90de4e456bd8a"

PACKAGECONFIG ??= "bluetooth nm ${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)}"
PACKAGECONFIG[bluetooth] = ",,gnome-bluetooth"
PACKAGECONFIG[nm] = "-Dnetworkmanager=true, -Dnetworkmanager=false, networkmanager"
PACKAGECONFIG[systemd] = "-Dsystemd=true, -Dsystemd=false, systemd"

EXTRA_OEMESON = " \
    -Dman=false \
"

do_install_append() {
    # fix shebangs
    for tool in `find ${D}${bindir} -name '*-tool'`; do
        sed -i 's:#!${PYTHON}:#!${bindir}/${PYTHON_PN}:' $tool
    done
}

FILES_${PN} += " \
    ${datadir}/dbus-1 \
    ${datadir}/gnome-control-center \
    ${datadir}/xdg-desktop-portal \
    ${systemd_user_unitdir} \
"

RDEPENDS_${PN} += "gsettings-desktop-schemas gdm-base librsvg-gtk"

PACKAGES =+ "${PN}-tools"
FILES_${PN}-tools = "${bindir}/*-tool"
RDEPENDS_${PN}-tools = "python3-core"

