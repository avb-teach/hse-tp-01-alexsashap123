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
mkdir -p "$output_dir"
copy_files() {
    local src="$1"
    local dest="$2"
    local current_depth="$3"
    if [ "$max_depth" -ne -1 ] && [ "$current_depth" -gt "$max_depth" ]; then
        return
    fi
    for item in "$src"/*; do
        if [ -f "$item" ]; then
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
            copy_files "$item" "$dest" $((current_depth + 1))
        fi
    done
}
copy_files "$input_dir" "$output_dir" 0
echo "Files collected successfully to $output_dir"

