[Back to API overview](../../apireference/)
# Creating and adjusting settings
## Overview
---
### vidhance_settings_t
The base settings object.
```
typedef struct _vidhance_settings_t* vidhance_settings_t;
```
---
### vidhance_settings_new
Creates a new Vidhance settings object.
```
vidhance_settings_t vidhance_settings_new();
```
---
### vidhance_motion_settings_t
The motion settings object.
```
typedef struct _vidhance_motion_settings_t* vidhance_motion_settings_t;
```
---
### vidhance_settings_get_motion
Returns the motion settings object.
```
vidhance_motion_settings_t vidhance_settings_get_motion(vidhance_settings_t settings);
```
#### Parameters
*settings* A base settings object.

---
### vidhance_motion_sensor_settings_t
The settings object for external motion sensors.
```
typedef struct _vidhance_motion_sensor_settings_t* vidhance_motion_sensor_settings_t;
```
---
### vidhance_motion_settings_get_sensor
Returns the motion sensor settings object.
```
vidhance_motion_sensor_settings_t vidhance_motion_settings_get_sensor(vidhance_motion_settings_t settings);
```
#### Parameters
*settings* A motion settings object.

---
### vidhance_motion_sensor_settings_set_rotation
Registers an external rotation sensor in the motion sensor settings.
```
void vidhance_motion_sensor_settings_set_rotation(vidhance_motion_sensor_settings_t settings, vidhance_motion_sensor_t rotation_sensor);
```
#### Parameters
*settings* A motion sensor settings object.

*rotation_sensor* A rotation sensor object.

---
### vidhance_stabilizer_settings_t
The stabilization settings object.
```
typedef struct _vidhance_stabilizer_settings_t* vidhance_stabilizer_settings_t;
```
---
### vidhance_settings_get_stabilize
Returns the stabilizer settings object.
```
vidhance_stabilizer_settings_t vidhance_settings_get_stabilize(const vidhance_settings_t settings);
```
#### Parameters
*settings* A Vidhance settings object.

---
### vidhance_stabilizer_mode_t
The available modes for the stabilization module.

+ VIDHANCE_STABILIZER_OFF - Stabilization turned off.
+ VIDHANCE_STABILIZER_ON - Stabilization turned on.

```
typedef enum {
	VIDHANCE_STABILIZER_OFF,
	VIDHANCE_STABILIZER_ON
} vidhance_stabilizer_mode_t;
```
---
### vidhance_motion_stabilize_settings_set_mode
Sets the stabilization mode.
```
void vidhance_stabilizer_settings_set_mode(vidhance_stabilizer_settings_t settings, vidhance_stabilizer_mode_t mode);
vidhance_stabilizer_mode_t vidhance_stabilizer_settings_get_mode(const vidhance_stabilizer_settings_t settings);

```
#### Parameters
*settings* A stabilize settings object.

*mode* One of the modes in vidhance_stabilizer_mode_t.

---
### vidhance_motion_stabilize_settings_set_show_trace
Enables the drawing of a trace to visualize the stabilization. Used for debugging and testing.
```
void vidhance_stabilizer_settings_set_show_trace(vidhance_stabilizer_settings_t settings, bool show_trace);
bool vidhance_stabilizer_settings_get_show_trace(const vidhance_stabilizer_settings_t settings);
```
#### Parameters
*settings* A stabilize settings object.

*show_trace* A bool which enables or disables the trace.

---
### vidhance_stabilizer_settings_set_target_scale
Sets the relative amount of the frame to be cropped during stabilization. A lower value will increase the maximum motion amplitude which is able to be stabilized but increase the cropping of the original frame.
```
void vidhance_stabilizer_settings_set_target_scale(vidhance_stabilizer_settings_t settings, float target_scale);
float vidhance_stabilizer_settings_get_target_scale(const vidhance_stabilizer_settings_t settings);
```
#### Parameters
*settings* A stabilize settings object.

*target_scale* The relative amount of cropping for the left, right, bottom and top side. Valid range 0.01 - 1.0.

---
### vidhance_stabilizer_settings_set_latency
Sets the frame latency. A higher number of frames will increase both performance and stabilization smoothness.
```
void vidhance_stabilizer_settings_set_latency(vidhance_stabilizer_settings_t settings, int frames);
int vidhance_stabilizer_settings_get_latency(const vidhance_stabilizer_settings_t settings);
```
#### Parameters
*settings* A stabilize settings object.

*frames* The number of frames latency. Valid range 0 - 15.

---

## Example
``` c
vidhance_settings_t settings = vidhance_settings_new();
vidhance_stabilizer_settings_t stabilizeSettings = vidhance__settings_get_stabilize(settings);
vidhance_stabilizer_settings_set_target_scale(stabilizeSettings, 0.8f);
```
