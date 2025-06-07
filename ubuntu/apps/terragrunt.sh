set -e
LATEST_VERSION=$(curl -s https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
curl -L -o /tmp/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/$LATEST_VERSION/terragrunt_linux_amd64
chmod +x /tmp/terragrunt
sudo mv /tmp/terragrunt /usr/local/bin/terragrunt

terragrunt --help
