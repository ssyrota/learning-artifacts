**Application types:**

*Compute-intensive -* challenge in parallelizing some very large computation

*Data-intensive -* when data management is one of the primary challenges in developing the application:

- storing and processing large data volumes
- manage changes to data
- ensuring consistency in face of failures and concurrency
- making sure services is highly available

<br/>

**Data warehouse vs data lake**

*Data warehouse -* OLAP database with data from business, has SQL interface

*Data lake* - centralized data repository that holds copy of any data which may be useful for analytics to perform any operations, like feature engineering using python. 

Often data warehouses can store aggregated(some data dropped) - for data scientists the messy data is better than lost. That's why data lakes should store all data without managing schema tightly. Data stored "just in case somebody would need it". Mess in schema is tolerated to make life of developers less painful.

Systems of record and derived data

*System of record -* source of truth, e.g. event, user input, created_at

*Derived data systems -* result of taking data from system of record and processing it in some way.

<br/>

**Cloud vs Self-Hosting**

> The received management wisdom is that things that are a core competency or a competitive advantage of your organization should be done in-house, whereas things that are non-core, routine, or commonplace should be left to a vendor
> 

Cloud:
- Can scale machines fast
- Doesn’t require setup
- Lack of control - you cannot add feature
- If the service goes down - you wait
- Privacy concerns

Self-Hosting:
- Cheaper
- More control

Cloud(AWS) core services - CPU and storage are separated. EBS/S3 are differentiated from computing machines. This disaggregation introduces networking issues like overhead, latency and bandwidth.

<br/>

**Organization**

Traditionally people managing an organization's server side data infrastructure were known as *DBAs* or *system administrators*.

DevOps philosophy has guided trend of integration of roles of software developers and operations into teams with shared responsibility for both backend services and data infrastructure. Google implemented is as a *Site Reliability Engineers*.

The high-level goal of providing a reliable service remains the same, but process and tools are evolved.

DevOps/SRE philosophy places greater emphasis on:
- Automation - preferring repeatable processes over manual one-off jobs
- preferring ephemeral virtual machines and services over long running servers to think about fail-tolerance by design
- enabling frequent application updates
- learning from incidents
- preserving the organization's knowledge about the system, even as individual people come and go

<br/>

**Distributed vs single node**

*Distributed system* - a system that involves several machines communicating via a network.

Reasons to have distributed system:
- Inherited
- Requests between cloud services
- Fault tolerance
- Scalability and elasticity
- Latency
- Using specialized software
- Legal compliance
- Sustainability

Problems:
- Network: latency, overhead, limited bandwidth, failures
- Troubleshooting
- Data consistency

<br/>

**Microservices and Serverless**

Services:
- can be a client and a server
- often organization mirrors team organization
- microservice has small responsibility scope
- database is not shared(easy to change schema/performance troubleshoot)

To facilitate deployment and operations of services *orchestration framework* is required.


> Microservices are primarily a technical solution to a people problem: allowing different teams to make progress independently without having to coordinate with each other. 

**Cloud vs super computing**

Super computing(high-performance computing):
- used for computationally intensive scientific computing tasks
- runs large batch jobs with checkpoints, if node failures - the computing starts again after repair
- nodes communicate through shared memory with high bandwidth and low latency, assuming high level of trust
- regional distribution is not available


**Law**

> Once all the risks are taken into account, it might be reasonable to decide that some data is simply not worth storing, and that it should therefore be deleted. This principle of data minimization (sometimes known by the German term Datensparsamkeit) runs counter to the “big data” philosophy of storing lots of data speculatively in case it turns out to be useful in the future. But it fits with the GDPR, which mandates that personal data may only be collected for a specified, explicit purpose, that this data may not later be used for any other purpose, and that the data must not be kept for longer than necessary for the purposes for which it was collected.



**Further questions:**
- Can we have a hybrid of cloud and self-hosting for example kubernetes with self-hosted nodes and with aws managed nodes?
- How about hybrid of multiple clouds, not only most popular?
- How cheap can be cloud? 
- How much electricity self-host can require?
- What exactly is DevOps and SRE, to which extend SaaS software developers should know this?
- How organization works in software companies?
- What is GDPR/CCPA/EU AI Act and how it can be implemented, which businesses are applicable to implement it?
- What is Service Organization Control Type 2?