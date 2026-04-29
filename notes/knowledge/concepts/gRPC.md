# gRPC

## What it is
Like a hyper-efficient postal system where both sender and receiver agree in advance on the exact envelope shape and contents (no guessing, no waste), gRPC is a high-performance Remote Procedure Call framework developed by Google that uses Protocol Buffers for serialization and HTTP/2 as its transport layer. It allows services to call functions on remote machines as if they were local, with strict contract enforcement via `.proto` schema files.

## Why it matters
Because gRPC traffic rides on HTTP/2 and uses binary serialization, traditional web application firewalls (WAFs) and deep packet inspection tools that expect JSON or XML will **miss malicious payloads entirely** — an attacker can exfiltrate data or issue commands through gRPC endpoints that security monitoring blindly ignores. This was a noted concern in cloud-native microservice environments where gRPC is common (Kubernetes, service meshes) but SIEM visibility tools haven't been updated to decode binary protobuf traffic.

## Key facts
- gRPC uses **HTTP/2** by default, enabling multiplexed streams, bidirectional streaming, and header compression (HPACK) — all of which complicate traffic inspection
- **Protocol Buffers (protobuf)** are binary, not human-readable; captured traffic requires the original `.proto` schema to decode, hindering incident response
- Common attack surface includes **insecure `.proto` definitions**, missing authentication (gRPC has no auth by default — TLS and token auth must be explicitly added), and **server reflection** being left enabled in production (exposes full API schema to unauthenticated callers)
- gRPC supports **four communication patterns**: unary, server streaming, client streaming, and bidirectional streaming — each has different abuse potential
- Misconfigurations in **gRPC-Web** (the browser-compatible proxy layer) can introduce CORS vulnerabilities similar to traditional REST APIs

## Related concepts
[[HTTP/2]] [[Protocol Buffers]] [[API Security]] [[Service Mesh]] [[TLS Mutual Authentication]]