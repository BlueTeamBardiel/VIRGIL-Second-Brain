# MITRE T1548

## What it is
Like a contractor who convinces the building manager to hand over the master key by claiming it's "just for today," this technique involves an attacker manipulating privilege mechanisms to gain elevated permissions they shouldn't permanently hold. T1548 (Abuse Elevation Control Mechanism) covers techniques where adversaries exploit or bypass OS controls designed to limit privilege — such as UAC on Windows or sudo on Linux — to escalate from standard user to administrator/root.

## Why it matters
In the 2020 SolarWinds supply chain attack, post-exploitation activity relied heavily on abusing Windows privilege elevation to move laterally and maintain persistence without triggering obvious alerts. Defenders who monitor for UAC bypass events (Event ID 4688, unexpected high-integrity processes spawned by medium-integrity parents) can catch this class of attack before full domain compromise occurs.

## Key facts
- **Sub-techniques include:** UAC Bypass (T1548.002), Sudo/Sudo Caching Abuse (T1548.003), Setuid/Setgid abuse on Linux (T1548.001), and Elevated Execution with Prompt (T1548.004)
- UAC Bypass often uses auto-elevation of trusted Windows binaries (e.g., `fodhelper.exe`) to silently spawn high-integrity processes without user prompts
- On Linux, misconfigured `sudoers` files (e.g., `NOPASSWD` entries) allow privilege escalation without authentication
- Setuid/Setgid binaries run with the file owner's permissions regardless of who executes them — a misconfigured one is a direct path to root
- Detection focus: monitoring for processes with unexpected integrity level mismatches, unusual `sudo` invocations, and SUID files in non-standard directories

## Related concepts
[[Privilege Escalation]] [[User Account Control (UAC)]] [[Linux File Permissions]] [[T1055 Process Injection]] [[Least Privilege Principle]]