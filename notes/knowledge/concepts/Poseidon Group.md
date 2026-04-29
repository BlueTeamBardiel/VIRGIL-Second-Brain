# Poseidon Group

## What it is
Like a deep-sea predator that trails ships for months before striking, the Poseidon Group is a Brazilian-based advanced persistent threat (APT) actor known for long-duration espionage campaigns that weaponize stolen data for extortion. Active since at least 2005, this threat actor targets organizations across multiple sectors — including financial, government, and energy — primarily in Brazil and Portuguese-speaking nations, stealing sensitive data and then leveraging it to coerce victims into hiring their "security services."

## Why it matters
In one documented campaign, Poseidon compromised corporate networks using spear-phishing emails with malicious Word documents, then maintained persistent access for months to exfiltrate confidential business data. The stolen information was subsequently used as leverage to force victim organizations into paying for "consulting contracts" — essentially a corporate shakedown disguised as cybersecurity services.

## Key facts
- **Extortion-as-a-business-model**: Poseidon uniquely monetizes intrusions by threatening to expose stolen data unless victims hire the group as security consultants — blurring criminal and commercial lines.
- **Custom malware**: Deploys a proprietary toolset including a backdoor known as **Poseidon Agent**, engineered to evade signature-based detection on both Windows and Windows Server environments.
- **Spear-phishing TTPs**: Primary initial access vector uses Portuguese-language lure documents exploiting Microsoft Office macros to deliver payloads.
- **Long dwell time**: Campaigns have demonstrated dwell times exceeding 6–12 months before detection, consistent with APT-level operational patience.
- **Satellite-linked C2**: Notably uses satellite internet connections for command-and-control communications, complicating attribution and network-based blocking.

## Related concepts
[[Advanced Persistent Threat (APT)]] [[Spear Phishing]] [[Command and Control (C2)]] [[Extortion]] [[Dwell Time]]