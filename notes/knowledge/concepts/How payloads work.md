# How payloads work

## What it is
Think of a payload like a Trojan horse: the delivery mechanism (the giant wooden horse) gets you past the gates, but the payload is the soldiers hiding inside who do the actual damage. In cybersecurity, a payload is the component of an attack that executes the malicious action — the code or commands that run *after* successful delivery and exploitation. The delivery mechanism and the exploit are just the envelope; the payload is the letter that does the work.

## Why it matters
In the 2017 WannaCry ransomware attack, the EternalBlue exploit was the delivery mechanism that leveraged an SMB vulnerability — but the ransomware encryption routine *was* the payload. Defenders who focused only on blocking the exploit vector missed that the payload itself needed to be detected behaviorally, which is why signature-based AV missed early variants.

## Key facts
- Payloads are categorized as **staged** (downloaded in pieces after initial foothold) or **stageless** (fully self-contained); staged payloads are smaller and evade size-based detection filters
- **Meterpreter** (Metasploit) is a classic in-memory payload — it never writes to disk, making forensic detection and AV evasion significantly harder
- Payload delivery phases map to the **Cyber Kill Chain**: delivery → exploitation → installation → command & control (C2), with the payload active at the installation stage onward
- Common payload types include **reverse shells** (victim connects back to attacker), **bind shells** (attacker connects to victim), and **web shells** (persistent access via web server)
- Payload obfuscation techniques — encoding (Base64), encryption, and polymorphism — are primary methods attackers use to bypass signature-based detection

## Related concepts
[[Exploit vs Vulnerability]] [[Metasploit Framework]] [[Reverse Shell]] [[Command and Control (C2)]] [[Antivirus Evasion Techniques]]