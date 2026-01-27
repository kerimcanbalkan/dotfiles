#!/usr/bin/env sh

# Configuration
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
SWWW_TRANSITION="simple"
SWWW_TRANSITION_STEP=2
SWWW_TRANSITION_FPS=60
SWWW_TRANSITION_DURATION=1
CACHE_DIR="$HOME/.cache/wallpaper-previews"

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Find all image files
IMAGES=$(find "$WALLPAPER_DIR" -type f \( \
    -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \
\) | sort)

if [ -z "$IMAGES" ]; then
    echo "No image files found in $WALLPAPER_DIR"
    exit 1
fi

# Generate preview images
for img in $IMAGES; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    preview="$CACHE_DIR/$filename"

    if [ ! -f "$preview" ] || [ "$img" -nt "$preview" ]; then
        magick "$img" -resize 200x200 "$preview"
    fi
done

# Temporary input file for wmenu
WMENU_INPUT=$(mktemp)

# Populate menu entries with icons
for img in $IMAGES; do
    [ -f "$img" ] || continue
    filename=$(basename "$img")
    preview="$CACHE_DIR/$filename"

    [ -f "$preview" ] || continue

    # wmenu icon format (same as wofi)
    printf "%s\0icon\x1f%s\n" "$filename" "$preview" >>"$WMENU_INPUT"
done

if [ ! -s "$WMENU_INPUT" ]; then
    echo "No valid wallpapers found"
    rm "$WMENU_INPUT"
    exit 1
fi

# Show wmenu
SELECTED_NAME=$(wmenu -i <"$WMENU_INPUT")

rm "$WMENU_INPUT"

[ -z "$SELECTED_NAME" ] && exit 0

# Resolve full path
SELECTED_WALLPAPER=""
for img in $IMAGES; do
    if [ "$(basename "$img")" = "$SELECTED_NAME" ]; then
        SELECTED_WALLPAPER="$img"
        break
    fi
done

if [ -z "$SELECTED_WALLPAPER" ]; then
    echo "Could not find selected wallpaper"
    exit 1
fi

# Set wallpaper
swww img "$SELECTED_WALLPAPER" \
    --transition-type "$SWWW_TRANSITION" \
    --transition-step "$SWWW_TRANSITION_STEP" \
    --transition-fps "$SWWW_TRANSITION_FPS" \
    --transition-duration "$SWWW_TRANSITION_DURATION"

# Save selection
echo "$SELECTED_WALLPAPER" >"$HOME/.cache/current_wallpaper"

echo "Wallpaper set successfully"
