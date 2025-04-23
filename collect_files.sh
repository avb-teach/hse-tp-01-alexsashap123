#!/bin/bash
max_depth=-1
input_dir=$1
output_dir=$2
#сравнение строк
if [ "$1" == "--max_depth" ]; then 
    max_depth=$2 
    input_dir=$3
    output_dir=$4
fi

# Создание выходной директории, если её нет
mkdir -p "$output_dir"

# Функция для копирования файлов с обработкой дубликатов
copy_files() {
    local src="$1"
    local dest="$2"
    local current_depth="$3"
    
    # Проверка глубины
    if [ "$max_depth" -ne -1 ] && [ "$current_depth" -gt "$max_depth" ]; then
        return
    fi
    
    # Перебор элементов во входной директории
    for item in "$src"/*; do
        if [ -f "$item" ]; then
            # Обработка файла
            filename=$(basename "$item")
            
            ext="${filename##*.}"
            
            if [ "$ext" == "$filename" ]; then
                ext=""
            else
                ext=".$ext"
            fi
            new_filename="$filename"

            
            cp "$item" "$dest/$new_filename"
        elif [ -d "$item" ]; then
            # Рекурсивный вызов для поддиректории
            copy_files "$item" "$dest" $((current_depth + 1))
        fi
    done
}

# Вызов функции копирования
copy_files "$input_dir" "$output_dir" 0

echo "Files collected successfully to $output_dir"

