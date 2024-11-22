#!/bin/bash

# Rapid Response Forensics Toolkit - Master Script
# Automates the mounting of the USB drive and execution of the data collection script with minimal interaction.

# Variables
DEVICE_LABEL="FORENSICS_USB"  # Replace with your USB drive's label
MOUNT_POINT="/mnt/forensics"

# Create mount point if it doesn't exist
if [ ! -d "$MOUNT_POINT" ]; then
    sudo mkdir -p "$MOUNT_POINT"
fi

# Find the device identifier for the USB drive
DEVICE_ID=$(lsblk -o LABEL,NAME | grep "$DEVICE_LABEL" | awk '{print "/dev/" $2}')

if [ -z "$DEVICE_ID" ]; then
    echo "USB drive with label '$DEVICE_LABEL' not found."
    exit 1
fi

# Mount the USB drive as read-only to minimize changes to the device
echo "Mounting USB drive..."
sudo mount -o ro "$DEVICE_ID" "$MOUNT_POINT"

# Copy the data collection script to the system's RAM (/dev/shm)
echo "Copying data collection script to RAM..."
sudo cp "$MOUNT_POINT/collect_forensic_data.sh" /dev/shm/

# Make the script executable
sudo chmod +x /dev/shm/collect_forensic_data.sh

# Execute the data collection script from RAM
echo "Executing data collection script..."
sudo bash /dev/shm/collect_forensic_data.sh

# Unmount the USB drive
echo "Unmounting USB drive..."
sudo umount "$MOUNT_POINT"

# Clean up
echo "Cleaning up..."
sudo rm /dev/shm/collect_forensic_data.sh

echo "Forensic data collection complete. You can now safely remove the USB drive."

# End of script

