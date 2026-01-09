#!/usr/bin/env bash
set -e

TEMP_DIR="/tmp/temporal-install"
BIN_PATH="/usr/local/bin/temporal"
SERVICE_NAME="temporal-dev"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
USER="temporal"
WORKDIR="/var/lib/temporal"

echo "==> Installing dependencies"
sudo apt-get update -y
sudo apt-get install -y wget tar

echo "==> Downloading Temporal CLI"
rm -rf "${TEMP_DIR}"
mkdir -p "${TEMP_DIR}"

wget -qO- "https://temporal.download/cli/archive/latest?platform=linux&arch=amd64" \
  | tar zxvf - -C "${TEMP_DIR}"

echo "==> Installing Temporal binary"
sudo mv -f "${TEMP_DIR}/temporal" "${BIN_PATH}"
sudo chmod +x "${BIN_PATH}"

echo "==> Temporal version"
temporal -v

echo "==> Creating system user"
if ! id "${USER}" &>/dev/null; then
  sudo useradd -r -s /bin/false "${USER}"
fi

echo "==> Creating work directory"
sudo mkdir -p "${WORKDIR}"
sudo chown "${USER}:${USER}" "${WORKDIR}"

echo "==> Creating systemd service"
sudo tee "${SERVICE_FILE}" >/dev/null <<EOF
[Unit]
Description=Temporal Server (Dev Mode)
After=network.target
Wants=network.target

[Service]
Type=simple
User=${USER}
Group=${USER}
WorkingDirectory=${WORKDIR}
ExecStart=${BIN_PATH} server start-dev --ip 0.0.0.0 --ui-ip 0.0.0.0
Restart=always
RestartSec=5
LimitNOFILE=65536
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

echo "==> Enabling and starting service"
sudo systemctl daemon-reload
sudo systemctl enable "${SERVICE_NAME}"
sudo systemctl start "${SERVICE_NAME}"

echo "==> Done"
echo "UI: http://localhost:8233"
echo "Logs: journalctl -u ${SERVICE_NAME} -f"

