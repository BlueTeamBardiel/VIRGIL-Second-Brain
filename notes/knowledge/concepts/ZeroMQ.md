# ZeroMQ

## What it is
Think of it like a postal system baked directly into your application — no post office building required, just drop a letter in a socket and it appears at the destination. ZeroMQ (ØMQ) is a high-performance asynchronous messaging library that provides socket-like abstractions for passing messages between processes, threads, or machines without requiring a dedicated message broker. It supports patterns like pub/sub, push/pull, and request/reply natively in code.

## Why it matters
Attackers targeting industrial control systems and financial trading platforms increasingly exploit misconfigured ZeroMQ endpoints because, unlike HTTP, ZeroMQ has **no built-in authentication or encryption** by default — a process binding to `tcp://*:5555` accepts connections from anyone. In 2019, researchers found exposed ZeroMQ sockets in SCADA environments accepting arbitrary command messages with zero validation, enabling remote manipulation of physical processes. Defenders must explicitly layer CurveZMQ (elliptic-curve encryption) or GSSAPI onto sockets, since the library itself won't protect you.

## Key facts
- ZeroMQ operates on **transport-agnostic** sockets: TCP, IPC (inter-process), in-process, and multicast (EPGM) are all supported
- **No authentication or encryption by default** — CurveZMQ must be manually configured using Curve25519 key pairs
- Supports four primary messaging patterns: **Req/Rep, Pub/Sub, Push/Pull, and Dealer/Router**
- Exposed ZeroMQ ports (commonly **5555, 5556**) are actively scanned by Shodan; misconfigured nodes are a real-world attack surface
- Unlike traditional message queues (RabbitMQ, Kafka), ZeroMQ is **brokerless** — peers connect directly, reducing infrastructure but increasing endpoint exposure risk

## Related concepts
[[Message Queue Security]] [[CurveZMQ]] [[SCADA Security]] [[Network Socket Hardening]] [[Shodan Reconnaissance]]