# Python

## What it is
Like a Swiss Army knife that speaks human — Python is a high-level, interpreted programming language designed for readability and rapid development. Its clean syntax and massive library ecosystem make it the dominant language for scripting, automation, and security tooling across both offensive and defensive operations.

## Why it matters
Attackers routinely weaponize Python to build custom malware, port scanners, and credential-stuffing tools — the Mirai botnet's successor variants have used Python-based C2 frameworks. Defenders use Python equally hard: tools like Volatility (memory forensics) and Scapy (packet manipulation) are Python-native, enabling analysts to automate SIEM alert triage and parse thousands of log lines in seconds.

## Key facts
- Python is **interpreted**, meaning malicious scripts can run without compilation, making them harder to detect through traditional signature-based AV scanning
- The `socket`, `subprocess`, and `os` libraries are commonly abused in Python malware for establishing reverse shells and executing system commands
- Many penetration testing frameworks — including **Impacket** (SMB attacks) and **Scapy** (packet crafting) — are written entirely in Python
- Python's `requests` library is frequently used in automated phishing credential harvesters and API abuse scripts
- CySA+ expects analysts to **read and interpret** Python scripts to identify malicious intent (e.g., recognizing base64 obfuscation via `base64.b64decode()`)

## Related concepts
[[Scripting and Automation]] [[Reverse Shell]] [[Penetration Testing Tools]] [[Log Analysis]] [[Obfuscation Techniques]]