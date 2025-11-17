## The problem with distributed systems

Network problems:
1. Request may be lost
2. Request may be waiting in queue and delivered later
3. The remote node may have failed
4. The remote node may have temporary stopped responding
5. The remote node may have processes your request, but response lost in network
6. The remote node may have processes your request, but response is in queue

TCP(not only) problem - it remote application closed connection, you cannot know data was processed or not.

Internet uses packet switching networking to allow bursty traffic.

Process problems:
- Garbage collection
- Suspense in virtualized environment
- Crash after leasing a lock

**Fencing off zombies and delayed requests**

- *zombie* is sometimes used to describe a former leaseholder who has not yet found out that it lost the lease, and who is still acting as if it was the current leaseholder
- every time the lock service grants a lock or lease, it also returns a *fencing token*
- when client sends request to storage service with old token - it get's rejected

**Byzantine faults**

To make distributed system reliable nodes, if alive, must tell the "truth", example of violating this is
*Byzantine Faults*, when node might cast multiple contradictory votes in the same election.

A system is *Byzantine fault-tolerant* if it continues to operate correctly even if some of the nodes are malfunctioning and not obeying the protocol, or if malicious attackers are interfering with the network.