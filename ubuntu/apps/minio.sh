#!/bin/bash
set -e

# Переменные для удобства изменения
MINIO_USER="minio-user"
MINIO_GROUP="minio-user"
MINIO_DATA_DIR="/var/lib/minio"
MINIO_CONF_DIR="/etc/default"

echo "=== 1. Проверка и установка uuidgen ==="
if ! command -v uuidgen &> /dev/null; then
    echo "uuidgen не найден. Устанавливаем uuid-runtime..."
    sudo apt-get update && sudo apt-get install -y uuid-runtime
fi

# Генерируем уникальный пароль
GENERATED_PASSWORD=$(uuidgen)
echo "Сгенерирован новый пароль: $GENERATED_PASSWORD"

echo "=== 2. Скачивание и установка MinIO и MC ==="
cd /tmp
wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20250524170830.0.0_amd64.deb -O minio.deb
sudo dpkg -i minio.deb
rm minio.deb

curl -o mc-minio https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc-minio
sudo mv mc-minio /usr/local/bin/mc-minio

echo "=== 3. Создание системного пользователя и группы ==="
if ! getent group "$MINIO_GROUP" > /dev/null; then
    sudo groupadd --system "$MINIO_GROUP"
fi

if ! getent passwd "$MINIO_USER" > /dev/null; then
    sudo useradd -s /sbin/nologin --system -g "$MINIO_GROUP" "$MINIO_USER"
fi

echo "=== 4. Создание каталога для данных и настройка прав ==="
sudo mkdir -p "$MINIO_DATA_DIR"
sudo chown -R "$MINIO_USER":"$MINIO_GROUP" "$MINIO_DATA_DIR"

echo "=== 5. Создание конфигурационного файла ==="
sudo mkdir -p "$MINIO_CONF_DIR"

sudo tee "$MINIO_CONF_DIR/minio" > /dev/null <<EOF
# MINIO_ROOT_USER and MINIO_ROOT_PASSWORD sets the root account for the MinIO server.
# This user has unrestricted permissions to perform S3 and administrative API operations on any resource in the deployment.
# Omit to use the default values 'minioadmin:minioadmin'.
# MinIO recommends setting non-default values as a best practice, regardless of environment

MINIO_ROOT_USER=root
MINIO_ROOT_PASSWORD=$GENERATED_PASSWORD

# MINIO_VOLUMES sets the storage volume or path to use for the MinIO server.
MINIO_VOLUMES="$MINIO_DATA_DIR"

# MINIO_OPTS sets any additional commandline options to pass to the MinIO server.
# For example, \`--console-address :9001\` sets the MinIO Console listen port
MINIO_OPTS="--address localhost:9000 --console-address localhost:9001"
EOF

sudo chown "$MINIO_USER":"$MINIO_GROUP" "$MINIO_CONF_DIR/minio"
sudo chmod 600 "$MINIO_CONF_DIR/minio"

echo "=== 6. Включение и запуск сервиса MinIO ==="
sudo systemctl daemon-reload
sudo systemctl enable minio
sudo systemctl restart minio

echo "=== Установка успешно завершена! ==="
echo "Данные авторизации:"
echo "Пользователь: root"
echo "Пароль:       $GENERATED_PASSWORD"
