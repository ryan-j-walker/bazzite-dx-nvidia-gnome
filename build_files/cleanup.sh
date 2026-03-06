#!/bin/bash

set -ouex pipefail

### Cleanup

echo "Cleaning up"

# Remove vscode repo file
rm -f /etc/yum.repos.d/vscode.repo

# Remove Steam from autostart
rm -f /etc/xdg/autostart/steam.desktop

# Remove desktop entries
rm -f /usr/share/applications/waydroid-container-restart.desktop