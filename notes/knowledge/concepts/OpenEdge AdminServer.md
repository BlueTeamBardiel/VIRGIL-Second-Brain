# OpenEdge AdminServer

## What it is
Think of it as the master key cabinet for a factory floor — whoever controls it can unlock every machine without touching them individually. OpenEdge AdminServer is a management service in Progress OpenEdge application environments that handles remote administration of databases and application servers, typically listening on TCP port 20931 by default.

## Why it matters
In 2023, CVE-2024-1403 exposed a critical authentication bypass in OpenEdge AdminServer where remote attackers could gain unauthenticated administrative access simply by sending crafted requests — no credentials required. This allowed full compromise of backend databases and application servers, illustrating how management plane services that skip authentication checks become the shortest path to total environment takeover.

## Key facts
- Default listening port is **20931/TCP**; exposure of this port to untrusted networks is a critical misconfiguration
- CVE-2024-1403 carries a **CVSS score of 10.0**, representing complete authentication bypass allowing remote code execution
- AdminServer manages OpenEdge NameServer, DataServers, and WebSpeed brokers — compromising it grants lateral control across the entire Progress stack
- The service is commonly found in **healthcare, finance, and ERP environments** running Progress/OpenEdge business applications
- Defensive remediation requires network-level controls (firewall rules restricting port 20931), patching to OpenEdge **12.2.13+ or 11.7.18+**, and disabling remote admin if unnecessary

## Related concepts
[[Authentication Bypass]] [[Default Port Exposure]] [[Remote Code Execution]]