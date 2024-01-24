#ifndef SPHERE_H
#define SPHERE_H
#define INF 2e10f
#define rnd(x) (x * rand() / RAND_MAX)
#define numSPHERES 20
#define DIM 1024

#include <cuda_runtime.h>

typedef struct Sphere {
    float r, g, b;
    float radius;
    float x, y, z;
    __device__ float hit(float px, float py, float *n);
} Sphere;

#endif
