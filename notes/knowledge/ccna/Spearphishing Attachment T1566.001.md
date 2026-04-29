# Spearphishing Attachment T1566.001

## What it is
Like a jeweler crafting a custom ring for one specific finger, spearphishing attachments are precision-tailored malicious files delivered via email to a carefully researched individual target. Unlike generic phishing blasts, this technique weaponizes personal context — job titles, colleagues' names, ongoing projects — to make a malicious attachment feel legitimate and expected.

## Why it matters
In the 2016 Democratic National Committee breach, attackers sent targeted emails with malicious attachments to specific staffers, ultimately delivering credential-harvesting malware that contributed to one of the most consequential political hacks in U.S. history. Defenders combating this technique focus on email gateway sandboxing and disabling macro execution in Office documents, since PDFs and .docx files with embedded macros remain the most common delivery vehicles.

## Key facts
- **MITRE ATT&CK ID:** T1566.001, a sub-technique under Initial Access (TA0001)
- Common malicious file types include Office documents with VBA macros, PDFs with embedded exploits, ISO files, and .lnk shortcut files — ISO/LNK use surged after Microsoft disabled macros by default in 2022
- Indicators of compromise include unexpected attachments from known contacts, mismatched sender domains (display name vs. actual address), and attachments that prompt macro enablement
- Detection relies on email security gateways (e.g., Proofpoint, Mimecast), sandbox detonation, and endpoint telemetry showing Office spawning PowerShell or cmd.exe as child processes
- Mitigation includes Group Policy to disable macros, Attack Surface Reduction (ASR) rules in Microsoft Defender, and user awareness training focused on attachment verification

## Related concepts
[[Phishing T1566]] [[User Execution T1204]] [[Macro-based Malware]] [[Email Security Gateways]] [[Initial Access TA0001]]