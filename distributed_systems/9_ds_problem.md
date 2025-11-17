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


