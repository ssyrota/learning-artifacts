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
It's self balanced tree with all leaf nodes at one level property.

Must have min degree(root node is exception).
When node is too big - get median value and promote to upper level.
If the node is too small - get separator key from parent and place the sinling key as separator.
If we have sibling at low - take separator and merge with sibling.
When deleting a separator - take from the lower level. 

Break the database into fixed-size blocks(8KiB for postgresql, 16 for mysql).

Pages have *branching factor*, or "which is enough to split the page", sometimes it's items count-based, sometimes - storage size.

Insert into full page breaks it to two half-filled pages.
To make an insert - the seek and rewrite is needed.
Deleting keys may be complex due to requiring merging pages.
Algorithm ensures that B-Tree is balanced, which means that for N items, the search would always be O(log *n*)

**Analytics**

Components for data warehouse:
1. Query engine
2. Storage format
3. Table format(ability to update/delete)
4. Data catalog

Analytics operations often run on column-oriented storage.
Column-oriented - columns stored separately in block-files to reduce amount of extra work for reading/decoding/parsing.

Rows can be stored in sorted order if specified at table creation(like in starrocks)

**Multidimensional and full-text indexes**

Concatenated index combines several fields into one key. So it's not possible to efficiently query like this:
```

```
```sql
SELECT * FROM restaurants WHERE latitude  > 51.4946 AND latitude  < 51.5079
                            AND longitude > -0.1162 AND longitude < -0.1004;
```

To make geo query we need a multidimensional index of latitude + longitude.

One option to do this for geo - translate location into single number using a **space-filling curve**.
More commonly used R-trees(PostGIS using Generalized Search Tree indexing facility or GiST index), Bkd-trees.

Inverted index - key-value structure where the key is term, and the value is list of IDs of all the documents contain the term.

Indexes for vector query:
- flat indexes - vectore value in index
- Inverted file indexes - with centroids
- Hierarchical Navigable Small World(HNSW)

> As an application developer, if you’re armed with this knowledge about the internals of storage engines, you are in a much better position to know which tool is best suited for your particular application. If you need to adjust a database’s tuning parameters, this understanding allows you to imagine what effect a higher or a lower value may have.
Although this chapter couldn’t make you an expert in tuning any one particular storage engine, it has hopefully equipped you with enough vocabulary and ideas that you can make sense of the documentation for the database of your choice.

TODO:
- vector indexes and databases
- vectorized query
- db for AI
- different index types in postgres
- geo
- time-series
- gpu in analytics?
