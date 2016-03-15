
[Back to API overview](../../apireference/)
# Initializing Vidhance
## Overview
---
### vidhance_load
Initializes the Vidhance library. Must be called before anything else can be used.
``` c
void vidhance_load();
```
---
### vidhance_graphic_buffer_register_callbacks
Registers a number of necessary callbacks for Vidhance to allocate graphics memory. The necessary callbacks are included in the SDK and should not be defined by the user.
``` c
void vidhance_graphic_buffer_register_callbacks(void (*allocate)(int, int, int, int, void**, void**, int*),
		void (*create)(int, int, int, int, int, void*, bool, void**, void**), void (*free)(void*), void (*lock)(void*, bool, void**),
		void (*unlock)(void*));
```
---
### vidhance_debug_register_callback
Registers a callback for debug prints from inside the Vidhance library. A default callback is provided in the SDK where the output is directed to the Android logging system (logcat). The user is however free to use a custom callback.
``` c
void vidhance_debug_register_callback(void (*print)(const char*));
```
#### Parameters
*print* A function pointer to a callback which handles the debug output.

---
## Example
``` c
vidhance_load();
vidhance_debug_register_callback(debugPrint);
vidhance_graphic_buffer_register_callbacks(allocateGraphicBuffer, createGraphicBuffer, freeGraphicBuffer, lockGraphicBuffer,
		unlockGraphicBuffer);
```
