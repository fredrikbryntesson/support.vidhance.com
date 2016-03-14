[Back to API overview](../../apireference/)
# Creating and adjusting settings
## Overview
---
### vidhance_settings
The base settings object.
```
typedef struct _vidhance_settings vidhance_settings;
```
---
### vidhance_settings_new
Creates a new Vidhance settings object.
```
vidhance_settings* vidhance_settings_new();
```
---
### vidhance_settings_registerCallback
Registers optional callbacks. This function is optional.
``` c
void vidhance_settings_registerCallback(vidhance_settings*, int (*rotation)(float*, int));
```
#### Parameters
*rotation* A callback to sample the rotation of the device. Note that this is a very naive implementation and will change in the near future. Use the default callback provided in the SDK or simply NULL if the callback should not be used.

---
### vidhance_motion_settings
The motion settings object.
```
typedef struct _vidhance_motion_settings vidhance_motion_settings;
```
---
### vidhance_settings_getMotion
Returns the motion settings object.
```
vidhance_motion_settings* vidhance_settings_getMotion(vidhance_settings* settings);
```
#### Parameters
*settings* A base settings object.

---
### vidhance_motion_settings_setComplexity
Sets the complexity used for the motion module. A higher complexity improves the quality but increases the overhead.
```
void vidhance_motion_settings_setComplexity(vidhance_motion_settings* settings, int complexity);
int vidhance_motion_settings_getComplexity(vidhance_motion_settings* settings);
```
#### Parameters
*settings* A motion settings object.

*complexity* An integer clamped between 1 and 10 where a higher number results in better stabilization quality but more overhead.

---
### vidhance_motion_mode
The available modes for the motion module.

+ VIDHANCE_MOTION_MODE_OFF - The motion module will not be used.
+ VIDHANCE_MOTION_MODE_TWO_DEGREES - Stabilization with X and Y translations.
+ VIDHANCE_MOTION_MODE_FOUR_DEGREES - Stabilization with X, Y, Z translations and Z rotations.
+ VIDHANCE_MOTION_MODE_SIX_DEGREES - Stabilization with X, Y, Z translations and X, Y, Z rotations.
```
enum vidhance_motion_mode {
	VIDHANCE_MOTION_MODE_OFF, VIDHANCE_MOTION_MODE_TWO_DEGREES, VIDHANCE_MOTION_MODE_FOUR_DEGREES, VIDHANCE_MOTION_MODE_SIX_DEGREES
};
```
---
### vidhance_motion_settings_setMode
Sets the mode of the motion module.
```
void vidhance_motion_settings_setMode(vidhance_motion_settings* settings, vidhance_motion_mode mode);
vidhance_motion_mode vidhance_motion_settings_getMode(vidhance_motion_settings* settings);
```
#### Parameters
*settings* A motion settings object.

*mode* One of the available modes in the vidhance_motion_mode enum.

---
### vidhance_motion_stabilize_settings
The stabilization settings object.
```
typedef struct _vidhance_motion_stabilize_settings vidhance_motion_stabilize_settings;
```
---
### vidhance_motion_settings_getStabilize
Returns the stabilize settings object.
```
vidhance_motion_stabilize_settings* vidhance_motion_settings_getStabilize(vidhance_motion_settings* settings);
```
#### Parameters
*settings* A motion settings object.

---
### vidhance_motion_stabilize_mode
The available modes for the stabilization module.

+ VIDHANCE_MOTION_STABILIZE_MODE_OFF - Stabilization turned off.
+ VIDHANCE_MOTION_STABILIZE_MODE_ON - Stabilization turned on.

```
enum vidhance_motion_stabilize_mode {
	VIDHANCE_MOTION_STABILIZE_MODE_OFF, VIDHANCE_MOTION_STABILIZE_MODE_ON
};
```
---
### vidhance_motion_stabilize_settings_setMode
Sets the stabilization mode.
```
void vidhance_motion_stabilize_settings_setMode(vidhance_motion_stabilize_settings* settings, vidhance_motion_stabilize_mode mode);
vidhance_motion_stabilize_mode vidhance_motion_stabilize_settings_getMode(vidhance_motion_stabilize_settings* settings);

```
#### Parameters
*settings* A stabilize settings object.

*mode* One of the modes in vidhance_motion_stabilize_mode.

---
### vidhance_motion_stabilize_settings_setPreemptionLookahead
Sets the number of frames to use in preemption lookahead.
```
void vidhance_motion_stabilize_settings_setPreemptionLookahead(vidhance_motion_stabilize_settings* settings, int preemptionLookahead);
int vidhance_motion_stabilize_settings_getPreemptionLookahead(vidhance_motion_stabilize_settings* settings);
```
#### Parameters
*settings* A stabilize settings object.

*preemptionLookahead* The number of frames to use in the lookahead buffer. A higher number will increase the smoothness of the stabilization but increase the latency in the recorded video. Valid range is 0-16.

---
### vidhance_motion_stabilize_settings_setShowTrace
Enables the drawing of a trace to visualize the translations of the stabilization. Used for debugging and testing.
```
void vidhance_motion_stabilize_settings_setShowTrace(vidhance_motion_stabilize_settings* settings, bool showTrace);
bool vidhance_motion_stabilize_settings_getShowTrace(vidhance_motion_stabilize_settings* settings);
```
#### Parameters
*settings* A stabilize settings object.

*showTrace* A bool which enables or disables the trace.

---
### vidhance_motion_stabilize_settings_setTargetScale
Sets the relative amount of the frame to be cropped during stabilization. A lower value will increase the maximum motion amplitude which is able to be stabilized but increase the cropping of the original frame.
```
void vidhance_motion_stabilize_settings_setTargetScale(vidhance_motion_stabilize_settings* settings, float targetScale);
float vidhance_motion_stabilize_settings_getTargetScale(vidhance_motion_stabilize_settings* settings);
```
#### Parameters
*settings* A stabilize settings object.

*targetScale* The relative amount of cropping for the left, right, bottom and top side. Valid range 0.01 - 1.0.

---

## Example
``` c
vidhance_settings* settings = vidhance_settings_new();
vidhance_settings_registerCallback(settings, getRotationVector);
vidhance_motion_settings* motionSettings = vidhance_settings_getMotion(settings);
vidhance_motion_settings_setMode(motionSettings, VIDHANCE_MOTION_MODE_OFF);
vidhance_motion_stabilize_settings* stabilizeSettings = vidhance_motion_settings_getStabilize(motionSettings);
vidhance_motion_stabilize_settings_setShowTrace(stabilizeSettings, true);
```
