# Metasploit

## What it is
Think of Metasploit as a Swiss Army knife where every blade is a pre-built exploit — point it at a target, select your tool, and execute with precision. It is an open-source penetration testing framework that provides a structured environment for developing, testing, and launching exploits against known vulnerabilities, managing payloads, and maintaining post-exploitation access.

## Why it matters
During a red team engagement, a penetration tester discovers a Windows server running an unpatched SMB service. Using Metasploit's `exploit/windows/smb/ms17_010_eternalblue` module, they exploit the EternalBlue vulnerability in under two minutes — the same technique used in the WannaCry ransomware outbreak — demonstrating to the client exactly what an attacker would do before a patch is applied.

## Key facts
- Metasploit is organized into **modules**: exploits, payloads, auxiliaries (scanners/fuzzers), encoders, and post-exploitation modules
- **Meterpreter** is Metasploit's advanced in-memory payload that runs entirely in RAM, leaving minimal disk artifacts and evading basic forensic detection
- The **msfvenom** tool generates standalone payloads (e.g., reverse shells) outside of the framework for embedding in files or scripts
- Metasploit's database (`db_nmap`) integrates with Nmap to store scan results, enabling organized target tracking during engagements
- For Security+/CySA+: Metasploit is classified as a **exploitation framework** under penetration testing tools; knowing its phases (reconnaissance → exploitation → post-exploitation) maps directly to the **Penetration Testing Methodology**

## Related concepts
[[Exploitation Frameworks]] [[Meterpreter Payloads]] [[EternalBlue (MS17-010)]] [[Penetration Testing Methodology]] [[Reverse Shells]]