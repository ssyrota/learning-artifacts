**Storage and retrieval**

**Log structured**

One way to store data is to have one append only file with key and value in it and store the hashmap in memory.
- The log would grow up
- The hashmap is not serialized and it takes long time to restore it
- If hashmap bigger then RAM, performance degrades

**SSTable**
Alternative is storing data as SSTable(sorted string)
You have 1 table with blocks(data) and second with sorted start keys of this blocks(key,block_offset).

SSTable allows to make random I/O, but not full scan of the file.

SSTable writing is heavy operation which requires rewriting the file. To speed up the process:
1. New writes is written to memtable(until 8mb of data) and append-only log.
2. When memtable becomes big - flush data from memtable into new SSTable file with own index(called *segment*)
3. When read by key - read memtable(if not found -> than latest segment, than previous and so on.)
4. Sometimes perform the merging and compaction process

To simplify not-found case the bloom filter can be used.

Compaction can be performed in two ways:
1. Compact older with newer to make size-tiered segments
2. Compact by key to make segments with key ranges

**B-Tree**

Break the database into fixed-size blocks(8KiB for postgresql, 16 for mysql).

Pages have *branching factor*, or "which is enough to split the page", sometimes it's items count-based, sometimes - storage size.

Insert into full page breaks it to two half-filled pages.
To make an insert - the seek and rewrite is needed.
Deleting keys may be complex due to requiring merging pages.
Algorithm ensures that B-Tree is balanced, which means that for N items, the search would always be O(log *n*)

