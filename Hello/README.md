# Vanilla.cu
## Explanation
- An empty function named `kernel()` qualified with `__global__`.
- A call to empty function qualified with `<<<1, 1>>>`

## CUDA C
- CUDA C adds the `__global__` qualifier to standard C. This mechanism alerts the compiler -> this function should be compiled to run on GPU.
- nvcc gives the function `kernel()` to the GPU compiler, and `main()` to host compiler.
- The angle braket denot args we plan to pass to the runtime system.

# Vanilla_advance.cu
- `cudaMalloc()`: This call behaves similarly to the standard C call malloc().
- it tells the CUDA runtime to allocate the mem on GPU.
    - arg[0]: A pointer to (the pointer you want to hold the address of the newly allocated on-device mem).
    - arg[1]: the size of the allocation desired.
## Usage of device pointer
- Allow to pass pointers allocated with `cudaMalloc()` to functions that execute on the device.
- Allow to use pointers allocated with `cudaMalloc()` to read/write **mem** from code that exec on the device.
- Allow to use pointers allocated with `cudaMalloc()` to **functions** that exec code on the host.
- Not allow to use pointers allocated with `cudaMalloc()` to r/w **mem** on the host.
> We can not modify the memory from the host.
> To access device memory: use device ptrs!

## Commands
```
make clean
make all
```
