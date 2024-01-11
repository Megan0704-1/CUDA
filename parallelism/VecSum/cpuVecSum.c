#include <stdio.h>

#define N 100000

void add(int *a, int* b, int* c){
    int cpuid=0;
    while(cpuid < N){
        c[cpuid] = a[cpuid] + b[cpuid];
        cpuid ++;
    }
}

int main(void){
    int a[N], b[N], c[N];

    // fill the arr
    for(int i=0; i<N; i++){
        a[i] = -i;
        b[i] = i*i;
    }

    add(a, b, c);

    // diaply the result
    for(int i=0; i<N; i++){
        printf("%d + %d = %d\n", a[i], b[i], c[i]);
    }

    return 0;
}
