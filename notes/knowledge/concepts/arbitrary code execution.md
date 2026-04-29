# arbitrary code execution

## What it is
Imagine handing someone a grocery list, but they secretly swap it with a forged list that makes you buy ingredients for *their* dinner instead — and you follow it without question. Arbitrary code execution (ACE) occurs when an attacker tricks a program into running attacker-supplied instructions with the same privileges as the vulnerable process. It is the crown jewel of exploitation: full control over what the CPU does next.

## Why it matters
The 2017 EternalBlue exploit (used in WannaCry) achieved ACE against Windows SMB by sending malformed packets that triggered a buffer overflow, allowing ransomware to execute at SYSTEM level across hundreds of thousands of machines with no user interaction. Defenders counter ACE with DEP (Data Execution Prevention) and ASLR (Address Space Layout Randomization), which make it significantly harder to reliably redirect execution flow.

## Key facts
- ACE differs from **Remote Code Execution (RCE)** only by delivery vector — RCE is ACE triggered over a network
- Common root causes include buffer overflows, use-after-free vulnerabilities, format string bugs, and deserialization flaws
- **CVSS scores** for confirmed ACE vulnerabilities frequently reach 9.0–10.0 (Critical) due to full confidentiality, integrity, and availability impact
- **NX/DEP** marks memory regions as non-executable to block shellcode injection; attackers bypass it with Return-Oriented Programming (ROP)
- Privilege at execution time matters: ACE as a low-privileged user is dangerous; ACE as SYSTEM/root is catastrophic and often leads to full host compromise

## Related concepts
[[buffer overflow]] [[return-oriented programming]] [[remote code execution]] [[privilege escalation]] [[exploit mitigation]]