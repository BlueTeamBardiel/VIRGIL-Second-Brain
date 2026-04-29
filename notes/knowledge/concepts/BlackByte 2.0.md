# BlackByte 2.0

## What it is
Like a burglar who breaks in, robs the safe, then burns the house down — all within five minutes — BlackByte 2.0 is a ransomware-as-a-service (RaaS) operation notorious for compressing its entire attack lifecycle into under 48 hours. It is a double-extortion ransomware variant that encrypts victim data while simultaneously exfiltrating it, threatening public release on a dedicated leak site if ransom demands go unmet.

## Why it matters
In a 2023 Microsoft Incident Response case, BlackByte 2.0 operators exploited an unpatched ProxyShell vulnerability (CVE-2021-34473) in Microsoft Exchange, deployed web shells, and completed full ransomware deployment in less than five days — from initial access to encrypted endpoints. Defenders must prioritize patch cadence and monitor for web shell artifacts in IIS directories, as traditional 30-day patch windows are catastrophically slow against this threat tempo.

## Key facts
- Exploits **ProxyShell** vulnerabilities (CVE-2021-34473, CVE-2021-34523, CVE-2021-31207) for initial access via unpatched Exchange servers
- Uses **Cobalt Strike beacons** for command-and-control and lateral movement after establishing persistence via web shells
- Employs **living-off-the-land (LotL)** techniques, abusing legitimate tools like `netsh`, `reg.exe`, and Windows Remote Management to evade detection
- Deploys a **custom-compiled ransomware binary per victim**, using a random 8-character alphanumeric extension on encrypted files to hinder signature-based detection
- Uses **VSS deletion** (vssadmin delete shadows) to destroy Volume Shadow Copies, preventing local backup recovery

## Related concepts
[[ProxyShell Vulnerability]] [[Ransomware-as-a-Service]] [[Living Off the Land Attacks]] [[Double Extortion Ransomware]] [[Cobalt Strike]]