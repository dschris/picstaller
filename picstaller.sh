#!/bin/bash

# Function to sanitize app name
sanitize_name() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//'
}

# Prompt for AppImage file
read -p "Enter the path to the AppImage file: " appimage_path

# Check if file exists
if [ ! -f "$appimage_path" ]; then
    echo "Error: AppImage file not found."
    exit 1
fi

# Prompt for app name
read -p "Enter a user-friendly name for the app: " app_name
sanitized_name=$(sanitize_name "$app_name")

# Prompt for icon URL
read -p "Enter the URL of the PNG icon (leave blank for no icon): " icon_url

# Prompt for category
read -p "Enter the category for the app: " app_category

# Make AppImage executable
chmod a+x "$appimage_path"

# Move AppImage to /opt
sudo mv "$appimage_path" "/opt/${sanitized_name}.AppImage"

# Download icon if URL is provided
if [ -n "$icon_url" ]; then
    sudo wget -O "/opt/${sanitized_name}.png" "$icon_url"
    icon_path="/opt/${sanitized_name}.png"
else
    icon_path=""
fi

# Create desktop entry
cat << EOF | sudo tee "/usr/share/applications/${sanitized_name}.desktop" > /dev/null
[Desktop Entry]
Name=$app_name
Exec=/opt/${sanitized_name}.AppImage
Icon=$icon_path
Type=Application
Categories=$app_category
EOF

echo "Installation completed successfully!"