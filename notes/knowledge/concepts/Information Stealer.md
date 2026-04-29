# Information Stealer

## What it is
Like a silent pickpocket who photographs the contents of your wallet instead of taking it — so you never notice it's gone — an information stealer is malware designed to silently harvest credentials, cookies, financial data, and system information and exfiltrate it to an attacker-controlled server. Unlike ransomware, it prioritizes stealth over disruption, often running briefly and deleting itself after collection.

## Why it matters
In 2022, the Raccoon Stealer v2 campaign compromised millions of browser-saved passwords and session cookies, enabling attackers to bypass MFA entirely by hijacking authenticated sessions. Defenders countering this threat focus on endpoint detection of suspicious process injection into browsers (e.g., Chrome's credential store) and monitoring for anomalous HTTPS POST requests to unknown external IPs.

## Key facts
- **Common targets**: Browser-saved credentials, autofill data, cryptocurrency wallet files, Discord/Steam tokens, and clipboard content (especially crypto addresses)
- **Delivery vectors**: Malvertising, phishing attachments, trojanized software (pirated games/tools), and YouTube video descriptions with fake download links
- **Exfiltration method**: Data is typically compressed, encrypted, and sent via HTTPS or Telegram Bot API to attacker infrastructure, evading basic network filters
- **Session cookie theft** allows attackers to perform **pass-the-cookie attacks**, defeating MFA without ever knowing the password
- **Notable families**: RedLine, Raccoon, Vidar, and LummaC2 — all sold as Malware-as-a-Service (MaaS) on dark web forums for $100–$300/month

## Related concepts
[[Credential Harvesting]] [[Session Hijacking]] [[Malware-as-a-Service]] [[Keylogger]] [[Command and Control (C2)]]