#include "../include/Sphere.h"

__device__ float Sphere::hit(float px, float py, float* n){
    float dx = px - x;
    float dy = py - y;
    if( dx*dx + dy*dy < radius*radius ){
        float dz = sqrtf( radius*radius - dx*dx - dy*dy );
        *n = dz / sqrtf( radius*radius );
        return z - dz*2;
    }

    return -INF;
}
