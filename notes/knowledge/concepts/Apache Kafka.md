# Apache Kafka

## What it is
Think of Kafka like a massive post office with infinite mailboxes — producers drop letters into labeled slots (topics), and any number of subscribers can read those letters independently without removing them. Precisely: Apache Kafka is a distributed event streaming platform that enables high-throughput, fault-tolerant, real-time data pipelines by persisting messages in ordered, immutable logs across a cluster of brokers.

## Why it matters
Security teams use Kafka as the backbone of SIEM data pipelines — ingesting billions of firewall, endpoint, and application log events and routing them simultaneously to threat detection engines, cold storage, and alerting systems without data loss. However, a misconfigured Kafka cluster with no authentication (common in cloud deployments) exposes all that sensitive telemetry publicly, as demonstrated in 2019 when researchers found thousands of open Kafka brokers leaking internal application data and credentials on the public internet.

## Key facts
- Kafka organizes messages into **topics** divided into **partitions**; consumers track their position using **offsets**, meaning data is not deleted upon consumption — a forensic advantage and a data-exposure risk
- Default Kafka installations pre-2.0 had **no authentication or encryption** enabled; securing it requires SASL (authentication) and TLS (encryption in transit)
- **Authorization** is controlled via Kafka ACLs (Access Control Lists), which must be explicitly configured — misconfigurations can allow any consumer to read any topic
- Kafka is widely used inside **SIEM platforms** (Splunk, Elastic Security) and **SOAR pipelines** as a message bus, making it a high-value lateral movement target
- Data at rest in Kafka logs is **not encrypted by default** — disk-level encryption must be implemented separately to meet compliance requirements (PCI-DSS, HIPAA)

## Related concepts
[[SIEM]] [[Data Loss Prevention]] [[Encryption in Transit]] [[Access Control Lists]] [[Log Management]]