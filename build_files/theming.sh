#!/bin/bash

set -ouex pipefail

### Install Icons/Themes

echo "Installation of MoreWaita icons started"

git clone https://github.com/somepaulo/MoreWaita.git
./MoreWaita/install.sh
rm -rf ./MoreWaita

echo "Installation of Gnome Round Corner Blur Library"
curl https://raw.githubusercontent.com/aunetx/blur-my-shell/refs/heads/master/scripts/rounded_blur_build.sh | bash -s -- -i