# Thunderbird

## What it is
Like a postal worker who sorts, delivers, and stores your physical mail — Mozilla Thunderbird is a free, open-source desktop email client that fetches, displays, and manages email messages locally on your machine. It communicates with mail servers using standard protocols (IMAP, POP3, SMTP) and stores messages in local folders rather than relying solely on a web interface.

## Why it matters
In a phishing investigation, a SOC analyst might examine a victim's Thunderbird profile folder (stored at `~/.thunderbird/` on Linux or `%APPDATA%\Thunderbird\` on Windows) to recover raw email headers — revealing the true originating IP address of a phishing email despite spoofed display names. Thunderbird also supports S/MIME and OpenPGP encryption natively, meaning improperly configured keys can create false confidence that messages are authenticated when they aren't.

## Key facts
- Thunderbird stores emails locally in **Mbox** or **Maildir** formats; forensic investigators can parse these files directly without needing server access
- Supports **S/MIME** (certificate-based) and **OpenPGP** (key-based) encryption and digital signatures — relevant to email integrity and non-repudiation concepts on Security+
- Vulnerable to **malicious attachment** attacks and historically to **JavaScript injection** before scripting was disabled by default in email rendering
- The Thunderbird profile directory contains **logins.json** and **key4.db**, which store saved email credentials — a high-value target for credential-harvesting malware
- Uses **IMAP (port 143/993)** and **POP3 (port 110/995)** for receiving; **SMTP (port 25/465/587)** for sending — port knowledge is directly exam-tested

## Related concepts
[[Email Protocols (IMAP POP3 SMTP)]] [[S/MIME]] [[OpenPGP]] [[Phishing]] [[Email Header Analysis]]