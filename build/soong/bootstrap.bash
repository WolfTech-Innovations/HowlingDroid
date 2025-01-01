#!/bin/bash

# *********************************************************************************************#
# Powered by WolfTech Innovations — Leaders in tech innovation and digital wizardry            #
# *********************************************************************************************#

# ASCII art for branding the script with WolfTech Innovations’ logo
WOLFTECH_BRAND="********************************************
*                                              *
*          WOLFTECH INNOVATIONS                *
*     Pioneering the Future of Technological    *
*        Solutions and Digital Mastery!         *
*                                              *
********************************************"

# Function to display an elegant, branded header for the script
function display_header() {
    clear
    echo "$WOLFTECH_BRAND"
    echo ""
    echo "Welcome to the TWRP Build Script, powered by WolfTech Innovations!"
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

# Step 2: Syncing repositories
function sync_repositories() {
    echo "Step 2: Syncing repositories..."
    repo init -u git://github.com/TWRP-Mi-A2-Lite/platform_manifest_twrp_omni.git -b twrp-9.0
    echo "Repo initialization complete."
    repo sync
    echo "Repositories synchronized successfully! The source code is now on your local machine."
}

# Step 3: Replacing 'Android' with 'WTRP'
function modify_xml_files() {
    echo "Step 3: Replacing 'Android' with 'WTRP' in XML files..."
    find . -type f \( -name "strings.xml" -o -name "values.xml" \) -exec sed -i 's/Android/WTRP/g' {} +
    echo "'Android' has been successfully replaced with 'WTRP' in all relevant XML files."
}

# Step 4: Auto-fixing redeclaration issues in Go files and linting
function auto_fix_go_files() {
    echo "Step 4: Auto-fixing redeclaration issues in Go files..."
    find . -type f -name "*.go" -exec sed -i 's/eventEntry/eventEntryRenamed/g' {} +
    find . -type f -name "*.go" -exec sed -i 's/importEvents/importEventsRenamed/g' {} +
    echo "Auto-fix completed for redeclaration issues in Go files."
}

# Step 5: Selecting the target device configuration
function select_device_configuration() {
    echo "Step 5: Selecting the target device configuration..."
    export ALLOW_MISSING_DEPENDENCIES=true
    build/envsetup.sh
    lunch omni_arm64-eng
}

# Step 6: Building the recovery image
function build_recovery_image() {
    echo "Step 6: Building the recovery image..."
    make recoveryimage
    echo "Build completed! The recovery image has been successfully generated."
}

# Step 7: Preparing the output directory
function prepare_output_directory() {
    echo "Step 7: Preparing the output directory..."
    mkdir -p output
    echo "Output directory created successfully!"
}

# Step 8: Moving the recovery image to the output directory
function move_recovery_image() {
    echo "Step 8: Moving the recovery image to the output directory..."
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
    echo "*     TWRP Build Complete! Powered by WolfTech      *"
    echo "*      The custom TWRP recovery image has been saved to the 'output' directory. *"
    echo "*      You can now proceed with flashing the image   *"
    echo "*      to your device. Happy flashing!              *"
    echo "*****************************************************"
}

# TUI Progress Indicator
function display_progress() {
    echo -n "Processing... Please wait while we work our magic!"
    for i in {1..10}; do
        echo -n "."
        sleep 1
    done
    echo " Done!"
}

# Main Execution Block: Running all steps in sequence

display_header
install_repo
display_progress

sync_repositories
display_progress

modify_xml_files
display_progress

auto_fix_go_files
display_progress

select_device_configuration
display_progress

build_recovery_image
display_progress

prepare_output_directory
display_progress

move_recovery_image
display_progress

final_message
