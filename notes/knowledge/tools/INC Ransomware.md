# INC Ransomware

## What it is
Like a burglar who photographs your valuables *before* stealing them so they can threaten to post the photos online, INC Ransomware combines file encryption with data exfiltration to create a double-extortion trap. It is a ransomware-as-a-service (RaaS) operation first observed in 2023 that encrypts victim files while simultaneously stealing sensitive data, threatening to publish it on a leak site if the ransom is not paid.

## Why it matters
In 2024, INC Ransomware operators targeted Yamaha Motor's Philippines subsidiary and several NHS Scotland health boards, exfiltrating patient records and threatening public release. This demonstrates how ransomware groups increasingly target critical infrastructure and healthcare, where data sensitivity amplifies payment pressure beyond just operational disruption.

## Key facts
- **Double extortion model**: Combines encryption (disrupts operations) with data theft (threatens reputational/regulatory damage), giving attackers two independent leverage points.
- **Initial access vectors**: Primarily exploits public-facing applications (notably CVE-2023-3519, a Citrix NetScaler vulnerability) and spear-phishing for credential harvesting.
- **Affiliate-based RaaS**: Core developers lease the malware to affiliates who conduct intrusions; profits are split, making attribution harder and attack volume higher.
- **Living-off-the-land (LotL) tactics**: Uses legitimate tools like MegaSync for exfiltration, WinSCP, and PsExec for lateral movement, blending into normal network traffic.
- **Ransom note indicator**: Drops a file named `INC-README.txt` in encrypted directories — a key forensic indicator of compromise (IoC).

## Related concepts
[[Ransomware-as-a-Service (RaaS)]] [[Double Extortion]] [[Living off the Land (LotL)]] [[Citrix Bleed CVE-2023-4966]] [[Indicators of Compromise (IoC)]]