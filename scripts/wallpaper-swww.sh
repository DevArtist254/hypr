#!/bin/bash

# exec rm -rf "~/.config/*.png"

# Define the folder containing the images
IMAGE_FOLDER="/home/devartist/.config/wallpapers"

# Check if the image folder exists
if [ ! -d "$IMAGE_FOLDER" ]; then
    echo "Error: image folder not found."
    exit 1
fi

# Get all image files in the folder
image_files=("$IMAGE_FOLDER"/*)

# Check if there are any image files in the folder
if [ ${#image_files[@]} -eq 0 ]; then 
    echo "Error: no image file found."
    exit 1
fi

# Select a random image
random_index=$((RANDOM % ${#image_files[@]}))
random_image=${image_files[$random_index]}

# Set input and output file names
input_image="$random_image"
output_left="/tmp/wallpaper_left.png"
output_right="/tmp/wallpaper_right.png"

# Get the dimensions of the input image using ImageMagick
dimensions=$(identify -format "%wx%h" "$input_image")
width=$(echo $dimensions | cut -d'x' -f1)
height=$(echo $dimensions | cut -d'x' -f2)

# Calculate the width of each half
half_width=$((width / 2))

# Split the image into left and right halves
echo "Splitting the image into two halves..."
convert "$input_image" -crop "${half_width}x${height}+0+0" "$output_left"
convert "$input_image" -crop "${half_width}x${height}+$half_width+0" "$output_right"

# Resize the images to 2560x1440
echo "Resizing the halves to 2560x1440..."
convert "$output_left" -resize 2560x1440 "$output_left"
convert "$output_right" -resize 2560x1440 "$output_right"

# Inform the user
echo "Wallpapers created: $output_left and $output_right"

# Set the wallpaper using swaybg
exec swaybg -i "$output_right" -o "DP-1" -i "$output_left" -o "DP-2"
