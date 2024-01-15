# Paralelizing vector addition using multithread
- CUDA provides built-in variables for accessing thread info.
    - `threadIdx.x`: contains the idx of the thread within the block.
    - `blockDim.x`: contains the size of thread block (the num of threads in a thread block.)
- In multithread.cu exercise, the number of `threaIdx.x` ranges from 0~255; the value of `blockDim.x` is 256.

- GPU have several parallel processors called Streaming MultiProcessors (SMs). Each SM consists of multiple parallel processors and can run multiple concurrent thread blocks. To take advantage of CUDA GPUs, kernel should be launched with multiple thread blocks. 
    - `blockIdx.x`: contains the idx of the block with in the grid.
    - `gridDim.x`: contains the size of the grid.

