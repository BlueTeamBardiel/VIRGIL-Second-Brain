# EMQ EMQX Enterprise

## What it is
Think of it as a high-speed postal sorting facility for IoT devices — every sensor, camera, and controller gets its message routed instantly to the right destination at massive scale. EMQX Enterprise is a commercial, distributed MQTT broker built for industrial-grade deployments, capable of handling millions of concurrent device connections with persistent sessions, rule-based message routing, and built-in data integration pipelines.

## Why it matters
In a smart manufacturing environment, an attacker who gains access to an EMQX broker could intercept MQTT messages from PLCs and sensors — reading telemetry, injecting false commands, or disrupting production lines. Because EMQX supports authentication plugins, TLS mutual authentication, and ACL-based topic-level access control, misconfiguration (such as anonymous access left enabled) is a critical attack surface that security teams must audit in OT/ICS environments.

## Key facts
- EMQX uses the **MQTT protocol** (port 1883 for plaintext, 8883 for TLS), a lightweight publish-subscribe protocol common in IoT/ICS deployments
- Supports **authentication via username/password, X.509 client certificates, and JWT tokens** — each method carries distinct credential theft risks
- **Topic-level ACLs** control which clients can publish or subscribe to specific channels; overly permissive wildcard rules (`#`) are a common misconfiguration
- Default installations may enable **anonymous client access** — a Security+ red flag requiring explicit hardening before production deployment
- Built-in **rule engine** can forward messages to databases, Kafka, or HTTP endpoints, expanding the attack surface to downstream systems if not properly secured

## Related concepts
[[MQTT Protocol Security]] [[IoT Device Hardening]] [[Access Control Lists]] [[TLS Mutual Authentication]] [[OT/ICS Security]]