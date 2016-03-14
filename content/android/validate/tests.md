---
date: "2015-03-11T14:32:03+01:00"
title: "Vidhance Mobile Test Specification"
---
***
# 1 General
## 1.1 Identification
This document acts as a template for the testing procedures that verifies Vidhance Mobile against the [requirement specification](../requirements/). A complete specification is produced in collaboration with the customer.
## 1.2 Revision history
*revision 1* Emil Westergren 2015-05-26
<br>
***
# 2 Test Specifications
## 2.1 Performance
### 2.1.1 Endurance
**Objectives** <br>
Verifies the capability of stabilizing video over longer periods of time.

**Requirements verified** <br>
**prf01**

**Setup** <br>
Reboot the device.

**Procedure**

1. Set the resolution to 1280 x 720 and frame rate to 120 fps.
2. Start the recording.
3. Wait for 30 minutes or until the maximum file size is reached.
4. Verify that the video was successfully recorded.
5. Set the resolution to 1920 x 1080 and frame rate to 60 fps.
6. Repeat steps 2-4.
7. Set the resolution to 4096 x 2160 and frame rate to 30 fps.
8. Repeat steps 2-4.

### 2.1.2 Processing speed
**Objectives** <br>
Verifies the capability of stabilizing video without frame drops.

**Requirements verified** <br>
**prf02** **prf03** **prf04**

**Setup** <br>
Reboot the device.

**Procedure**

1. Set the resolution to 1280 x 720 and frame rate to 120 fps.
2. Start the recording.
3. Wait for 5 minutes.
4. Verify that the number of frames dropped is less than specified.
5. Set the resolution to 1920 x 1080 and frame rate to 60 fps.
6. Repeat steps 2-4.
7. Set the resolution to 4096 x 2160 and frame rate to 30 fps.
8. Repeat steps 2-4.

<br>

## 2.2 Scenarios
### 2.2.1 Walking forward in lit indoor scene
**Objectives** <br>
Verifies the capability of stabilizing video in an indoor environment while walking.

**Requirements verified** <br>
**sce02**

**Setup** <br>
Reboot the device. Make sure the scene does not contain any moving objects.

**Procedure**

1. Stand up with the camera in a steady grip in the beginning of the corridor.
2. Start the recording and slowly walk forward at a maximum speed of 1 m/s.
3. Stop the recording after 10 m.

### 2.2.2 Sideways recording of moving person in sunlight
**Objectives** <br>
Verifies the capability of stabilizing video in an sunny outdoor environment while walking sideways and recording a moving object.

**Requirements verified** <br>
**sce03**

**Setup** <br>
Reboot the device.

**Procedure**

1. Stand up with the camera in a steady grip in the beginning of the corridor.
2. Start the recording and slowly walk forward at a maximum speed of 1 m/s.
3. Stop the recording after 10 m.

### 2.2.3 Rotation around moving object in cloudy outdoor scene
**Objectives** <br>
Verifies the capability of stabilizing video in an cloudy outdoor environment while rotating around a moving object.

**Requirements verified** <br>
**sce04**

**Setup** <br>
Reboot the device.

**Procedure**

1. Stand up with the camera in a steady grip.
2. Start the recording and slowly rotate around the object while keeping it centered and in focus.
3. Stop the recording after two full rotations.

### 2.2.4 Rotation around user in indoor scene
**Objectives** <br>
Verifies the capability of stabilizing video in an indoor environment while rotating around the user.

**Requirements verified** <br>
**sce05**

**Setup** <br>
Reboot the device.

**Procedure**

1. Stand up with the camera in a steady grip.
2. Start the recording and slowly rotate around the user.
3. Stop the recording after two full rotations.

### 2.2.5 Transitions to/from shade in sunny outdoor scene
**Objectives** <br>
Verifies the capability of stabilizing video in an sunny outdoor environment while transitioning from shade.

**Requirements verified** <br>
**sce06**

**Setup** <br>
Reboot the device. Make sure the scene does not contain any moving objects.

**Procedure**

1. Stand up with the camera in a steady grip standing in sunlight.
2. Start the recording and slowly walk towards and enter a shaded area.
3. Walk out from the shaded area.
4. Stop the recording.

### 2.2.6 Zoomed capture of distant target in sunny outdoor scene
**Objectives** <br>
Verifies the capability of stabilizing video in an sunny outdoor environment while zoomed in on distant target.

**Requirements verified** <br>
**sce07**

**Setup** <br>
Reboot the device. Make sure the target can be captured without obstacles blocking the view.

**Procedure**

1. Stand up with the camera in a steady grip standing in sunlight.
2. Zoom in as much as possible on the target.
3. Start the recording and try to keep the target centered in the preview.
4. Stop the recording.
