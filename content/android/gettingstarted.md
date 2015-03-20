---
date: "2015-03-11T14:32:03+01:00"
title: "Getting Started with Vidhance SDK for Android"
menu:
  main:
    parent: android
    weight: 20
    name: "getting started"
---

# Introduction
This section will describe how to integrate Vidhance by wrapping the camera driver on Android devices. This can be achieved by replacing the camera HAL implementation with a wrapper which internally will link to the original implementation. This enables the wrapper to monitor the requests sent to the camera and modify the input and output data.
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
You will need ndk-build located in the Android-NDK to build the sources for your device.

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
Inside the nexus6 example folder you will find *download_vidhance.sh*. This script can be used to download the correct version of Vidhance for your device. You will need a key to be able to begin the download. Run the script and follow the instructions:
```sh
chmod a+x download_vidhance.sh
./download_vidhance.sh
```

# Configuring for your device
We recommend that you modify the example implementation for Nexus 6 to create a compatible version for your device.
## Android dependencies
The camera wrapper depends on libraries found in the Android source tree. We have provided the needed headers and libraries for Nexus 6 which should be compatible with any 32-bit ARM-based device running Android 5.0.1. The headers can be found in the *include* folder and the libraries in the *libs* folder. If your device uses a different architecture or Android version you may need to replace these libraries with ones compatible with your device. Contact us if you need help with this matter.

