## Transaction

Transactions are an abstraction layer that allows an application to pretend that certain concurrency problems and certain kinds of hardware and software faults don’t exist

## ACID

Atomicity(specifically *abortability*) - if the writes are grouped together intro an atomic transaction,
and the transaction cannot be completed due to a fault, then database must discard
or undo any writes it has made so far in that transaction. 
**User should not worry about partial failure.**

Consistency - after transaction database being in a "good state".(e.g. it doesn't violate
constraints)

Isolation - concurrently executing transactions are isolated from each other. Transaction A cannot see
data changed by transaction B if transaction B is still executing.
More classic database books call this serializability

Durability - once transaction committed successfully, any data it has written will not be forgotten, even
if there is a fault or crash.(of course if disk is destroyed, data will be lost)


Distributed databases like ScyllaDB provide light-weight transactions for single object update.

## Weak transaction isolation

Weak isolation means that transaction will have isolation if specific cases of events intersection(events are writes and reads of one or many records from different transactions).

### Anomalies

*Dirty read* - one transaction reads resulted update of another NOT committted transaction.

*Dirty write*:
Two transactions A and B can make two writes to different tables at the same id W1(first table) and W2(second table).

Dirty write is situation of events:
AW1
BW1
BW2(and commit)
AW2(and commit)

Resulting records:
BW1
AW2

The update AW1 is lost.


*Read skew*(or read timing anomaly) - ![read skew](./read_skew.png "Read skew")
In the process of transaction **one record**, which it queries may have changed and committed from another transaction, which is not okay if several records have connection.

This skew is critical for making backups, analytic queries and integrity checks, transaction correctness.

### Isolation levels

#### *Read committed isolation*:
1. When reading from the database, transaction will see only committed data(no dirty reads)
2. When writing to the database, transaction will only overwrite data that has been committed(no dirty writes)
However, *read committed* does not prevent race condition on read-write counters.(Picture read_write_counters.png)

