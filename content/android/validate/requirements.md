---
date: "2015-03-11T14:32:03+01:00"
title: "Requirement Specification Template"
---
***
# 1 General
## 1.1 Identification
Vidhance Mobile is a unique real-time, purpose-built all-software video stabilization solution for mobile devices. The solution complements existing stabilization technologies, thereby augmenting camera capabilities and removes unwanted wobbling and swaying that occurs in most videos shot on a handheld device. Vidhance is a 3rd generation solution needed to propel widespread video clip sharing to the levels where still photo sharing is today.

This document acts as a template for how a requirement specification can be structured for Vidhance Mobile. A complete specification is produced in collaboration with the customer.
## 1.2 Definitions
**frame rate** The rate at which frames are recorded and/or processed. <br>
**fps** Frames Per Second - The number of frames for each second of video. <br>
**real-time** The ability of a system to process data in the same rate as it is gathered. <br>
**720p** A resolution of 1280 x 720 pixels. <br>
**1080p** A resolution of 1920 x 1080 pixels. <br>
**2160p** A resolution of 4096 x 2160 pixels. <br>
## 1.3 Revision History
*revision 1* Emil Westergren 2015-05-26

<br>
***
# 2 System Overview

## 2.1 Problem Description
Recording video with smartphone devices is becoming increasingly more popular in today's market. Practically all smartphones on the market have at least one camera sensor and the ability to capture video. A major problem with capturing quality video on a smartphone is the difficulty of keeping the device steady enough for the video to be stable and free from unintended motion from the photographer. This results in video with poor quality which makes it unpleasant to the eye.
## 2.2 System Context
Video recording with a smartphone is usually spontaneously captured, with the photographer controlling the camera by hand and perhaps also moving around while recording.
## 2.3 System Usage
Vidhance is used to stabilize the video in real-time during the recording, resulting in a stabilized, high quality video without the need of post-processing.
## 2.4 Platform Prerequisites

### 2.4.1 Hardware
---Insert hardware specifications for target device---

### 2.4.2 Operating System and Library Dependencies
+ Android 5.0
+ OpenGL ES 3
+ EGLImage extension

## 2.5 Recording Prerequisites
+ The user moves with a maximum speed of 1 m/s
+ The camera is held as steady as possible, using both hands with a firm grip on each side of the camera. The elbows should stay close to the body. Movements when holding the camera should be as slow and gentle as possible.
+ The scene has sufficient light from the sun or other light sources

<br>
***
# 3 Technical requirements

## 3.1 General Requirements

### 3.1.1 Performance
**prf01** The recording runs continuously for 30 minutes or until the maximum file size is reached. <br>
**prf02** Less than 3% frames dropped when recording 2160p video with a frame rate of 30 fps. <br>
**prf03** Less than 2% frames dropped when recording 1080p video with a frame rate of 30 fps. <br>
**prf04** Less than 1% frames dropped when recording 720p video with a frame rate of 30 fps. <br>

### 3.1.2 Power usage
**pwu01** Having the stabilization enabled increases the power usage with a maximum of 30% during recording.

## 3.2 Scenario Requirements
**sce01** The product shall perform better for at least 4 out of 5 of the following scenarios compared to with the product disabled. <br>
**sce02** Walking forward in lit indoor scene. <br>
**sce03** Sideways recording of moving person in sunlight. <br>
**sce04** Rotation around moving object in cloudy outdoor scene. <br>
**sce05** Rotation around user in lit indoor scene. <br>
**sce06** Transition to/from shade in sunny outdoor scene. <br>
**sce07** Zoomed capture of distant target in sunny outdoor scene. <br>

<!-- **sce02** The product shall perform equal or better for at least 80% of the following scenarios compared to the solutions on Apple iPhone 6 and Sony Xperia Z3.
### 3.2.1 Light Conditions
**lit01** A lit indoor scene. <br>
**lit02** A sunny outdoor scene. <br>
**lit03** A cloudy outdoor scene. <br>
**lit04** Transitions between shade and sunlight. <br>

### 3.2.2 User Movement
**umv01** *Stationary* - The user remains stationary during the recording. <br>
**umv02** *Moving forward/backward* - The user walks forward/backward at a maximum speed of 1 m/s. <br>
**umv03** *Moving sideways* - As in **umv02** but instead recording to the right or left side. <br>
**umv04** *Rotation around object* - The user rotates around the object in focus. <br>
**umv05** *Rotation around user* - The user rotates around himself/herself. <br>

### 3.2.3 Scene Movement
**omv01** *Static* - No moving objects in the scene. <br>
**omv02** *Dynamic* - A maximum of five moving objects in the scene. <br> -->




<br>
***
