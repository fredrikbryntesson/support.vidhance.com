[Back to API overview](../../apireference/)
# Processing frames
## Overview
---
### vidhance_context_videoStart
Prepares a Vidhance context for a new video stream. This function must be called before the first frame of the stream is sent to Vidhance.
``` c
void vidhance_context_videoStart(vidhance_context* context);
```
#### Parameters
*context* A Vidhance context.

---
### vidhance_context_videoStop
Ends a processing session for the Vidhance context. This function must be called after the last frame of the stream is sent to Vidhance.
``` c
void vidhance_context_videoStop(vidhance_context* context);
```
#### Parameters
*context* A Vidhance context.

---
### vidhance_context_process
Process a frame in the specified context using separate buffers as input and output.
``` c
void vidhance_context_process(vidhance_context* context, kean_draw_image* input, kean_draw_image* output);
```
#### Parameters
*context* The context in which to process.

*input* The input frame.

*output* The output frame. This is where the resulting frame is written.

---
### vidhance_context_process_inplace
Process a frame in the specified context using the same buffer as input and output.
``` c
void vidhance_context_process_inplace(vidhance_context* context, kean_draw_image* input);
```
#### Parameters
*context* The context in which to process.

*input* The input frame. The buffer is overwritten with the resulting frame.

---
### vidhance_context_processPreview
Process the preview buffer.
``` c
void vidhance_context_processPreview(vidhance_context* context, kean_draw_image* input, kean_draw_image* output);
```
#### Parameters
*context* The context in which to process.

*input* The input frame.

*output* The output frame. This is where the resulting frame is written.

---
### kean_math_intSize2D
Image resolution object used by Vidhance.
``` c
typedef struct _kean_math_intSize2D kean_math_intSize2D;
kean_math_intSize2D kean_math_intSize2D_new(int width, int height);
```

---
### kean_draw_image
The base image class used by Vidhance.
``` c
typedef struct _kean_draw_image kean_draw_image;
```

---
### kean_draw_gpu_android_graphicBufferYuv420Semiplanar
The image class used to create images from YUV420SP buffers located in graphics memory.
``` c
typedef struct _kean_draw_gpu_android_graphicBufferYuv420Semiplanar kean_draw_gpu_android_graphicBufferYuv420Semiplanar;
```

---
## Example
Prepare the Vidhance context for a new video session.
``` c
vidhance_context_videoStart(context);
```

Process frames by creating a *kean_draw_gpu_android_graphicBufferYuv420Semiplanar* from the GraphicBuffer from the camera.
``` c
void VidhanceProcessor::processVideoCapture(sp<GraphicBuffer> input, sp<GraphicBuffer> output) {
	int horizontalStride = ALIGN(input->width, 64);
	int verticalStride = ALIGN(input->height, 32);
	int uvOffset = horizontalStride * verticalStride;

	kean_draw_gpu_android_graphicBufferYuv420Semiplanar* inputImage = kean_draw_gpu_android_graphicBufferYuv420Semiplanar_new((void*)input.get(),
			(void*)input->getNativeBuffer(), (void*) input->handle,
			kean_math_intSize2D_new(input->width, input->height), horizontalStride, input->format, uvOffset);
	kean_draw_gpu_android_graphicBufferYuv420Semiplanar* outputImage = kean_draw_gpu_android_graphicBufferYuv420Semiplanar_new((void*)output.get(),
			(void*)output->getNativeBuffer(), (void*) output->handle,
			kean_math_intSize2D_new(output->width, output->height), horizontalStride, output->format, uvOffset);
	vidhance_context_process(context, (kean_draw_image*) inputImage, (kean_draw_image*) outputImage);
}
```

Process preview frames.
``` c
void VidhanceProcessor::processPreview(sp<GraphicBuffer> input, sp<GraphicBuffer> output) {
	kean_draw_gpu_android_graphicBufferYuv420Semiplanar* inputImage = kean_draw_gpu_android_graphicBufferYuv420Semiplanar_new((void*)input.get(),
			(void*)input->getNativeBuffer(), (void*) input->handle,
			kean_math_intSize2D_new(input->width, input->height), input->width, input->format, 0);
	kean_draw_gpu_android_graphicBufferYuv420Semiplanar* outputImage = kean_draw_gpu_android_graphicBufferYuv420Semiplanar_new((void*)output.get(),
			(void*)output->getNativeBuffer(), (void*) output->handle,
			kean_math_intSize2D_new(output->width, output->height), output->width, output->format, 0);
	vidhance_context_processPreview(context, (kean_draw_image*) inputImage, (kean_draw_image*) outputImage);
}
```

End the video session.
``` c
vidhance_context_videoStop(context);
```
