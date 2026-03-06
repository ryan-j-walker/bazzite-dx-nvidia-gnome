#!/bin/bash

set -ouex pipefail

### Install Nerd Fonts
# Credit to Bluebuild https://github.com/blue-build/modules/blob/main/modules/fonts/sources/nerd-fonts.sh

FONTS=("JetBrainsMono")
URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download"
DEST="/usr/share/fonts/nerd-fonts"

echo "Installation of Nerd Fonts started"

mkdir -p /tmp/fonts
for FONT in "${FONTS[@]}"; do
    FONT=${FONT// /} # remove spaces
    if [ ${#FONT} -gt 0 ]; then
        rm -rf "${DEST}/${FONT}"
        mkdir -p "${DEST}/${FONT}"

        echo "Downloading ${FONT} from ${URL}/${FONT}.tar.xz"
        curl -fLsS --retry 5 --create-dirs "${URL}/${FONT}.tar.xz" -o "/tmp/fonts/${FONT}.tar.xz"
        echo "Downloaded ${FONT}"

        tar -xf "/tmp/fonts/${FONT}.tar.xz" -C "${DEST}/${FONT}"
    fi
done
rm -rf /tmp/fonts

fc-cache --system-only --really-force "${DEST}"