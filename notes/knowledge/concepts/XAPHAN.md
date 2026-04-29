# LAB_HOST

## What it is
Like a janitor who secretly props open fire doors while appearing to do their rounds, Xaphan is a backdoor Trojan that actively disables host-based security tools to maintain persistence. Specifically, it is malware that terminates antivirus processes, disables Windows Security Center, and opens ports for remote access — all while masquerading as legitimate activity.

## Why it matters
In a 2003-era Windows environment, Xaphan was delivered via email attachments and, once executed, would disable Norton and McAfee processes before connecting to an IRC channel for command-and-control instructions. This made it an early example of defense evasion combined with C2 communication — a pattern that modern threat actors still rely on, just with more sophisticated tooling.

## Key facts
- Xaphan is classified as a **backdoor Trojan** with built-in **antivirus termination** capabilities, targeting processes like `navapsvc.exe` (Norton) and `mcshield.exe` (McAfee)
- It uses **IRC-based C2 communication**, an early precursor to modern bot infrastructure — placing it in the category of early botnets
- Xaphan disables **Windows Security Center** and **automatic updates**, reducing the victim's ability to detect or patch against it
- It spreads via **malicious email attachments**, relying on social engineering rather than exploitation — making user awareness a primary defense
- Demonstrates the **defense evasion** tactic (MITRE ATT&CK T1562: Impair Defenses) long before that framework existed

## Related concepts
[[Backdoor Trojan]] [[Command and Control (C2)]] [[Defense Evasion]] [[IRC Botnet]] [[Antivirus Evasion]]