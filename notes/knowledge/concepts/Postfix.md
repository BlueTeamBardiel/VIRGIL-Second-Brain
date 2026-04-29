# Postfix

## What it is
Like a postal sorting facility that receives, routes, and delivers mail without caring what's inside the envelopes, Postfix is an open-source Mail Transfer Agent (MTA) that handles SMTP traffic — accepting, queuing, and forwarding email between servers. It runs on Linux/Unix systems and is one of the most widely deployed MTAs on the internet.

## Why it matters
A misconfigured Postfix server set to act as an **open relay** will forward email from any source to any destination, making it a free spam and phishing launchpad for attackers. In 2023-era phishing campaigns, threat actors actively scan for open relays using tools like Shodan, then weaponize them to send spoofed emails that appear to originate from a trusted domain, bypassing sender-reputation filters.

## Key facts
- Postfix listens on **TCP port 25** (SMTP) by default; secure submission uses ports **465** (SMTPS) or **587** (STARTTLS)
- The `mynetworks` directive controls which hosts are trusted to relay mail — a misconfigured wildcard here creates an open relay vulnerability
- Postfix supports **SPF, DKIM, and DMARC** enforcement via integration with tools like `policyd-spf` and `OpenDKIM`, which harden against spoofing
- Queue management commands (`postqueue -p`, `postsuper -d`) are critical for incident response when purging malicious mail stuck in transit
- Postfix replaced Sendmail in many environments due to Sendmail's historically large attack surface and complex configuration

## Related concepts
[[SMTP]] [[Open Relay]] [[Email Spoofing]] [[SPF Records]] [[DMARC]]