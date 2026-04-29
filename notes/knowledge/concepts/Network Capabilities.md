# Network Capabilities

## What it is
Like a Swiss Army knife issued to a specific soldier rather than the full armory, Linux capabilities slice root's omnipotent privileges into discrete, assignable units. Specifically, `CAP_NET_RAW` allows raw socket access, `CAP_NET_BIND_SERVICE` allows binding to ports below 1024, and `CAP_NET_ADMIN` allows interface configuration — each grantable independently without giving full root.

## Why it matters
In a 2022-era container escape scenario, a misconfigured Docker container granted `CAP_NET_ADMIN` to a web application process. An attacker who compromised that process used the capability to manipulate network interfaces and perform ARP spoofing *from inside the container*, pivoting laterally across the internal network — a privilege escalation that wouldn't have been possible without that single over-granted capability.

## Key facts
- Linux defines ~40 distinct capabilities; the three most security-relevant are `CAP_NET_RAW` (craft arbitrary packets, enables tools like `ping` and `tcpdump`), `CAP_NET_ADMIN`, and `CAP_NET_BIND_SERVICE`
- `CAP_NET_RAW` is frequently exploited for sniffing and spoofing attacks when granted to unprivileged processes
- Capabilities can be set on *files* (like SUID but granular) or *threads* (process-level); `getcap` and `setcap` are the primary Linux tools for auditing and configuring them
- CySA+ expects you to recognize over-granted capabilities as a misconfiguration vector, especially in containerized environments
- The principle of least privilege applied to capabilities means: if a service only needs to bind port 443, grant only `CAP_NET_BIND_SERVICE` — never full root

## Related concepts
[[Principle of Least Privilege]] [[Linux Privilege Escalation]] [[Container Security]] [[SUID/SGID Permissions]]