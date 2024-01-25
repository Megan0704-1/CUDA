I will exploit the usage of constant memory on GPU to run a ray tracing application.

# Concepts Introduction
1. Ray Tracing
- One way to producing the 2D image of a scene consists of 3D objects.
### HOW?
> Choose a spot in a 3D scene and place an imaginary camera, which has a light sensor. To produce an image (from the camera), we need to determine which light ray hit the sensor. Since light ray can literally come from anywhere in the scene, it would be easier to estimate if we shoot the ray from image pixel into the scene. (Each pixel of the image is the same color and intensity of the light ray that hits the light sensor)
2. Rasterization
- Rasterization in GPU computing is a process that converts vector graphics (like 3D models composed of vertices and edges) into raster graphics (pixels or dots) for display on a screen. Essentially, it's the step where the GPU takes shape descriptions and transforms them into a grid of pixels. This process involves:
> **Vertex Processing**: Transforming 3D vertices into a 2D perspective.
> **Clipping**: Removing parts of shapes outside the viewing area.
> **Rasterizing**: Determining which pixels within a shape's 2D projection need to be colored.
> **Pixel Processing**: Applying textures, lighting, and color to these pixels.

3. Constant memory
- In CUDA programming, constant memory is a special type of memory on the GPU that is optimized for situations where all threads of a CUDA kernel read the same value. It is a small read-only region of mem (typically 64KB) that is cached on the chip, making it much faster than refular global memory when accessed by multiple threads simultaneously.
    1, Read-Only memory
        - Constant memory is read-only from the persepctive o the device code (GPU). It can be written to by te host code (CPU), typically before kernel execution.
    2. Cache optimization
        - The GPU constant cache is designed to speed up reads when all threads in a wrap read the same address. This makes it particularly efficien for broadvasting data to all threads.
    3. Usage
        - To use constant memory in CUDA, you declare a global variable within the `__constant__` qualifier. This variable can then be accessed from any kernel. The host code must use specific CUDA functions (like `cudaMemcpyToSymbol`) to copy data to constant memory.

## src/RayTrace.cu
- cpu version of ray tracing
## src/gpuRayTrace.cu
- use constant memory to accelerate gpu program
- In the native version of Ray Tracing, I use a pointer and `cudaMalloc` to allocate GPU memory, since constant memory is not modifiable, I changed the declaration to static allocation of the memory. (Therefore, no need to worry about memory leak problem.)

> cudaMemcpy: copies the memory on host to global memory in GPU.
> cudaMemcpyToSymbol: copies host memory to constant memory in GPU.

### Memory coaleasing
- A single read from constant memory can be broadcast to other "nearby" threads. Saving up to 15 reads.
- Constant memory is cached, so consecutive reads of the same address will not incur additional memory traffic.
    - NVIDIA hardware can broadcast a single memory read to rach 1/2 wrap. (16 threads)
    - if every thread in a half-wrap requests data from the same address and your GPU will generate single read request and subsequently broadcast the data to every other thread.
    - Hence, this generate 1/16 (roughly 6%) of the memory traffic reduction as you would when you use the global memory.
    - Additionally, becuase constant memory is committed to leaving memory unchanged, the hardware can aggressively cache the constant data on the GPU.
    - Therefore, when other half-wrap request the same address, they will hit the constant cache, avoiding additional memory traffic overhead.
