# Nobelium

## What it is
Like a master locksmith who doesn't break down the door but instead steals the key shop's master template, Nobelium is a Russian state-sponsored threat actor (APT29/Cozy Bear) that compromises trusted software supply chains rather than attacking targets directly. It is the group behind the 2020 SolarWinds attack, operated by Russia's Foreign Intelligence Service (SVR), specializing in stealthy, long-dwell espionage campaigns against government and critical infrastructure targets.

## Why it matters
In the SolarWinds attack, Nobelium injected malicious code (SUNBURST) into legitimate software updates distributed to ~18,000 organizations, including the U.S. Treasury and DHS. By weaponizing a trusted update mechanism, they bypassed perimeter defenses entirely — defenders never saw a "break-in" because the malware arrived pre-signed and legitimately packaged.

## Key facts
- **Attribution:** Linked to Russia's SVR (Foreign Intelligence Service); overlaps with APT29 and Cozy Bear
- **Primary technique:** Supply chain compromise — injecting backdoors into vendor software (SolarWinds Orion platform, MITRE ATT&CK T1195.002)
- **SUNBURST malware** lay dormant for 12–14 days after installation before activating, deliberately evading sandbox detection with time-based delays
- **Persistence method:** Used legitimate credentials and OAuth tokens to move laterally through cloud environments (Azure AD), making detection extremely difficult
- **Targeted sectors:** Government agencies, NGOs, think tanks, and IT managed service providers — primarily for espionage, not destruction

## Related concepts
[[Supply Chain Attack]] [[APT (Advanced Persistent Threat)]] [[SUNBURST Malware]] [[SolarWinds Compromise]] [[Lateral Movement]]