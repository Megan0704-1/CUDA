#include "cuda.h"
#include "../include/Sphere.h"
#include "../../../common/book.h"
#include "../../../common/cpu_bitmap.h"

using uc=unsigned char;

// declare constant memory allocation
__constant__ Sphere s[numSPHERES];

__global__ void kernel(uc* ptr){
    int x = threadIdx.x + blockIdx.x * blockDim.x;
    int y = threadIdx.y + blockIdx.y * blockDim.y;
    int offset = x + y * blockDim.x * gridDim.x;
    
    float px = x - (DIM/2);
    float py = y - (DIM/2);

    float r=0, g=0, b=0;
    float maxZ = -INF;

    for(int i=0; i<numSPHERES; i++)
    {
        float n; // n is the scale of color
        float dist = s[i].hit(px, py, &n);
        if(dist > maxZ)
        {
            float scale = n;
            r = s[i].r * scale;
            g = s[i].g * scale;
            b = s[i].b * scale;
        }
        
    }

    ptr[offset*4 + 0] = (int)(255 * r);
    ptr[offset*4 + 1] = (int)(255 * g);
    ptr[offset*4 + 2] = (int)(255 * b);
    ptr[offset*4 + 3] = (int)(255);
}

int main(void)
{
    cudaEvent_t start, stop;
    cudaEventCreate( &start );
    cudaEventCreate( &stop );
    cudaEventRecord( start, 0 );

    CPUBitmap bitmap( DIM, DIM );
    uc *dev_bitmap;

    cudaMalloc( (void**)&dev_bitmap, bitmap.image_size() );
    

    Sphere* host_s = (Sphere*)malloc( sizeof(Sphere)*numSPHERES );
    for( int i=0; i<numSPHERES; i++ )
    {
        host_s[i].r = rnd( 1.0f );
        host_s[i].g = rnd( 1.0f );
        host_s[i].b = rnd( 1.0f );
        host_s[i].x = rnd( 1000.0f ) - 500;
        host_s[i].y = rnd( 1000.0f ) - 500;
        host_s[i].z = rnd( 1000.0f ) - 500;
        host_s[i].radius = rnd( 100.0f ) + 20;
    }

    // different memcpy api
    cudaMemcpyToSymbol( s, host_s, sizeof(Sphere)*numSPHERES );

    free(host_s);
    
    // num of blocks in grids
    dim3 blocks( DIM/16, DIM/16 );
    // num of threads per block
    dim3 threads( 16, 16 );

    kernel<<<blocks, threads>>>( dev_bitmap);

    cudaMemcpy(bitmap.get_ptr(), dev_bitmap, bitmap.image_size(), cudaMemcpyDeviceToHost);

    bitmap.display_and_exit();

    cudaFree( dev_bitmap );
}
