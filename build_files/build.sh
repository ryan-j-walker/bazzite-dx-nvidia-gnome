#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y solaar wine-mono
dnf5 remove -y epiphany ffmpeg fish Sunshine waydroid
wget https://proton.me/download/bridge/protonmail-bridge-3.21.2-1.x86_64.rpm
dnf5 install -y ./protonmail-bridge-3.21.2-1.x86_64.rpm
rm -f ./protonmail-bridge-3.21.2-1.x86_64.rpm
dnf5 autoremove -y


# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
systemctl enable brew-setup.service

# Remove Steam from autostart
rm -f /etc/xdg/autostart/steam.desktop

# Remove desktop entries
rm -f /usr/share/applications/waydroid-container-restart.desktop

# Install MoreWaita Icons
git clone https://github.com/somepaulo/MoreWaita.git 
./MoreWaita/install.sh
rm -rf ./MoreWaita

# Download Nerd Font
URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download"
FONT="FiraCode"
DEST="/usr/share/fonts/nerd-fonts"

echo "Installation of nerd-fonts started"

mkdir -p /tmp/fonts
rm -rf "${DEST}/${FONT}"
mkdir -p "${DEST}/${FONT}"

echo "Downloading ${FONT} from ${URL}/${FONT}.tar.xz"
curl -fLsS --retry 5 --create-dirs "${URL}/${FONT}.tar.xz" -o "/tmp/fonts/${FONT}.tar.xz"
echo "Downloaded ${FONT}"

tar -xf "/tmp/fonts/${FONT}.tar.xz" -C "${DEST}/${FONT}"
rm -rf /tmp/fonts

fc-cache --system-only --really-force "${DEST}"
