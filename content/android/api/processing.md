[Back to API overview](../../apireference/)
# Processing frames
## Overview
---
### vidhance_context_start
Prepares a Vidhance context for a new video stream. This function must be called before the first frame of the stream is sent to Vidhance.
``` c
void vidhance_context_start(vidhance_context_t context);
```
#### Parameters
*context* A Vidhance context.

---
### vidhance_context_stop
Ends a processing session for the Vidhance context. This function must be called after the last frame of the stream is sent to Vidhance.
``` c
void vidhance_context_stop(vidhance_context_t context);
```
#### Parameters
*context* A Vidhance context.

---
### vidhance_context_process
Process a frame in the specified context. Returns a new buffer containing the resulting frame.
``` c
vidhance_frame_t vidhance_context_process(vidhance_context_t context, vidhance_frame_t frame);
```
#### Parameters
*context* The context in which to process.

*frame* The input frame.
---
### vidhance_context_process_output
Process a frame in the specified context using different buffers as input and output.
``` c
void vidhance_context_process_output(vidhance_context_t context, vidhance_frame_t input, vidhance_frame_t output);
```
#### Parameters
*context* The context in which to process.

*input* The input frame.

*output* The output frame where the result is written.

---
### vidhance_context_process_preview
Process the preview buffer.
``` c
void vidhance_context_process_preview(vidhance_context_t context, vidhance_frame_t input);
```
#### Parameters
*context* The context in which to process.

*input* The input frame.

---
### vidhance_int_vector_2d_t
2D vector used by Vidhance.
``` c
typedef struct {
	int x;
	int y;
} vidhance_int_vector_2d_t;
vidhance_int_vector_2d_t vidhance_int_vector_2d_new(int x, int y);
```

---
### vidhance_image_t
The base image class used by Vidhance.
``` c
typedef struct _vidhance_image_t* vidhance_image_t;
```

---
## Example
Prepare the Vidhance context for a new video session.
``` c
vidhance_context_start(context);
```

Process frames by creating a *vidhance_image_t* from the GraphicBuffer from the camera.
``` c
```

Process preview frames.
``` c
```

End the video session.
``` c
vidhance_context_stop(context);
```
