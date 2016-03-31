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
### vidhance_context_process_in_place
Process a frame in the specified context using the same buffer as input and output.
``` c
void vidhance_context_process_in_place(vidhance_context_t context, vidhance_frame_t frame);
```
#### Parameters
*context* The context in which to process.

*frame* The input frame and output frame where the result is written.

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
### vidhance_float_vector_3d_t
3D float vector used by Vidhance.
``` c
typedef struct {
	float x;
	float y;
	float z;
} vidhance_float_vector_3d_t;
```

---
### vidhance_float_point_3d_t
3D float point used by Vidhance.
``` c
typedef struct {
	float x;
    float y;
    float z;
} vidhance_float_point_3d_t;
vidhance_float_point_3d_t vidhance_float_point_3d_new(float x, float y, float z);
```

---
### vidhance_quaternion_t
quaternion used by Vidhance.
``` c
typedef struct {
	float real;
	vidhance_float_point_3d_t imaginary;
} vidhance_quaternion_t;
vidhance_quaternion_t vidhance_quaternion_new(float w, float x, float y, float z);
```

---
### vidhance_float_rotation_3d_t
structure representing a 3d rotation.
``` c
typedef struct {
	vidhance_quaternion_t quaternion;
} vidhance_float_rotation_3d_t;
vidhance_float_rotation_3d_t vidhance_float_rotation_3d_new(const vidhance_quaternion_t quaternion);
```

---
### vidhance_image_t
The base image class used by Vidhance.
``` c
typedef struct _vidhance_image_t* vidhance_image_t;
```

---
### vidhance_date_time_t
Object representing timestamps. 1 tick = 100 nanoseconds.
``` c
typedef struct {
	uint64_t ticks;
} vidhance_date_time_t;
vidhance_date_time_t vidhance_date_time_new(const uint64_t ticks);
vidhance_date_time_t vidhance_date_time_from_date(int year, int month, int day);
vidhance_date_time_t vidhance_date_time_from_time(int hour, int minute, int second, int millisecond);
vidhance_date_time_t vidhance_date_time_from_date_time(int year, int month, int day, int hour, int minute, int second, int millisecond);
vidhance_date_time_t vidhance_date_time_get_now();
uint64_t vidhance_date_time_get_ticks(const vidhance_date_time_t);
int vidhance_date_time_get_millisecond(const vidhance_date_time_t);
int vidhance_date_time_get_second(const vidhance_date_time_t);
int vidhance_date_time_get_minute(const vidhance_date_time_t);
int vidhance_date_time_get_hour(const vidhance_date_time_t);
int vidhance_date_time_get_day(const vidhance_date_time_t);
int vidhance_date_time_get_month(const vidhance_date_time_t);
int vidhance_date_time_get_year(const vidhance_date_time_t);
```

---
### vidhance_time_span_t
Object representing time durations. 1 tick = 100 nanoseconds.
``` c
typedef struct {
	int64_t ticks;
} vidhance_time_span_t;
vidhance_time_span_t vidhance_time_span_new(int64_t ticks);
vidhance_time_span_t vidhance_time_span_from_data(int hour, int minute, int second, int millisecond);
int64_t vidhance_time_span_get_ticks(const vidhance_time_span_t);
vidhance_time_span_t vidhance_time_span_get_negated(const vidhance_time_span_t);
int64_t vidhance_time_span_get_total_milliseconds(const vidhance_time_span_t);
int64_t vidhance_time_span_get_total_seconds(const vidhance_time_span_t);
int64_t vidhance_time_span_get_total_minutes(const vidhance_time_span_t);
int64_t vidhance_time_span_get_total_hours(const vidhance_time_span_t);
int64_t vidhance_time_span_get_total_days(const vidhance_time_span_t);
int64_t vidhance_time_span_get_total_weeks(const vidhance_time_span_t);
vidhance_time_span_t vidhance_time_span_from_milliseconds(const double count);
vidhance_time_span_t vidhance_time_span_from_seconds(const double count);
vidhance_time_span_t vidhance_time_span_from_minutes(const double count);
vidhance_time_span_t vidhance_time_span_from_hours(const double count);
vidhance_time_span_t vidhance_time_span_from_days(const double count);
vidhance_time_span_t vidhance_time_span_from_weeks(const double count);
```

