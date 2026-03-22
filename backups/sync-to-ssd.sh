#!/bin/bash

# Синхронизация приватных данных на внешний SSD
# Использование: ./sync-to-ssd.sh [имя_диска]
#
# Перед первым запуском:
#   chmod +x sync-to-ssd.sh
#   Подключи SSD и укажи его имя (как он монтируется в /Volumes/)

SSD_NAME="${1:-MY_SSD}"
SSD_PATH="/Volumes/$SSD_NAME"
SOURCE="$HOME/projects/artmadiar"
DEST="$SSD_PATH/artmadiar-backup"

if [ ! -d "$SSD_PATH" ]; then
    echo "Диск '$SSD_NAME' не найден в /Volumes/"
    echo "Доступные диски:"
    ls /Volumes/
    echo ""
    echo "Использование: $0 <имя_диска>"
    exit 1
fi

echo "Синхронизация на $SSD_PATH..."

mkdir -p "$DEST/journal"

echo "→ Синхронизация journal/..."
rsync -av --progress --delete "$SOURCE/journal/" "$DEST/journal/"

echo ""
echo "Готово! Бэкап сохранён в $DEST/"
echo "Дата: $(date)"
