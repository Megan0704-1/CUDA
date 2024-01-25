# Pinned Memory
- Pinned memory, aka page-locked or non-pagable memory, involves designating a portion of the system's RAM in such a way that it cannnot be moved to disk or swapped out by the OS.
- In other words, the memory is locked in the physical RAM.
- The key benefit of Pinned memory is that it can be directly accessed by other processors (like GPU).
- Processors like GPUs can read from and modify the pinned memory without additional memory overhead of going through the CPU. 
