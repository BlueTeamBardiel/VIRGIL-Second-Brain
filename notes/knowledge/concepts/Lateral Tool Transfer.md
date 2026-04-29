# Lateral Tool Transfer

## What it is
Like a burglar who breaks in through the front door but then retrieves their full toolkit from a hidden car nearby, attackers who already have a foothold will copy offensive tools *across* the compromised network rather than downloading them fresh each time. Precisely: Lateral Tool Transfer (MITRE ATT&CK T1570) is the technique of copying files — malware, exploit frameworks, scripts — between systems within a victim environment after initial access is established.

## Why it matters
During the 2017 NotPetya attack, the malware spread laterally by copying itself to remote hosts via SMB shares and PsExec, leveraging legitimate Windows administrative tools to avoid triggering perimeter defenses. Defenders countering this look for anomalous file copy events across internal hosts — specifically SMB traffic between workstations, which almost never happens in healthy networks — as a high-fidelity detection signal.

## Key facts
- Common transfer mechanisms include SMB/Windows Admin Shares (`ADMIN$`, `C$`), RDP clipboard/drive redirection, SCP/SFTP, and `certutil.exe` abuse
- Attackers favor Living-off-the-Land Binaries (LOLBins) like `robocopy`, `xcopy`, and `bitsadmin` to blend tool transfers into normal sysadmin activity
- Detection focus: workstation-to-workstation SMB connections are abnormal; server-to-server is less suspicious — baseline your environment accordingly
- MITRE maps this under **Lateral Movement (TA0008)**; it differs from Ingress Tool Transfer (T1105), which involves pulling tools *from the internet* into the environment
- Endpoint telemetry (Sysmon Event ID 11 — FileCreate) combined with network flow analysis provides the strongest detection coverage

## Related concepts
[[Lateral Movement]] [[Living off the Land (LOLBins)]] [[SMB Exploitation]] [[Ingress Tool Transfer]] [[PsExec]]