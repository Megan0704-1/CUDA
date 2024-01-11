#include <iostream>

#define N 100000

__global__ void add(int* a, int* b, int* c){
    int threadId = blockIdx.x;
    if(threadId < N){
        c[threadId] = a[threadId] + b[threadId];
    }
    printf("thread Id: %d, a[id]: %d\n", threadId, a[threadId]);
    return;
}

int main(void){
    int a[N], b[N], c[N];
    int *dev_a, *dev_b, *dev_c;

    // allocate the memory on GPU
    cudaMalloc((void**)&dev_a, N*sizeof(int));
    cudaMalloc((void**)&dev_b, N*sizeof(int));
    cudaMalloc((void**)&dev_c, N*sizeof(int));

    // fill the arrays 'a' and 'b' on the CPU
    for(int i=0; i<N; i++){
        a[i] = -i;
        b[i] = i*i;
    }

    // copy the arrays to the GPU
    cudaMemcpy(dev_a, a, N*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, N*sizeof(int), cudaMemcpyHostToDevice);

    add<<<N, 1>>>(dev_a, dev_b, dev_c);

    // copy the array c back from the GPU to CPU
    cudaMemcpy(c, dev_c, N*sizeof(int), cudaMemcpyDeviceToHost);

    // display the resule
    for(int i=0; i<N; i++){
        printf("%d + %d = %d\n", a[i], b[i], c[i]);
    }

    // free the memory allocated on GPU
    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_c);

    return 0;
}
