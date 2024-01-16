#include "../../common/book.h"
#include "../../common/cpu_bitmap.h"

#define DIM 1000

struct cuComplex {
    float r;
    float i;

    // constructor
    cuComplex( float a, float b ): r(a), i(b) {}

    // method
    float magnitude2( void ){ return r*r + i*i; }

    cuComplex operator* (const cuComplex& a) {
        return cuComplex(r*a.r - i*a.i, i*a.r + r*a.i);
    }

    cuComplex operator+ (const cuComplex &a){
        return cuComplex(r+a.r, i+a.i);
    }
};

int julia(int x, int y){
    const float scale = 1.5;
    // shift the complex coordinate to the image center. (0~DIM-1) -> (-DIM/2~DIM/2) with scalar value.
    float jx = scale * (float)(DIM/2 - x)/(DIM/2);
    float jy = scale * (float)(DIM/2 - y)/(DIM/2);

    cuComplex C(-1.9, 0.156);
    cuComplex a(jx, jy);

    for(int i=0; i<1000; i++){
        a = a*a + C;
        if(a.magnitude2() > 1000){
            return 0;
        }
    }
    return 1;
}

void kernel( unsigned char *ptr ){
    for(int y=0; y<DIM; y++){
        for(int x=0; x<DIM; x++){
            int offset = x + y*DIM;

            int juliaVal = julia(x, y);
            ptr[offset*4 + 0] = 255 * juliaVal;
            ptr[offset*4 + 1] = 0;
            ptr[offset*4 + 2] = 0;
            ptr[offset*4 + 3] = 255;
        }
    }
}

int main( void ){
    CPUBitmap bitmap( DIM, DIM );
    unsigned char *ptr = bitmap.get_ptr();

    kernel(ptr);

    bitmap.display_and_exit();
}
