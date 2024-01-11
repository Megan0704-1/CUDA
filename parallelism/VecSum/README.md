# gpuVecSum
- `<<<N, 1>>>()`: the runtime creates N copies of the kernel and run them in parallel.
- Since the GPU runs N copies of kernel code, we can tell which block is currently running which code by `blockIdx.x`. (A built-in variable CUDA defines for us.)
- We then called the collection of blocks a `grid`.
    - This tells to the runtime system that we want a 1-dim grid of N blocks.

**Note.** You should not lauch kernels over 65,535. (hardware-imposed limit)
