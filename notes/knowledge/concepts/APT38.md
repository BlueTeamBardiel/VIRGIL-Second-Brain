# APT38

## What it is
Think of a bank heist crew that spends months casing the vault, disables the alarms on their way out, and burns the evidence — except they never leave their keyboards. APT38 is a North Korean state-sponsored threat actor specifically tasked with large-scale financial cybercrime, operating as a sub-group under the Lazarus Group umbrella to fund the DPRK regime through bank fraud and cryptocurrency theft.

## Why it matters
In the 2016 Bangladesh Bank heist, APT38 infiltrated SWIFT interbank messaging systems and issued fraudulent transfer orders totaling $951 million — successfully stealing $81 million before a typo in one transfer request triggered suspicion. Defenders learned that SWIFT network access must be treated as crown-jewel infrastructure requiring strict network segmentation, behavioral anomaly detection, and out-of-band transaction verification.

## Key facts
- APT38 is financially motivated, not espionage-driven — making them distinct from most other nation-state actors
- They use a "slow and low" dwell time strategy, often residing in victim networks for 18+ months before executing theft
- Signature malware includes **BLINDINGCAN**, **HOPLIGHT**, and destructive tools like **WHISKEYBRAVO** used to wipe evidence post-heist
- They specifically target SWIFT messaging infrastructure, cryptocurrency exchanges, and ATM networks (FASTCash campaign)
- Attribution is to North Korea's RGB (Reconnaissance General Bureau), operating under UN sanctions for funding WMD programs

## Related concepts
[[Lazarus Group]] [[SWIFT Attack]] [[Nation-State Threat Actor]] [[Lateral Movement]] [[Anti-Forensics]]