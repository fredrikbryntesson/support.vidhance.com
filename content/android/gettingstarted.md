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
+ Camera HAL version 3.0 or 3.2 (support for 1.0 coming soon)

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

## Determining HAL version
You need to know which HAL version your original library has implemented to choose the correct wrapper. Query the device with:
```sh
adb shell dumpsys | grep "Device version:"
```
The result should be something like:
```
Device version: 0x302
```
where the most significant digit is the major version number and the two least significant digits are the minor version number. In the above example the original HAL is therefore of version 3.2. Note that Vidhance SDK currently only supports HAL version 3.0 and 3.2 but support for older versions will be available soon.

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

### Include correct VideoProcessor header
Make sure the correct VideoProcessor header for your HAL version is included in VidhanceProcessor.h.
```
/* VidhanceProcessor.h */
#include "../hal3.2/VideoProcessor.h"
```

### Configure GraphicBuffer
Vidhance uses Android's *GraphicBuffer* class to allocate buffer memory. To maximize performance, Vidhance needs to be provided with a list of widths that are aligned in memory, i.e. no padding is used. This is device-specific and needs to be explicitly provided to Vidhance. The list should contain aligned widths in bytes for GraphicBuffers allocated with format *HAL_PIXEL_FORMAT_RGBA_8888*.

#### Option 1
You can use the function *getAlignedWidth()* located in *vidhance/graphicbuffer/GraphicBufferWrapper.h* to check the values for your device:
```
/* VidhanceProcessor.cpp */
#include "../vidhance/graphicbuffer/GraphicBufferWrapper.h"

vidhance_context* context = NULL;
VidhanceProcessor::VidhanceProcessor(const char* cameraId) :
		VideoProcessor(cameraId) {
	if (context == NULL) {
		aligned_width alignedWidth = getAlignedWidth();
		kean_draw_gpu_android_graphicBuffer_configureAlignedWidth(&alignedWidth.width[0], alignedWidth.count);
	}
}
```
#### Option 2 (Recommended)
Option 1 should only be used to get started if you do not know the values for your device since it will slow down the initialization. The function will return the values and print the aligned widths to Logcat under the log tag *GraphicBufferWrapper* (See [Using DDMS](./android/gettingstarted#UsingDDMS) for instructions). Use this output to create a predefined array with values. Example for Nexus 6:
```
/* VidhanceProcessor.cpp */

/* Predefined aligned width in bytes for RGBA8888 GraphicBuffers on Nexus 6 */
#define ALIGNED_WIDTH_COUNT 10
const int alignedWidth[ALIGNED_WIDTH_COUNT] =
{ 128, 256, 384, 512, 1024, 1536, 2560, 3072, 3584, 4608 };

vidhance_context* context = NULL;
VidhanceProcessor::VidhanceProcessor(const char* cameraId) :
		VideoProcessor(cameraId) {
	if (context == NULL) {
		kean_draw_gpu_android_graphicBuffer_configureAlignedWidth(&alignedWidth[0], ALIGNED_WIDTH_COUNT);
	}
}
```

<a name="Building"></a>
# Building
The *make.sh* script is an example of how to use ndk-build to build the sources. You are of course free to use your toolchain of choice. The build should generate *libcamera_wrapper.so*.

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
#setup_device.sh

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
	echo "Successfully created camera backend library."
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
#push.sh

#!/bin/bash
CAMERA_HAL=camera.msm8084.so
WRAPPER_PATH=./libs/armeabi-v7a/libcamera_wrapper.so

OUTPUT=$(adb shell ls /system/lib/hw/$CAMERA_HAL)
OUTPUT_WRAPPER=$(adb shell ls /system/lib/hw/camera_backend.so)
if [[ $OUTPUT == *"No such file or directory"* ]]
then
	echo "Couldn't find" $CAMERA_HAL "on the device. Are you using the correct filename?"
elif [[ $OUTPUT_WRAPPER == *"No such file or directory"* ]]
then
	echo "Couldn't find camera_backend.so on the device. Make sure to run the setup_device.sh script before overwriting" $CAMERA_HAL
else
	echo Overwriting $CAMERA_HAL ...
	echo "Waiting for device to go online..."
	adb wait-for-device
	adb root
	sleep 2
	echo "Waiting for device to go online..."
	adb wait-for-device
	adb shell mount -o remount,rw /system
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
<a name="DebugPrint"></a>
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
## Instructions
1. Make sure you have successfully executed the *setup_device.sh* script so the backend library and the Vidhance library exist on the device. (See [Preparing phone for wrapper](./android/gettingstarted#PreparingPhoneForWrapper))
2. Build your implementation. (See [Building](./android/gettingstarted#Building))
3. Push the wrapper to the device. (See [Pushing to phone](./android/gettingstarted#PushingToPhone))
4. When the device has rebooted you can use any camera app on the device to view your results.

## What to expect
If you have successfully built and pushed the correct files to your device you should be able to notice modifications in both the preview and captured video. If you used the default settings when creating the Vidhance context you can expect to see the following:

+ The preview should have a clearly visible viewfinder
+ The captured video should be stabilized with a cleary visible motion trace in the lower right corner

If your result is not as expected you can proceed to the next chapter or contact our support via the chat widget on this page.

# Troubleshooting
It is recommended to use the debug version of the Vidhance library while in development. Version can be selected when running the *download_vidhance.sh* script. The debug version includes useful print output which can be captured by configuring the debugPrint callback to a function of your choice (see [Debug print](./android/gettingstarted#DebugPrint)).
<a name="UsingDDMS"></a>
## Using DDMS
The default callback for output is located in *vidhance/debug/Debug.h* and will print the output to Android's logging system Logcat. This output can be captured by using DDMS (Dalvik Debug Monitor Server) which is included in the Android-SDK. Follow these steps:

1. Download Android-SDK [here](http://developer.android.com/sdk/index.html)
2. Run *ddms* located in *android-sdks/tools*
3. Make sure your device is connected by USB and with USB debugging enabled. You should see your device listed in the DDMS window.
4. Create a new filter with these settings:

  + *Filter Name:* Vidhance
  + *by Log Tag:* Vidhance
  + *by Log Level:* verbose
  + Leave the rest blank.
5. You should now get output to the filter from the Vidhance library when your device is capturing video.
6. If you have problems with crashes it can be helpful to get the backtrace from the device. Create another filter with these settings:

  + *Filter Name:* Debug
  + *by Log Tag:* DEBUG
  + *by Log Level:* verbose
  + Leave the rest blank.
7. When the device crashes you can check the backtrace in the debug filter for useful information.
