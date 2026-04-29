# CUI

## What it is
Think of CUI like the middle shelf in a government filing cabinet — not locked in a vault like classified secrets, but definitely not left on the break room table. Controlled Unclassified Information (CUI) is sensitive federal information that requires safeguarding under law, regulation, or policy, but does not meet the threshold for classified status. It replaces a patchwork of older labels like FOUO (For Official Use Only) and SBU (Sensitive But Unclassified).

## Why it matters
A defense contractor handling CUI about troop logistics was breached in 2020 because their network lacked NIST SP 800-171 controls — the exact framework DoD requires for CUI protection under DFARS. The attacker exfiltrated personnel files and procurement details without ever touching a classified system. This is precisely why the Cybersecurity Maturity Model Certification (CMMC) was created: to enforce CUI protection across the defense supply chain.

## Key facts
- CUI is governed by **32 CFR Part 2002** and managed by the **National Archives (NARA)** through the CUI Registry
- Organizations handling federal CUI must comply with **NIST SP 800-171** (110 security controls across 14 families)
- CUI has defined **categories**: CUI Basic (standard handling) vs. **CUI Specified** (additional or restricted handling required by law)
- The **CMMC 2.0** framework ties directly to CUI protection — contractors must be certified at Level 2 (Advanced) to handle CUI for DoD
- CUI marking format follows: `CUI//[Category]` (e.g., `CUI//PRVCY` for privacy-related CUI)

## Related concepts
[[NIST SP 800-171]] [[CMMC]] [[Data Classification]] [[DFARS]] [[Federal Information Security]]