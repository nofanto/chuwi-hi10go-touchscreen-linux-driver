# Chuwi Hi10 go N5100 Touchscreen Linux Driver

Touchscreen driver for Chuwi hi10 go N5100, the current mainline driver (kernel 6.6) have inverted the touch screen in the device.

This driver tested on Manjaro 23.1 (Vulcan) with gnome wayland as desktop environment. 


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