Preventing dirty writes often implemented as row-based locks. Only one transaction can acquire lock at a time(which may cause deadlock or error).
Dirty reads is prevented by using latest committed version of row(which doesn't have lock).

When isolation only prevents dirty-writes it's called *Read uncommitted isolation*


#### *Snapshot isolation or Repeatable Read(named by postgres)*

Goal is to prevent *read skew*. Idea is that transaction reads from *consistent snapshot* of database.

**MVCC(multi-version concurrency control) as implementation**

Key principle - readers never block writers, and writers never block readers.

To make it possible database need to keep several different committed versions of a row, because
various in-progress transactions may need to see the state of database in a different point of time.

In PostgreSQL:
1. When transaction is started it receives txid(always increasing integer ID)
2. When transaction writes anything to the db, the data it writes tagged with the transaction ID of the writer.
3. Each row has inserted_by_txid and deleted_by_txid(initially empty). 

Postgres storage is append-only so old rows deleted with autovacuum process when it's certain that no transaction
can any longer access the deleted or overwritten data.

> What if tx 1 started and tx 2 started too, and tx2 reads data and then tx1 updates data and tx2 reads data again. 
What happens then?

Well, to prevent this there are visibility rules for transactions:
1. At the beginning of current transaction - it receives list of currently active transactions and ignores data written by them
2. Also transaction ignores all data with txid bigger than it's own
3. The rollbacked transactions data ignored too
4. Any other data is visible for transaction


#### **Preventing lost updates**

The problem with counters example is the "read and modify" approach, many databases support atomic operations.
Another approach is to exclusively lock object before "read and modify" approach, so any other transaction cannot infer.

Another cool way is when database itself provides **automatically detecting lost updates** has occurred and aborts the offending transaction. Postgres does it with repeatable read. MySQL doesn't detect lost updates in repeatable reads.

Databases without transactions provide "compare and set" conditional writes, which is atomic "compare and swap"
The approach of "compare and swap" with version checking called *optimistic locking*, PostgreSQL uses *pessimistic locking*, which actually locks the record

#### **Write skew and phantoms**
![write skew](./write_skew.png)

While lost updates is about non-commutative update operations on one record. Write skew is when transactions read the same objects and then update some of those objects(different transactions may update different objects).

When transactions update one object - possible anomalies are: *dirty write or lost update*.

Write skew doesn't automatically detected in Postgres repeatable read. It may be prevented by using constraints.

Possible solution is to lock all rows returned by query:
```sql
BEGIN TRANSACTION;

SELECT * FROM doctors
  WHERE on_call = true
  AND shift_id = 1234 FOR UPDATE;

UPDATE doctors
  SET on_call = false
  WHERE name = 'Aaliyah'
  AND shift_id = 1234;

COMMIT;
```

`FOR SHARE` may be used to make a read-lock.

1. A `SELECT` query checks whether some requirement is satisfied
2. Depending on result application decides to continue
3. It makes write and commits, the effect of write changes the precondition. Another concurrent transaction would not see committed write and decision step would be skewed.

##### Phantoms causing write skew

Locking rows from `SELECT` statement may help, **however** the absence of record cannot be locked. 
This effect, where a write in one transaction changes the result of a search query in another transaction, is called a phantom.

Possible solution is to create a table with artificial objects to attach locks(in a booking case - table with time slots), when transactions would have **materializing conflict**.

<br/>

#### Serializability

It's great, but not anybody uses it. Implementations:

**Actual serial execution**

Redis, VoltDB, Datomic uses this approach.

Faster than may seem, because often data is cached in memory.

Systems with single-threaded serial transaction processing don’t allow interactive multi-statement transactions because of dramatically large networking latency. 

Instead, the application must either limit itself to transactions containing a single statement, or submit the entire transaction code to the database ahead of time, as a *stored procedure*.

<br/>

**Two-phase locking(2PL, not confuse with two-phase commit)**

Used for serializable isolation level in MySQL, SQL Server

Several transactions are allowed to concurrently read the same object as long as nobody is writing to it. When anyone wants to write an object, exclusive lock is required:
1. If transaction A reads object and transaction B want to update it, transaction B must wait until A completed.
2. If transaction A writes an object and transaction B want to read the object, B must wait until A is completed.

Each object has *multi-reader single-writer lock*.

> **KEY NOTE**: After a transaction has acquired the lock, it must continue to hold the lock until the end of the transaction. For example read skew becomes impossible

Downside of having so much locks - bad performance and common deadlocks.

*Prevented anomalies with two-phase locks:*
- Dirty write/read
- Read skew
- Lost updates
- Write skew

To prevent phantoms there are **predicate locks** or **index-range locks**.

<br/>

**Serializable Snapshot Isolation(SSI)**

Used in PostgreSQL, CockroachDB.

**Key idea** is preserve snapshot isolation and add an algorithm of detection of the write skew and phantoms, with optimistic locking, algorithm evaluated at the commit-time. Algorithm remembers which key ranges was read and if there are conflict between two transactions, latest is just aborted.


SSI is based on snapshot isolation—that is, all reads within a transaction are made from a consistent snapshot of the database.

On top of snapshot isolation, SSI adds an algorithm for detecting serialization conflicts among reads and writes, and determining which transactions to abort.

![ssi problem](./ssi_problem.png)

Transaction 43 reads snapshot version and ignores T42 result.

![ssi 2](./ssi_2.png)
<br/>

**Performance**

> If the database keeps track of each transaction’s activity in great detail, it can be precise about which transactions need to abort, but the bookkeeping overhead can become significant. Less detailed tracking is faster, but may lead to more transactions being aborted than strictly necessary.

### Real world example
> Flexcoin collapsed because of weak isolation bug - two transactions made SELECT balance as first statement
and then update it, in result - due to isolation level, balance get negative.

*X-ability*

**Serializability** - each transaction can pretend that it is the
only transaction running on the entire database. The database ensures that than all transactions are
complete - result is the same as if they had run serially or one after another, even if they have run
concurrently.
(Oracle is not serializable)

**Linearizability** - as soon as one client successfully completes a write, all clients reading from the database must be able to see the value just written.


**Single node transaction**

**Distributed transaction**


TODO:
- how to make distributed transaction - is it possible, if yes with which conditions?
- what is the future of transactions or it's just exist and doesn't need improvements?


## Distributed transactions

When a transaction involves multiple database nodes, it may commit on some and fail on others.
It's an *atomic commitment problem*.

2PC involves new entity - coordinator or *transactions manager*. Nodes are *participants* of transaction.
1. When application want to commit transaction coordinator sends *prepare* request  to each of the nodes.
2.1 If all participants respond with "yes", coordinator sends *commit* request
2.2 If any participant responds with "no", coordinator sends *abort* request to all nodes 

Before the moment participant responds "yes" to prepare request it checks constraints/conflicts/flushes to disk, just ensures that if or when *commit* request would arrive, participant would make commit fast.
However when coordinator fails, entire transaction may fail and state may become corrupted.

There are need of making distributed heterogeneous transactions, for example to implement *exactly once semantics* in message brokers
