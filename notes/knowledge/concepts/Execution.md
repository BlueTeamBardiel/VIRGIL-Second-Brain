# Execution

## What it is
Like a chef who breaks into a kitchen and then actually *cooks* — getting in is only half the story; execution is when the attacker runs their malicious code on the target system. Precisely, execution is the MITRE ATT&CK tactic (TA0002) describing techniques adversaries use to run attacker-controlled code on a local or remote system.

## Why it matters
In the 2017 NotPetya attack, the malware spread via EternalBlue but became catastrophic only when it executed a destructive payload that wiped master boot records across global networks. Defenders who monitor for anomalous process creation — such as `cmd.exe` spawned by a Word document — can catch execution in progress before the payload completes its damage.

## Key facts
- **T1059 (Command and Scripting Interpreter)** is the most commonly observed execution technique, covering PowerShell, Bash, Python, and WScript abuse
- **Living-off-the-land binaries (LOLBins)** like `mshta.exe`, `regsvr32.exe`, and `certutil.exe` allow execution using trusted Windows tools to evade signature-based detection
- **User execution (T1204)** relies on social engineering — tricking users into opening malicious attachments or links — and requires no technical exploit
- **Process injection (T1055)** lets attackers execute code within the memory space of a legitimate process, making it appear as trusted activity to defenders
- Monitoring **Event ID 4688** (Windows process creation) with command-line logging enabled is a primary defensive telemetry source for detecting malicious execution

## Related concepts
[[MITRE ATT&CK Framework]] [[Living-off-the-Land Attacks]] [[Process Injection]] [[PowerShell Abuse]] [[Endpoint Detection and Response]]