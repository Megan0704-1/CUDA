#include <stdio.h>
#include <assert.h>
#include <math.h>

#define N 100000000
#define MAX_ERROR 1e-6

__global__ void add(float* a, float* b, float* c, int n){
    int idx = threadIdx.x;
    int stride = blockDim.x;
    int blockID = blockIdx.x;

    int tid = idx + stride * blockID;

    while(tid < n){
        c[tid] = a[tid] + b[tid];
        tid += stride * gridDim.x;
    }
}

int main(){
    float *a, *b, *c;
    float *dev_a, *dev_b, *dev_c;

    a = (float*)malloc(sizeof(float)*N);
    b = (float*)malloc(sizeof(float)*N);
    c = (float*)malloc(sizeof(float)*N);

    for(int i=0; i<N; i++){
        a[i] = 1.0f;
        b[i] = 2.0f;
    }

    cudaMalloc((void**)&dev_a, sizeof(float)*N);
    cudaMalloc((void**)&dev_b, sizeof(float)*N);
    cudaMalloc((void**)&dev_c, sizeof(float)*N);

    cudaMemcpy(dev_a, a, sizeof(float)*N, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, sizeof(float)*N, cudaMemcpyHostToDevice);

    add<<<N/256+1, 256>>>(dev_a, dev_b, dev_c, N);

    cudaMemcpy(c, dev_c, sizeof(float)*N, cudaMemcpyDeviceToHost);

    for(int i=0; i<N; i++){
        assert(fabs(c[i] - a[i] - b[i]) < MAX_ERROR);
    }

    printf("PASSED\n");

    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_c);

    free(a);
    free(b);
    free(c);

    return 0;
}
