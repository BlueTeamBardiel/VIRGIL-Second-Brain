# Webhooks

## What it is
Think of a webhook like a doorbell instead of a peephole — rather than your app constantly checking "did something happen yet?", the external service rings you the moment it does. Precisely: a webhook is an HTTP callback mechanism where a server sends an automated POST request to a predefined URL when a specific event occurs, enabling real-time, event-driven communication between systems.

## Why it matters
Attackers frequently abuse webhook endpoints as exfiltration channels — malware can POST stolen credentials or keylogger output to an attacker-controlled webhook URL hosted on legitimate services like Discord or Slack, bypassing egress filters that whitelist those domains. Defenders must monitor for unusual outbound POST traffic to collaboration platforms and validate webhook payloads using HMAC signatures to ensure requests are authentic and untampered.

## Key facts
- Webhooks are **unauthenticated by default** — anyone who discovers the endpoint URL can send malicious POST requests unless signature validation (typically HMAC-SHA256) is implemented
- **Secret tokens** embedded in HTTP headers (e.g., `X-Hub-Signature`) allow the receiver to verify the payload hasn't been forged or tampered with
- Webhook endpoints that blindly follow redirect responses can be exploited in **SSRF (Server-Side Request Forgery)** attacks to probe internal network resources
- **Replay attacks** are a real risk — without timestamp validation and nonce checking, a captured webhook payload can be resent to trigger repeated actions
- Legitimate services like GitHub, Stripe, and PagerDuty use webhooks extensively, making them attractive **LOLBAS-style** exfiltration cover for attackers blending into normal traffic

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[HMAC Authentication]] [[Data Exfiltration]] [[API Security]] [[Event-Driven Architecture]]