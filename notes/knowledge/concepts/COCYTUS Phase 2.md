# COCYTUS Phase 2

## What it is
Like a burglar who has already picked the lock and is now quietly memorizing the floor plan before stealing anything, COCYTUS Phase 2 is the **post-exploitation reconnaissance and persistence establishment stage** within the COCYTUS attack framework — a structured intrusion methodology where the attacker, having achieved initial access, focuses on lateral movement mapping, credential harvesting, and implanting durable backdoors before executing the primary mission objective.

## Why it matters
In the 2020s-era APT campaigns targeting defense contractors, adversaries following similar phased intrusion models used this "quiet expansion" window — sometimes lasting weeks — to identify domain controllers and harvest Kerberos tickets via AS-REP roasting before any data exfiltration triggered alerts. Defenders who monitor only for initial compromise or final exfiltration miss the Phase 2 window entirely, which is precisely where dwell time becomes catastrophically expensive.

## Key facts
- Phase 2 activities typically include **privilege escalation, internal network scanning, credential dumping** (e.g., LSASS memory access), and C2 channel consolidation
- This phase corresponds to MITRE ATT&CK tactics: **Discovery (TA0007), Lateral Movement (TA0008), and Persistence (TA0003)**
- Attackers deliberately operate **below SIEM alert thresholds** during this phase — slow scanning, low-volume credential attempts, living-off-the-land binaries (LOLBins)
- Detection relies heavily on **behavioral analytics and EDR telemetry** rather than signature-based AV — a core CySA+ detection principle
- Mean dwell time during this phase historically averages **11–21 days** before discovery in enterprise environments (per Mandiant M-Trends data)

## Related concepts
[[Lateral Movement]] [[Credential Dumping]] [[MITRE ATT&CK Framework]] [[Persistence Mechanisms]] [[Living off the Land (LOLBins)]]