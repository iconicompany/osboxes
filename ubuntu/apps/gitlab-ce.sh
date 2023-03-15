set -e
if [ -z "$EXTERNAL_URL" ]
  then echo "usage EXTERNAL_URL=https://gitlab.example.com" $0
  exit 1
fi

sudo apt-get install -y curl openssh-server ca-certificates tzdata perl
sudo apt-get install -y postfix

curl -LO https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh

sudo bash script.deb.sh

sudo EXTERNAL_URL=$EXTERNAL_URL apt install gitlab-ce
