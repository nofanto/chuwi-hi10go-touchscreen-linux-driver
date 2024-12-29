# Chuwi Hi10 go N5100 Touchscreen Linux Driver

Touchscreen driver for Chuwi hi10 go N5100, the current mainline driver (kernel 6.6) have inverted the touch screen in the device.

This driver tested on Manjaro 23.1 (Vulcan) with kernel 6.6 and gnome wayland as desktop environment. 


## Preparation

Open a terminal and follow these steps:

1. Prepare the **build tools (make)**, depend on the distro, on Manjaro can use this command :
```
sudo pacman -S base-devel
``` 

2. Prepare the **linux header for the target kernel**, again this depend on the distro, on Manjaro with kernel 6.6 can use this command :
```
sudo pacman -S linux66-headers
```


## Build the driver

Open a terminal and follow these steps:

1. **Clone** this repository:
  ```
  git clone https://github.com/nofanto/chuwi-hi10go-touchscreen-linux-driver
  ```

2. **Move** into the folder:
  ```
  cd goodix-touchscreen-linux-driver
  ```

3. **Build** the driver:
  ```
  make
  ```

## Install the driver

If the build succeded, go to the cloned folder and follow these steps:

1. **Compress** the driver into zst format:
  ```
    zstd goodix.ko
  ```

2. **Replace** the current driver with the new one:
  ```
  sudo mv goodix_ts.ko.zst /lib/modules/$(uname -r)/kernel/drivers/input/touchscreen/goodix_ts.ko.zst
  ```

3. Reboot the device

## DKMS Installation

To install the DKMS driver, follow these steps:

1. **Update the Script**:
   - Open the [create_dkms-driver.sh](cci:7://file:///Users/nofantoibrahim/Projects/personal/chuwi-hi10go-touchscreen-linux-driver/create_dkms-driver.sh:0:0-0:0) script.
   - Update the `SOURCE_DIR` variable to point to the actual path of your Goodix touchscreen driver source files.

2. **Run the Installation Script**:
   - Open a terminal and navigate to the directory containing the [create_dkms-driver.sh](cci:7://file:///Users/nofantoibrahim/Projects/personal/chuwi-hi10go-touchscreen-linux-driver/create_dkms-driver.sh:0:0-0:0) script.
   - Run the following command to execute the script with superuser permissions:
     ```bash
     sudo bash create_dkms-driver.sh
     ```

3. **Reboot (if prompted)**: After the installation completes, you may be prompted to reboot your system. Follow the instructions provided by the script.

## Prerequisites

- Ensure that DKMS is installed on your system.
- You may need superuser (sudo) permissions to run the script.

## Troubleshooting

If you encounter any issues during installation, check the output messages for errors. Ensure that all paths are correct and that you have the necessary permissions.

# References

- linux kernel 6.6 https://github.com/torvalds/linux/tree/v6.6
- Adya Goodix Touchscreen Linux Driver https://gitlab.com/AdyaAdya/goodix-touchscreen-linux-driver
