# MITRE ATT&CK T1040 Network Sniffing

## What it is
Like a postal worker secretly steaming open envelopes to read letters before resealing them, network sniffing places a network interface into **promiscuous mode** to capture traffic not addressed to that host. Adversaries use this passive technique to harvest credentials, session tokens, and sensitive data flowing across a network segment in cleartext or weakly encrypted form.

## Why it matters
During the 2013 Target breach, attackers moved laterally through the internal network and used sniffing techniques to capture point-of-sale credentials traversing the network unencrypted. Had network segmentation and encrypted protocols been enforced between POS systems and backend servers, the captured traffic would have been useless ciphertext.

## Key facts
- **Promiscuous mode** allows a NIC to capture all packets on a segment, not just those addressed to its MAC — detectable via tools like `ip link` or ARP response timing analysis
- Common sniffing tools include **Wireshark**, **tcpdump**, **Ettercap**, and **Dsniff** — all legitimate admin tools that dual-use as attack weapons
- Sniffing is most effective on **hub-based networks** or after an **ARP poisoning** attack forces traffic through the attacker's machine on switched networks
- T1040 maps to **Discovery and Credential Access** tactics in ATT&CK, making it a dual-category technique
- Detection relies on **network anomaly monitoring**, identifying hosts in promiscuous mode, and enforcing **TLS/encryption** to render captures valueless

## Related concepts
[[ARP Poisoning]] [[Man-in-the-Middle Attack]] [[Promiscuous Mode Detection]] [[Credential Access]] [[Packet Capture Analysis]]