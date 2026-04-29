# payload

## What it is
Like the warhead strapped to a missile — the delivery system (rocket) doesn't cause the damage, the payload does. In cybersecurity, the payload is the component of malware or an attack that actually executes the malicious action: encrypting files, opening a reverse shell, exfiltrating data, or deleting records.

## Why it matters
In the 2017 WannaCry attack, the delivery mechanism was EternalBlue (an SMB exploit), but the payload was ransomware code that encrypted files and demanded Bitcoin. Defenders who only blocked the exploit vector missed the point — understanding payloads helps analysts identify *what the attacker actually wanted to accomplish*, which drives incident response and forensic investigation.

## Key facts
- A payload is distinct from the **exploit** (which gains access) and the **dropper** (which delivers the payload); these are separate stages in an attack chain
- Payloads can be **staged** (downloaded in pieces to evade detection) or **stageless** (self-contained, executed immediately upon delivery)
- Common payload types include **reverse shells**, **RATs (Remote Access Trojans)**, **keyloggers**, **ransomware**, and **credential harvesters**
- Tools like **Metasploit's msfvenom** are used by both attackers and pen testers to generate and encode payloads, often to bypass signature-based AV detection
- **Payload obfuscation** techniques (Base64 encoding, XOR encryption, packing) are used to hide malicious intent from static analysis — behavior-based detection is more effective against these

## Related concepts
[[malware]] [[exploit]] [[dropper]] [[reverse shell]] [[obfuscation]]