#!/bin/bash

# Step 1: Create a DKMS directory structure
DKMS_DIR="/usr/src/goodix-touchscreen-linux-driver-1.0"
sudo mkdir -p $DKMS_DIR
if [ $? -ne 0 ]; then
    echo "Failed to create DKMS directory: $DKMS_DIR"
    exit 1
fi

# Step 2: Copy the source files into the DKMS directory
SOURCE_DIR="/path/to/goodix-touchscreen-linux-driver"  # Update this path to your actual source directory
sudo cp -r $SOURCE_DIR/* $DKMS_DIR/
if [ $? -ne 0 ]; then
    echo "Failed to copy source files from: $SOURCE_DIR"
    exit 1
fi

echo "Source files copied successfully."

# Step 3: Create a DKMS configuration file
cat <<EOF | sudo tee $DKMS_DIR/dkms.conf
PACKAGE_NAME="goodix_touchscreen"
PACKAGE_VERSION="1.0"

BUILT_MODULE_NAME[0]="goodix_ts"
DEST_MODULE_LOCATION[0]="/kernel/drivers/input/touchscreen"
AUTOINSTALL="yes"

CLEAN="make clean"
BUILD="make"
EOF

echo "DKMS configuration file created."

# Step 4: Add the module to DKMS
sudo dkms add goodix-touchscreen/1.0
if [ $? -ne 0 ]; then
    echo "Failed to add module to DKMS."
    exit 1
fi

echo "Module added to DKMS successfully."

# Step 5: Build the module using DKMS
sudo dkms build goodix_touchscreen/1.0
if [ $? -ne 0 ]; then
    echo "Failed to build the module."
    exit 1
fi

echo "Module built successfully."

# Step 6: Install the module using DKMS
sudo dkms install goodix_touchscreen/1.0
if [ $? -ne 0 ]; then
    echo "Failed to install the module."
    exit 1
fi

echo "Module installed successfully."

# Step 7: Reboot your system (if necessary)
echo "Driver installation complete. You may need to reboot your system."
read -r -p "Do you want to reboot now? [y/N] " REBOOT
if [[ $REBOOT =~ ^[Yy]$ ]]; then
    sudo reboot
fi