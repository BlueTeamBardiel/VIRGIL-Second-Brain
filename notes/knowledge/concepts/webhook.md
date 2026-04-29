# webhook

## What it is
Like a doorbell that *you* install at someone else's house so they ring *your* phone when a visitor arrives — a webhook is a user-defined HTTP callback that allows one application to automatically send real-time data to another when a specific event occurs. Rather than polling an API repeatedly, the source system pushes an HTTP POST request to a pre-configured URL the moment something happens.

## Why it matters
Attackers frequently abuse misconfigured webhooks to exfiltrate data or establish covert command-and-control channels — for example, malware installed on a victim machine can silently POST stolen credentials to an attacker-controlled HTTPS endpoint that looks like legitimate API traffic. Defenders must monitor outbound POST requests to unexpected external URLs and validate webhook endpoints using shared secrets or HMAC signatures to prevent webhook hijacking, where an attacker redirects event payloads to their own server.

## Key facts
- Webhooks operate over HTTP/HTTPS; **unauthenticated webhook endpoints** are a common vulnerability allowing anyone to forge event payloads and trigger unintended actions
- **HMAC-SHA256 signature verification** (e.g., GitHub's `X-Hub-Signature-256` header) is the standard defense to ensure payloads originate from a trusted source
- Webhook URLs leaked in public repositories or logs can be harvested for **data injection or denial-of-service** by flooding the endpoint with requests
- Because webhooks use standard HTTPS traffic, malicious outbound callbacks are difficult to distinguish from normal API calls — making **egress filtering and DLP** critical detection controls
- Webhook abuse is classified under **MITRE ATT&CK T1071.001** (Application Layer Protocol: Web Protocols) as a command-and-control technique

## Related concepts
[[API Security]] [[HMAC]] [[HTTP POST]] [[Data Exfiltration]] [[Command and Control]]