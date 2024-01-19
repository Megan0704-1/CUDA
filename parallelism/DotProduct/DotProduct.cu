#include <stdio.h>
#include <assert.h>

#define N 100000000

__global__ void dotProduct(int* a, int* b, int* c){
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    while(tid < N){
        c[tid] = a[tid] * b[tid];
        tid += blockDim.x * gridDim.x;
    }
}

int main(){
    int* a;
    int* b;
    int* c;

    int* device_a;
    int* device_b;
    int* device_c;

    a = (int*)malloc(N * sizeof(int));
    b = (int*)malloc(N * sizeof(int));
    c = (int*)malloc(N * sizeof(int));

    for(int i=0; i<N; i++){
        a[i] = i;
        b[i] = -i;
    }

    cudaMalloc((void**)&device_a, sizeof(int)*N);
    cudaMalloc((void**)&device_b, sizeof(int)*N);
    cudaMalloc((void**)&device_c, sizeof(int)*N);

    cudaMemcpy(device_a, a, sizeof(int)*N, cudaMemcpyHostToDevice);
    cudaMemcpy(device_b, b, sizeof(int)*N, cudaMemcpyHostToDevice);

    dotProduct<<<128, 128>>>(device_a, device_b, device_c);

    cudaMemcpy(c, device_c, sizeof(int)*N, cudaMemcpyDeviceToHost);

    for(int i=0; i<N; i++){
        assert(c[i]==a[i] * b[i]);
    }
    printf("PASSED\n");

    free(a);
    free(b);
    free(c);

    cudaFree(device_a);
    cudaFree(device_b);
    cudaFree(device_c);

    return 0;

}
