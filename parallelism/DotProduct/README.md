## Synchronization
- One crucial characteristic of `__syncthreads()` mechanism is that it should never be places in a conditional statements.
    - The CUDA architecture guarantees that no thread will execute instruction beyond the `__syncthreads()` util every thread in the threadblock has executed the `__syncthreadis()` method.
