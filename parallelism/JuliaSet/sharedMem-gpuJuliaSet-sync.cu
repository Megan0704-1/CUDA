#include "cuda.h"
#include "../../common/book.h"
#include "../../common/cpu_bitmap.h"

#define DIM 1024
#define PI 3.1415926535897932f

using uc = unsigned char;

__global__ void kernel (uc *ptr){

    __shared__ float shareMem[16][16];

    // map from threadIdx/blockIdx to pixel position
    int x = threadIdx.x + blockIdx.x * blockDim.x;
    int y = threadIdx.y + blockIdx.y * blockDim.y;

    // true position of the thread
    int offset = x + y * blockDim.x * gridDim.x;

    const float period = 128.0f;

    shareMem[threadIdx.x][threadIdx.y] = 255 * (sinf(x*2.0f*PI / period) + 1.0f) * 
                                               (sinf(x*2.0f*PI / period) + 1.0f) / 4.0f;

    __syncthreads();

    ptr[offset*4 + 0] = 0;
    ptr[offset*4 + 1] = shareMem[15 - threadIdx.x][15 - threadIdx.y];
    ptr[offset*4 + 2] = 0;
    ptr[offset*4 + 3] = 255;
}

int main(void){
    CPUBitmap bitmap( DIM, DIM );

    uc *dev_bitmap;

    cudaMalloc( (void**)&dev_bitmap, bitmap.image_size() );

    dim3 grids(DIM/16, DIM/16);
    dim3 threads(16, 16);
    kernel<<<grids, threads>>>( dev_bitmap );

    cudaMemcpy(bitmap.get_ptr(), dev_bitmap, bitmap.image_size(), cudaMemcpyDeviceToHost);

    bitmap.display_and_exit();

    cudaFree(dev_bitmap);
}
