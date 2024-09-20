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
        \( -size 1000x1000 -background none -fill 'rgba(255,255,255,0.6)' \
           -gravity Center -pointsize 48 -font Arial-Bold \
           label:"$watermark_text" -rotate -30 \
           -virtual-pixel transparent -distort SRT 1.2 \) \
        -compose multiply -composite \
        \( -clone 0 -fill 'rgba(0,0,0,0.4)' \
           -draw "rectangle 0,0 1000,80" \
           -fill white -gravity North -pointsize 36 -annotate +0+20 "$watermark_text" \) \
        -compose over -composite \
        \( -clone 0 -fill 'rgba(0,0,0,0.4)' \
           -draw "rectangle 0,920 1000,1000" \
           -fill white -gravity South -pointsize 36 -annotate +0+20 "$watermark_text" \) \
        -compose over -composite \
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
