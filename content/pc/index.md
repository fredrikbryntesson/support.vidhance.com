---
title: "Gettings started with Vidhance SDK for PC"
menu:
  main:
    weight: 40
    name: pc
---
# Download the Vidhance library
# Using the Vidhance API
## Initializing and creating creating a Vidhance context
Before you can use the Vidhance API you need to initialize it by calling the load function:
```c++
vidhance_load();
```
Now we can create settings for the context and then the context itself:
```c++
vidhance_settings settings = vidhance_settings_new();
vidhance_context context = vidhance_context_new(settings);
```
## Configuring settings
It is recommend to use the default settings until you have successfully compiled and run. The Vidhance API enables you to configure the settings of different modules to optimize quality and performance for different needs. The available settings can be seen in *vidhance.h*. Here is an example on how to configure stabilizer settings:
```c++
vidhance_settings settings = vidhance_settings_new();
vidhance_motion_settings settings_motion = vidhance_settings_getMotion(settings);
vidhance_stabilizer_settings settings_stabilizer = vidhance_motion_settings_getStabilize(settings_motion);
vidhance_stabilizer_settings_setMode(settings_stabilizer, VIDHANCE_STABILIZE_MODE_OPTICALFLOW);
vidhance_stabilizer_settings_setShowTrace(settings_stabilizer, true);
```
## Processing frames
To process a frame you need to create a vidhance_frame and then call the process function:
```c++
const int stride = image.width * image.bytesPerPixel;
kean_draw_rasterBgr raster = kean_draw_rasterBgr_new(image.width, image.height, stride, image.data);
vidhance_frame input = vidhance_frame_fromImage(vidhance_frame_header_default(), raster);
vidhance_frame output = vidhance_context_process(context, input);
```
## Using the stabilizer
Stabilization is active by default and this code can be used to activate a trace for the stabilization:
```c++
vidhance_settings settings = vidhance_settings_new();
vidhance_motion_settings settings_motion = vidhance_settings_getMotion(settings);
vidhance_stabilizer_settings settings_stabilizer = vidhance_motion_settings_getStabilize(settings_motion);
vidhance_stabilizer_settings_setShowTrace(settings_stabilizer, true);
```
This is an example of how to process a frame and retrieve a transformation matrix from it:
```c++
vidhance_frame frame = vidhance_context_process(context, input);
kean_math_floatTransform3D matrix = vidhance_stabilizer_getTransformFromFrame(frame);
kean_math_floatSize3D translation = kean_math_floatTransform3D_getTranslation(matrix);
kean_math_floatSize3D scaling = kean_math_floatTransform3D_getScaling(matrix);
```
## Using the tracker
Tracking is not active by default and this code can be used to activate it:
```c++
vidhance_settings settings = vidhance_settings_new();
vidhance_motion_settings settings_motion = vidhance_settings_getMotion(settings);
vidhance_tracker_settings settings_tracker = vidhance_motion_settings_getTracker(settings_motion);
vidhance_tracker_settings_setMode(settings_tracker, VIDHANCE_TRACKER_IR);
vidhance_tracker_settings_setVisualizeBounds(settings_stracker, true);
```
This is an example of how to process a frame and retrieve the tracker bounds from it:
```c++
vidhance_motion motion = vidhance_context_getMotion(context);
vidhance_tracker tracker = vidhance_motion_getTracker(motion);
tracker = vidhance_tracker_start(tracker, startRegion);
vidhance_frame = vidhance_context_process(context, input);
kean_math_floatBox2D tracker_bounds = vidhance_tracker_instance_getBounds(tracker);
```
## Complete code examples
There are complete code examples available [here](https://github.com/vidhance/example-vidhance-pc-cpp-stabilize-track) for running Vidhance with stabilizer and tracker.
