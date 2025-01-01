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

# Step 1: Installing the 'repo' tool with sudo
function install_repo() {
    echo "Step 1: Installing the 'repo' tool..."
    mkdir -p ~/bin
    export PATH=~/bin:$PATH
    curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    sudo chmod a+x ~/bin/repo
    echo "Repo tool installed successfully!"
}

# Step 2: Syncing repositories with a stable, generic manifest
function sync_repositories() {
    echo "Step 2: Syncing repositories..."
    repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_lineageos.git -b twrp-14.1
    echo "Repo initialization complete."
    repo sync --force-sync --no-tags --no-clone-bundle
    echo "Repositories synchronized successfully!"
}

# Step 3: Giving permissions to /build/envsetup.sh
function setup_env_permissions() {
    echo "Step 3: Setting permissions for build scripts..."
    sudo chmod +x build/envsetup.sh
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
    # Example: Adding a custom script for WTRP functionality
    mkdir -p external/wtrp_features
    echo "#!/bin/bash" > external/wtrp_features/custom_script.sh
    echo "echo 'Welcome to WTRP with advanced features!'" >> external/wtrp_features/custom_script.sh
    sudo chmod +x external/wtrp_features/custom_script.sh

    # You can add more feature injections here
    echo "Custom features successfully injected into the build."
}

# Step 6: Selecting the target device configuration
function select_device_configuration() {
    echo "Step 6: Selecting the target device configuration..."
    export ALLOW_MISSING_DEPENDENCIES=true
    sudo ./build/envsetup.sh
    lunch cm_arm64-eng
}

# Step 7: Building the recovery image
function build_recovery_image() {
    echo "Step 7: Building the recovery image..."
    sudo make recoveryimage
    echo "Build completed! The recovery image has been successfully generated."
}

# Step 8: Moving the recovery image to the output directory
function move_recovery_image() {
    echo "Step 8: Moving the recovery image to the output directory..."
    mkdir -p output
    if [ -f out/target/product/generic/recovery.img ]; then
        mv out/target/product/generic/recovery.img ./output/recovery.img
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
