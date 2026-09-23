#!/bin/bash
set -e

# Установка FluffyChat Desktop (клиент Matrix) из официального релиза GitHub
# https://github.com/krille-chan/fluffychat
# Использование: ./fluffychat.sh [версия]   (по умолчанию — последняя, например v2.9.5)

export DEBIAN_FRONTEND=noninteractive

APP_ID="chat.fluffy.fluffychat"
APP_DIR="/opt/fluffychat"
REPO="krille-chan/fluffychat"

# ставит первый доступный пакет из списка (имена библиотек различаются между релизами Ubuntu)
apt_first() {
    for p in "$@"; do
        if apt-cache show "$p" >/dev/null 2>&1; then
            sudo apt install -y "$p"
            return
        fi
    done
    echo "Предупреждение: не найден ни один из пакетов: $*"
}

echo "=== 1. Определение версии и архитектуры ==="
DEB_ARCH=$(dpkg --print-architecture)
case "$DEB_ARCH" in
    amd64) ARCH=x64 ;;
    arm64) ARCH=arm64 ;;
    *) echo "Ошибка: неподдерживаемая архитектура $DEB_ARCH"; exit 1 ;;
esac
VERSION="${1:-$(curl -sSL "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')}"
if [ -z "$VERSION" ]; then
    echo "Ошибка: не удалось определить версию релиза"
    exit 1
fi
echo "FluffyChat $VERSION, архитектура: $ARCH"

echo "=== 2. Установка зависимостей ==="
sudo apt update
sudo apt install -y curl ca-certificates libsecret-1-0 libsqlite3-0
apt_first libgtk-3-0t64 libgtk-3-0
apt_first libwebkit2gtk-4.1-0 libwebkit2gtk-4.0-37

echo "=== 3. Скачивание архива ==="
TARBALL="fluffychat-linux-${ARCH}.tar.gz"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
curl -fL --progress-bar -o "${TMP}/${TARBALL}" \
    "https://github.com/${REPO}/releases/download/${VERSION}/${TARBALL}"

echo "=== 4. Установка в ${APP_DIR} ==="
sudo rm -rf "$APP_DIR"
sudo mkdir -p "$APP_DIR"
sudo tar xzf "${TMP}/${TARBALL}" -C "$APP_DIR"
sudo chown -R root:root "$APP_DIR"
sudo chmod +x "${APP_DIR}/fluffychat"
sudo ln -sf "${APP_DIR}/fluffychat" /usr/local/bin/fluffychat

echo "=== 5. Иконка и пункт меню ==="
ICON=$(find "${APP_DIR}/data/flutter_assets/assets/logo" -name 'logo_mini.png' -o -name 'logo.png' 2>/dev/null | head -1)
if [ -n "$ICON" ]; then
    sudo install -Dm644 "$ICON" /usr/share/pixmaps/fluffychat.png
else
    echo "Предупреждение: иконка в архиве не найдена"
fi
sudo tee /usr/share/applications/${APP_ID}.desktop >/dev/null <<EOF
[Desktop Entry]
Type=Application
Name=FluffyChat
GenericName=Matrix Client
Comment=The cutest messenger in the [matrix]
Exec=${APP_DIR}/fluffychat %u
Icon=fluffychat
Terminal=false
Categories=Network;InstantMessaging;Chat;
MimeType=x-scheme-handler/matrix;
Keywords=matrix;chat;messenger;
StartupNotify=true
StartupWMClass=${APP_ID}
EOF
sudo update-desktop-database /usr/share/applications >/dev/null 2>&1 || true

echo "=== Установка успешно завершена! ==="
echo "Версия: ${VERSION}, каталог: ${APP_DIR}"
echo "Запуск: fluffychat (или из меню приложений)"
echo "Удаление: sudo rm -rf ${APP_DIR} /usr/local/bin/fluffychat /usr/share/applications/${APP_ID}.desktop /usr/share/pixmaps/fluffychat.png"
