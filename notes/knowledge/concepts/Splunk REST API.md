# Splunk REST API

## What it is
Think of Splunk like a massive library where a librarian manually pulls books for you — the REST API is the pneumatic tube system that lets external programs request and receive those books automatically, without human intervention. Precisely, the Splunk REST API is an HTTP-based interface that allows programmatic access to Splunk's search, indexing, alerting, and administrative functions using standard HTTP methods (GET, POST, DELETE) against endpoints on port 8089.

## Why it matters
During a SOC incident response, analysts use the Splunk REST API to automatically trigger searches and pull correlated log data into a SOAR platform like Phantom or Splunk SOAR, enabling automated playbook execution without manual dashboard interaction. Conversely, an attacker who compromises Splunk credentials can use the REST API to exfiltrate indexed logs containing credentials, PII, or network topology data — all without ever touching the Splunk UI, making detection harder.

## Key facts
- Default port is **8089** (management port); the web UI runs on 8000 — knowing the difference matters for firewall rules and threat hunting
- Authentication supports **session tokens**, **Basic Auth**, and **Splunk tokens** — compromised tokens grant full API access equivalent to the user's role
- The `/services/search/jobs` endpoint is the core of programmatic searching — attackers and defenders both use it to run SPL queries remotely
- **Role-Based Access Control (RBAC)** governs API permissions; the `admin` role can read all indexes, making privilege escalation to admin extremely high-value for attackers
- API calls can create or modify **saved searches and alerts**, meaning an attacker with write access could silence detection rules programmatically

## Related concepts
[[SOAR Platforms]] [[Security Information and Event Management (SIEM)]] [[API Authentication and Token Security]]