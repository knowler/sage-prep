#!/bin/bash

# Get theme name
theme=${PWD##*/}

echo "Preparing $theme..."

# Optmize Composer deps + autoload for production
composer install --no-ansi --no-dev --no-interaction --no-progress --optimize-autoloader --no-scripts

# Get short hash of current commit
hash="$(git rev-parse --verify HEAD --short)"

# Get timestamp
timestamp="$(date '+%s')"

# Create temp directory
temp=".prep/$theme-$timestamp-$hash"
mkdir -p $temp

# Copy relevant files to the the directory
cp -R {app,config,dist,resources,vendor} $temp  # Theme setup & config, views, theme files, composer deps, & repo
rm -rf $temp/resources/assets                   # Remove source assets
cp LICENSE.md $temp                             # Copy Sage license (legally required)

# Create build info and instructions file
printf "Commit:   $hash\nBuilt at: $timestamp\nBuilt by: $(git config user.name)\n\n" > $temp/deploy-info.md
cat bin/instructions.md >> $temp/deploy-info.md

# Set distribute file name
dist="$theme-distribute-$timestamp-$hash".zip

# Compress distribution
cd .prep
zip -qr $dist "$theme-$timestamp-$hash"

# Remove temporary theme directory
rm -rf "$theme-$timestamp-$hash"

# Relocate distribution and current working directory
mv $dist ..
cd ..

echo "Finished!"
# Set distribute file name
dist="$theme-distribute-$timestamp-$hash".zip

# Compress distribution
cd .prep
zip -qr $dist "$theme-$timestamp-$hash"

# Remove temporary theme directory
rm -rf "$theme-$timestamp-$hash"

# Relocate distribution and current working directory
mv $dist ..
cd ..

# Install Composer dependencies for development (again)
composer install

echo "Finished!"
