[Back to API overview](../../apireference/)
# Creating contexts

## Overview
---
### vidhance_context
The context in which frames are processed.
``` c
typedef struct _vidhance_context vidhance_context;
```
---
### vidhance_context_new
Creates a new Vidhance context.
``` c
vidhance_context* vidhance_context_new(vidhance_settings* settings);
```
#### Parameters
*settings* A Vidhance settings object.

---
### vidhance_context_free
Frees the Vidhance context.
``` c
void vidhance_context_free(vidhance_context*);
```
#### Parameters
*context* A Vidhance context.

---
## Example
``` c
vidhance_settings* settings = vidhance_settings_new();
vidhance_context* context = vidhance_context_new(settings);
vidhance_context_free(context);
```