---
### vidhance_header_t
A header object holding an image and metadata.
``` c
typedef struct _vidhance_header_t* vidhance_header_t;
```

---
### vidhance_graphic_buffer_t
Corresponds to the GraphicBuffer class in Android.
``` c
typedef struct _vidhance_graphic_buffer_t* vidhance_graphic_buffer_t;
```


---
### vidhance_graphic_buffer_t
Creates a new vidhance_graphic_buffer_t
``` c
vidhance_graphic_buffer_t vidhance_graphic_buffer_new(const void* backend, const void* native_buffer, const void* handle, vidhance_int_vector_2d_t size, int pixel_stride, int format);
```

#### Parameters
*backend* The GraphicBuffer

*native_buffer* The native buffer

*handle* The buffer handle

*size* Image resolution.

*pixel_stride* Image stride in pixels

*format* The buffer format

---
### vidhance_graphic_buffer_t
Frees a vidhance_graphic_buffer_t, normally not needed since ownership is transferred to vidhance when creating an image
``` c
void vidhance_graphic_buffer_free(vidhance_graphic_buffer_t buffer);
```

---
### vidhance_graphic_buffer_yuv_420_semiplanar_new
Function for creating a YUV420 image from a GraphicBuffer in Android.
``` c
vidhance_image_t vidhance_graphic_buffer_yuv_420_semiplanar_new(vidhance_graphic_buffer_t buffer, vidhance_int_vector_2d_t size, int stride, int uv_offset);
```
#### Parameters
*buffer* The buffer containing the image.

*size* Image resolution.

*stride* Image stride in bytes

*uv_offset* Offset in bytes to the uv plane in the buffer.

---
## Example
Prepare the Vidhance context for a new video session.
``` c
vidhance_context_start(context);
```

Create `vidhance_image_t` from Android GraphicBuffer.
``` c
vidhance_image_t image = vidhance_graphic_buffer_yuv_420_semiplanar_new(buffer, vidhance_int_vector_2d_new(1920, 1080), 1920, 1920 * 1080);
```
Create `vidhance_header_t` from metadata.
``` c
vidhance_header_t header = vidhance_header_new(vidhance_date_time_new(timestamp_ticks), vidhance_time_span_new(lifetime_ticks),
		readout_ticks, focalLengthPixels, vidhance_time_span_new(exposureTime_ticks));
```
Create `vidhance_frame_t` from header and image.
``` c
vidhance_frame_t frame = vidhance_frame_from_image(header, image);
```

Process frame.
``` c
vidhance_context_process_output(context, inputFrame, outputFrame);
```

Process preview frames.
``` c
vidhance_context_process_preview(context, previewFrame);
```

End the video session.
``` c
vidhance_context_stop(context);
```

---
# Sensors
---

## General

### vidhance_motion_sensor_t
Represents a motion sensor
``` c
typedef struct _vidhance_motion_sensor_t* vidhance_motion_sensor_t;
```

---
### vidhance_motion_sensor_free
Frees the memory allocated for a motion sensor
``` c
void vidhance_motion_sensor_free(vidhance_motion_sensor_t);
```

---
## Orientation sensor measurment
---

### vidhance_orientation_measurement_t
``` c
typedef struct {
	vidhance_float_rotation_3d_t rotation;
	vidhance_date_time_t timestamp;
} vidhance_orientation_measurement_t;
```
### vidhance_orientation_measurement_new
``` c
vidhance_orientation_measurement_t vidhance_orientation_measurement_new(vidhance_float_rotation_3d_t rotation, vidhance_date_time_t time);
```

---
## Orientation sensor measurments
---

### vidhance_orientation_measurements_t
Represents several instances of [vidhance_orientation_measurements_t]({{< ref "#vidhance-orientation-measurements-t" >}})
``` c
typedef struct _vidhance_orientation_measurements_t* vidhance_orientation_measurements_t;
```