## Configuring Android makefiles
### Android.mk
Inside the Nexus 6 folder you can find Android.mk which is used as a makefile when building with ndk-build. We provide wrapper implementations for a number of camera HAL versions. You need to edit the makefile to use the sources for the HAL version you intend to use with your device. In the example Android.mk you will see the sources from HAL 3.2 included in the makefile. Simply change the folder to the correct version.
```
LOCAL_SRC_FILES := \
    ../hal3.2/VidhanceWrapperHAL.cpp \
    ../hal3.2/VidhanceWrapperFactory.cpp \
    ../hal3.2/VidhanceWrapper.cpp \
    ../hal3.2/StreamMonitor.cpp \
    ../hal3.2/VideoProcessor.cpp \
    ../vidhance/rotation_sensor/SensorReader.cpp \
    VidhanceProcessor.cpp \
```
### Application.mk
In this file you can specify which Android API level you are building for. A complete list can be found [here](https://source.android.com/source/build-numbers.html).

## Changes in source code
The VidhanceProcessor implementation in the nexus6 folder is an example of how to use the camera wrapper implementation in combination with the Vidhance library. You need some minor modifications before you start building.

Make sure the correct VideoProcessor header for your HAL version is included in VidhanceProcessor.h.
```
#include "../hal3.2/VideoProcessor.h"
```
Vidhance uses Android's *GraphicBuffer* class to allocate buffer memory. To maximize performance, Vidhance needs to be provided with a list of widths that are aligned in memory, i.e. no padding is used. This is device-specific and needs to be explicitly provided to Vidhance. The list should contain aligned widths in bytes for GraphicBuffers allocated with format *HAL_PIXEL_FORMAT_RGBA_8888*. Example array for Nexus 6:
```
const int alignedWidth[ALIGNED_WIDTH_COUNT] = { 32 * 4, 64 * 4, 96 * 4,
  128 * 4, 256 * 4, 384 * 4, 640 * 4, 768 * 4, 896 * 4, 1152 * 4 };
```
If you wish to skip this step you can simply provide an empty array, however this will cause a significant drop in performance.

<a name="Building"></a>
# Building
The make.sh script is an example of how to use ndk-build to build the sources. You are of course free to use your toolchain of choice. The build should generate libcamera_wrapper.so.

<a name="PreparingPhoneForWrapper"></a>
# Preparing phone for wrapper
Before we can push the wrapper to the device we need to know the filename Android expects when loading the camera HAL. For example, for Nexus 5 it is *camera.hammerhead.so* and for Nexus 6
*camera.msm8084.so*. What we want to do is to rename the wrapper library to the expected filename and rename the actual HAL implementation to camera_backend.so so it can be loaded by the wrapper.

It is recommended to create a backup of the original HAL implementation if you somehow manage to delete it by mistake. You can pull the library from the device with adb:
```
adb pull /system/lib/hw/camera.msm8084.so <path on your computer>
```

First take a look at the setup_device.sh script which demonstrates how to create the backend library from the default HAL implementation. Make sure you set the *CAMERA_HAL* variable to the name of your original library. The script also pushes the Vidhance library to the phone so make sure you have downloaded it and specified the correct path to it in the script. Once the script has completed you don't have to run it unless you reinstall Android on your phone or simply want to push a newer version of the Vidhance library.
```
#!/bin/bash
CAMERA_HAL=camera.msm8084.so
VIDHANCE_PATH=./libs/libvidhance_android32.so

echo "Waiting for device to go online..."
adb wait-for-device
adb root
sleep 2
echo "Waiting for device to go online..."
adb wait-for-device
adb shell mount -o remount,rw /system
echo "Creating camera backend library..."
WRAPPER_OUTPUT=$(adb shell ls /system/lib/hw/camera_backend.so)
if [[ $WRAPPER_OUTPUT == *"No such file or directory"* ]]
then
	echo "Successfully Created camera backend library."
	adb shell cp /system/lib/hw/$CAMERA_HAL /system/lib/hw/camera_backend.so
else
	echo "Camera backend library already exists. Skipping."
fi

if [ ! -f $VIDHANCE_PATH ]
then
	echo "Couldn't find Vidhance library at" $VIDHANCE_PATH
	echo "Have you downloaded the library and specified the correct path in the script?"
else
	echo "Pushing Vidhance library..."
	adb push $VIDHANCE_PATH /system/lib/
fi

adb reboot

```

<a name="PushingToPhone"></a>
# Pushing to phone
Every time you have rebuilt the wrapper library you can use the push.sh script to overwrite it on the device. Make sure you set the *CAMERA_HAL* variable to the name of your original library and the correct path to your wrapper library.
```
#!/bin/bash
CAMERA_HAL=camera.msm8084.so
WRAPPER_PATH=./libs/armeabi-v7a/libcamera_wrapper.so

OUTPUT=$(adb shell ls /system/lib/hw/$CAMERA_HAL)
if [[ $OUTPUT == *"No such file or directory"* ]]
then
	echo "Couldn't find" $CAMERA_HAL "on the device. Are you using the correct filename?"
else
	echo Overwriting $CAMERA_HAL ...
	echo "Waiting for device to go online..."
	adb wait-for-device
	adb root
	sleep 2
	echo "Waiting for device to go online..."
	adb wait-for-device
	adb shell mount -o remount,rw /system
	adb shell rm -f /system/lib/hw/$CAMERA_HAL
	adb push  $WRAPPER_PATH /system/lib/hw/$CAMERA_HAL
	adb reboot
fi

```
# Using the Vidhance API
Examine the *VidhanceProcessor* implementation in the nexus6 folder and use it as a tutorial of how to integrate Vidhance for Android. Here is a more detailed description of the code:
## Initializing
Before you can use the Vidhance API you need to initialize it by calling the load function:
```
vidhance_load();
```
## Register callbacks
### GraphicBuffer
Vidhance depends on a number of callbacks to interact with Android's GraphicBuffer. These callbacks are located in the vidhance folder and should **NOT** be modified. Simply include the header and supply Vidhance with the function pointers.
```
#include "../vidhance/graphicbuffer/GraphicBufferWrapper.h"
```
```
kean_draw_gpu_android_graphicBuffer_registerCallbacks(
  allocateGraphicBuffer,
  createGraphicBuffer,
  freeGraphicBuffer,
  lockGraphicBuffer,
  unlockGraphicBuffer);
```
### Debug print
If you want debug output from Vidhance you can register a print callback. A default function that prints to logcat is located in the vidhance folder but you are free to use your own.
```
#include "../vidhance/debug/Debug.h"
```
```
kean_base_debug_registerCallback(debugPrint);
```
## Creating Vidhance context
To create a context we first need to create settings for the context.
```
vidhance_settings* settings = vidhance_settings_new();
```
If your device can provide rotational sensor data you should register the getRotationVector callback in the settings. Include the header in the vidhance folder and register the function pointer.
```
#include "../vidhance/rotation_sensor/RotationSensor.h"
```
```
vidhance_settings_registerCallback(settings, getRotationVector);
```
We can now create a vidhance context using the settings. It is recommended to store the context statically to prevent the need to construct it every time the camera starts.
```
vidhance_context* context = NULL;
VidhanceProcessor::VidhanceProcessor(const char* cameraId) :
		VideoProcessor(cameraId) {
...
if (context == NULL)
  context = vidhance_context_new(settings);
}
```
## Processing frames
The VidhanceProcessor contains one callback for video capture buffers and one for preview buffers. To feed a frame to the Vidhance context, an image structure needs to be created from some of the properties of the GraphicBuffer parameter. The structure needs to know how the data in the buffer is aligned in memory. For example, for Nexus 6 the width of the frame will be padded to 64 byte alignment and the height to 32 byte alignment.

The image structure can then be passed to one of the process functions. The first argument will be used as input buffer and the second argument will be used as output buffer where the result is written. It is currently recommended to use the same buffer as input and output.
```
void VidhanceProcessor::processVideoCapture(GraphicBuffer* graphicBuffer) {
    kean_draw_gpu_android_graphicBufferYuv420Semiplanar* image =
    kean_draw_gpu_android_graphicBufferYuv420Semiplanar_new(
      (void*) graphicBuffer,
      (void*) graphicBuffer->getNativeBuffer(),
      (void*) graphicBuffer->handle,
      kean_math_intSize2D_new(graphicBuffer->width, graphicBuffer->height),
      graphicBuffer->getStride(),
      graphicBuffer->format,
      64, /* Width byte alignment */
      32); /* Height byte alignment */
    vidhance_context_process(context, (kean_draw_image*) image, (kean_draw_image*) image);
}
```

## Configuring settings
It is recommended to use the default settings until you have successfully built and pushed to the device. The Vidhance API enables you to configure the settings of the different modules to optimize quality and performance for your device. Take a look in *vidhance.h* to see the available settings. As an example we will look at the motion settings:

```
/* Motion Settings */
vidhance_motion_settings* vidhance_settings_getMotion(vidhance_settings* settings);
void vidhance_motion_settings_setComplexity(vidhance_motion_settings* settings, int complexity);
int vidhance_motion_settings_getComplexity(vidhance_motion_settings* settings);
void vidhance_motion_settings_setMode(vidhance_motion_settings* settings, vidhance_motion_mode mode);
vidhance_motion_mode vidhance_motion_settings_getMode(vidhance_motion_settings* settings);
```

First we need a reference to the motion settings from our base settings:
```
vidhance_settings* settings = vidhance_settings_new();
vidhance_motion_settings* motionSettings = vidhance_settings_getMotion(settings);
```
Then we can alter a setting for this settings object:
```
vidhance_motion_settings_setComplexity(motionSettings, 3);
```
Finally we create the Vidhance context with the base settings object:
```
context = vidhance_context_new(settings);
```

# Running
1. Make sure you have successfully executed the *setup_device.sh* script so the backend library and the Vidhance library exist on the device. (See [Preparing phone for wrapper](./android/gettingstarted#PreparingPhoneForWrapper))
2. Build your implementation. (See [Building](./android/gettingstarted#Building))
3. Push the wrapper to the device. (See [Pushing to phone](./android/gettingstarted#PushingToPhone))
4. When the device has rebooted you can use any camera app on the device to view your results.
