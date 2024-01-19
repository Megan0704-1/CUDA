#include <stdio.h>
#include "../../common/book.h"

#define imin(a, b) (a<b?a:b)
#define sum_square(x) (x*(x+1)*(2*x+1)/6)

const int N = 33*1024;
const int threadPerBlock = 256;
const int blockPerGrid = imin(32, (N + threadPerBlock-1) / threadPerBlock);

__global__ void dot(float* a, float* b, float* c){
    // qualifier `__shared__` is init once per block.
    // that is, only one thread would possess this instruction for allocating memory
    __shared__ float cache[threadPerBlock];

    int cacheIdx = threadIdx.x;
    int tid = threadIdx.x + blockIdx.x * blockDim.x;

    float cacheVal = 0;
    while(tid < N){
        cacheVal += a[tid] * b[tid];
        tid += blockDim.x * gridDim.x;
    }

    cache[cacheIdx] = cacheVal;

    // synchronizing threads in a block.
    __syncthreads();

    for(int i=blockDim.x>>1; i>0; i=i>>1){
        if(cacheIdx < i){
            cache[cacheIdx] += cache[cacheIdx + i];
        }
        __syncthreads();
    }

    if(cacheIdx==0){
        c[blockIdx.x] = cache[0];
    }
}

int main(void){
    float* a, *b, *partial_c;
    float* dev_a, *dev_b, *dev_partial_c;
    float cum;

    a = (float*)malloc(N*sizeof(float));
    b = (float*)malloc(N*sizeof(float));
    partial_c = (float*)malloc(N*sizeof(float));

    cudaMalloc( (void**)&dev_a, N*sizeof(float) );
    cudaMalloc( (void**)&dev_b, N*sizeof(float) );
    cudaMalloc( (void**)&dev_partial_c, N*sizeof(float) );
    
    for(int i=0; i<N; i++){
        a[i] = i;
        b[i] = i*2;
    }

    cudaMemcpy(dev_a, a, N*sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, N*sizeof(float), cudaMemcpyHostToDevice);

    dot<<<blockPerGrid, threadPerBlock>>>(dev_a, dev_b, dev_partial_c);

    cudaMemcpy(partial_c,dev_partial_c, blockPerGrid*sizeof(float), cudaMemcpyDeviceToHost);

    cum=0;
    for(int i=0; i<blockPerGrid; i++){
        cum += partial_c[i];
    }

    printf("Does GPU value %.6g = %.6g?\n", cum, 2*sum_square( (float)(N-1) ));

    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_partial_c);

    free(a);
    free(b);
    free(partial_c);

    return 0;
}
