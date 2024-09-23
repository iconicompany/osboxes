set -e
VERSION=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
V=${VERSION#*v}
cd /tmp
wget -O obsidian.deb https://github.com/obsidianmd/obsidian-releases/releases/download/${VERSION}/obsidian_${V}_amd64.deb
sudo apt install -y ./obsidian.deb
rm obsidian.deb