#!/bin/bash

# Install repo tool
echo "Installing repo tool"
mkdir -p ~/bin
export PATH=~/bin:$PATH
curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# Init repo
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11

# Clone my local repo
git clone https://github.com/EinKara/android_manifest_google_bluejay.git -b twrp-13 .repo/local_manifests

# Sync
repo sync --no-repo-verify -c --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j`sysctl -n hw.ncpu`

# Build
. build/envsetup.sh
lunch twrp_bluejay-eng
make bootimage


# Find and replace 'Android' with 'WTRP' in strings.xml and values.xml
echo "Replacing 'Android' with 'WTRP' in XML files"
find . -type f \( -name "strings.xml" -o -name "values.xml" \) -exec sed -i 's/Android/WTRP/g' {} +

# Build WTRP
echo "Building WTRP"
make

echo "Done!"
