Often software released using rolling updates. New features in app often change schema of storage.
With client-side your are with mercy of user, who can skip installing update.

There are forward and *backward* *compatibility*.

Different formats can be used for data **storage and for communication**: in databases, web services, REST APIs, remote procedure calls (RPC), workflow engines, and event-driven systems such as actors and message queues.

Often languages implement their serialization format, which is simple and bad for some reasons:
1. May be bloated, bad performance
2. Forward and backwward compatibility is bad

Json/XML/CSV have common problems:
1. numbers encoding, very big numbers cannot be parsed using js, but still available in json
2. no support of binary strings
3. no schema or complicated side solution


Avro vs protobuf:
Avro doesn't store field numbers and types, only length. Data type can be read by using schema,
Application that reads avro encoded file needs to know writer schema and it should have reader schema.
Reader schema tells which fields application needs, the avro library must convert object from writer to reader schema.

>With Avro, forward compatibility means that you can have a new version of the schema as writer and an old version of the schema as reader. Conversely, backward compatibility means that you can have a new version of the schema as reader and an old version as

One advantage of Avro’s approach, compared to Protocol Buffers, is that the schema doesn’t contain any tag numbers

Modes of dataflow:
- Via databases
- Service calls
- Workflow engines
- Async messages


TODO:
- idempontency in requests
- rpc and rest in web
