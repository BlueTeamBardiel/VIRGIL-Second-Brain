# infostealer

## What it is
Think of it like a silent pickpocket who photographs everything in your wallet instead of taking the wallet itself — you never notice it's gone. An infostealer is a category of malware specifically designed to harvest credentials, browser cookies, session tokens, cryptocurrency wallets, and system data, then exfiltrate that data to an attacker-controlled server, all without disrupting normal system operation.

## Why it matters
In 2023, the Raccoon Stealer and RedLine Stealer families were distributed via malvertising and cracked software downloads, compromising millions of browser-saved credentials that were then sold on darknet markets like Genesis Market. Security teams detected these intrusions not through endpoint alerts, but by monitoring for unusual credential reuse attempts in authentication logs — illustrating why identity threat detection is now a core defensive layer.

## Key facts
- Infostealers commonly target the **browser credential store**, cookies (enabling session hijacking without a password), autofill data, and locally stored cryptocurrency wallet files
- They frequently abuse the **Windows DPAPI** (Data Protection API) to decrypt Chrome-stored passwords using the victim's own OS credentials
- Exfiltration typically occurs over **HTTPS to C2 servers**, making traffic blend with normal web activity and evading many network controls
- Many modern infostealers are sold as **Malware-as-a-Service (MaaS)**, with subscription tiers, dashboards, and customer support — lowering the barrier to entry for threat actors
- Stolen session cookies allow **post-authentication bypass**, meaning MFA protections can be circumvented entirely without knowing the user's password

## Related concepts
[[credential dumping]] [[session hijacking]] [[malware-as-a-service]] [[browser security]] [[data exfiltration]]