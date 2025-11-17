**Overview and some use cases**

Redis is in-memory database.

Useful features:
- key-value
- vector search
- storing hashmaps/json with text indexes, secondary indexes to enhance search
- transactions(without rollbacks, but ACID-like)
- Pub-sub and streaming

Value data types:
- string
- string lists
- sets
- sorted sets(leaderboard like, key and it's score)
- hashes(or dictionary from python)
- vector sets
- streams(append only log)
- Geospatial indexes
- Bitmaps
- JSON
- Probabilistic data types

Redis(one instance) can have persistence:
- Interval snapshots or Redis Database(RDB)
- Append only file(AOF)
- RDB + AOF