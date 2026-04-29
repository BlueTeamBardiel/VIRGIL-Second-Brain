# CTF

## What it is
Like a locked-room escape game where every padlock is a cryptographic puzzle or vulnerable service, a Capture the Flag (CTF) competition challenges participants to find hidden strings ("flags") by exploiting intentionally vulnerable systems, reversing binaries, cracking ciphers, or analyzing forensic artifacts. Flags are typically formatted strings (e.g., `flag{s0m3_s3cr3t}`) submitted to a scoreboard for points.

## Why it matters
CTFs directly simulate adversarial thinking — the same skills used to pop a CTF web challenge (e.g., SQL injection to dump a flag from a database) map 1:1 to real penetration testing engagements. Security teams use CTF performance as a hiring filter precisely because solving challenges under time pressure demonstrates applied skill, not just certification knowledge. The 2014 Heartbleed disclosure was found through research habits identical to CTF-style binary auditing.

## Key facts
- **Two main formats:** Jeopardy-style (solve independent challenges across categories) and Attack/Defense (teams maintain their own services while exploiting opponents')
- **Core CTF categories:** Web exploitation, binary exploitation (pwn), reverse engineering, cryptography, forensics, and OSINT
- **Flag formats are standardized per event** — e.g., `picoCTF{}`, `HTB{}`, `DUCTF{}` — making automated validation possible
- **Tools of the trade:** Ghidra/IDA Pro (reversing), Wireshark (forensics), Burp Suite (web), pwntools (binary exploitation), CyberChef (crypto/encoding)
- **Platforms like picoCTF, HackTheBox, and CTFtime.org** provide practice environments aligned with real CVEs and MITRE ATT&CK techniques

## Related concepts
[[Penetration Testing]] [[Binary Exploitation]] [[Reverse Engineering]] [[SQL Injection]] [[Forensic Analysis]]