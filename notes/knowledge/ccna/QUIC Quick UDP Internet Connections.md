# QUIC Quick UDP Internet Connections

## What it is

In StarCraft, a Terran player lifts off a Command Center and flies it across the map to a new mineral line — production never stops, the SCVs keep mining, the same building just changes location. That's exactly what QUIC does — your connection picks up and moves to a new network without tearing down and starting over.

**QUIC** is a transport-layer protocol built on UDP that integrates TLS 1.3 encryption, eliminates head-of-line blocking for multiplexed streams, and supports connection migration across IP changes.

## Why it matters

TCP + TLS requires multiple round trips before a single byte of data moves, and a single dropped packet stalls every multiplexed stream sitting behind it. On mobile networks where latency is high and IP addresses change every time you walk between Wi-Fi and LTE, this is misery. QUIC collapses the handshake, isolates streams, and survives network changes — which is why [[HTTP/3]] is built on it and not TCP. Exam angle: know that QUIC runs over **UDP port 443** and that HTTP/3 = HTTP over QUIC.

## Key facts

### Transport foundation

- Runs over [[UDP]], not [[TCP]] — uses **port 443** by default
- Implemented in **user space**, not the kernel, so protocol updates ship with the application
- Standardized in **RFC 9000** (2021)

### Integrated TLS 1.3

- [[TLS 1.3]] is **baked into QUIC** — not layered on top
- Encryption is mandatory; there is no unencrypted QUIC
- Both transport headers and payload are authenticated; most of the header is encrypted
- Compare to the legacy stack:

| Stack | Round trips to first byte |
|---|---|
| TCP + TLS 1.2 | 3 RTT |
| TCP + TLS 1.3 | 2 RTT |
| QUIC (new connection) | 1 RTT |
| QUIC (resumed, **0-RTT**) | 0 RTT |

### 0-RTT connection setup

- On **resumption**, client sends application data in the *first* packet using cached keys
- Trade-off: 0-RTT data is **replayable** — only safe for idempotent requests
- New connections still need 1-RTT for the cryptographic handshake

### No head-of-line blocking

- TCP delivers bytes in order — one lost segment stalls *every* HTTP/2 stream sharing the connection
- QUIC gives each **stream** its own delivery context; loss on stream 3 does not block stream 7
- This is the single biggest reason [[HTTP/3]] abandoned TCP

### Connection migration

- Connections are identified by a **Connection ID**, not the 4-tuple (src IP, src port, dst IP, dst port)
- When your phone roams from Wi-Fi to cellular, the IP changes but the Connection ID does not — session survives
- TCP would have required a full reconnect and TLS handshake

### Why HTTP/3 chose QUIC

1. Eliminates head-of-line blocking that crippled [[HTTP/2]] multiplexing
2. Faster handshakes on lossy mobile networks
3. Connection migration matches modern device behavior
4. Encryption is non-optional — middleboxes cannot meddle with the protocol, avoiding the **ossification** that froze TCP

### Operational notes

- Some enterprise firewalls block UDP/443 by default — browsers fall back to HTTP/2 over TCP
- Harder to inspect: traditional [[deep packet inspection]] tools see encrypted UDP and little else
- Cisco devices increasingly recognize QUIC in NBAR2 application classification:

```
show ip nbar protocol-discovery
class-map match-any QUIC-TRAFFIC
 match protocol quic
```

## Related concepts

[[HTTP/3]] · [[TLS 1.3]] · [[UDP]] · [[TCP]] · [[HTTP/2]] · [[Head-of-line blocking]] · [[NBAR2]]

---
*Source: VIRGIL knowledge base — 2026-05-07*