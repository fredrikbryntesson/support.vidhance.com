
[Back to API overview](./android/apireference/index.html)
# Initializing Vidhance
## Overview
---
### vidhance_load
Initializes the Vidhance library. Must be called before anything else can be used.
``` c
void vidhance_load();
```
---
### kean_draw_gpu_android_graphicBuffer_configureAlignedWidth
Provides Vidhance with a list of memory aligned widths in bytes for allocations of GraphicBuffers with format RGBA8888. This is not strictly necessary but greatly improves the performance.
``` c
void kean_draw_gpu_android_graphicBuffer_configureAlignedWidth(const int* alignedWidth, int count);
```
#### Parameters
*alignedWidth* An array of integers with aligned width in bytes.

*count* Number of aligned widths.

---
### kean_draw_gpu_android_graphicBuffer_registerCallbacks
Registers a number of necessary callbacks for Vidhance to allocate graphics memory. The necessary callbacks are included in the SDK and should not be defined by the user.
``` c
void kean_draw_gpu_android_graphicBuffer_registerCallbacks(void (*allocate)(int, int, int, int, void**, void**, int*),
		void (*create)(int, int, int, int, int, void*, bool, void**, void**), void (*free)(void*), void (*lock)(void*, bool, void**),
		void (*unlock)(void*));
```
---
### kean_base_debug_registerCallback
Registers a callback for debug prints from inside the Vidhance library. A default callback is provided in the SDK where the output is directed to the Android logging system (logcat). The user is however free to use a custom callback.
``` c
void kean_base_debug_registerCallback(void (*print)(const char*));
```
#### Parameters
*print* A function pointer to a callback which handles the debug output.

---
## Example
``` c
/* Predefined aligned width in bytes for RGBA8888 GraphicBuffers on Nexus 6 */
#define ALIGNED_WIDTH_COUNT 10
const int alignedWidth[ALIGNED_WIDTH_COUNT] = { 128, 256, 384, 512, 1024, 1536, 2560, 3072, 3584, 4608 };

vidhance_load();
kean_draw_gpu_android_graphicBuffer_configureAlignedWidth(&alignedWidth[0], ALIGNED_WIDTH_COUNT);

kean_base_debug_registerCallback(debugPrint);
kean_draw_gpu_android_graphicBuffer_registerCallbacks(allocateGraphicBuffer, createGraphicBuffer, freeGraphicBuffer, lockGraphicBuffer,
		unlockGraphicBuffer);
```
