basic concepts:

CPU is designed to excel at executing a sequence of operations, called a thread, as fast as possible and can execute a few tens of these threads in parallel

GPU is designed to excel at executing thousands of them in parallel (amortizing the slower single-thread performance to achieve greater throughput).



`
the original CPU-code.c is a simple vector add program that added two vectors and assigned the result to another vector I named: c.

For GPU-code.cu, we introduced cudaMallocManaged, moving the original data location (CPU memory) to an unified space that can be accessed both by CPU and GPU.
*cudaMallocManaged returns a pointer for host and device to access. To free data in the unified memory, we should pass the pointer to cudaFree api.

launch confiuration for the kernel:
"triple angle braket" <<<>>>

