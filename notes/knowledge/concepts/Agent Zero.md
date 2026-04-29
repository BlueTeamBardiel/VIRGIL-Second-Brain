# Agent Zero

## What it is
Like a master key that unlocks every door in a building, Agent Zero refers to the initial compromised system or identity used as a launchpad to pivot deeper into a network. Precisely, it is the first foothold established by an attacker — the beachhead machine, account, or process from which lateral movement, privilege escalation, and further exploitation originate.

## Why it matters
In the 2020 SolarWinds supply chain attack, the build server acted as Agent Zero — once compromised, it silently injected malicious code into trusted software updates distributed to thousands of organizations worldwide. Defenders use this concept during incident response to identify the true patient zero, trace the kill chain backward, and close the initial access vector before containment efforts are undermined.

## Key facts
- Agent Zero is distinct from subsequent compromised hosts; identifying it is critical for accurate root cause analysis during forensic investigations
- Common Agent Zero establishment methods include spear phishing, exploitation of internet-facing services (VPNs, RDP), and supply chain compromise
- In MITRE ATT&CK, Initial Access (TA0001) tactics describe exactly how an Agent Zero is created — techniques include Valid Accounts, Exploit Public-Facing Application, and Phishing
- Threat hunters prioritize isolating Agent Zero to prevent reinfection; removing it without understanding how it was established leads to recurring breaches
- EDR telemetry and SIEM correlation rules are commonly tuned to detect anomalous behavior originating from a single host, helping identify Agent Zero early in an intrusion

## Related concepts
[[Lateral Movement]] [[Initial Access]] [[Pivot Point]] [[Kill Chain]] [[Indicators of Compromise]]