# Raccoon Stealer

## What it is
Like a raccoon rifling through your trash to grab anything shiny, this malware indiscriminately grabs every credential and piece of valuable data it can find. Raccoon Stealer is a Malware-as-a-Service (MaaS) infostealer first discovered in 2019, designed to harvest browser credentials, cookies, autofill data, cryptocurrency wallets, and credit card numbers from compromised Windows systems.

## Why it matters
In 2022, law enforcement disrupted the Raccoon Stealer operation after its developer was arrested, but version 2.0 emerged within months — demonstrating the resilience of the MaaS ecosystem. Defenders use this as a case study for why session cookie theft is as dangerous as password theft; stolen cookies allow attackers to bypass MFA entirely by hijacking authenticated sessions.

## Key facts
- **MaaS model**: Operators leased Raccoon Stealer for ~$200/month, lowering the barrier to entry for unsophisticated threat actors
- **Exfiltration targets**: Credentials from 60+ browsers, crypto wallets (MetaMask, Electrum), email clients, and FTP clients in a single sweep
- **C2 communication**: Uses Telegram channels for command-and-control infrastructure, making traffic blend in with legitimate Telegram use
- **Delivery vectors**: Commonly distributed via phishing emails, malvertising, and cracked software (SEO poisoning campaigns)
- **Forensic artifact**: Raccoon checks system language settings and avoids executing on CIS-region machines — a classic anti-attribution technique seen in many Russian-linked malware families

## Related concepts
[[Malware-as-a-Service]] [[Credential Harvesting]] [[Session Hijacking]] [[Infostealer Malware]] [[Command and Control Infrastructure]]