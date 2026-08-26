#!/bin/bash
set -e

# Установка VectorChord (vchord) — расширение PostgreSQL для векторного поиска
# https://docs.vectorchord.ai/vectorchord/getting-started/installation.html
# Использование: ./vectorchord.sh [версия_postgresql]   (по умолчанию — установленная)

export DEBIAN_FRONTEND=noninteractive

echo "=== 1. Определение версии PostgreSQL и архитектуры ==="
PG_VER="${1:-$(psql -V 2>/dev/null | grep -oE '[0-9]+' | head -1)}"
if [ -z "$PG_VER" ]; then
    echo "Ошибка: PostgreSQL не найден. Сначала выполните ./postgresql.sh"
    exit 1
fi
ARCH=$(dpkg --print-architecture)
echo "PostgreSQL: $PG_VER, архитектура: $ARCH"

echo "=== 2. Установка pgvector ==="
sudo apt install -y "postgresql-${PG_VER}-pgvector"

echo "=== 3. Скачивание и установка vchord ==="
VCHORD_VERSION=$(curl -sSL "https://api.github.com/repos/tensorchord/VectorChord/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
DEB="postgresql-${PG_VER}-vchord_${VCHORD_VERSION}-1_${ARCH}.deb"
cd /tmp
curl -fOL "https://github.com/tensorchord/VectorChord/releases/download/${VCHORD_VERSION}/${DEB}"
sudo apt install -y "./${DEB}"
rm "./${DEB}"

echo "=== 4. Добавление vchord в shared_preload_libraries ==="
CURRENT=$(sudo -u postgres psql -tAc 'SHOW shared_preload_libraries;')
if echo "$CURRENT" | grep -qw vchord; then
    echo "vchord уже прописан: $CURRENT"
else
    if [ -z "$CURRENT" ]; then
        NEW="vchord"
    else
        NEW="${CURRENT},vchord"
    fi
    sudo -u postgres psql -c "ALTER SYSTEM SET shared_preload_libraries = '${NEW}';"
    echo "shared_preload_libraries = $NEW"
fi

echo "=== 5. Перезапуск PostgreSQL ==="
sudo systemctl restart postgresql.service

echo "=== Установка успешно завершена! ==="
echo "Включить расширение в нужной базе:"
echo "  sudo -u postgres psql -d <база> -c 'CREATE EXTENSION IF NOT EXISTS vchord CASCADE;'"
