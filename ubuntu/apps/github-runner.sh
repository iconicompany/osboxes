set -e
id -u runner &>/dev/null || sudo useradd -m runner
sudo -u runner bash -c "cd /home/runner;
curl -o actions-runner-linux-x64-2.324.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.324.0/actions-runner-linux-x64-2.324.0.tar.gz;
tar xzf ./actions-runner-linux-x64-2.324.0.tar.gz;
rm actions-runner-linux-x64-2.324.0.tar.gz"

