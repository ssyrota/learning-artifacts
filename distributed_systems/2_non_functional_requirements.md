**Materialization**
In big social network pooling the posts for users potentially makes hundreds of millions lookups.
To deal with it *materialization* can be used, when somebody publishes a post - it is being sent to the user feed.
Celebrities(100k followers+) may be handled differently to speed this process up.

**Performance**
Two key metrics are:
1. Response time
2. Throughput - requests count or data volume per second

When system gets overloaded they may come into retry storm which is called metastable failure - the system takes longer to respond, queue gets bigger and retries are killing the server.

To prevent this - exponential backoff,circuit breaker, token bucket algorithm and backpressure may be used.

**Latency and response time**

1. Response time - what client sees
2. Service time(processing) - duration for which the service is actively processing the user request
3. Queueing delay - OS queueing for example waiting for CPU/network resource
4. Latency - networking overhead. *latent* time


**Reliability and Fault tolerance**

Typical expectations for software:
1. Performs expected function
2. Tolerate user mistakes
3. Good enough performance
4. Prevents unathorized access or abuse

*Fault* - part of system stops working correctly
*Failure* - the system as a whole stops providing the required service

System called *fault-tolerant* if it continues providing the required service in spite of certain faults occurring.
If a system cannot tolerate fault - this place called *single point of failure*.

**Scaling**

Can be:
1. Vertical
2. Vertical with shared memory/disks
3. Shared nothing or horizontal

**Maintainability**

Majority of cost of software is not initial development, but in its ongoing maintenance - fixing bugs, keep systems operation, investigating failures, adapting to new platforms, modifying or adding new features, repaying technical debt.

Principles of good maintainable software:
1. Simplicity of understanding
2. Operability - easy to keep running
3. Extensible and flexible

[TODO]
- How internet works?
- What are the tools to prevent metastable failure in node/go/python?
- What are the tools to measure latency and RPS in services?
- DDD?