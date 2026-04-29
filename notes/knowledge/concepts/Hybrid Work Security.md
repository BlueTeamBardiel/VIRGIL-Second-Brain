# Hybrid Work Security

## What it is
Like a medieval castle that suddenly punched holes in its walls so knights could work from the village — and then had to guard both the castle *and* every knight's cottage — hybrid work security is the discipline of protecting corporate resources when employees split time between controlled office environments and uncontrolled remote locations. It encompasses endpoint security, identity verification, and network controls that function consistently regardless of where a user physically sits.

## Why it matters
In 2021, attackers compromised a financial firm by targeting a remote employee's home router running default credentials, pivoting through the VPN tunnel into the corporate network and exfiltrating client data. The office firewall never saw the attack because it originated from a trusted, authenticated VPN session — illustrating that perimeter-based defenses alone fail when the perimeter is someone's kitchen.

## Key facts
- **Split-tunnel VPN** sends only corporate-destined traffic through the VPN, reducing bandwidth load but leaving internet traffic unmonitored — a common misconfiguration attackers exploit
- **Zero Trust Network Access (ZTNA)** replaces legacy VPN by enforcing per-session, least-privilege access based on identity, device health, and context — critical for hybrid models
- **Endpoint Detection and Response (EDR)** must be deployed on all remote devices because corporate network-based IDS/IPS cannot see traffic on home networks
- **MFA fatigue attacks** (repeated push notification bombing) spiked with hybrid work adoption; phishing-resistant MFA (FIDO2/passkeys) is the recommended countermeasure
- **BYOD policies** require Mobile Device Management (MDM) or containerization to prevent data leakage between personal and corporate apps on the same device

## Related concepts
[[Zero Trust Architecture]] [[VPN Security]] [[Endpoint Detection and Response]] [[Mobile Device Management]] [[Multi-Factor Authentication]]