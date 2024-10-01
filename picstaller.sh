#!/usr/bin/env bash

# Function to sanitize app name
sanitize_name() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//'
}

# Function to prompt for input with default value
prompt_with_default() {
    local prompt="$1"
    local default="$2"
    local result

    read -p "${prompt} [${default}]: " result
    echo "${result:-$default}"
}

# Check if AppImage file is provided as an argument
if [ $# -ge 1 ]; then
    appimage_path="$1"
else
    read -p "Enter the path to the AppImage file: " appimage_path
fi

# Check if file exists
if [ ! -f "$appimage_path" ]; then
    echo "Error: AppImage file not found."
    exit 1
fi

# Extract app name from filename (without extension)
default_app_name=$(basename "$appimage_path" .AppImage)

# Prompt for app name with default
app_name=$(prompt_with_default "Enter the name of the app" "$default_app_name")
sanitized_name=$(sanitize_name "$app_name")

# Prompt for icon URL
icon_url=$(prompt_with_default "Enter the URL of the PNG icon (leave blank for no icon)" "")

# Prompt for category
app_category=$(prompt_with_default "Enter the category for the app" "Utility")

# Create app directory in /opt
sudo mkdir -p "/opt/${sanitized_name}"

# Make AppImage executable and move it
chmod a+x "$appimage_path"
sudo mv "$appimage_path" "/opt/${sanitized_name}/${sanitized_name}.AppImage"

# Download icon if URL is provided
if [ -n "$icon_url" ]; then
    sudo wget -O "/opt/${sanitized_name}/${sanitized_name}.png" "$icon_url"
    icon_path="/opt/${sanitized_name}/${sanitized_name}.png"
else
    icon_path=""
fi

# Create desktop entry
cat << EOF | sudo tee "/usr/share/applications/${sanitized_name}.desktop" > /dev/null
[Desktop Entry]
Name=$app_name
Exec=/opt/${sanitized_name}/${sanitized_name}.AppImage
Icon=$icon_path
Type=Application
Categories=$app_category
EOF

echo "picstaller has successfully installed ${app_name}!"