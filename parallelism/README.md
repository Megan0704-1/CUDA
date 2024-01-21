# CUDA in actions
> As we know, the power of GPU lies in its massive parallelism.
> CUDA use a kerenel execution configuration `<<<M, T>>>` to tell CUDA runtime how many threads to launch on device. CUDA orgaizes threads into a group called **thread block**. Kernel can launch multiple thread blocks, organized into a **grid** structure. (M: a grid of M thread blocks, Each thread block has T parallel threads.)
1. VecSum
- basic Vector add program
2. VecAdd
- parallel VecSum programs with multithread.
3. JuliaSet
- Using OpenGL, GLUT, GLEW, and GLFW3 packages to render JuliaSet images (cpu, gpu)
4. DotProduct
- Combining concepts in element wise product, shared_memory on GPU, syncrhonization, and reduction.
5. Animation
- Animating application to render infinite JuliaSet.
6. ConstantMem

