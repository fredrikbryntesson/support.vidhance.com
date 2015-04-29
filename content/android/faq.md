---
date: "2015-03-11T14:32:03+01:00"
title: "FAQ"
menu:
  main:
    parent: android
    weight: 30
    name: "FAQ"
---

## Does Vidhance crop the captured video?

Yes, any video stabilization solution requires a smaller field of view in the resulting video compared to the original. In Vidhance however, the level of trimming can be dynamically set through the API. This enables functions like “Adaptive Zoom”, where the crop can be smoothly adjusted to fit the amplitude of unwanted motion. It also allows to create different video capture modes, such as “normal” and “sports mode”, where the latter will need a smaller field of view as the amplitude of shakes is expected to be higher.

## Which SoCs are supported?

The quick integration method applied means that the software to a large extent is hardware agnostic. The first successful integrations have been done on various Qualcomm and Nvidia chipsets. After a first successful integration, further hardware specific optimizations and adjustments can be made to further improve performance and quality.

Vidhance should work on most high-end SoCs such as the following:

* Qualcomm Snapdragon 800 (Quad-core 2.3 GHz Krait 400, Adreno 330)
* Qualcomm Snapdragon 805 (Quad-core 2.7 GHz Krait 450, Adreno 420)
* Nvidia Tegra 3 (Quad-core 1.2 GHz Cortext-A9)

## What video resolutions and frame rates are supported?

Vidhance is adjustable to any video resolution. Obviously, the larger the resolution, the better the image computational capacity of the hardware needs to be dimensioned. However, the processor load for the core motion analysis algorithms does not scale proportional to increased video resolution, so it is more a question on efficient image data transfers.

Vidhance is also adjustable to any frame rate, but the higher the frame rate, the better hardware performance is needed. For framerates 120 fps and above, which is intended to be played back at standard frame rates (slow motion replay), the need for video stabilization is reduced, as the slowdown in itself mitigate the instability issues.

## Latency?

Vidhance is uniquely quick, and can perform with less than one frame delay (meaning no look-ahead buffer at all). For consumer devices however, a latency of 2-4 frames is typically used, as this enables better processor load balancing, and thus saves battery time. It is still fast enough to be viable to use the enhanced video in screen preview, or for live streaming purposes.

Vidhance is also being extended with a mode using a lookahead buffer. This will enable further improvements in video stabilization quality, and supports features such as “preemptive stabilization”, where a future known motion can be compensated by letting a smooth motion through earlier.

## Performance/Battery?

The quick integration method typically gives a penalty of around 30% added power consumption during recording. The majority of processor time is however spent copying and moving image data, and the core algorithms build up only a fraction of the processing cycle. In a deeper integration, where hardware specific tuning can be done (e.g. specific memory access primitives), the design target is to reach 10% or below.

## Sensors needed?

Vidhance does not need any hardware sensors, and can perform stabilization with great results using only video data (e.g. using the camera as the only sensor), using an in-house algorithm based on optical flow analysis. However, if rotation sensor data is available, this can easily be enabled as well to increase both performance and quality.

## Patents?

Vidhance core algorithms in motion estimation and stabilization are protected under US Patents. This can be valuable to mitigate risk of infringement claims from competitors, aiming to block or delay entrance into other markets.

## Competition?

Imint cannot get access to competitor’s solutions to perform own, detailed tests. Comparing results with leading phones for photo and video, such as the Apple iPhone6 and Sony Xperia Z3, Imint can demonstrate that Vidhance adds substantial quality gains in video stabilization. As for independent companies providing similar solutions, in Imint’s view, these are they key differentiators for Imint’s solution:

* Able to execute with minimal latency (no look-ahead buffer needed)
* Does not depend on (but can benefit from) additional sensor data
* Does not only dampen motion, but separates intentional from unintentional motions, and cancelling out the latter
* Smooth pass-through of motions to emulate rigs and tripods
* Open API with a rich level of configuration available for the integrator.
