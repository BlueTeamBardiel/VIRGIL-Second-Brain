# Cobalt Group

## What it is
Like a precision safecracker who studies bank blueprints for months before ever touching a vault, Cobalt Group is a sophisticated, financially motivated threat actor that conducts long-term reconnaissance before striking financial institutions. Precisely defined, Cobalt Group (also tracked as GOLD KINGSWOOD) is an advanced persistent threat (APT) group active since at least 2016, primarily targeting banks, ATM networks, and financial infrastructure across Europe, CIS countries, and Southeast Asia.

## Why it matters
In 2017, Cobalt Group used spear-phishing emails impersonating SWIFT partner notifications to deliver Cobalt Strike beacon malware into Eastern European banks, ultimately compromising ATM switch servers and enabling "jackpotting" attacks that dispensed millions in cash. Defenders studying this campaign learned to prioritize monitoring of SWIFT messaging infrastructure and lateral movement from initial phishing endpoints toward payment processing systems.

## Key facts
- **Primary tool:** Cobalt Strike (the group's namesake), a legitimate penetration testing framework weaponized for command-and-control, lateral movement, and payload staging
- **Initial access vector:** Spear-phishing with malicious Microsoft Office documents exploiting CVE-2017-11882 (Equation Editor RCE) and similar Office vulnerabilities
- **Target profile:** Interbank networks, SWIFT infrastructure, ATM controllers, and card processing systems — following money movement pathways
- **TTPs:** Heavy use of living-off-the-land binaries (LOLBins) such as PowerShell and mshta.exe to evade endpoint detection
- **Attribution note:** The group's alleged leader was arrested in Spain in 2018, but activity continued — indicating either the group reorganized or multiple subgroups operate under the same tradecraft umbrella

## Related concepts
[[Cobalt Strike]] [[Spear Phishing]] [[Advanced Persistent Threat]] [[SWIFT Banking Attacks]] [[Lateral Movement]]