# throughput

## What it is
Like water flowing through a pipe, throughput measures not just whether data *can* travel, but how much of it actually *moves* per second under real conditions. Precisely defined, throughput is the actual rate of successful data transfer across a network path, measured in bits per second (bps), distinct from theoretical bandwidth which represents maximum capacity. Latency, packet loss, and congestion all cause throughput to fall below the advertised bandwidth ceiling.

## Why it matters
In a volumetric DDoS attack, an attacker floods a target with junk traffic to saturate available bandwidth, collapsing legitimate throughput to near zero — the pipe is full, but none of the water is useful. Defenders use baseline throughput measurements to detect anomalies: a sudden spike or unexpected drop in measured throughput can be the first observable indicator of an ongoing flood attack or network bottleneck introduced by malware. QoS (Quality of Service) policies prioritize critical traffic flows to preserve throughput for essential services even under load.

## Key facts
- **Throughput ≠ bandwidth**: Bandwidth is the maximum theoretical capacity; throughput is what you actually achieve after accounting for overhead, retransmissions, and congestion.
- **Measured in bps**: Common units are Kbps, Mbps, Gbps; Security+ expects you to distinguish this from latency (time delay) and jitter (latency variability).
- **DDoS impact**: Volumetric DDoS attacks specifically target throughput exhaustion by overwhelming link capacity, making availability the CIA triad element at risk.
- **Encryption overhead reduces throughput**: VPN tunnels and TLS add packet overhead, measurably lowering effective throughput — a design factor in secure network architecture.
- **Baseline monitoring**: Establishing normal throughput baselines is a core CySA+ detection technique; deviations trigger alerts in SIEM and network behavior analysis tools.

## Related concepts
[[bandwidth]] [[denial-of-service]] [[network-baseline]] [[quality-of-service]] [[latency]]