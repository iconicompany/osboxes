# Download the script
sed -e

sudo apt install fd-find fzf
cd /tmp
curl -o llmcat https://raw.githubusercontent.com/azer/llmcat/main/llmcat
sed -i 's/\<fd\>/fdfind/g' llmcat

# Make it executable
chmod +x llmcat

# Move to your PATH
sudo mv llmcat /usr/local/bin/
