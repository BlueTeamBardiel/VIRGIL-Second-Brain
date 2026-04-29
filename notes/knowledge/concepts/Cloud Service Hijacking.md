# Cloud Service Hijacking

## What it is
Imagine someone steals your gym membership card and starts using all the equipment under your name — racking up fees and locking you out. Cloud service hijacking works the same way: an attacker compromises valid cloud account credentials or API keys to take control of cloud resources, impersonating the legitimate owner to steal data, launch attacks, or consume services at the victim's expense.

## Why it matters
In 2019, researchers discovered exposed AWS credentials on public GitHub repositories, allowing attackers to spin up thousands of EC2 instances to mine cryptocurrency — leaving victims with six-figure electricity bills they never incurred. Defenders counter this by enforcing MFA on cloud accounts, rotating API keys regularly, and using tools like AWS CloudTrail to audit access logs for anomalous resource creation patterns.

## Key facts
- **Credential exposure** is the primary attack vector — hardcoded API keys in public source code repositories are a top cause of hijacking incidents
- Attackers frequently abuse hijacked accounts for **cryptomining, data exfiltration, or launching further attacks**, making detection via sudden cost spikes a useful indicator
- **Account hijacking** is listed as a top threat in the Cloud Security Alliance (CSA) Top Threats report, relevant to Security+ cloud domain objectives
- Defense relies on **least privilege IAM policies**, MFA enforcement, and continuous monitoring of cloud access logs (e.g., AWS CloudTrail, Azure Monitor)
- Unlike on-premise attacks, hijacking cloud accounts can give attackers **instant global scale** — spinning up resources across multiple regions within minutes

## Related concepts
[[Credential Stuffing]] [[Identity and Access Management]] [[Insecure API]] [[Privilege Escalation]] [[Shared Responsibility Model]]