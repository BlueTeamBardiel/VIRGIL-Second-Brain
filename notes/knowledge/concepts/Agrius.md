# Agrius

## What it is
Like a vandal who picks your lock, ransacks your house, then burns it down while wearing a burglar's mask, Agrius is an Iranian state-sponsored threat actor that disguises destructive wiper malware as ransomware. Formally tracked as APT-C-50 and linked to Iran's Ministry of Intelligence, Agrius conducts espionage and destructive operations primarily targeting Israeli and Middle Eastern organizations.

## Why it matters
In 2021, Agrius deployed the **Fantasy** wiper and **Apostle** malware against Israeli diamond industry firms and HR companies, disguising destructive payloads as ransomware to create plausible deniability and delay incident response. Defenders who treated the attack as a criminal ransomware incident wasted critical time on negotiation rather than containment, demonstrating how nation-states weaponize ransomware aesthetics to slow defenders.

## Key facts
- Agrius uses **DEADWOOD**, **Fantasy**, and **Apostle** — wipers that masquerade as ransomware but are designed to destroy data, not recover it for payment
- The group frequently uses **supply chain compromise** via third-party IT service providers to pivot into target networks
- Attributed to **Iran's Ministry of Intelligence and Security (MOIS)**, distinguishing it from IRGC-linked groups like APT33
- Agrius employs **ProxyShell** and **Exchange Server vulnerabilities** as initial access vectors before deploying destructive payloads
- The actor uses a **VPN infrastructure** (particularly Iranian VPN exit nodes) and legitimate tools like ASPXSpy web shells for persistence

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Wiper Malware]] [[False Flag Operations]] [[Supply Chain Attack]] [[Ransomware]]