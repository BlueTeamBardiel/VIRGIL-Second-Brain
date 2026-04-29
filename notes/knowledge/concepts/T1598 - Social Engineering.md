# T1598 - Social Engineering

## What it is
Like a con artist casing a bank by posing as a health inspector to learn which vault is used on Fridays, T1598 describes adversaries manipulating people into revealing information *before* launching a primary attack — specifically to gather reconnaissance. It is a pre-attack technique under MITRE ATT&CK's Reconnaissance tactic, where threat actors deceive targets into disclosing credentials, system details, or organizational structure through human interaction rather than technical scanning.

## Why it matters
In the 2020 Twitter Bitcoin scam, attackers phone-called Twitter employees pretending to be IT support, convincing them to hand over VPN credentials — a textbook T1598 execution that preceded full account takeover. Defenders counter this by implementing strict callback verification procedures and training staff to recognize unsolicited "internal" requests for credentials or system access.

## Key facts
- T1598 is classified under **Reconnaissance (TA0043)**, making it a *pre-intrusion* technique, not an execution or persistence tactic
- Sub-techniques include **T1598.001** (Spearphishing Service), **T1598.002** (Spearphishing Attachment), and **T1598.003** (Spearphishing Link) — all focused on *eliciting information*, not delivering malware
- The goal is intelligence collection (usernames, org charts, software versions), not immediate compromise — distinguishing it from T1566 Phishing, which seeks execution
- Detection relies heavily on **user awareness reporting**, email gateway anomaly detection, and monitoring for unusual requests via helpdesk tickets or IT communication channels
- Mitigation prioritizes **security awareness training** and **multi-factor authentication** as primary controls, since no technical patch exists for human deception

## Related concepts
[[T1566 - Phishing]] [[T1591 - Gather Victim Org Information]] [[T1589 - Gather Victim Identity Information]]