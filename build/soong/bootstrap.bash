#!/bin/bash

# *********************************************************************************************
# Welcome to the **TWRP Build Script** powered by WolfTech Innovations
# *********************************************************************************************

# ASCII art for WolfTech Innovations branding
WOLFTECH_BRAND="********************************************
*                                              *
*          WOLFTECH INNOVATIONS                *
*         Leading the Way in Tech Innovation!  *
*                                              *
********************************************"

# Function to display a branded header
function display_header() {
    clear
    echo "$WOLFTECH_BRAND"
    echo ""
    echo "Welcome to the TWRP Build Script powered by WolfTech Innovations!"
    echo "This script will guide you through the entire process of syncing repositories,"
    echo "modifying configuration files, and building TWRP recovery for the cm-12.1 branch."
    echo ""
}

# Step 1: Install the 'repo' tool
function install_repo() {
    echo "Step 1: Installing the 'repo' tool..."
    echo "This tool is essential for managing Android source repositories."
    mkdir -p ~/bin
    export PATH=~/bin:$PATH
    curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo
    echo "Repo tool installed successfully!"
}

# Step 2: Sync repositories from GitHub
function sync_repositories() {
    echo "Step 2: Syncing repositories..."
    echo "Now, we will initialize the repo configuration and sync the required repositories . . ."
    repo init --depth=1 -u https://github.com/WolfTech-Innovations/platform_manifest_twrp_aosp/blob/twrp-12.1
    echo "Repo initialized."
    
    echo "Syncing repositories..."
    repo sync
    echo "Repositories synchronized successfully!"
}

# Step 3: Replace 'Android' with 'WTRP' in XML files
function modify_xml_files() {
    echo "Step 3: Replacing 'Android' with 'WTRP' in XML files..."
    echo "Searching for 'strings.xml' and 'values.xml' to perform the replace operation."
    find . -type f \( -name "strings.xml" -o -name "values.xml" \) -exec sed -i 's/Android/WTRP/g' {} +
    echo "'Android' has been successfully replaced with 'WTRP' in XML files."
}

# Step 4: Set up the build environment
function setup_build_environment() {
    echo "Step 4: Setting up the build environment..."
    echo "We will now configure the build environment to prepare for the actual build."
    export ALLOW_MISSING_DEPENDENCIES=true
    . build/envsetup.sh
    echo "Build environment set up successfully!"
}

# Step 5: Select the target device configuration
function select_device_configuration() {
    echo "Step 5: Selecting the target device configuration..."
    echo "We are targeting the 'TWRP_cm_generic' device for the build process."
    lunch twrp_generic-eng
    echo "Target device 'TWRP_cm_generic-eng' selected successfully."
}

# Step 6: Start building the recovery image
function build_recovery_image() {
    echo "Step 6: Building the recovery image..."
    make recoveryimage
    echo "Build completed! The recovery image has been successfully generated."
}

# Step 7: Prepare the output directory
function prepare_output_directory() {
    echo "Step 7: Preparing the output directory..."
    echo "Creating the 'output' directory to store the generated files."
    mkdir -p output
    echo "Output directory created successfully!"
}

# Step 8: Move the recovery image to the output directory
function move_recovery_image() {
    echo "Step 8: Moving the recovery image to the output directory..."
    if [ -f out/target/product/generic/recovery.img ]; then
        mv out/target/product/generic/recovery.img ./output/recovery.img
        echo "Recovery image successfully moved to 'output' directory."
    else
        echo "Error: recovery.img not found! Please check the build logs for errors."
        exit 1
    fi
}

# Final message
function final_message() {
    echo "*****************************************************"
    echo "*                                                   *"
    echo "*     TWRP Build Complete! Powered by WolfTech      *"
    echo "*                                                   *"
    echo "*      Recovery image has been saved to the 'output' *"
    echo "*      directory.                                    *"
    echo "*                                                   *"
    echo "*****************************************************"
}

# TUI Progress Indicator
function display_progress() {
    echo -n "Processing..."
    for i in {1..10}; do
        echo -n "."
        sleep 1
    done
    echo " Done!"
}

# Main Execution: 
display_header  # Show WolfTech Innovations header and greeting
install_repo    # Install repo tool
display_progress
sync_repositories  # Sync repositories
display_progress
modify_xml_files  # Replace 'Android' with 'WTRP' in XML files
display_progress
setup_build_environment  # Set up build environment
display_progress
select_device_configuration  # Select target device config
display_progress
build_recovery_image  # Build recovery image
display_progress
prepare_output_directory  # Prepare output directory
display_progress
move_recovery_image  # Move recovery image to output directory
display_progress
final_message  # Display final success message
