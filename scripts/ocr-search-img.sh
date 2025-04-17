#!/bin/bash

# Trap for interrupt signal (Ctrl+C)
trap 'cleanup "aborted"' INT TERM

cleanup() {
    local status="$1"
    
    # Show appropriate notification
    if [ "$NOTIFY_ENABLED" != false ]; then
        if [ "$status" = "aborted" ]; then
            notify-send -t 3000 --replace-id=33 --urgency=critical "OCR Search Aborted" "Process interrupted by user"
        elif [ "$status" = "error" ]; then
            notify-send -t 3000 --replace-id=33 --urgency=critical "OCR Search Failed" "An error occurred during search"
        fi
    fi

    # Terminal message
    if [ "$status" = "aborted" ]; then
        echo -e "\n❌ OCR search aborted by user"
    elif [ "$status" = "error" ]; then
        echo -e "\n⚠️ OCR search failed with errors"
    fi

    # Clean temp files
    rm -f "$TMP_OCR" "$MATCHED_IMAGES"
    exit 1
}

# Check required commands
command -v tesseract >/dev/null 2>&1 || {
    echo "❌ tesseract is not installed. Install it with: sudo pacman -S tesseract tesseract-data-eng"
    exit 1
}

command -v sxiv >/dev/null 2>&1 || {
    echo "❌ sxiv is not installed. Install it with: sudo pacman -S sxiv"
    exit 1
}

command -v notify-send >/dev/null 2>&1 || {
    echo "⚠️ notify-send not found - progress notifications disabled"
    NOTIFY_ENABLED=false
}

# Directory to search - defaults to current directory
SEARCH_DIR="${1:-$(pwd)}"

# Prompt user for search text if not given
if [ -z "$2" ]; then
    read -p "Enter text to search in images: " SEARCH_TEXT
else
    SEARCH_TEXT="$2"
fi

# Exit if no search text provided
if [ -z "$SEARCH_TEXT" ]; then
    echo "❌ No search text provided."
    exit 1
fi

echo "🔍 Searching in: $SEARCH_DIR"
echo "🔎 Looking for text: \"$SEARCH_TEXT\""

# Temp files
TMP_OCR=$(mktemp)
MATCHED_IMAGES=$(mktemp)

# Get total number of files first
TOTAL_FILES=$(find "$SEARCH_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) -printf '.' | wc -c)
[ "$TOTAL_FILES" -eq 0 ] && {
    echo "❌ No image files found in directory"
    cleanup "error"
}

CURRENT_FILE=0

# Find and check images
while IFS= read -r -d '' IMG; do
    CURRENT_FILE=$((CURRENT_FILE + 1))
    PERCENTAGE=$(( CURRENT_FILE * 100 / TOTAL_FILES ))
    
    # Update progress notification
    if [ "$NOTIFY_ENABLED" != false ]; then
        notify-send --replace-id=33 -t 10000 -h int:value:$PERCENTAGE 'Scanning' "=== Total files: $TOTAL_FILES ==="
            # "Scanning $CURRENT_FILE/$TOTAL_FILES\n$(basename "$IMG")"
            # "OCR Search Progress ($PERCENTAGE%)" \
    fi
    
    echo "🖼️  Scanning ($CURRENT_FILE/$TOTAL_FILES): $(basename "$IMG")"
    tesseract "$IMG" stdout -l eng 2>/dev/null | grep -iq "$SEARCH_TEXT" && {
        echo "✅ Match found in: $IMG"
        printf '%s\0' "$IMG" >> "$MATCHED_IMAGES"
    }
done < <(find "$SEARCH_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) -print0)

# Final notification
if [ "$NOTIFY_ENABLED" != false ]; then
    MATCH_COUNT=$(grep -cz '^' "$MATCHED_IMAGES")
    notify-send -t 3000 "OCR Search Complete" "Found $MATCH_COUNT matches in $TOTAL_FILES images"
fi

# Show matched images in sxiv if any found
if [ -s "$MATCHED_IMAGES" ]; then
    MATCH_COUNT=$(grep -cz '^' "$MATCHED_IMAGES")
    echo "🎉 Found $MATCH_COUNT matching images"
    echo "🖥️  Opening matches in sxiv..."
    xargs -0 sxiv -a -f < "$MATCHED_IMAGES"
else
    echo "❌ No matches found"
fi

# Cleanup on normal exit
rm -f "$TMP_OCR" "$MATCHED_IMAGES"
exit 0