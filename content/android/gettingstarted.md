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
+ Camera HAL version 1.0, 3.0 or 3.2

# Setting up device
## Enabling USB debugging
You need to have USB debugging enabled on your device.

Note: The following steps are correct for Nexus 5, 6 and 6P. Other devices may look somewhat different:

0. Make sure you have `adb` and `fastboot` installed (`sudo apt-get install phablet-tools`).
1. Connect the device to a USB port on your computer
2. Go to the *Settings* app on your device.
3. Select *About phone*
4. If you have not yet unlocked developer options, tap *Build number* seven times to unlock developer options
5. You should see a message that confirms you have enabled the developer options
6. Go back to the main Settings menu and select *Developer options*
7. Check the *USB debugging* box
8. Press OK when asked: *Allow USB debugging?*
9. Press OK if asked: *Allow USB debugging?* with the computer's RSA key fingerprint displayed.
10. To verify, run the command:

    ```sh
    adb devices
    ```
12. If the device is listed as *device* you are ready. If it is listed as *unauthorized*, restart the ADB server:

    ```sh
    adb kill-server && adb start-server
    ```

You may then be asked to allow USB debugging (see step 9), then try step 10 again.

# Setting up environment
## Installing ADB
You will need ADB (Android Debug Bridge) to write files to the device:
```sh
sudo apt-get install phablet-tools
```

## Installing Android-NDK
You will need `ndk-build`, located in the Android NDK, to build the sources for your device.

