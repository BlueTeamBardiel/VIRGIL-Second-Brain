# Jaaz

## What it is
Like a Swiss Army knife smuggled inside a legitimate toolbox, Jaaz is a multi-stage ransomware and infostealer malware family that disguises its malicious components within seemingly benign delivery mechanisms. Jaaz is a relatively emerging threat actor toolkit observed distributing ransomware payloads alongside credential harvesting capabilities, often delivered via phishing campaigns and malicious loaders.

## Why it matters
In a documented attack scenario, Jaaz operators used phishing emails with malicious attachments to drop a loader that first exfiltrated credentials and sensitive data before deploying the ransomware payload — maximizing leverage for double extortion. This "steal first, encrypt second" approach means even paying the ransom doesn't guarantee data confidentiality, forcing organizations to treat every ransomware incident as a confirmed data breach.

## Key facts
- Jaaz employs a **double extortion model**: data is exfiltrated *before* encryption, giving attackers two payment levers — restore access AND prevent data publication
- Delivered primarily via **phishing with malicious loaders**, often abusing legitimate scripting environments (e.g., PowerShell, JavaScript droppers)
- Functions as a **combined infostealer + ransomware**, targeting credentials, browser data, and organizational files in a single campaign
- Associated with **affiliate-based RaaS (Ransomware-as-a-Service)** distribution models, meaning the core developers lease the toolkit to different threat actors
- Detection focus: anomalous **data staging behavior** (large internal file copies, compression before outbound transfer) often precedes encryption and serves as an early warning indicator

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[Infostealer Malware]] [[Phishing]] [[Indicators of Compromise]]