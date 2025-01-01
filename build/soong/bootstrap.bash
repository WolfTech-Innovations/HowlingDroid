#!/bin/bash

# Install repo tool
echo "Installing repo tool"
mkdir -p ~/bin
export PATH=~/bin:$PATH
curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo "Syncing repos"
repo init -u git://github.com/neporood/twrp_cm.git -b cm-12.1
repo sync

# Find and replace 'Android' with 'WTRP' in strings.xml and values.xml
echo "Replacing 'Android' with 'WTRP' in XML files"
find . -type f \( -name "strings.xml" -o -name "values.xml" \) -exec sed -i 's/Android/WTRP/g' {} +

# Build WTRP
echo "Building WTRP"
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch omni_generic-eng
make recoveryimage
mkdir output
mv out/target/product/generic/recovery.img ./output/recovery.img



echo "Done!"
