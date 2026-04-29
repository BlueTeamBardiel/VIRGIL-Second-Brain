# Monolithic Architecture

## What it is
Imagine a Swiss Army knife where all the tools are fused together — if the corkscrew breaks, you lose the scissors too. A monolithic architecture is a software design pattern where all components of an application (UI, business logic, data access) are built and deployed as a single, tightly coupled unit. There are no independent services; every function lives inside one executable or codebase.

## Why it matters
When attackers compromised the Equifax application server in 2017, the monolithic design meant a single Apache Struts vulnerability exposed the entire data pipeline — credit records, SSNs, and PII all reachable from one entry point. A successful exploit didn't just breach one service; it handed attackers the keys to the entire kingdom because business logic, database credentials, and data processing were inseparable within the same process.

## Key facts
- **Blast radius is large**: A single RCE or privilege escalation in a monolith can compromise all application functionality simultaneously
- **Attack surface is concentrated**: One codebase means one patching cycle; unpatched libraries affect the entire application, not just one service
- **Harder to apply least privilege**: Because components share memory and execution context, isolating sensitive operations is architecturally difficult
- **Logging and monitoring challenges**: Security events from different functions may blend into a single log stream, complicating SIEM correlation and incident response
- **Contrasts with microservices**: Microservices allow blast-radius containment; a compromised payment service doesn't automatically expose the authentication service

## Related concepts
[[Microservices Architecture]] [[Attack Surface]] [[Least Privilege]] [[Defense in Depth]] [[Secure Software Development Lifecycle]]