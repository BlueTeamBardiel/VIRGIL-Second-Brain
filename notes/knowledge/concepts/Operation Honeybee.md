# Operation Honeybee

## What it is
Like a spy disguising poison inside a gift basket of flowers, Operation Honeybee weaponized seemingly benign documents to deliver malware against humanitarian aid workers. It was a 2018 cyber-espionage campaign attributed to a suspected North Korean threat actor that targeted individuals and organizations involved in humanitarian relief efforts in Asia, using malicious Word documents embedded with backdoor malware.

## Why it matters
In 2018, attackers distributed lure documents themed around United Nations humanitarian aid meetings and job recruitment to trick targets into enabling macros. Once macros were enabled, the SYSCON backdoor was installed, giving attackers persistent remote access to harvest intelligence from NGOs and relief organizations — demonstrating that threat actors deliberately exploit trusted, mission-driven contexts to lower victim suspicion.

## Key facts
- **Attribution**: Linked to a suspected North Korean APT group, sometimes associated with APT37 (Reaper/Group123) activity patterns
- **Delivery mechanism**: Spear-phishing emails carrying weaponized Microsoft Word documents requiring macro execution to deploy the payload
- **Malware used**: SYSCON backdoor, which used FTP as its Command-and-Control (C2) communication channel — an unusual choice designed to blend into normal traffic
- **Target profile**: Humanitarian aid workers, NGOs, and relief organizations operating in Asia — a high-trust, low-suspicion demographic
- **Technique alignment**: Maps to MITRE ATT&CK techniques T1566.001 (Spearphishing Attachment) and T1059.005 (Visual Basic macro execution)

## Related concepts
[[APT37]] [[Spear Phishing]] [[Macro Malware]] [[SYSCON Backdoor]] [[Command and Control (C2)]]