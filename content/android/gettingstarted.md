---
date: "2015-03-11T14:32:03+01:00"
title: "Getting Started with Vidhance SDK for Android"
menu:
  main:
    parent: android
    weight: 20
    name: "getting started"
---


This section will guide you through installing and setting up the environment you will need in order to use the Vidhance SDK for Android.
# Prerequisites
+ We recommend using a computer with Ubuntu 14.04
+ Android device with root access

# Setting up device
## Enabling USB debugging
You need to have USB debugging enabled on your device:

9. Connect the device to a USB port on your computer
1. Go to the *Settings* app on your device.
2. Select *About phone*
3. Tap *Build number* seven times to unlock developer options
4. You should see a message that confirms you have enabled the developer options
5. Go back to the Settings menu
6. Select *Developer options*
7. Check the *USB debugging* box
8. Press OK when asked: *Allow USB debugging?*
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
and you should be asked to allow USB debugging (see step 10).

# Setting up environment
## Installing ADB
You will need ADB (Android Debug Bridge) to write files to the device:
```sh
sudo apt-get install phablet-tools
```
## Installing Android-NDK
You will need Android-NDK to build the sources for your device.

1. Download the installer [here](https://developer.android.com/tools/sdk/ndk/index.html)
2. Open a terminal and move to a suitable directory (e.g. home)

    ```sh
    cd ~
    ```
3. Set execution rights on the binary

    ```sh
    chmod a+x android-ndk-r10d-linux-x86_64.bin
    ```
4. Run the binary

    ```sh
    ./android-ndk-r10d-linux-x86_64.bin
    ```

## Downloading wrapper sources
To quickly get started with Vidhance SDK we provide a public repository containing code to wrap the camera HAL and examples of how to integrate Vidhance SDK for Nexus devices. This code can easily be modified to run on your device. The repository can be cloned from github:

```sh
git clone https://github.com/vidhance/android-camera-wrapper
```

## Downloading Vidhance library
Inside the Nexus6 example folder you will find download_vidhance.sh. Run the script and
