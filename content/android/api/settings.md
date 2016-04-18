[Back to API overview](../../apireference/)
# Creating and adjusting settings
## Overview
---
### vidhance_settings_t
The base settings object.
``` c
typedef struct _vidhance_settings_t* vidhance_settings_t;
```
---
### vidhance_settings_new
Creates a new Vidhance settings object.
``` c
vidhance_settings_t vidhance_settings_new();
```
<!--
---
### vidhance_settings_set_latency
Set latency
``` c
void vidhance_settings_set_latency(const vidhance_settings_t settings, int frames);
```
#### Parameters
*settings* A base settings object.

*frames* Number of frames.

---
### vidhance_settings_get_latency
Get latency
``` c
int vidhance_settings_get_latency(const vidhance_settings_t settings);
```
#### Parameters
*settings* A base settings object.
-->
---
### vidhance_motion_settings_t
The motion settings object.
``` c
typedef struct _vidhance_motion_settings_t* vidhance_motion_settings_t;
```
---
### vidhance_settings_get_motion
Returns the motion settings object.
``` c
vidhance_motion_settings_t vidhance_settings_get_motion(vidhance_settings_t settings);
```
#### Parameters
*settings* A base settings object.

---
### vidhance_motion_sensor_settings_t
The settings object for external motion sensors.
``` c
typedef struct _vidhance_motion_sensor_settings_t* vidhance_motion_sensor_settings_t;
```
---
### vidhance_motion_settings_get_sensor
Returns the motion sensor settings object.
``` c
vidhance_motion_sensor_settings_t vidhance_motion_settings_get_sensor(vidhance_motion_settings_t settings);
```
#### Parameters
*settings* A motion settings object.

---
### vidhance_motion_sensor_settings_set_rotation
Registers an external rotation sensor in the motion sensor settings.
``` c
void vidhance_motion_sensor_settings_set_rotation(vidhance_motion_sensor_settings_t settings, vidhance_motion_sensor_t rotation_sensor);
```
#### Parameters
*settings* A motion sensor settings object.

*rotation_sensor* A rotation sensor object.

---
### vidhance_stabilizer_settings_t
The stabilization settings object.
``` c
typedef struct _vidhance_stabilizer_settings_t* vidhance_stabilizer_settings_t;
```
---
### vidhance_settings_get_stabilize
Returns the stabilizer settings object.
``` c
vidhance_stabilizer_settings_t vidhance_settings_get_stabilize(const vidhance_settings_t settings);
```
#### Parameters
*settings* A Vidhance settings object.

---
### vidhance_stabilizer_mode_t
The available modes for the stabilization module.

+ VIDHANCE_STABILIZER_OFF - Stabilization turned off.
+ VIDHANCE_STABILIZER_ON - Stabilization turned on.

``` c
typedef enum {
	VIDHANCE_STABILIZER_OFF,
	VIDHANCE_STABILIZER_ON
} vidhance_stabilizer_mode_t;
```
---
### vidhance_motion_stabilize_settings_set_mode
Sets the stabilization mode.
``` c
void vidhance_stabilizer_settings_set_mode(vidhance_stabilizer_settings_t settings, vidhance_stabilizer_mode_t mode);
vidhance_stabilizer_mode_t vidhance_stabilizer_settings_get_mode(const vidhance_stabilizer_settings_t settings);

```
#### Parameters
*settings* A stabilize settings object.

*mode* One of the modes in vidhance_stabilizer_mode_t.

---

## Example
``` c
vidhance_settings_t settings = vidhance_settings_new();
vidhance_stabilizer_settings_t stabilizeSettings = vidhance__settings_get_stabilize(settings);
vidhance_stabilizer_settings_set_mode(stabilizeSettings, VIDHANCE_STABILIZER_ON);
```
