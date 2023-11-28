#include <stdio.h>
#define SIZE 1024

/**
 * @brief vector add function for cpu
 */
__global__ void Vecadd(int *a, int *b, int *c, int n){
    int id = threadIdx.x;
    if(id < n){
        c[id] = a[id]+b[id];
    }
}

int main(){
    int *a, *b, *c;

    cudaMallocManaged(&a, SIZE*sizeof(int));
    cudaMallocManaged(&b, SIZE*sizeof(int));
    cudaMallocManaged(&c, SIZE*sizeof(int));

    for(int i=0; i<SIZE; i++){
        a[i] = i;
        b[i] = i;
        c[i] = 0;
    }
    
    Vecadd<<<1, SIZE>>>(a, b, c, SIZE);
    cudaDeviceSynchronize();

    for(int i=0; i<SIZE; i++){
        printf("c[%d] = %d\n", i, c[i]);
    }

    cudaFree(&a);
    cudaFree(&b);
    cudaFree(&c);
    
    return 0;
}
