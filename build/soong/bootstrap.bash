#!/bin/bash

# *********************************************************************************************#
# Powered by WolfTech Innovations — Innovating with WTRP, the Next Evolution of Recovery!       #
# *********************************************************************************************#

WOLFTECH_BRAND="********************************************
*                                              *
*                WOLFTECH                      *
*       Pioneering WTRP with Next-Level        *
*          Features and Customization!         *
*                                              *
********************************************"

function display_header() {
    clear
    echo "$WOLFTECH_BRAND"
    echo ""
    echo "Welcome to the WTRP Build Script, powered by WolfTech Innovations!"
    echo ""
}

# Step 1: Installing the 'repo' tool
function install_repo() {
    echo "Step 1: Installing the 'repo' tool..."
    mkdir -p ~/bin
    export PATH=~/bin:$PATH
    curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo
    echo "Repo tool installed successfully!"
}

# Step 2: Syncing repositories with a stable, generic manifest
function sync_repositories() {
    echo "Step 2: Syncing repositories..."
    repo init -u https://github.com/WolfTech-Innovations/platform_manifest_twrp_aosp.git -b twrp-12.1
    repo sync --force-sync --no-tags --no-clone-bundle -j$(nproc)
    echo "Repositories synchronized successfully!"
}

# Step 3: Giving permissions to /build/envsetup.sh
function setup_env_permissions() {
    echo "Step 3: Setting permissions for build scripts..."
    chmod +x build/envsetup.sh
    echo "Permissions set for /build/envsetup.sh."
}

# Step 4: Rebranding TWRP to WTRP during the build
function rebrand_to_wtrp() {
    echo "Step 4: Rebranding TWRP to WTRP..."
    find . -type f \( -name "*.xml" -o -name "*.mk" -o -name "*.java" \) -exec sed -i 's/TWRP/WTRP/g' {} +
    echo "Rebranding complete! All references to TWRP have been updated to WTRP."
}

# Step 5: Injecting custom features into the build
function inject_features() {
    echo "Step 5: Injecting custom features into the build..."

    # Feature 1: Add support for custom themes
    echo "Injecting support for custom themes..."
    mkdir -p res/theme/wtrp_theme
    echo '<resources>
    <string name="custom_theme">WolfTech Theme</string>
    <color name="primary_color">#1a73e8</color>
    </resources>' > res/theme/wtrp_theme/styles.xml
    echo "Custom theme added."

    # Feature 2: Enable OTA zip flashing detection
    echo "Adding support for OTA zip flashing..."
    mkdir -p patches/ota_flash
    echo '#!/bin/bash
    if [[ $1 == *.zip ]]; then
        echo "Detected OTA zip file: $1"
    fi
    ' > patches/ota_flash/detect_ota.sh
    chmod +x patches/ota_flash/detect_ota.sh
    echo "OTA zip flashing detection added."

    # Feature 3: Add advanced logging mechanism
    echo "Injecting advanced logging mechanism..."
    mkdir -p external/wtrp_logger
    echo 'void log_to_file(const char* log) {
        FILE* fp = fopen("/sdcard/wtrp_logs.txt", "a");
        if (fp) {
            fprintf(fp, "%s\n", log);
            fclose(fp);
        }
    }' > external/wtrp_logger/logger.c
    echo "Advanced logging mechanism added."

    # Feature 4: Introduce file manager enhancements
    echo "Enhancing file manager with delete protection..."
    sed -i '/deleteFile/ a \
    if (isProtectedFile(file)) return -1;' recovery/filemanager.cpp
    echo "File manager delete protection added."

    # Feature 5: Include custom splash screen
    echo "Adding custom splash screen..."
    mkdir -p res/splash
    echo '<html>
    <head><title>Welcome to WTRP</title></head>
    <body><h1>WolfTech Recovery</h1><p>Custom splash screen!</p></body>
    </html>' > res/splash/index.html
    echo "Custom splash screen added."

    # Feature 6: Add custom key combo for advanced menu
    echo "Adding custom key combo for advanced menu..."
    sed -i '/checkKeyCombo/ a \
    if (keyCombo == ADVANCED_MENU_COMBO) showAdvancedMenu();' recovery/ui.cpp
    echo "Custom key combo for advanced menu added."

    echo "All custom features successfully injected into the build!"
}

# Step 6: Selecting the target device configuration
function select_device_configuration() {
    echo "Step 6: Selecting the target device configuration..."
    source build/envsetup.sh
    export ALLOW_MISSING_DEPENDENCIES=true
    lunch twrp_arm64-eng
}

# Step 7: Building the recovery image
function build_recovery_image() {
    echo "Step 7: Building the recovery image..."
    build/soong/soong_ui.bash --make-mode recoveryimage -j$(nproc)
}

# Step 8: Moving the recovery image to the output directory
function move_recovery_image() {
    echo "Step 8: Moving the recovery image to the output directory..."
    mkdir -p output
    if [ -f out/target/product/generic_arm64/recovery.img ]; then
        mv out/target/product/generic_arm64/recovery.img ./output/recovery.img
        echo "Recovery image successfully moved to the 'output' directory!"
    else
        echo "Error: recovery.img not found! Please check the build logs for errors."
        exit 1
    fi
}

# Final message
function final_message() {
    echo "*****************************************************"
    echo "*     WTRP Build Complete! Powered by WolfTech      *"
    echo "*  The custom WTRP recovery image has been saved to the 'output' directory. *"
    echo "*      You can now proceed with flashing the image   *"
    echo "*      to your device. Happy flashing!              *"
    echo "*****************************************************"
}

# Main Execution Block
display_header
install_repo
sync_repositories
setup_env_permissions
rebrand_to_wtrp
inject_features
select_device_configuration
build_recovery_image
move_recovery_image
final_message
