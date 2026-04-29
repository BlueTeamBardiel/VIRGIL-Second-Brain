# MITRE ATT&CK T1033

## What it is
Like a burglar checking the mailbox name to confirm they've broken into the right house, T1033 (System Owner/User Discovery) describes an attacker querying a compromised system to identify who is logged in, who owns the machine, and what user context they're operating under. Attackers use this to orient themselves after initial access and determine whether they've landed on a high-value target or need to move laterally.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used discovery techniques including user enumeration to confirm they had reached privileged administrator accounts before deploying additional payloads — avoiding noisy actions on low-value endpoints. Defenders monitoring for unusual execution of `whoami`, `query user`, or `net user` commands — especially from non-interactive processes — can catch this reconnaissance phase early and disrupt the kill chain before escalation.

## Key facts
- Common commands used: `whoami`, `who`, `w`, `query user /server`, `net user`, `id` (Linux), and `Get-LocalUser` (PowerShell)
- Typically occurs immediately after initial access as part of the broader **Discovery** tactic (TA0007)
- Attackers use results to decide whether to escalate privileges, pivot laterally, or deploy final-stage payloads
- Execution of `whoami` by SYSTEM-level processes or web server processes (e.g., IIS, Apache) is a high-fidelity detection indicator
- Maps to **CySA+** objectives around threat hunting and behavioral analytics — knowing *who* ran a discovery command matters as much as *what* was run

## Related concepts
[[Privilege Escalation]] [[Lateral Movement]] [[System Information Discovery T1082]] [[Account Discovery T1087]] [[Windows Command Shell]]