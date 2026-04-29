# RabbitMQ

## What it is
Think of RabbitMQ like a postal sorting office: applications drop messages into labeled bins (queues), and other applications pick them up when ready — neither side needs to be present simultaneously. Precisely, RabbitMQ is an open-source message broker that implements the Advanced Message Queuing Protocol (AMQP), enabling asynchronous communication between distributed application components. It decouples producers and consumers so systems can scale and fail independently.

## Why it matters
In 2023, misconfigured RabbitMQ instances exposed to the internet without authentication allowed attackers to inject malicious messages into application queues, triggering downstream code execution in processing workers — effectively achieving remote code execution without touching the web tier directly. Defenders must ensure RabbitMQ's management console (default port 15672) and AMQP port (5672) are never publicly exposed and that default credentials (`guest`/`guest`) are rotated immediately on deployment.

## Key facts
- **Default credentials vulnerability**: RabbitMQ ships with `guest`/`guest` restricted to localhost, but misconfigurations frequently expose authenticated access using these credentials remotely.
- **Attack surface ports**: AMQP runs on **5672** (unencrypted) and **5671** (TLS); the management UI runs on **15672** — all should be firewalled from untrusted networks.
- **Message injection attacks**: An attacker with queue write access can poison messages to manipulate business logic, trigger deserialization flaws, or cause denial-of-service via queue flooding.
- **Insecure deserialization risk**: Consumer applications that deserialize message payloads without validation are vulnerable to RCE if an attacker controls queue input (CWE-502).
- **TLS enforcement**: Without TLS on AMQP connections, credentials and message contents traverse the network in plaintext, enabling credential harvesting via packet capture.

## Related concepts
[[Message Queue Security]] [[Insecure Deserialization]] [[Default Credentials]] [[Network Segmentation]] [[AMQP Protocol]]