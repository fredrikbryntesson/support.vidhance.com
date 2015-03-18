---
date: "2015-03-11T14:32:03+01:00"
title: "Evaluate Vidhance Mobile"
menu:
  main:
    parent: "android"
    weight: 10
    name: "evaluate"
---
# Prerequisites
## PC
We recommend using a Ubuntu 14.04 LTS. You will need to install ADB and fastboot:
```sh
sudo apt-get install phablet-tools
```

### Downloading files
1. Create a folder
2. Download the [download script](../../download.sh) and run it inside the folder
3. Enter your key to start downloading the necessary files

## Phone

### Enabling USB debugging
1. Go to the *Settings* app on your device.
2. Select *About phone*
3. Tap *Build number* seven times to unlock developer options
4. You should see a message that confirms you have enabled the developer options
5. Go back to the Settings menu
6. Select *Developer options*
7. Check the *USB debugging* box
8. Press OK when asked: *Allow USB debugging?*
9. Connect the device to a USB port on your computer
10. Press OK when asked: *Allow USB debugging?* with the computer's RSA key fingerprint displayed.
11. To verify, run the command:

    ```sh
    adb devices
    ```
12. If the device is listed as *device* you are all set. If it is listed as *unauthorized*, restart the ADB server:

    ```sh
    adb kill-server
    ```

    ```sh
    adb start-server
    ```
and you should be asked to allow USB debugging (see step 6).

### Booting device into bootloader
1. Use ADB to reboot the device into the bootloader:

    ```sh
    adb reboot-bootloader
    ```
2. Make sure the device is unlocked by using the fastboot command and follow the instructions on the screen of the device:

    ```sh
    fastboot oem unlock
    ```

### Installing rooted Android
1. Run the script for flashing Android:

    ```sh
    ./flash_android.sh
    ```
2. Wait for the flash to complete.

### Installing Vidhance mobile
1. Run the script for flashing Vidhance:

    ```sh
    ./flash_vidhance.sh
    ```

# Running Vidhance
