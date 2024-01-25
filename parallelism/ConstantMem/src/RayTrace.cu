#include "cuda.h"
#include "../include/Sphere.h"
#include "../../../common/book.h"
#include "../../../common/cpu_bitmap.h"


using uc = unsigned char;

__global__ void kernel( uc* ptr, Sphere* s){
    // map to pixel position
    int x = threadIdx.x + blockIdx.x * blockDim.x;
    int y = threadIdx.y + blockIdx.y * blockDim.y;
    int offset = x + y * blockDim.x * gridDim.x;

    // shift (x, y) => image coordinate, by DIM/2, so that the z-axis runs through the center of the image
    float px = ( x - DIM/2 );
    float py = ( y - DIM/2 );

    float r = 0;
    float g = 0;
    float b = 0;
    float maxZ = -INF;
    for(int i=0; i<numSPHERES; i++){
        float n;
        float t = s[i].hit(px, py, &n);
        if(t > maxZ){
            float fscale = n;
            r = s[i].r * fscale;
            g = s[i].g * fscale;
            b = s[i].b * fscale;
        }
    }

    ptr[offset*4 + 0] = (int)(r*255);
    ptr[offset*4 + 1] = (int)(g*255);
    ptr[offset*4 + 2] = (int)(b*255);
    ptr[offset*4 + 3] = 255;
}

int main(void){
    // capture the start time
    cudaEvent_t start, stop;
    cudaEventCreate( &start );
    cudaEventCreate( &stop );
    cudaEventRecord( start, 0 );

    CPUBitmap bitmap( DIM, DIM );
    uc *dev_bitmap;
    Sphere* s;

    // allocate space for output (dev_map), and input (s) on GPU
    cudaMalloc( (void**)&dev_bitmap, bitmap.image_size() );
    cudaMalloc( (void**)&s, sizeof(Sphere)*numSPHERES );

    // generate 20 spheres
    Sphere* host_s = (Sphere*)malloc( sizeof(Sphere)*numSPHERES );
    for(int i=0; i<numSPHERES; i++){
        host_s[i].r = rnd( 1.0f );
        host_s[i].g = rnd( 1.0f );
        host_s[i].b = rnd( 1.0f );
        host_s[i].x = rnd( 1000.0f ) - 500;
        host_s[i].y = rnd( 1000.0f ) - 500;
        host_s[i].z = rnd( 1000.0f ) - 500;
        host_s[i].radius = rnd( 100.0f ) + 20;
    }

    // move input to GPU
    cudaMemcpy(s, host_s, sizeof(Sphere)*numSPHERES, cudaMemcpyHostToDevice);
    free(host_s);

    // generate a bitmap from sphere data
    dim3 grids( DIM/16, DIM/16 );
    dim3 threads( 16, 16 );
    kernel<<<grids, threads>>>(dev_bitmap, s);

    cudaMemcpy(bitmap.get_ptr(), dev_bitmap, bitmap.image_size() , cudaMemcpyDeviceToHost);
    
    bitmap.display_and_exit();

    // free out memory
    cudaFree(dev_bitmap);
    cudaFree(s);
}
