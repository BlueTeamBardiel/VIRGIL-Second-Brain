# gRPC Security

## What it is
Think of gRPC like a high-speed pneumatic tube system between buildings — incredibly fast and efficient, but if you don't lock the tube entrances, anyone can shove anything through. gRPC is a high-performance Remote Procedure Call framework developed by Google that uses HTTP/2 as its transport layer and Protocol Buffers (protobuf) for serialization. Its security posture depends heavily on TLS configuration, authentication mechanisms, and how services validate incoming calls.

## Why it matters
In 2023, researchers demonstrated that misconfigured gRPC microservices exposed in cloud environments accepted unauthenticated calls due to developers testing without TLS and forgetting to re-enable it before deployment. An attacker who discovers an exposed gRPC endpoint via port scanning (default port 50051) can invoke internal service methods directly — bypassing API gateways entirely — and trigger sensitive operations like user deletion or data exfiltration that were never meant to be externally reachable.

## Key facts
- gRPC uses **HTTP/2** by default, which supports multiplexed streams — this means a single connection can carry multiple simultaneous RPC calls, complicating traffic inspection for traditional firewalls
- **TLS is optional by default** in many gRPC implementations; developers must explicitly configure it, making misconfiguration a common attack surface
- Authentication is typically handled via **channel credentials** (TLS) and **call credentials** (tokens like JWT or OAuth2 metadata headers) — these operate at different layers
- **Protobuf deserialization attacks** are a real threat: malformed protobuf messages can cause excessive memory consumption or logic errors in poorly validated services
- gRPC services exposed without an **API gateway** or **service mesh** (like Istio with mTLS) lack centralized authentication, authorization, and rate limiting

## Related concepts
[[TLS/SSL]] [[API Security]] [[Mutual TLS (mTLS)]] [[Deserialization Attacks]] [[Microservices Security]]