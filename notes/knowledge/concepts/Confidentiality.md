# confidentiality

## What it is
Think of confidentiality like a sealed letter in a wax-stamped envelope — only the intended recipient should be able to break that seal and read the contents. In security terms, confidentiality is the principle that information is accessible only to those authorized to view it. It is one of the three pillars of the CIA Triad, alongside integrity and availability.

## Why it matters
In 2013, Edward Snowden exfiltrated NSA classified documents by exploiting overly broad access privileges — a confidentiality failure rooted in poor least-privilege enforcement. Had need-to-know access controls and robust data loss prevention (DLP) tools been in place, the scope of exposure would have been dramatically limited. This illustrates that confidentiality failures are often organizational and policy failures, not just technical ones.

## Key facts
- Confidentiality is enforced through **encryption, access controls, and data classification** — encryption protects data in transit and at rest, while access controls restrict who can reach it
- **Symmetric encryption** (e.g., AES-256) is the primary tool for bulk data confidentiality; **asymmetric encryption** handles key exchange
- Violations include **eavesdropping, man-in-the-middle attacks, insider threats, and shoulder surfing** — not all attacks are digital
- **Data classification schemes** (Top Secret, Confidential, Public, etc.) drive confidentiality decisions by labeling what must be protected and at what level
- On Security+, confidentiality is specifically threatened by **sniffing/packet capture attacks** on unencrypted channels — always associate HTTP, Telnet, and FTP with confidentiality risks

## Related concepts
[[CIA Triad]] [[encryption]] [[data classification]] [[least privilege]] [[data loss prevention]]