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
