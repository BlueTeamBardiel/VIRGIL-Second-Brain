# MITRE ATT&CK T1040

## What it is
Like a wiretap on a phone line, where a listener captures every word spoken between two parties without either knowing — Network Sniffing is the passive capture of network traffic as it traverses a medium. Attackers use tools like Wireshark, tcpdump, or custom scripts to intercept packets traveling across a network segment, extracting credentials, session tokens, or sensitive data in cleartext.

## Why it matters
During the 2013 Target breach, attackers moved laterally through the internal network and sniffed point-of-sale traffic to harvest unencrypted credit card data in memory before it could be encrypted. This demonstrates why encrypting data **in transit** is non-negotiable — sniffing is trivially easy on unencrypted protocols like HTTP, FTP, and Telnet.

## Key facts
- Passive sniffing on a **switched network** requires an adversary to be on the same collision domain or use techniques like ARP poisoning to redirect traffic first
- Protocols vulnerable to sniffing include **HTTP, FTP, Telnet, SMTP, and LDAP** (cleartext) — TLS/SSL renders captured packets unreadable
- Tools commonly associated: **Wireshark, tcpdump, dsniff, Ettercap**
- Detection is difficult because sniffing is **read-only** — it generates no anomalous traffic of its own; promiscuous mode on a NIC is a key indicator
- Defenses include **network encryption (TLS/HTTPS), switched network architecture, 802.1X port authentication, and IDS signatures** for known sniffing tool traffic

## Related concepts
[[ARP Poisoning]] [[Man-in-the-Middle Attack]] [[Credential Access]] [[Protocol Analysis]] [[Promiscuous Mode Detection]]