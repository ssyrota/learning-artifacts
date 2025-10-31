> Why not async/await like in node.js - because of function coloring.

**Why not use system threads?**

**Concurrency vs parallelism**

Concurrency - composition of independently executing processes(functions).
Is about **dealing** with a lot of things at once.

Parallelism - is the simultaneous execution of (possibly related) computations.
Is about **doing** a lot of things at once.

**Goroutines(G) > Threads(M) > Cores(P)**

GOMAXPROCS - sets maximum P or parallelism.

The scheduler has fairness property - if a goroutine is runnable, it will eventually run.
