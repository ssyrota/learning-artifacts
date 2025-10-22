**Models**

*Relational* - modeling through relation algebra.

Has object-relational mismatch(aka. impedance mismatch).
Tuples inside relation are unordered.

**ORM cited problems**:
1. Two complex and don't solve mismatch, so developer should think about both relational and object representation
2. Doesn't work with OLAP
3. Query and schema generation are bad
4. Make easy to write ineffective queries (N+1)

Advantages:
1. Reduces boilerplate
2. Can cache results
3. Can help with schema migrations

**Document** - flexible json schema

Introduces data locality and one-to-few relationship.
Schema on read approach.

**Snowflake**

One big table of facts with links to dimensions like time, product or customer.

**Graphs**
- Facebook social(find liked posts by friends)
- Railway networks(find the shortest path)
- Web graph(PageRank to find popularity)


**Graph Storage models**

*Property*

Triple-store is the same as property but with other words.

Each vertex:
1. ID
2. Type of vertex(for example person, city, continent)
3. Set of outgoing edges
4. Set of incoming edges
5. A collection of properties(key-value)

Each edge:
1. ID
2. ID of head vertex
3. ID of tail vertex
4. Type of relationship(for example lives in, within)
5. Set of properties

Example DBs: Neo4j, Memgraph, KùzuDB


> Sql is not suitable to query graphs because amount of joins often is not specified and in SQL requires writing recursive queries.

*Query languages*
Cypher, SPARQL, Datalog, and GraphQL, Gremlin


[TODO]
- How impedance mismatch is solved and what we really need, raw-query, query builders or ORM(https://en.wikipedia.org/wiki/Object%E2%80%93relational_impedance_mismatch)
- Why update table is hurting operation
- How to scale postgres
- What is spanner and column families in cassandra
- How data stored inside graph databases and which read patterns it supports and how fast
- How good is oracle and in which state relational databases are now?