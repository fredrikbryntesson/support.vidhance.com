---
date: "2015-03-11T14:32:03+01:00"
title: "Vidhance API reference"
menu:
  main:
    parent: android
    weight: 20
    name: "API reference"
---

# Introduction
This section will describe the available methods and types in the Vidhance API.

[Initializing Vidhance](hej.html)

[Creating and adjusting settings](hej.html)

[Creating contexts](hej.html)

[Processing frames](hej.html)


# Initializing Vidhance
## Overview
### vidhance_load
Initializes the Vidhance library. Must be called before anything else can be used.
``` c
void vidhance_load();
```

### kean_draw_gpu_android_graphicBuffer_configureAlignedWidth
Provides Vidhance with a list of memory aligned widths in bytes for allocations of GraphicBuffers with format RGBA8888. This is not strictly necessary but greatly improves the performance.
``` c
void kean_draw_gpu_android_graphicBuffer_configureAlignedWidth(const int* alignedWidth, int count);
```
#### Parameters
*alignedWidth* An array of integers with aligned width in bytes.

*count* Number of aligned widths.

### kean_draw_gpu_android_graphicBuffer_registerCallbacks
Registers a number of necessary callbacks for Vidhance to allocate graphics memory. The necessary callbacks are included in the SDK and should not be defined by the user.
``` c
void kean_draw_gpu_android_graphicBuffer_registerCallbacks(void (*allocate)(int, int, int, int, void**, void**, int*),
		void (*create)(int, int, int, int, int, void*, bool, void**, void**), void (*free)(void*), void (*lock)(void*, bool, void**),
		void (*unlock)(void*));
```

### kean_base_debug_registerCallback
Registers a callback for debug prints from inside the Vidhance library. A default callback is provided in the SDK where the output is directed to the Android logging system (logcat). The user is however free to use a custom callback.
``` c
void kean_base_debug_registerCallback(void (*print)(const char*));
```
#### Parameters
*print* A function pointer to a callback which handles the debug output.

## Example
```
/* Predefined aligned width in bytes for RGBA8888 GraphicBuffers on Nexus 6 */
#define ALIGNED_WIDTH_COUNT 10
const int alignedWidth[ALIGNED_WIDTH_COUNT] = { 128, 256, 384, 512, 1024, 1536, 2560, 3072, 3584, 4608 };

vidhance_load();
kean_draw_gpu_android_graphicBuffer_configureAlignedWidth(&alignedWidth[0], ALIGNED_WIDTH_COUNT);

kean_base_debug_registerCallback(debugPrint);
kean_draw_gpu_android_graphicBuffer_registerCallbacks(allocateGraphicBuffer, createGraphicBuffer, freeGraphicBuffer, lockGraphicBuffer,
		unlockGraphicBuffer);
```

# Creating and adjusting settings
## Overview
### vidhance_settings
The base settings object.
```
typedef struct _vidhance_settings vidhance_settings;
```
### vidhance_settings_new
Creates a new Vidhance settings object.
```
vidhance_settings* vidhance_settings_new();
```
### vidhance_settings_registerCallback
Registers optional callbacks. This function is optional.
#### Parameters
*rotation* A callback to sample the rotation of the device. Note that this is a very naive implementation and will change in the near future. Use the default callback provided in the SDK or simply NULL if the callback should not be used.
### vidhance_motion_settings
The motion settings object.
```
typedef struct _vidhance_motion_settings vidhance_motion_settings;
```
### vidhance_settings_getMotion
Returns a motion settings object.
```
vidhance_motion_settings* vidhance_settings_getMotion(vidhance_settings* settings);
```
#### Parameters
*settings* A base settings object.

### vidhance_motion_settings_setComplexity
Sets the complexity used for the motion module. A higher complexity improves the quality but increases the overhead.

#### Parameters
*settings* A motion settings object
*complexity* An integer clamped between 1 and 10 where 1 is the lowest possible




### Overview
#### vidhance_motion_mode
``` c
enum vidhance_motion_mode {
	VIDHANCE_MOTION_MODE_OFF, VIDHANCE_MOTION_MODE_TWO_DEGREES, VIDHANCE_MOTION_MODE_FOUR_DEGREES, VIDHANCE_MOTION_MODE_SIX_DEGREES
};
```
``
typedef struct _vidhance_motion_settings vidhance_motion_settings;

vidhance_motion_settings* vidhance_settings_getMotion(vidhance_settings* settings);
void vidhance_motion_settings_setComplexity(vidhance_motion_settings* settings, int complexity);
int vidhance_motion_settings_getComplexity(vidhance_motion_settings* settings);
void vidhance_motion_settings_setMode(vidhance_motion_settings* settings, vidhance_motion_mode mode);
vidhance_motion_mode vidhance_motion_settings_getMode(vidhance_motion_settings* settings);
```
### Example
``` c
vidhance_motion_settings* motionSettings = vidhance_settings_getMotion(settings);
vidhance_motion_settings_setComplexity(motionSettings, 4);
void vidhance_motion_settings_setMode(vidhance_motion_settings* settings, VIDHANCE_MOTION_MODE_FOUR_DEGREES);
```
## Stabilization settings
### Overview
``` c
vidhance_motion_stabilize_settings* vidhance_motion_settings_getStabilize(vidhance_motion_settings*);
void vidhance_motion_stabilize_settings_setMode(vidhance_motion_stabilize_settings* settings, vidhance_motion_stabilize_mode mode);
vidhance_motion_stabilize_mode vidhance_motion_stabilize_settings_getMode(vidhance_motion_stabilize_settings* settings);
void vidhance_motion_stabilize_settings_setPreemptionLookahead(vidhance_motion_stabilize_settings* settings, int preemptionLookahead);
int vidhance_motion_stabilize_settings_getPreemptionLookahead(vidhance_motion_stabilize_settings* settings);
void vidhance_motion_stabilize_settings_setShowTrace(vidhance_motion_stabilize_settings* settings, bool showTrace);
bool vidhance_motion_stabilize_settings_getShowTrace(vidhance_motion_stabilize_settings* settings);
void vidhance_motion_stabilize_settings_setTargetScale(vidhance_motion_stabilize_settings* settings, float targetScale);
float vidhance_motion_stabilize_settings_getTargetScale(vidhance_motion_stabilize_settings* settings);
```
