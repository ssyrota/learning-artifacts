Things that I'm interested in message broker or event streaming platforms:
1. Throughput and latency
2. Routing
3. Acknowledgements
4. Persistence
5. Horizontal scalability and drop of performance, availability
6. Advanced stream processing(multi-topic transactions maybe)
7. Security
8. How system acts on overload/critical situations(no free disk)


Can have simple queue with name.

By default rabbitmq when sends message automatically acknowledges it.

**Work queue**

> The assumption behind a work queue is that **each task** is delivered to **exactly one worker**

Queue can be marked as durable to store on disk, also the messages must be marked persistent too. Each message doesn't trigger `fsync(2)`, so there is a chance that message will be lost.(read *publisher confirms*)

By default on multiple consumers "round robin" used to route pushed messages. To make dispatching more fair, `prefetch count` may be set to 1, to limit count of unacknowledged messages per consumer.


**Publish/Subscribe**

To decouple consumer from producer, consumer sends messages to *exchange*. The exchange must know exactly what to do with a message it receives:
- Should it be appended to a particular queue? 
- Should it be appended to many queues? 
- Should it get discarded?

The rules for that are defined by the *exchange type*.
There are a few exchange types available: `direct`, `topic`, `headers` and `fanout`.

There are may be several exchanges per rabbitmq instance.(like topics inside kafka)

*Fanout* - broadcasts messages to all queues he knows.

Producer can publish to exchange and set "routing key". 
The consumer may connect to empty name auto-deletable queue(rabbitmq will set random name) to subscribe to new messages.

To make exchange know about queue, the `binding` must be used.

<br/>

*Direct* - exchange sends message to queues which binding matches routing key.

*Topic exchange* - another flexible routing scheme with domain-like routing.


*RPC routing* - requests are sent via one queue, responses are received via callback queue with correlation-id.


## Streams


---

*TODO*:
- why do we need rabbitmq when we have kafka? 
  - Latency and pull/push difference. 
  - Kafka producer must know queue which it would send message(apparently rabbitmq producers also must set some info to make exchange apply rules)
  - Acknowledgments in kafka made by offsets(problem with 1 failed message being repeatedly sent)