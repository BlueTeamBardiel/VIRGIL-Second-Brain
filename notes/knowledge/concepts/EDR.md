# EDR

## What it is
Think of EDR like a flight data recorder combined with an active co-pilot — it doesn't just log what happened, it can grab the controls mid-flight to prevent a crash. Endpoint Detection and Response (EDR) is a security solution that continuously monitors endpoint activity (processes, registry changes, network connections, file writes), records telemetry for forensic analysis, and can automatically contain threats in real time.

## Why it matters
During the 2020 SolarWinds supply chain attack, attackers used a legitimate signed DLL to execute malicious code — bypassing traditional AV entirely. Organizations with mature EDR deployments were able to detect the anomalous *behavior* (unusual parent-child process relationships, unexpected LDAP queries from Orion) even when signatures were useless, giving incident responders the telemetry needed to scope the breach and isolate affected hosts.

## Key facts
- EDR differs from traditional AV by focusing on **behavioral analysis** rather than signature matching — it asks *what is this process doing*, not *what does this file look like*
- Core capabilities: **threat detection, investigation, and response** — the three pillars tested on CySA+; response actions include host isolation, process killing, and rollback
- EDR agents typically run at **kernel level** to intercept system calls before malware can hide activity (rootkit detection)
- **MITRE ATT&CK** framework is commonly used by EDR platforms to tag detected behaviors to specific adversary techniques (e.g., T1055 Process Injection)
- EDR generates massive telemetry — organizations often pair it with a **SIEM** for correlation and long-term storage; this combination is called XDR when natively integrated

## Related concepts
[[SIEM]] [[XDR]] [[Threat Hunting]] [[MITRE ATT&CK]] [[Indicators of Compromise]]