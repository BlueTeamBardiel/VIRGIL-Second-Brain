# advanced persistent threats

## What it is
Like a cat burglar who moves into your attic and lives there for months — studying your routines, copying your valuables slowly, and leaving no obvious trace — an APT is a prolonged, stealthy cyberattack where a well-resourced adversary establishes deep access and maintains it over an extended period. APTs typically involve nation-state or sophisticated criminal actors who prioritize stealth and data exfiltration over speed or disruption.

## Why it matters
The 2020 SolarWinds attack exemplifies APT methodology: attackers compromised the software build pipeline, embedded backdoor code (SUNBURST) into legitimate updates, and silently accessed networks across ~18,000 organizations — including the U.S. Treasury and DHS — for nearly nine months before discovery. This illustrates why signature-based detection alone fails; APTs use legitimate credentials, living-off-the-land techniques, and slow exfiltration to stay invisible.

## Key facts
- APTs follow a lifecycle: **Reconnaissance → Initial Compromise → Establish Foothold → Escalate Privileges → Lateral Movement → Exfiltration → Maintain Persistence**
- They commonly abuse **valid accounts and signed binaries** (LOLBins) to blend into normal traffic, defeating many endpoint controls
- **Dwell time** — the period between compromise and detection — historically averages over 200 days, giving attackers enormous opportunity
- Indicators of Compromise (IOCs) like unusual outbound DNS queries, beaconing at regular intervals, and large compressed archives signal APT activity in CySA+ scenarios
- Mitigation strategies include **network segmentation, privileged access workstations (PAWs), threat hunting, and User and Entity Behavior Analytics (UEBA)**

## Related concepts
[[threat intelligence]] [[lateral movement]] [[indicators of compromise]] [[privilege escalation]] [[defense in depth]]