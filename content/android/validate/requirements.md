---
date: "2015-03-11T14:32:03+01:00"
title: "Requirement specification"
---

# 1 General
## 1.1 Identification

## 1.2 Definitions

## 1.3 Revision History

# 2 System Overview

## 2.1 Problem Description

## 2.2 System Context

## 2.3 Platform Prerequisites

### 2.3.1 Hardware


### 2.3.2 Operating System
+ Android 5.1

## 2.4 Recording Prerequisites
+ The user moves with a maximum speed of 1 m/s
+ The camera is held as steady as possible, using both hands with a firm grip on each side of the camera. The elbows should stay close to the body. Movements when holding the camera should be as slow and gentle as possible.
+ The scene has sufficient light from the sun or other light sources

# 3 Technical requirements

## 3.1 General Requirements

### 3.1.1 Performance
+ **prf01** The recording runs continuously for 30 minutes or until the maximum file size is reached.
+ **prf02** Less than 1% frames dropped when recording video with 4096 x 2160 resolution and a frame rate of 30 fps.
+ **prf03** Less than 1% frames dropped when recording video with 1920 x 1080 resolution and a frame rate of 60 fps.
+ **prf04** Less than 1% frames dropped when recording video with 1280 x 720 resolution and a frame rate of 120 fps.

## 3.2 Scenario Requirements
Compared to the solution without the product integrated the product shall perform better for at least 95% of the test cases for the following scenarios:
### 3.2.1 Light Conditions
+ **lit01** A bright indoor scene.
+ **lit02** A sunny outdoor scene.
+ **lit03** A cloudy outdoor scene.
+ **lit04** Transitions between shade and sunlight.

### 3.2.2 User Movement
+ **umv01** Stationary recording.
+ **umv02** Moving forward/backward.
+ **umv03** Moving sideways.
+ **umv04** Rotating around object.
+ **umv05** Rotating around user.

### 3.2.3 Object Movement
+ **omv01** No moving objects in the scene.
+ **omv02** A maximum of 10 moving objects in the scene.
