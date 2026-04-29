# AdminServer

## What it is
Think of AdminServer as the building superintendent's master control room — it holds the keys to every apartment and can reconfigure the entire building's plumbing from one desk. In WebLogic and similar Java EE application server environments, the AdminServer is the central management node that controls configuration, deployment, and monitoring of all managed servers in a domain. It exposes a web-based console (typically on port 7001/7002) and serves as the single authoritative source for the domain's configuration data.

## Why it matters
In 2020, Oracle WebLogic's AdminServer was the target of CVE-2020-14882, a critical unauthenticated RCE vulnerability (CVSS 9.8) that allowed attackers to execute arbitrary commands by simply sending a crafted HTTP GET request — no credentials required. Threat actors actively chained this with CVE-2020-14883 to achieve full server compromise, deploying cryptominers and ransomware across enterprise environments running unpatched WebLogic instances.

## Key facts
- Default AdminServer console ports: **7001** (HTTP) and **7002** (HTTPS) on Oracle WebLogic
- AdminServer compromise = domain-wide compromise — all managed servers inherit configuration from it
- CVE-2020-14882 required **no authentication** and affected WebLogic versions 10.3.6.0 through 14.1.1.0
- AdminServer consoles left internet-facing violate the principle of **least exposure** and represent a critical misconfiguration
- Disabling or restricting the AdminServer console via `console.address` binding to localhost is a hardening best practice per CIS benchmarks

## Related concepts
[[Remote Code Execution]] [[Attack Surface Reduction]] [[Privileged Access Management]] [[CVE Exploitation]] [[Application Server Hardening]]