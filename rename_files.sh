



#!/bin/bash

for dir in *_mapped/; do
    prefix=$(basename "$dir" | cut -d'_' -f1)
    for file in "$dir"/*; do
        new_name="$dir$prefix-$(basename "$file")"
        mv "$file" "$new_name"
    done
done

