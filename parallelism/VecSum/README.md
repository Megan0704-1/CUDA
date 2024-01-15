# Commands
```bash
mkdir build
cd build
cmake ..
make -j8

# run the code
./cpuVecSum
./gpuVecSum
./gpuBadVecSum
```

- You will probably notice that the program does not work correctly. The reason is CPU and GPU are separate entities. Both have their own memory space. CPU cannot directly access GPU memory, and vice versa. Pointers to CPU and GPU memory are called host pointer and device pointer respectively.
- For data to be accessible by GPU, it mmust be presented in the device memory. CUDA provides API for allocating device memory and data transfer between host and device mem.

## Common workflow
    1. Allocate host mem and init host data
    2. Allocate device mem
    3. Transfer input data from host to device
    4. Execute kernels
    5. Transfer output from device to host


# gpuVecSum
- `<<<N, 1>>>()`: the runtime creates N copies of the kernel and run them in parallel.
- Since the GPU runs N copies of kernel code, we can tell which block is currently running which code by `blockIdx.x`. (A built-in variable CUDA defines for us.)
- We then called the collection of blocks a `grid`.
    - This tells to the runtime system that we want a 1-dim grid of N blocks.

**Note.** You should not lauch kernels over 65,535. (hardware-imposed limit)
