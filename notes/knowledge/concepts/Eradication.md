# Eradication

## What it is
Like a surgeon removing a tumor — containment stops the bleeding, but eradication cuts out the root cause entirely. Eradication is the incident response phase where you eliminate the threat actor's foothold: deleting malware, removing backdoors, patching the exploited vulnerability, and resetting compromised credentials. It follows Containment and precedes Recovery in the NIST/SANS IR lifecycle.

## Why it matters
During the 2020 SolarWinds supply chain attack, organizations that merely isolated affected systems without performing thorough eradication left dormant SUNBURST backdoors embedded in their environments. Attackers had planted multiple persistence mechanisms, meaning incomplete eradication allowed re-compromise the moment systems were brought back online — illustrating why rushing to Recovery without proper eradication is dangerous.

## Key facts
- Eradication is **Phase 4** in the SANS 6-step IR model (Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned)
- Common eradication tasks: reimaging compromised hosts, removing malicious scheduled tasks/registry keys, revoking stolen certificates, and patching CVEs used for initial access
- **Persistence mechanisms** (registry run keys, cron jobs, web shells) must be explicitly hunted and removed — simply killing a process is NOT eradication
- Threat hunting during eradication should use IOCs from the Containment phase to find lateral movement artifacts across the entire environment
- Eradication without root cause analysis risks **re-infection** — you must know *how* the attacker got in before declaring the environment clean

## Related concepts
[[Incident Response Lifecycle]] [[Containment]] [[Recovery]] [[Persistence Mechanisms]] [[Indicators of Compromise]]