# CWE-400 Uncontrolled Resource Consumption

## What it is
Imagine a restaurant with unlimited free breadsticks — one bad actor orders 10,000 baskets, leaving nothing for paying customers. CWE-400 occurs when an application allows external input to dictate how much CPU, memory, disk, or network bandwidth it consumes, without enforcing any upper limit. The result is resource exhaustion that degrades or completely denies service to legitimate users.

## Why it matters
The 2016 Mirai botnet exploited IoT devices to flood targets with traffic, but many application-layer DoS attacks exploit CWE-400 more surgically — sending a single malformed request that triggers a server to allocate gigabytes of memory or spin in an infinite loop. A classic example is the "Billion Laughs" XML attack, where a 1 KB XML file causes a parser to expand into gigabytes of data by referencing nested entity definitions, crashing the server with a single request.

## Key facts
- **Four main resource types targeted:** CPU cycles, heap/stack memory, file descriptors/disk space, and network sockets/bandwidth
- **Distinct from DoS vulnerabilities:** CWE-400 is the *root cause* (missing resource limits); DoS (CWE-730, CWE-770) describes the *impact*
- **ReDoS (Regular Expression DoS)** is a high-frequency CWE-400 variant — crafted input causes catastrophic backtracking in poorly written regex patterns
- **Mitigations include:** rate limiting, input size validation, timeouts, memory quotas, and connection pool limits — all enforced *server-side*
- **CVSS scoring note:** Exploitability is often rated High because unauthenticated remote attackers can trigger it with minimal effort

## Related concepts
[[Denial of Service Attack]] [[ReDoS]] [[XML Entity Expansion]] [[Rate Limiting]] [[CWE-770 Allocation of Resources Without Limits]]