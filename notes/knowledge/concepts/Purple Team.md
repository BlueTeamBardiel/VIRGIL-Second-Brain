# Purple Team

## What it is
Like a sparring coach who works *with* both the boxer and their trainer simultaneously — Purple Team is the collaborative fusion of Red Team (attackers) and Blue Team (defenders) working together in real time to improve defenses, rather than operating in separate silos. It is not a permanent team but a *methodology* where offensive findings are immediately shared with defenders to tune detections and close gaps while the exercise is still running.

## Why it matters
During a Purple Team exercise at a financial firm, the Red Team successfully exfiltrated data using DNS tunneling — but instead of just reporting it post-engagement, they immediately showed the Blue Team exactly which packets to look for. The Blue Team updated their SIEM rules on the spot, and the Red Team attempted the same technique again to confirm the detection actually fired. This tight feedback loop compressed months of remediation into hours.

## Key facts
- Purple Team is a **methodology/mindset**, not a dedicated staffing role — organizations without large budgets achieve it by having Red and Blue collaborate directly
- The primary goal is **measurable improvement in detection and response capabilities**, validated by re-testing after fixes
- Purple Team exercises produce **MITRE ATT&CK-mapped coverage reports**, showing which techniques are detected vs. blind spots
- Differs from a standard penetration test: pentest = find vulnerabilities and report; Purple Team = find gap → fix → verify fix in continuous loop
- Tools like **Atomic Red Team** and **VECTR** are commonly used to execute and track Purple Team exercises

## Related concepts
[[Red Team]] [[Blue Team]] [[MITRE ATT&CK Framework]] [[Security Information and Event Management (SIEM)]] [[Penetration Testing]]