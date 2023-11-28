# CUDA
parallel programming

Concepts:
Typically, one thread handles one data element, threads are grouped into blocks, and the blocks are arranged into a grid.

Threads within the same block can communicate and shared info with each other

SIMT architecture
A cuda device is made up of several 'Streaming Multiprocessors', each SMs contains a number of cuda cores, registers, caches and shared memory. These resources are all shared between the cores. The device also have a larger pool of memory, which are shared by all the SMs.

Single Instruction multiple threads: one can launch multuple light weighted threads and execute the same instruction with different data.

CUDA hardware executes threads in groups of 32 which are called warps.
All the threads in a warp will run at the same time on the same SM, and typically will exec the same instructions.

When running a kernel...
1. The threadBlocks are assigned to available SMs.
2. Each block is split into warps of 32 threads, which are scheduled and run on the SM.
3. You can have multiple warps on a SM, the hardware will switched between them whenever a warp needs to wait.
4. After a block is fiished executing, CUDA will scheduled new block to the SM, untill the grid is done.
