# SolarWinds Incident

## What it is
Imagine a trusted locksmith secretly copying every key they cut for 18,000 clients — not breaking in through the front door, but embedding access *into the key itself*. The SolarWinds incident was a supply chain attack (2020) where threat actors (APT29/Cozy Bear) compromised SolarWinds' Orion software build pipeline, injecting a backdoor called SUNBURST into legitimate, digitally-signed updates distributed to thousands of organizations worldwide.

## Why it matters
Because the malicious code arrived inside a *trusted, vendor-signed update*, traditional signature-based defenses were blind to it. Victims including the U.S. Treasury, DHS, and FireEye unknowingly installed the backdoor themselves — demonstrating that even rigorous patch management can become an attack vector when the upstream supplier is compromised.

## Key facts
- **SUNBURST** was the malware embedded in Orion DLL `SolarWinds.Orion.Core.BusinessLayer.dll`, dormant for ~14 days before activating to evade sandboxes
- Attackers used **DGA (Domain Generation Algorithms)** via `avsvmcloud[.]com` for C2 communication, blending into legitimate DNS traffic
- Approximately **18,000 organizations** received the trojanized update; roughly 100 were actively exploited for espionage
- The attack is attributed to **Russian SVR intelligence** (APT29/Cozy Bear), classified as an advanced persistent threat (APT) operation
- Detection came via **FireEye** discovering their own red team tools were stolen, triggering the broader investigation — a third-party discovery, not internal monitoring

## Related concepts
[[Supply Chain Attack]] [[Advanced Persistent Threat (APT)]] [[Indicators of Compromise (IoC)]] [[Domain Generation Algorithm (DGA)]] [[Trusted Execution and Code Signing]]