### vidhance_orientation_measurements_new
``` c
vidhance_orientation_measurements_t vidhance_orientation_measurements_new();
```

### vidhance_orientation_measurements_free
Frees all the internal memory and all added [vidhance_orientation_measurement_t]({{< ref "#vidhance-orientation-measurement-t" >}}) instances
``` c
void vidhance_orientation_measurements_free(vidhance_orientation_measurements_t);
```

### vidhance_orientation_measurements_add
```
void vidhance_orientation_measurements_add(vidhance_orientation_measurements_t result, vidhance_orientation_measurement_t measurement);
```

---
## Orientation sensor
---

### get_orientation_cb_t
Defintion of callback function used to get [vidhance_orientation_measurements_t]({{< ref "#vidhance-orientation-measurements-t" >}})
``` c
typedef vidhance_orientation_measurements_t (*get_orientation_cb_t)(vidhance_date_time_t, vidhance_time_span_t);
```

### vidhance_orientation_sensor_new
Creates a new orientation sensor
``` c
vidhance_motion_sensor_t vidhance_orientation_sensor_new(get_orientation_cb_t cb, vidhance_time_span_t sample_period);
```

#### Parameters
*get_orientation_cb_t* Callback used when Vidhance requests new orientation sensor data

*sample_period* How often Vidhance vill sample the orientation sensor

---
## Angular velocity sensor measurment
---

### vidhance_angular_velocity_measurement_t
``` c
typedef struct {
	vidhance_float_vector_3d_t velocity;
	vidhance_date_time_t timestamp;
} vidhance_angular_velocity_measurement_t;
```

### vidhance_angular_velocity_measurement_new
``` c
vidhance_angular_velocity_measurement_t vidhance_angular_velocity_measurement_new(vidhance_float_vector_3d_t velocity, vidhance_date_time_t time);
```

---
## Angular velocity sensor measurements
---

### vidhance_angular_velocity_measurements_t
Represents several instances of [vidhance_angular_velocity_measurement_t]({{< ref "#vidhance-angular-velocity-measurement-t" >}})
``` c
typedef struct _vidhance_angular_velocity_measurements_t* vidhance_angular_velocity_measurements_t;
```

### vidhance_angular_velocity_measurements_new
``` c
vidhance_angular_velocity_measurements_t vidhance_angular_velocity_measurements_new(vidhance_time_span_t sample_period);
```

### vidhance_angular_velocity_measurements_add
``` c
void vidhance_angular_velocity_measurements_add(vidhance_angular_velocity_measurements_t result, vidhance_angular_velocity_measurement_t measurement);
```

### vidhance_angular_velocity_measurements_free
Frees all the internal memory and all added [vidhance_angular_velocity_measurement_t]({{< ref "#vidhance-angular-velocity-measurement-t" >}}) instances
``` c
void vidhance_angular_velocity_measurements_free(vidhance_angular_velocity_measurements_t);
```

---
## Gyro sensor
---

### get_velocity_cb_t
Defintion of callback function used to get [vidhance_angular_velocity_measurements_t]({{< ref "#vidhance-angular-velocity-measurements-t" >}})
``` c
typedef vidhance_angular_velocity_measurements_t (*get_velocity_cb_t)(vidhance_date_time_t, vidhance_time_span_t);
```

### vidhance_gyro_sensor_new
Creates a new gyro sensor
``` c
vidhance_motion_sensor_t vidhance_gyro_sensor_new(get_velocity_cb_t cb, vidhance_time_span_t sample_period);
```

#### Parameters
*get_velocity_cb_t* Callback used when Vidhance requests new gyro sensor data

*sample_period* How often Vidhance vill sample the gyro sensor

---
## Rotation sensor
---

### vidhance_rotation_sensor_new
Creates a new rotation sensor
``` c
vidhance_motion_sensor_t vidhance_rotation_sensor_new(vidhance_motion_sensor_t sensor);
```

#### Parameters
*sensor* A gyro sensor created using vidhance_gyro_sensor_new