# Hancitor

## What it is
Think of Hancitor as a delivery truck driver who doesn't rob banks himself — he just drops off the getaway crew. Hancitor (also known as Chanitor) is a malware downloader/dropper that arrives via phishing emails and serves as a first-stage loader, fetching and executing secondary payloads like Cobalt Strike beacons, Ficker Stealer, or ransomware onto compromised Windows systems.

## Why it matters
In documented 2021 campaigns, Hancitor was distributed through malicious Word documents disguised as DocuSign notifications. Once a user enabled macros, Hancitor executed, called back to its C2 infrastructure, and downloaded Cobalt Strike, which threat actors then used for lateral movement leading to Cuba ransomware deployment — turning a single phishing click into a full network compromise.

## Key facts
- **Delivery vector**: Phishing emails with malicious Office documents requiring macro enablement (classic "Enable Content" social engineering)
- **C2 mechanism**: Uses HTTP-based callbacks, often abusing legitimate services and sending victim system fingerprint data (username, hostname, IP) before pulling payloads
- **Payload chain**: Commonly drops Ficker Stealer (credential theft), Cobalt Strike (lateral movement), and ransomware — making it a multi-stage threat multiplier
- **Macro dependency**: Disabling Office macros by default (now enforced in Microsoft 365) directly breaks Hancitor's primary infection chain
- **Attribution pattern**: Linked to financially motivated threat actors; frequently observed using contact form spam and traffic distribution systems (TDS) to evade detection

## Related concepts
[[Malware Dropper]] [[Phishing]] [[Cobalt Strike]] [[Macro-based Malware]] [[Command and Control (C2)]]