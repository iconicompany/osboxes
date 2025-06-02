sudo apt install curl wget gnupg2 apt-transport-https -y

sudo wget -O /usr/share/keyrings/matrix-org-archive-keyring.gpg https://packages.matrix.org/debian/matrix-org-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/matrix-org-archive-keyring.gpg] https://packages.matrix.org/debian/ $(lsb_release -cs) main" |sudo tee /etc/apt/sources.list.d/matrix-org.list

sudo apt update && sudo apt install matrix-synapse-py3

sudo systemctl enable --now matrix-synapse

#systemctl status matrix-synapse
