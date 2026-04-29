# foothold

## What it is
Like a climber jamming one hand into a crack in a cliff face — not at the summit yet, but no longer falling — a foothold is the attacker's first stable, persistent position inside a target environment. Technically, it's the initial execution capability established on at least one compromised host after exploitation, from which all further lateral movement and privilege escalation begins.

## Why it matters
In the 2020 SolarWinds attack, threat actors established a foothold by inserting malicious code into the Orion software build pipeline, giving them a beachhead inside thousands of networks simultaneously. Defenders who monitor for unusual outbound connections or unexpected process spawning from trusted software can detect footholds before attackers weaponize them into full-scale breaches.

## Key facts
- A foothold is distinct from initial access — it implies *persistence*, meaning the attacker survives a reboot or credential rotation
- Common foothold mechanisms include web shells, scheduled tasks, registry run keys, and reverse shells calling back to C2 infrastructure
- MITRE ATT&CK maps foothold establishment primarily under the **Persistence** and **Command and Control** tactics
- Defenders measure "dwell time" — the gap between foothold establishment and detection — as a key incident response metric (industry average historically ~200 days)
- Footholds are often "low and slow," deliberately avoiding noisy actions to evade SIEM alerts and EDR behavioral rules

## Related concepts
[[initial access]] [[lateral movement]] [[command and control]] [[persistence]] [[privilege escalation]]