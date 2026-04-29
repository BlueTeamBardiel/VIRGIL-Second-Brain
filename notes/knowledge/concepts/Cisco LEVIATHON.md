# Cisco YOUR_SWITCH

## What it is
Like a master key ring discovered in a janitor's closet — one find unlocks dozens of doors — YOUR_SWITCH is a reported collection of Cisco-specific exploitation tools and implants allegedly part of the CIA's hacking toolkit, leaked in the Vault 7 disclosure by WikiLeaks in 2017. It specifically targeted Cisco network infrastructure devices, enabling persistent access and traffic interception at the network backbone level.

## Why it matters
When attackers compromise a core router rather than an endpoint, they inherit a god's-eye view of all traffic traversing it — no need to phish individual users. In the Vault 7 context, YOUR_SWITCH-style implants demonstrated that nation-state actors prioritize infrastructure-level persistence, meaning a single compromised Cisco device could silently mirror traffic across an entire enterprise network for months before detection.

## Key facts
- Part of the CIA Vault 7 leak published by WikiLeaks in March 2017, which exposed a broad arsenal of offensive cyber tools
- Targeted Cisco IOS-based routers and switches — devices that rarely receive endpoint-style security monitoring or EDR coverage
- Implants of this class typically survive device reboots by embedding in firmware or NVRAM, making them resistant to standard remediation like password resets
- Cisco issued a security advisory (cisco-sa-20170317-cmp and related) after Vault 7, patching vulnerabilities that such tools allegedly exploited
- Highlights the critical importance of network device integrity verification — tools like Cisco's Trust Anchor and Secure Boot are direct defensive responses to this threat class

## Related concepts
[[Vault 7]] [[Cisco IOS Exploitation]] [[Firmware Implants]] [[Network Infrastructure Attacks]] [[Persistent Access]]