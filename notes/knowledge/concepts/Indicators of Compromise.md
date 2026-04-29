# Indicators of Compromise

## What it is
Like a burglar leaving muddy boot prints, a broken window latch, and a missing jewelry box — IoCs are the forensic breadcrumbs an attacker leaves behind after (or during) malicious activity. Precisely defined, Indicators of Compromise (IoCs) are observable artifacts or behaviors in a network or system that suggest with high confidence that a security breach has occurred or is actively occurring.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat hunters identified specific IoCs — including a backdoor DLL named `SolarWinds.Orion.Core.BusinessLayer.dll` with a known malicious hash, and C2 traffic to `avsvmcloud[.]com` — that allowed organizations to rapidly determine whether they were compromised and isolate affected systems before further lateral movement occurred.

## Key facts
- **Four main IoC categories:** file-based (hashes, malicious executables), network-based (IP addresses, domains, URLs), host-based (registry keys, suspicious processes), and behavioral (unusual login times, lateral movement patterns)
- **IoCs vs. IoAs:** IoCs are *retrospective* (evidence of past compromise); Indicators of Attack (IoAs) are *proactive* (detecting attacker behavior in real time before an objective is achieved)
- **MD5/SHA-256 hashes** are the most precise IoC type — one bit change produces a completely different hash, making them exact-match signatures
- **STIX/TAXII** is the standardized framework for structuring and sharing IoC data between organizations and threat intelligence platforms
- **Short shelf life:** IP addresses and domains used as IoCs can rotate within hours; hash-based IoCs are more durable but easily evaded by recompiling malware

## Related concepts
[[Threat Intelligence]] [[SIEM]] [[STIX/TAXII]] [[Indicators of Attack]] [[Threat Hunting]]