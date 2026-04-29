# NO_PROXY

## What it is
Like a VIP express lane at the airport that bypasses the security checkpoint entirely, `NO_PROXY` is an environment variable that tells applications which hostnames or IP ranges should connect *directly* — skipping the configured proxy server. It is a comma-separated list of domains, IPs, or CIDR blocks that proxy-aware tools (curl, wget, Python requests) will exempt from routing through `HTTP_PROXY` or `HTTPS_PROXY`.

## Why it matters
In a penetration test or misconfiguration audit, an attacker who gains code execution on a server may find `NO_PROXY=10.0.0.0/8` set in the environment — revealing the internal network range and confirming that internal services are reachable without proxy inspection. This means traffic to those hosts also bypasses any proxy-based DLP, logging, or SSL inspection, creating a blind spot defenders may not realize exists.

## Key facts
- `NO_PROXY` (and its lowercase `no_proxy`) is honored by most Unix tools and language libraries, but behavior varies — some tools only match exact hostnames, not subdomains or CIDR notation.
- A common misconfiguration is setting `NO_PROXY=localhost,127.0.0.1` while forgetting `0.0.0.0` or `::1`, allowing unexpected loopback traffic through the proxy.
- In container orchestration (Docker, Kubernetes), `NO_PROXY` must explicitly include cluster-internal DNS suffixes (e.g., `.svc.cluster.local`) or internal service calls route through the external proxy, breaking mTLS or leaking internal hostnames.
- From a threat-hunting perspective, `NO_PROXY` entries exposed via `/proc/<pid>/environ` or leaked in error messages can map internal network architecture without active scanning.
- `NO_PROXY` bypasses do **not** bypass firewall rules — they only affect application-layer proxy selection.

## Related concepts
[[HTTP_PROXY Environment Variable]] [[SSL Inspection]] [[Data Loss Prevention]] [[Container Security]] [[Environment Variable Exposure]]