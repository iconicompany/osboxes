#!/bin/bash
set -e

# Проверяем, передан ли первый параметр (имя пользователя)
if [ -z "$1" ]; then
    echo "Ошибка: Не указано имя пользователя!"
    echo "Использование: $0 <имя_пользователя>"
    exit 1
fi

NEW_USER="$1"

# Настройки подключения к локальному MinIO
MINIO_URL="http://localhost:9000"
ROOT_USER="root"

echo "=== 1. Получение ROOT_PASSWORD из конфигурации ==="
if [ ! -f /etc/default/minio ]; then
    echo "Ошибка: Конфигурационный файл /etc/default/minio не найден!"
    exit 1
fi

# Извлекаем root-пароль из существующего конфига
ROOT_PASSWORD=$(grep -E '^MINIO_ROOT_PASSWORD=' /etc/default/minio | cut -d'=' -f2)

if [ -z "$ROOT_PASSWORD" ]; then
    echo "Ошибка: Не удалось найти MINIO_ROOT_PASSWORD в файле конфигурации."
    exit 1
fi

echo "=== 2. Проверка и установка uuidgen ==="
if ! command -v uuidgen &> /dev/null; then
    echo "uuidgen не найден. Устанавливаем uuid-runtime..."
    sudo apt-get update && sudo apt-get install -y uuid-runtime
fi

# Генерируем надежный пароль
NEW_PASSWORD=$(uuidgen)

echo "=== 3. Настройка клиента mc-minio ==="
# Инициализируем подключение (создаем или обновляем alias 'local')
mc-minio alias set local "$MINIO_URL" "$ROOT_USER" "$ROOT_PASSWORD"

echo "=== 4. Создание пользователя в MinIO ==="
# Создаем пользователя с именем из первого параметра
mc-minio admin user add local "$NEW_USER" "$NEW_PASSWORD"

# Назначаем пользователю стандартную политику readwrite
mc-minio admin policy attach local readwrite --user "$NEW_USER"

echo "=========================================="
echo " Пользователь успешно создан в MinIO!   "
echo "=========================================="
echo "URL подключения:  $MINIO_URL"
echo "Access Key (User): $NEW_USER"
echo "Secret Key (Pass): $NEW_PASSWORD"
echo "Политика прав:    readwrite"
echo "=========================================="
