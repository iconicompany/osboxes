# Claude Desktop for Linux (beta), official Anthropic apt repo
# https://code.claude.com/docs/en/desktop-linux
# Requires Ubuntu 22.04+ / Debian 12+, amd64 or arm64
set -e

sudo apt install -y curl gnupg

# Add the GPG key
sudo curl -fsSLo /usr/share/keyrings/claude-desktop-archive-keyring.asc https://downloads.claude.ai/claude-desktop/key.asc

# Verify it belongs to Anthropic before trusting the repo
gpg --show-keys /usr/share/keyrings/claude-desktop-archive-keyring.asc | grep -q 31DDDE24DDFAB679F42D7BD2BAA929FF1A7ECACE

# Add the repository
echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/claude-desktop-archive-keyring.asc] https://downloads.claude.ai/claude-desktop/apt/stable stable main" | sudo tee /etc/apt/sources.list.d/claude-desktop.list

# Update and install
sudo apt update
sudo apt install -y claude-desktop

# Updates arrive with regular `sudo apt upgrade`, the app does not self-update on Linux.
# Uninstall: sudo apt remove claude-desktop && sudo rm -f /etc/apt/sources.list.d/claude-desktop.list
