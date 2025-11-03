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

### Anomalies


### Isolation levels
Read committed isolation - 


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
- what types of transaction guarantees exist
- which implemented in popular DBS like pg/mongo/scylla/olap?
- how it stored in disk
- how to make distributed transaction - is it possible, if yes with which conditions?
- what is the future of transactions or it's just exist and doesn't need improvements?
- what is MVCC?
