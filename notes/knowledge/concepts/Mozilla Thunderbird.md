# Mozilla Thunderbird

## What it is
Think of it like a post office you install on your own computer — it picks up your mail from remote servers and lets you read, write, and organize it locally. Mozilla Thunderbird is an open-source, cross-platform email client (MUA — Mail User Agent) that supports protocols like IMAP, POP3, and SMTP, along with extensions for encryption and digital signing via S/MIME and OpenPGP.

## Why it matters
Thunderbird is a frequent target in phishing campaigns because it supports HTML email rendering and embedded content — attackers craft malicious emails with tracking pixels or hyperlinks that execute drive-by downloads when opened. On the defensive side, Thunderbird's native OpenPGP integration (added in version 78) allows users to sign and encrypt emails end-to-end without third-party plugins, making it a practical tool for organizations handling sensitive communications who want verifiable message integrity.

## Key facts
- Supports **S/MIME** and **OpenPGP** natively for email encryption and digital signatures — both are testable standards on Security+
- Uses **IMAP** (port 143/993) to sync mail server-side and **POP3** (port 110/995) to download and delete from server — port numbers are exam-relevant
- As an open-source client, it has no vendor telemetry by default, reducing data exfiltration risk compared to cloud-based clients
- Thunderbird can be misconfigured to accept **self-signed certificates** silently, creating a man-in-the-middle risk on corporate networks
- Its extension/add-on system has historically introduced vulnerabilities — supply chain risk via malicious add-ons mirrors broader software supply chain threats

## Related concepts
[[Email Protocols (IMAP POP3 SMTP)]] [[S/MIME]] [[OpenPGP]] [[Phishing]] [[Man-in-the-Middle Attack]]