set -e
if ! command -v dpkg > /dev/null; then
    LATEST_STEP_VERSION=$(curl -s https://api.github.com/repos/smallstep/cli/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    wget -qO - https://dl.smallstep.com/gh-release/cli/gh-release-header/${LATEST_STEP_VERSION}/step_linux_${LATEST_STEP_VERSION:1}_amd64.tar.gz | tar zxvf -  -C /tmp/
    sudo mv /tmp/step_${LATEST_STEP_VERSION:1}/bin/step /usr/local/bin
else
    deb=$(mktemp --suffix .deb)
    wget -O $deb https://dl.smallstep.com/cli/docs-ca-install/latest/step-cli_amd64.deb
    sudo dpkg -i $deb
    rm -f $deb
fi
step