1. Download the installer [here](https://developer.android.com/ndk/downloads/index.html)
2. Unpack the files into a path of your choice.

## Downloading wrapper sources
To quickly get started with Vidhance SDK we provide a public repository containing code to wrap the camera HAL and examples of how to integrate Vidhance SDK for Nexus devices. This code can easily be modified to run on your device.

If you do not already have `git` installed, install it using:
```sh
sudo apt-get install git
```

The repository can then be cloned from github:

```sh
git clone https://github.com/vidhance/android-camera-wrapper-legacy
```

## Setting up help functions
In the `android-camera-wrapper/nexus6p` folder, you will find the script *setup.sh*. You need to set the correct paths and names in this file in order for the script to work. The following information is needed:

* The name of the camera HAL library on your device (camera.msm8994.so on Nexus 6P)
* The path to where your wrapper library will be located once you build it (leave it as it is if you are unsure)
* The path to where the Android NDK is located
* The path to where the Vidhance binary is located (leave it as it is if you are unsure)

When the valid paths are set, run the script:

```sh
. setup.sh
```

You now have access to a number of help functions listed in the terminal.

## Downloading Vidhance library and Android dependencies
Run the function `download_vidhance` in the terminal. Follow the instructions to start downloading. You will need a key to authorize the download. This will supply you with a Vidhance binary and the needed headers and libraries to build the wrapper for your version of Android.

# Configuring for your device
We recommend that you modify the example implementation for Nexus 6P to create a compatible version for your device.

## Android dependencies
The camera wrapper depends on libraries found in the Android source tree. We have provided the needed headers and libraries for Nexus 6P which should be compatible with any 32-bit ARM-based device running Android 6.0. The headers can be found in the *include* folder and the libraries in the *libs* folder. The files are downloaded when running the *download_vidhance* function. If your device uses a different architecture or Android version, you may need to replace these libraries with ones compatible with your device. Contact us if you need help with this matter.

## Determining camera HAL and module version
In order to choose the correct wrapper, you need to know which HAL and module version your original library has implemented. Query the device with:
```sh
adb shell dumpsys | grep "Camera module"
```
The result should be something like:
```
Camera module HAL API version: 0x303
Camera module API version: 0x204
Camera module name: Vidhance Module
Camera module author: Imint AB
```
The most significant digit is the major version number and the two least significant digits are the minor version number. In the above example the original HAL API is therefore of version 3.2 and the module API of version 2.4.

## Configuring Android makefiles
### Android.mk
Inside the Nexus 6P folder you can find `Android.mk` which is used as a makefile when building with `ndk-build`. We provide wrapper implementations for a number of camera HAL versions. You need to edit the makefile to use the sources for the HAL version you intend to use with your device. In the example `Android.mk` you will see the following configuration:
```
#Android version
ANDROID_VERSION_MAJOR=6
ANDROID_VERSION_MINOR=0
#Module API version
MODULE_VERSION_MAJOR=2
MODULE_VERSION_MINOR=4
#Device API version
DEVICE_VERSION_MAJOR=3
DEVICE_VERSION_MINOR=3
```
This means the library is compiled for Android 6.0, using Camera module API version 2.4 and Camera device API version 3.3 (also called Camera HAL version).

### Application.mk
In this file you can specify which Android API level you are building for. A complete list can be found [here](https://source.android.com/source/build-numbers.html).

## Changes in source code
The `VidhanceProcessor` implementation in the Nexus 6P folder is an example of how to use the camera wrapper implementation in combination with the Vidhance library. You probably need some minor modifications before you start building.

### Include correct VideoProcessor header
Make sure the correct VideoProcessor header for your HAL version is included in VidhanceProcessor.h.
```
/* VidhanceProcessor.h */
#include "../HAL/HAL3/VideoProcessor.h"
#include "../HAL/HAL3/DoubleBufferVideoProcessor.h"
```

### Implement getStride
The stride factor for GraphicBuffer depends on the platform you are using. You therefore need to define a function where this information can be accessed. Take a look at the implementation for Nexus 6P:
```c++
stride_t VidhanceProcessor::getStride(const sp<GraphicBuffer>& buffer) {
	return stride_t(ALIGN(buffer->width, buffer->usage & GraphicBuffer::USAGE_HW_VIDEO_ENCODER ? 64 : 32), ALIGN(buffer->height, 32));
}
```

<a name="Building"></a>
# Building
The `build` function is an example of how to use `ndk-build` to build the sources. You are of course free to use your toolchain of choice. The build should generate *libcamera_wrapper.so*.

<a name="PreparingPhoneForWrapper"></a>
# Preparing phone for wrapper
Before we can push the wrapper to the device we need to know the filename Android expects when loading the camera HAL. For example, for Nexus 5 it is *camera.hammerhead.so* and for Nexus 6P
*camera.msm8994.so*. What we want to do is to rename the wrapper library to the expected filename and rename the actual HAL implementation to *camera_backend.so* so it can be loaded by the wrapper.

It is recommended to create a backup of the original HAL implementation if you somehow manage to delete it by mistake. You can pull the library from the device with `adb`:
```
adb pull /system/lib/hw/camera.msm8994.so camera_backup.msm8994.so
```

The function `setup_device` will create a copy of your camera HAL library on your device and rename it to *camera_backend.so*. It will also push the Vidhance library to the phone - so make sure you have downloaded it and specified the correct path to it in the setup.sh script. Once the function has completed you don't have to run it unless you reinstall Android on your phone or simply want to push a newer version of the Vidhance library.

<a name="PushingToPhone"></a>
# Pushing to phone
Every time you have rebuilt the wrapper library with `build` you can use the `push` function to overwrite it on the device. Make sure you set the *CAMERA_HAL* variable to the name of your original library and the correct path to your wrapper library in the *setup.sh* script.

# Restoring phone
If you want to reset the device to its original state you can use the `restore` function. This will set the camera library on the device to the original.

# Using the Vidhance API

Examine the *CameraWrapper* implementation in the HAL folder and use it as an example for how to interact with the Vidhance API for Android. Here is a more detailed description of the code using the Vidhance API:

## Initializing
Start with including the header containing the Vidhance API:
```
#include "../vidhance/vidhance.h"
```

Before you can use the Vidhance API you need to initialize it by calling the global load function:
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
vidhance_graphic_buffer_register_callbacks(
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
vidhance_debug_register_callback(debugPrint);
```

## Creating Vidhance context
To create a context we first need to create settings for the context. It is recommended to use the default settings until you have successfully built and pushed to the device.
```
vidhance_settings_t settings = vidhance_settings_new();
```
If your device can provide gyro sensor data you should register a RotationSensor in the settings. You can include the GyroReader header in the vidhance folder and use a predefined function `GyroReader::getAngularVelocity` which uses the Android SensorManager API. Of course you are free to supply a custom function pointer for the sensor sampling, as long as it will correctly return the requested samples between two camera timestamps. For this to be possible you need to be able to synchronize the camera timestamps and gyro timestamps.

Example implementation of sampling function:
```c++
vidhance_angular_velocity_measurements_t GyroReader::_getAngularVelocity(vidhance_date_time_t timestamp, vidhance_time_span_t length) {
	int64_t suspendedTimeNs = systemTime(SYSTEM_TIME_BOOTTIME) - systemTime(SYSTEM_TIME_MONOTONIC);
	vidhance_angular_velocity_measurements_t result = vidhance_angular_velocity_measurements_new(this->getSamplePeriod());
	std::vector<ASensorEvent> events = this->getEvents(timestamp, length);
	std::vector<ASensorEvent>::const_iterator iter;
	for(iter = events.begin(); iter != events.end(); ++iter) {
		ASensorEvent event = *iter;
		int64_t eventTimestampTicks = (event.timestamp - suspendedTimeNs) / 100;
		vidhance_float_vector_3d_t velocity = vidhance_float_vector_3d_new(-event.data[1], -event.data[0], -event.data[2]);
		vidhance_date_time_t eventTime = vidhance_date_time_new(eventTimestampTicks);
		vidhance_angular_velocity_measurement_t measurement = vidhance_angular_velocity_measurement_new(velocity, eventTime);
		vidhance_angular_velocity_measurements_add(result, measurement);
	}
	events.clear();
	return result;
}
```


```
#include "../vidhance/sensors/GyroReader.h"
```
```
vidhance_settings_t settings = vidhance_settings_new();
vidhance_motion_settings_t motion_settings = vidhance_settings_get_motion(settings);
vidhance_motion_sensor_settings_t sensor_settings = vidhance_motion_settings_get_sensor(motion_settings);
vidhance_motion_sensor_t gyro_sensor = vidhance_gyro_sensor_new(GyroReader::getAngularVelocity, GyroReader::getInstance()->getSamplePeriod());
vidhance_motion_sensor_t rotation_sensor = vidhance_rotation_sensor_new(gyro_sensor);
vidhance_motion_sensor_settings_set_rotation(sensor_settings, rotation_sensor);
```
We can now create a vidhance context using the settings.
```
vidhance_context_t context = vidhance_context_new(settings);
```

## Configuring settings
The Vidhance API enables you to configure the settings of the different modules to optimize quality and performance for your device. Take a look in *vidhance.h* to see the available settings. As an example we will look at the stabilization settings:

```
/* Motion stabilize settings */
extern vidhance_stabilizer_settings_t vidhance_settings_get_stabilize(const vidhance_settings_t settings);
extern void vidhance_stabilizer_settings_set_mode(vidhance_stabilizer_settings_t settings, vidhance_stabilizer_mode_t mode);
extern vidhance_stabilizer_mode_t vidhance_stabilizer_settings_get_mode(const vidhance_stabilizer_settings_t settings);
```

First we need a reference to the motion settings from our base settings:
```
vidhance_settings_t settings = vidhance_settings_new();
vidhance_stabilizer_settings_t stabilize_settings = vidhance_settings_get_stabilize(settings);
```
Then we can alter a setting for this settings object:
```
vidhance_stabilizer_settings_set_mode(stabilizeSettings, VIDHANCE_STABILIZER_ON);
```
Finally we create the Vidhance context with the base settings object:
```
context = vidhance_context_new(settings);
```

## Processing frames
*VidhanceProcessor* may inherit either *VideoProcessor* or *DoubleBufferVideoProcessor*. The difference is purely an optimization so we recommend starting out with a *VideoProcessor* implementation. *VideoProcessor* will override some of the HAL functions and prepare the camera buffers and metadata for input to Vidhance by creating a `frame_data_t` object:
```c++
typedef struct {
	sp<GraphicBuffer> inputBuffer;
	sp<GraphicBuffer> outputBuffer;
	uint64_t timestamp;
	uint64_t lifetime;
	uint64_t rollingShutterTime;
	uint32_t frame_number;
	float focalLength;
	int64_t exposureTime;
	int32_t cropRegion[4];
} frame_data_t;
```
The various functions in *CameraWrapper* will then be called by *VideoProcessor* and the *frame_data_t* can be converted into Vidhance compatible types.

Example showing how a *vidhance_image_t* is constructed from *GraphicBuffer* :
```c++
vidhance_image_t CameraWrapper::createImage(const sp<GraphicBuffer>& buffer, const FreeFlag flag) {
	stride_t stride = this->getStride(buffer);
	int uvOffset = stride.horizontal * stride.vertical;
	vidhance_int_vector_2d_t size = vidhance_int_vector_2d_new(buffer->width, buffer->height);
	GraphicBufferWrapper* wrapper = new GraphicBufferWrapper(buffer, flag);
	// Image objects for Vidhance. Ownership is passed to Vidhance when processed, hence memory management is handled internally.
	vidhance_graphic_buffer_t wrappedBuffer = vidhance_graphic_buffer_new((void*)wrapper, (void*)buffer->getNativeBuffer(),
			(void*)buffer->handle, size, stride.horizontal, buffer->format);
	return vidhance_graphic_buffer_yuv_420_semiplanar_new(wrappedBuffer, size, stride.horizontal, uvOffset);
}
```

Example showing how a *vidhance_frame_t* is constructed from metadata:
```c++
vidhance_frame_t CameraWrapper::createFrame(const frame_data_t& frame, const vidhance_image_t image) {
	int activePixelArrayWidth = this->cameraMeta.activePixelArraySize[2];
	int activePixelArrayHeight = this->cameraMeta.activePixelArraySize[3];
	int maxPixelArrayWidth = this->cameraMeta.pixelArraySize[0];
	int resolutionWidth = frame.inputBuffer->width;
	float focalLength = frame.focalLength;
	float sensorWidth = this->cameraMeta.physicalSize[0];
	float focalLengthPixels = float(resolutionWidth) * focalLength / sensorWidth;
	float cropY = 1.0f;
	if(activePixelArrayWidth > 0 && activePixelArrayHeight > 0) {
		//Note: This is actually more correct but the cropRegion metadata gives incorrect information on some devices
		//float cropY = (float)frame.cropRegion[3] / activePixelArrayHeight;
		//This approximation will do for now
		cropY = ((float)activePixelArrayWidth * frame.inputBuffer->height) / (activePixelArrayHeight * frame.inputBuffer->width);
	}

	int64_t croppedReadout = frame.rollingShutterTime * cropY;
	int64_t timestampOffset = (frame.rollingShutterTime - croppedReadout) / 2;
	uint64_t timestamp = frame.timestamp + timestampOffset;
	vidhance_time_span_t readoutSpan = vidhance_time_span_new(NS_TO_TICKS(croppedReadout));
	vidhance_time_span_t exposureTime = vidhance_time_span_new(NS_TO_TICKS(frame.exposureTime));
	vidhance_header_t header = vidhance_header_new(vidhance_date_time_new(NS_TO_TICKS(timestamp)), vidhance_time_span_new(NS_TO_TICKS(frame.lifetime)),
			readoutSpan, focalLengthPixels, exposureTime);
	return vidhance_frame_from_image(header, image);
}
```

When the *vidhance_frame_t* has been created, it can be sent to Vidhance:
```c++
void CameraWrapper::processVideoCapture(const frame_data_t& frame) {
	vidhance_context_process_in_place(context, this->createFrame(frame, this->createImage(frame.inputBuffer)));
}
```

# Running
## Instructions
1. Make sure you have successfully executed the `setup_device` function so the backend library and the Vidhance library exist on the device (see [Preparing phone for wrapper](#PreparingPhoneForWrapper)).
2. Build your implementation (see [Building](#Building)).
3. Push the wrapper to the device (see [Pushing to phone](#PushingToPhone)).
4. You can now use any camera app on the device to view the results.

## What to expect
If you have successfully built and pushed the correct files to your device you should be able to notice modifications in the captured video. If you used the default settings when creating the Vidhance context you can expect to see the following:

+ A Vidhance logo in the upper right corner
+ Version number in the bottom right corner

If your result is not as expected you can proceed to the next chapter or contact our support via the chat widget on this page.

# Troubleshooting
The Vidhance binary includes useful print output which can be captured by configuring the `debugPrint` callback to a function of your choice (see [Debug print](#DebugPrint)).

<a name="UsingMonitor"></a>
## Using Monitor
The default callback for output is located in *vidhance/debug/Debug.h* and will print the output to Android's logging system `logcat`. This output can be captured by using Monitor which is included in the Android SDK. Follow these steps:

1. Download Android SDK [here](http://developer.android.com/sdk/index.html). We will only need the package listed under `SDK Tools Only`, but the full `Android Studio` package contains the SDK as well.
2. Run *monitor* located in *android-sdks/tools*
3. Make sure your device is connected by USB and with USB debugging enabled. You should see your device listed in the Android Device Monitor window.
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
