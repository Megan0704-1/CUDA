#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <iostream>

/**
 * @brief CUDA kernel for vector addition
 */
__global__ void vectorAdd(int* a, int* b, int* c, int n){
    // calculate global thread ID (tid)
    int tid = (blockIdx.x * blockDim.x) + threadIdx.x;
    
    std::cout << "tid: " << tid << "\n";
    // Vector boundary guard
    // what is a single thread do?
    if(tid < n){
        c[tid] = a[tid] + b[tid];
    }
}

/**
 * @brief init vector of size n to int btw 0~99
 */
void matrix_init(int* a, int n){
    for(int i=0; i<n; i++){
        a[i] = rand() % 100;
    }
}

/**
 * @brief check vector add result
 */
void error_check(int* a, int* b, int *c, int n){
    for(int i=0; i<n; i++){
        assert(c[i] = a[i]+b[i]);
    }
}


int main(){
    // vector size of 2^16 elements
    int n = 1<<16;

    // Host vector pointers
    int *a_hostptr, *b_hostptr, *c_hostptr;

    // Device vector pointers
    int *a_deviceptr, *b_deviceptr, *c_deviceptr;

    // size of all vec
    size_t bytes = sizeof(int) * n;

    // Allocate host memory
    a_hostptr = (int*)malloc(bytes);
    b_hostptr = (int*)malloc(bytes);
    c_hostptr = (int*)malloc(bytes);

    // Allocate device memory
    cudaMalloc(&a_deviceptr, bytes);
    cudaMalloc(&b_deviceptr, bytes);
    cudaMalloc(&c_deviceptr, bytes);
   
    // Initialize vectors a and b with random values between 0 and 99
    matrix_init(a_hostptr, n);
    matrix_init(b_hostptr, n);

    // Copy data from host to device memory
    cudaMemcpy(a_deviceptr, a_hostptr, bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(b_deviceptr, b_hostptr, bytes, cudaMemcpyHostToDevice);

    // Threadblock size : should be a multiply of 32 -> wraps is size of 32.
    int NUM_THREADS = 256;

    // Grid Size
    // launching NUMBLOCKS of Threadblocks, each of size NUM_THREADS
    int NUM_BLOCKS = (int)ceil(n/NUM_THREADS);

    // lauch kernel code on default stream without sh mem
    vectorAdd<<<NUM_BLOCKS, NUM_THREADS>>>(a_deviceptr, b_deviceptr, c_deviceptr, n);   
    // Copy sum vector from device to cpu
    cudaMemcpy(c_hostptr, c_deviceptr, bytes, cudaMemcpyDeviceToHost);

    // Check result for errors
    error_check(a_hostptr, b_hostptr, c_hostptr, n);
    
    std::cout << "Completed\n";

    return 0;

}
