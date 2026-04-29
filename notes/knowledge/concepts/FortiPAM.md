# FortiPAM

## What it is
Think of it as a high-security bank vault where every employee must sign in, be watched on camera, and return the key when done — except the "keys" are privileged credentials and the "vault" is software. FortiPAM (Privileged Access Management) is Fortinet's enterprise solution for controlling, monitoring, and auditing access to high-value accounts like root, admin, and service accounts. It enforces least privilege by brokering credential access rather than handing passwords directly to users.

## Why it matters
In the 2020 SolarWinds supply chain attack, attackers pivoted through privileged service accounts to move laterally across networks undetected for months. A PAM solution like FortiPAM would have enforced just-in-time access, recorded all privileged sessions, and flagged the anomalous lateral movement — dramatically shrinking the attacker's dwell time and blast radius.

## Key facts
- **Credential vaulting**: Stores privileged passwords in an encrypted vault; users never see the actual password, they request access which FortiPAM brokers automatically.
- **Session recording**: All privileged sessions (SSH, RDP, web) are recorded and indexed, providing forensic-grade audit trails required by frameworks like PCI-DSS and HIPAA.
- **Just-in-time (JIT) access**: Grants elevated privileges only for a defined time window, automatically revoking them after — reducing standing privilege exposure.
- **Zero-trust integration**: FortiPAM integrates with Fortinet's Security Fabric, feeding behavioral telemetry into FortiSIEM and FortiSOAR for correlation and automated response.
- **Dual-control workflows**: High-risk operations can require approval from a second administrator before a credential is checked out, enforcing separation of duties.

## Related concepts
[[Privileged Access Management]] [[Least Privilege]] [[Just-In-Time Access]] [[Credential Vaulting]] [[Zero Trust Architecture]]