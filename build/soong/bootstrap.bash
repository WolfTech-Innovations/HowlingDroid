#!/bin/bash

# *********************************************************************************************
# WELCOME TO THE SUPER-DUPER, ULTRA-DETAILED, MEGA-EXPLANATORY **TWRP BUILD SCRIPT**
# Powered by WolfTech Innovations — Leaders in tech innovation and digital wizardry
# *********************************************************************************************

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
    clear  # Clear the terminal screen to make way for the awesome branding
    echo "$WOLFTECH_BRAND"  # Display the branding to make you feel like a tech wizard
    echo ""  # Add a blank line for formatting
    echo "Welcome to the TWRP Build Script, powered by WolfTech Innovations!"  # Script intro message
    echo "In this script, we'll guide you through the entire process of:"
    echo "- Syncing essential repositories from GitHub"
    echo "- Modifying configuration files for your desired outcome"
    echo "- Building TWRP recovery for the cm-12.1 branch"
    echo "Prepare yourself for an epic journey into the world of custom recoveries!"
    echo ""  # Formatting space
}

# Step 1: Installing the 'repo' tool — the foundation of Android source management
function install_repo() {
    echo "Step 1: Installing the 'repo' tool..."  # Initial message
    echo "The 'repo' tool is a command-line utility that helps us manage the large number of Git repositories required"
    echo "to build Android and related custom software. It's an essential piece of the puzzle!"
    echo "Let's begin by ensuring that we have everything in place for repo."
    
    mkdir -p ~/bin  # Ensure the bin directory exists to store the repo tool
    export PATH=~/bin:$PATH  # Add the bin directory to the system PATH for easier access to the repo tool
    curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo  # Download the repo tool from Google
    chmod a+x ~/bin/repo  # Make the repo tool executable
    
    echo "Repo tool installed successfully!"  # Confirmation message after installation
}

# Step 2: Syncing repositories — time to grab the source code
function sync_repositories() {
    echo "Step 2: Syncing repositories..."  # Step intro message
    echo "We will initialize the repository configuration and fetch the required code for our build. Please be patient."
    echo "Initializing repo with the platform manifest for TWRP..."
    
    repo init --depth=1 -u https://github.com/WolfTech-Innovations/platform_manifest_twrp_aosp/  # Initialize repo with the TWRP manifest
    echo "Repo initialization complete."
    
    echo "Now, let's begin syncing all the repositories. This will download all necessary source files."
    repo sync  # Sync the repositories, which will fetch all the Android source code
    echo "Repositories synchronized successfully! The source code is now on your local machine."
}

# Step 3: Replacing 'Android' with 'WTRP' — customizing configuration files
function modify_xml_files() {
    echo "Step 3: Replacing 'Android' with 'WTRP' in XML files..."  # Inform the user of the action
    echo "We're going to make a small, but significant, tweak in the code. We'll be searching through XML files"
    echo "to replace every occurrence of 'Android' with 'WTRP' to better reflect the name of our custom TWRP recovery."

    # Search for XML files and perform the substitution using sed
    find . -type f \( -name "strings.xml" -o -name "values.xml" \) -exec sed -i 's/Android/WTRP/g' {} +
    echo "'Android' has been successfully replaced with 'WTRP' in all relevant XML files."  # Success message
}

# Step 5: Selecting the target device configuration
function select_device_configuration() {
    echo "Step 4: Selecting the target device configuration..."  # Inform the user of the next step
    echo "In this step, we specify which device we want to build the TWRP recovery image for."
   export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch twrp_arm64-eng
}

# Step 6: Building the recovery image
function build_recovery_image() {
    echo "Step 5: Building the recovery image..."  # Notify the user of the build process
    echo "The heart of the process! We will now compile the source code into a working TWRP recovery image."
    echo "This might take a while, depending on your system's performance."

    make recoveryimage  # Start the actual build process for the recovery image
    echo "Build completed! The recovery image has been successfully generated."
}

# Step 7: Preparing the output directory — keeping things organized
function prepare_output_directory() {
    echo "Step 6: Preparing the output directory..."  # Preparation message
    echo "We're about to create a dedicated directory where the final recovery image will be stored."
    echo "Having a clean output folder helps keep things neat and easy to find."

    mkdir -p output  # Create the output directory if it doesn't exist already
    echo "Output directory created successfully! It's time to move the recovery image to its new home."
}

# Step 8: Moving the recovery image to the output directory
function move_recovery_image() {
    echo "Step 7: Moving the recovery image to the output directory..."  # Notify of file move action
    echo "Now, we'll move the freshly built recovery image to the 'output' directory."
    echo "This makes it easier to locate and flash the image to your device."

    if [ -f out/target/product/generic/recovery.img ]; then  # Check if the recovery image exists
        mv out/target/product/generic/recovery.img ./output/recovery.img  # Move the recovery image to the output folder
        echo "Recovery image successfully moved to the 'output' directory!"  # Success message
    else
        echo "Error: recovery.img not found! Please check the build logs for errors."  # Error message if the file is missing
        exit 1  # Exit the script if the recovery image doesn't exist
    fi
}

# Final message — congratulating the user on a successful build
function final_message() {
    echo "*****************************************************"
    echo "*                                                   *"
    echo "*     TWRP Build Complete! Powered by WolfTech      *"
    echo "*                                                   *"
    echo "*      The custom TWRP recovery image has been saved *"
    echo "*      to the 'output' directory.                   *"
    echo "*      You can now proceed with flashing the image   *"
    echo "*      to your device. Happy flashing!              *"
    echo "*                                                   *"
    echo "*****************************************************"
}

# TUI Progress Indicator — because we all love seeing progress
function display_progress() {
    echo -n "Processing... Please wait while we work our magic!"
    for i in {1..10}; do
        echo -n "."
        sleep 1  # Adding a 1-second pause between dots for suspense!
    done
    echo " Done!"  # Indicate that the process is finished
}

# Main Execution Block: Running all steps in sequence

display_header  # Show the WolfTech Innovations header and introductory message
install_repo  # Install the repo tool
display_progress  # Display progress bar for this step

sync_repositories  # Sync the required repositories from GitHub
display_progress  # Display progress bar for this step

modify_xml_files  # Modify XML files as needed
display_progress  # Display progress bar for this step

select_device_configuration  # Choose the target device for the build
display_progress  # Display progress bar for this step

build_recovery_image  # Build the TWRP recovery image
display_progress  # Display progress bar for this step

prepare_output_directory  # Prepare the output directory for storing the image
display_progress  # Display progress bar for this step

move_recovery_image  # Move the recovery image to the output directory
display_progress  # Display progress bar for this step

final_message  # Display final success message to the user
