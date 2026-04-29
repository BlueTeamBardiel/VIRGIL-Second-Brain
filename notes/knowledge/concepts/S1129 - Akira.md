# S1129 - Akira

## What it is
Like a smash-and-grab crew that picks the lock, raids the vault, and burns the security tapes on the way out, Akira is a ransomware-as-a-service (RaaS) operation that combines data exfiltration with encryption to maximize extortion leverage. Active since early 2023, it targets Windows and Linux (including VMware ESXi) environments, operates a dark web leak site, and is linked to threat actors potentially connected to the defunct Conti group.

## Why it matters
In 2023, Akira threat actors compromised organizations by exploiting Cisco VPN accounts lacking multi-factor authentication — including a notable attack against a healthcare provider — stealing data before deploying encryption. Defenders responded by enforcing MFA on VPN gateways and monitoring for Cisco ASA vulnerability exploitation (CVE-2023-20269), illustrating how a single authentication gap enables full ransomware deployment.

## Key facts
- **Initial access vector**: Frequently exploits Cisco VPN/ASA vulnerabilities (CVE-2023-20269, CVE-2023-20198) and uses compromised VPN credentials without MFA
- **Double extortion model**: Exfiltrates sensitive data *before* encrypting, threatening public leak on their ".onion" site if ransom is unpaid
- **Linux/ESXi targeting**: Deploys a Rust-based encryptor specifically built to attack VMware ESXi hypervisors, maximizing organizational disruption
- **Lateral movement tools**: Uses legitimate tools (AnyDesk, WinSCP, RClone) for persistence and data staging — a classic LOTL (Living off the Land) technique
- **Ransom demands**: Reported demands range from $200,000 to over $4 million, with victims spanning education, healthcare, and financial sectors

## Related concepts
[[Ransomware-as-a-Service (RaaS)]] [[Double Extortion]] [[Living off the Land (LotL)]] [[CVE Exploitation]] [[Multi-Factor Authentication (MFA)]]