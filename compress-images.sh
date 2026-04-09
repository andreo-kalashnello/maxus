#!/bin/bash

# Скрипт для сжатия WebP изображений в папке assets/images
# Использует встроенный cwebp компрессор

IMAGES_DIR="assets/images"
QUALITY=80  # Качество сжатия (0-100), 80 - оптимум для веба

echo "🔄 Начинаю сжатие изображений в $IMAGES_DIR..."
echo "Качество: $QUALITY"
echo ""

# Проверяем наличие cwebp
if ! command -v cwebp &> /dev/null; then
    echo "❌ cwebp не найден. Установи: sudo apt install webp"
    exit 1
fi

# Счетчик файлов
TOTAL=0
COMPRESSED=0

# Находим все .webp файлы рекурсивно
find "$IMAGES_DIR" -type f -name "*.webp" | while read FILE; do
    TOTAL=$((TOTAL + 1))
    
    # Получаем размер до сжатия
    SIZE_BEFORE=$(du -h "$FILE" | cut -f1)
    
    # Временный файл
    TEMP_FILE="${FILE}.tmp"
    
    # Сжимаем
    cwebp -q $QUALITY "$FILE" -o "$TEMP_FILE" 2>/dev/null
    
    # Если сжатый файл меньше оригинала - заменяем
    if [ -f "$TEMP_FILE" ]; then
        SIZE_AFTER=$(du -h "$TEMP_FILE" | cut -f1)
        mv "$TEMP_FILE" "$FILE"
        COMPRESSED=$((COMPRESSED + 1))
        echo "✅ $FILE"
        echo "   Было: $SIZE_BEFORE → Стало: $SIZE_AFTER"
    fi
done

echo ""
echo "✨ Готово! Сжато файлов: $COMPRESSED"
echo "Проверь размер папки: du -sh $IMAGES_DIR"
