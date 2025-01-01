#!/bin/bash

# Install repo tool
echo "Installing repo tool"
mkdir -p ~/bin
export PATH=~/bin:$PATH
curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo "Syncing repos"
repo init --depth=1 -u https://github.com/diparthshah/TWRP-manifest.git -b master
repo sync --force-sync --no-tags --no-clone-bundle

# Find and replace 'Android' with 'WTRP' in strings.xml and values.xml
echo "Replacing 'Android' with 'WTRP' in XML files"
find . -type f \( -name "strings.xml" -o -name "values.xml" \) -exec sed -i 's/Android/WTRP/g' {} +

# Build WTRP
echo "Building WTRP"
make

echo "Done!"
