#!/bin/bash

# Define an associative array for Cyrillic to Latin mapping
declare -A cyrillic_to_latin=(
    ["А"]="A" ["Б"]="B" ["В"]="V" ["Г"]="G" ["Д"]="D"
    ["Е"]="E" ["Ё"]="E" ["Ж"]="Zh" ["З"]="Z" ["И"]="I"
    ["Й"]="Y" ["К"]="K" ["Л"]="L" ["М"]="M" ["Н"]="N"
    ["О"]="O" ["П"]="P" ["Р"]="R" ["С"]="S" ["Т"]="T"
    ["У"]="U" ["Ф"]="F" ["Х"]="Kh" ["Ц"]="Ts" ["Ч"]="Ch"
    ["Ш"]="Sh" ["Щ"]="Shch" ["Ы"]="Y" ["Э"]="E" ["Ю"]="Yu"
    ["Я"]="Ya"
    ["а"]="a" ["б"]="b" ["в"]="v" ["г"]="g" ["д"]="d"
    ["е"]="e" ["ё"]="e" ["ж"]="zh" ["з"]="z" ["и"]="i"
    ["й"]="y" ["к"]="k" ["л"]="l" ["м"]="m" ["н"]="n"
    ["о"]="o" ["п"]="p" ["р"]="r" ["с"]="s" ["т"]="t"
    ["у"]="u" ["ф"]="f" ["х"]="kh" ["ц"]="ts" ["ч"]="ch"
    ["ш"]="sh" ["щ"]="shch" ["ы"]="y" ["э"]="e" ["ю"]="yu"
    ["я"]="ya"
)

# Function to transliterate a string from Cyrillic to Latin
transliterate() {
    local input="$1"
    local output=""

    for (( i=0; i<${#input}; i++ )); do
        char="${input:$i:1}"
        if [[ "${cyrillic_to_latin[$char]}" ]]; then
            output+="${cyrillic_to_latin[$char]}"
        else
            output+="$char"
        fi
    done

    echo "$output"
}

# Check if at least one argument is passed
if [[ -z "$1" ]]; then
    echo "Usage: $0 <source_folder> [destination_folder] [--replace-space dash|underscore] [--lowercase]"
    exit 1
fi

# Source folder containing files
source_folder="$1"

# Destination folder (optional)
destination_folder="$2"

# If destination folder is not provided, use the source folder
if [[ -z "$destination_folder" ]]; then
    destination_folder="$source_folder"
fi

# Default options
replace_space=""
to_lowercase=false

# Parse optional arguments
while [[ "$#" -gt 0 ]]; do
    case "$3" in
        --replace-space)
            replace_space="$4"
            shift 2
            ;;
        --lowercase)
            to_lowercase=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Create destination folder if it doesn't exist
mkdir -p "$destination_folder"

# Iterate over files in the source folder
for file in "$source_folder"/*; do
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    name="${filename%.*}"

    # Transliterate the filename
    new_name=$(transliterate "$name")

    # Replace spaces if the option is set
    if [[ "$replace_space" == "dash" ]]; then
        new_name="${new_name// /-}"
    elif [[ "$replace_space" == "underscore" ]]; then
        new_name="${new_name// /_}"
    fi

    # Transform to lowercase if the option is set
    if [[ "$to_lowercase" == true ]]; then
        new_name=$(echo "$new_name" | tr '[:upper:]' '[:lower:]')
    fi

    # Create the new filename
    new_filename="${new_name}.${extension}"

    # Copy or rename the file to the destination folder
    cp "$file" "$destination_folder/$new_filename"

    echo "Renamed: $filename -> $new_filename"
done
