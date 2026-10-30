#!/bin/bash
set -e

# CC Switch installer and systemd service setup for Ubuntu / Debian
# Project: https://github.com/farion1231/cc-switch

TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME=$(eval echo "~${TARGET_USER}")
TARGET_UID=$(id -u "${TARGET_USER}")

ARCH=$(uname -m)
case "$ARCH" in
  x86_64)
    PKG_ARCH="x86_64"
    ;;
  aarch64|arm64)
    PKG_ARCH="arm64"
    ;;
  *)
    echo "Unsupported architecture: $ARCH" >&2
    exit 1
    ;;
esac

echo "==> Detecting latest CC Switch release..."
LATEST_TAG=$(curl -fsSLI -o /dev/null -w '%{url_effective}' https://github.com/farion1231/cc-switch/releases/latest | sed 's#.*/tag/##')

if [ -z "$LATEST_TAG" ]; then
  LATEST_TAG=$(curl -s https://api.github.com/repos/farion1231/cc-switch/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
fi

if [ -z "$LATEST_TAG" ]; then
  echo "Failed to determine latest CC Switch version." >&2
  exit 1
fi

DEB_NAME="CC-Switch-${LATEST_TAG}-Linux-${PKG_ARCH}.deb"
DEB_URL="https://github.com/farion1231/cc-switch/releases/download/${LATEST_TAG}/${DEB_NAME}"
TEMP_DEB="/tmp/${DEB_NAME}"

echo "==> Downloading CC Switch ${LATEST_TAG} (${PKG_ARCH})..."
curl -fL -o "${TEMP_DEB}" "${DEB_URL}"

echo "==> Installing ${DEB_NAME}..."
sudo apt install -y "${TEMP_DEB}"
rm -f "${TEMP_DEB}"

echo "==> Creating launcher wrapper (/usr/local/bin/cc-switch-service)..."
sudo tee /usr/local/bin/cc-switch-service > /dev/null << 'EOF'
#!/bin/bash
USER_ID=$(id -u)

# Ensure runtime and dbus environment variables are configured
if [ -z "$XDG_RUNTIME_DIR" ] && [ -d "/run/user/$USER_ID" ]; then
  export XDG_RUNTIME_DIR="/run/user/$USER_ID"
fi

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && [ -n "$XDG_RUNTIME_DIR" ] && [ -S "$XDG_RUNTIME_DIR/bus" ]; then
  export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
fi

# Detect active X display if not set
if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
  if [ -e /tmp/.X11-unix/X1 ]; then
    export DISPLAY=:1
  elif [ -e /tmp/.X11-unix/X0 ]; then
    export DISPLAY=:0
  fi
fi

# Fallback to xvfb if no graphical display is available
if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && command -v xvfb-run >/dev/null 2>&1; then
  exec xvfb-run -a /usr/bin/cc-switch "$@"
else
  exec /usr/bin/cc-switch "$@"
fi
EOF
sudo chmod +x /usr/local/bin/cc-switch-service

echo "==> Creating systemd service (/etc/systemd/system/cc-switch.service)..."
sudo tee /etc/systemd/system/cc-switch.service > /dev/null << EOF
[Unit]
Description=CC Switch Service
After=network.target

[Service]
Type=simple
User=${TARGET_USER}
Group=$(id -gn "${TARGET_USER}")
WorkingDirectory=${TARGET_HOME}
Environment=HOME=${TARGET_HOME}
Environment=USER=${TARGET_USER}
Environment=XDG_RUNTIME_DIR=/run/user/${TARGET_UID}
Environment=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/${TARGET_UID}/bus
Environment=XAUTHORITY=${TARGET_HOME}/.Xauthority
ExecStart=/usr/local/bin/cc-switch-service
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

echo "==> Enabling and starting cc-switch service..."
sudo systemctl daemon-reload
sudo systemctl enable cc-switch
sudo systemctl restart cc-switch

echo "==> CC Switch installed and service started successfully!"
echo "Service status: sudo systemctl status cc-switch"
echo "Logs:           journalctl -u cc-switch -f"
