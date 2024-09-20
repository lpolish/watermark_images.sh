#!/bin/bash

set -e

if ! command -v convert &> /dev/null
then
    echo "ImageMagick is not installed. Please install it and try again."
    exit 1
fi

if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <watermark_text>"
    exit 1
fi

directory="$1"
watermark_text="$2"

if [ ! -d "$directory" ]; then
    echo "Directory not found: $directory"
    exit 1
fi

temp_dir=$(mktemp -d)
echo "Temporary directory created: $temp_dir"

for img in "$directory"/*.{jpg,jpeg,png,gif,JPG,JPEG,PNG,GIF}; do
    [ -e "$img" ] || continue
    
    filename=$(basename "$img")
    echo "Processing: $filename"
    

    convert "$img" \
        -fill 'rgba(255,255,255,0.1)' -pointsize 20 \
        -gravity NorthWest -annotate +10+10 "$watermark_text" \
        -gravity North -annotate +0+10 "$watermark_text" \
        -gravity NorthEast -annotate +10+10 "$watermark_text" \
        -gravity West -annotate +10+0 "$watermark_text" \
        -gravity Center -annotate +0+0 "$watermark_text" \
        -gravity East -annotate +10+0 "$watermark_text" \
        -gravity SouthWest -annotate +10+10 "$watermark_text" \
        -gravity South -annotate +0+10 "$watermark_text" \
        -gravity SouthEast -annotate +10+10 "$watermark_text" \
        "$temp_dir/$filename"

    if [ -f "$temp_dir/$filename" ]; then
        echo "Watermarked image created: $temp_dir/$filename"
    else
        echo "Failed to create watermarked image for: $filename"
    fi
done

echo "Moving watermarked images back to the original directory..."
mv "$temp_dir"/* "$directory" 2>/dev/null || true

rmdir "$temp_dir"
echo "Temporary directory removed: $temp_dir"

echo "Watermarking complete!"
