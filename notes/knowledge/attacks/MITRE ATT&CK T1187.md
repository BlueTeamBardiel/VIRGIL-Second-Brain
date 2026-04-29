# MITRE ATT&CK T1187

## What it is
Like leaving a fake "free coffee" sign that forces passersby to hand over their wallet to claim it, Forced Authentication tricks Windows systems into automatically sending NTLM credential hashes to an attacker-controlled server. Specifically, adversaries embed a UNC path (e.g., `\\attacker-ip\share`) in a document or web resource, forcing the victim's machine to authenticate outbound without user interaction.

## Why it matters
In the 2016 Fancy Bear (APT28) campaign, attackers embedded malicious UNC paths inside spear-phishing documents to harvest NTLMv2 hashes from government targets. Those hashes were then cracked offline or relayed directly to other internal systems — no password needed — enabling lateral movement without ever triggering a login dialog.

## Key facts
- **Trigger vectors**: Microsoft Office files (`.docx`, `.rtf`), HTML emails, shortcut (`.lnk`) files, and PDF documents can all embed UNC paths that fire automatically on open or preview
- **NTLMv2 hashes** are captured by the attacker's rogue SMB server (tools: Responder, Metasploit `smb_capture` module); these hashes can be cracked with Hashcat or used in Pass-the-Hash/NTLM Relay attacks
- **No user click required** for many vectors — simply previewing a file in Windows Explorer can trigger authentication
- **Mitigation**: Block outbound SMB (TCP 445/139) at the perimeter; enable "Restrict NTLM" Group Policy settings; disable automatic UNC path resolution in Office via Protected View
- **Detection**: Monitor for outbound SMB connections to external/non-corporate IPs; Windows Event ID 4648 (explicit credential use) and network logs flagging port 445 egress

## Related concepts
[[NTLM Relay Attack]] [[Pass-the-Hash]] [[Responder Tool]] [[Credential Access]] [[SMB Protocol Security]]