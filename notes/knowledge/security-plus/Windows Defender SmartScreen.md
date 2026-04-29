# Windows Defender SmartScreen

## What it is
Think of it as a bouncer at a club who checks your name against a known troublemaker list *and* eyeballs whether your outfit looks suspicious — even if you've never been seen before. SmartScreen is a cloud-based reputation service built into Windows and Microsoft Edge that evaluates downloaded files and URLs against Microsoft's threat intelligence database, blocking or warning users before execution if something looks malicious or unrecognized.

## Why it matters
In 2021, attackers distributing the BazarLoader malware relied on users clicking through SmartScreen warnings on malicious `.exe` files delivered via phishing emails — the attack literally *depended* on user override behavior. This highlights a critical gap: SmartScreen is effective at stopping automated execution, but fails when users habitually click "Run Anyway," making security awareness training an essential complement to the technical control.

## Key facts
- SmartScreen uses **Application Reputation** (checking file hashes and publisher signatures) and **URL Reputation** (checking against Microsoft's blocklist) as its two primary evaluation mechanisms
- Files downloaded from the internet receive a **Mark of the Web (MotW)** — an NTFS alternate data stream (`Zone.Identifier`) — which triggers SmartScreen inspection on execution
- SmartScreen can be bypassed by delivering payloads inside **password-protected archives** (ZIP/RAR), since extraction strips or prevents MotW propagation
- It is configurable via **Group Policy** at `Computer Configuration > Windows Settings > Security Settings`, making it a manageable enterprise control
- SmartScreen generates events in the **Windows Event Log (Event ID 1035 in AppLocker log and Microsoft-Windows-SmartScreen)**, making it a relevant data source for CySA+ threat hunting scenarios

## Related concepts
[[Mark of the Web (MotW)]] [[Application Whitelisting]] [[Phishing Defense Controls]] [[Microsoft Defender for Endpoint]] [[User Account Control (UAC)]]