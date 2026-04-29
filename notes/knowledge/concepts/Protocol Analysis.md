# Protocol Analysis

## What it is
Like a translator listening to a foreign conversation and breaking it into grammar rules, subject, and verb — protocol analysis is the process of capturing and dissecting network traffic to understand exactly how communication protocols behave at a granular level. It involves examining packet headers, payloads, timing, and sequencing to verify that protocols operate as specified or to uncover deviations that indicate misconfiguration or attack.

## Why it matters
During the discovery phase of a penetration test, an analyst running Wireshark on a corporate network captures unencrypted LDAP authentication traffic — revealing plaintext credentials being transmitted between a workstation and a domain controller. This finding exposes a critical misconfiguration where LDAP signing was disabled, and protocol analysis was the exact technique that made it visible.

## Key facts
- **Wireshark** is the industry-standard tool for protocol analysis; it can decode hundreds of protocols including TCP, DNS, HTTP, SMB, and TLS handshakes
- Protocol analysis can reveal **cleartext protocols in use** (Telnet, FTP, HTTP) that should be replaced with encrypted alternatives
- **Anomaly detection** relies on protocol analysis baselines — deviations like oversized DNS payloads or unexpected ICMP types signal tunneling or exfiltration
- TLS/SSL inspection (SSL decryption at a proxy) is required to perform protocol analysis on encrypted traffic without endpoint agents
- Protocol analysis is distinct from **NetFlow analysis** — NetFlow shows metadata (who talked to whom, how much), while protocol analysis shows the actual conversation content and structure

## Related concepts
[[Packet Capture]] [[Network Traffic Analysis]] [[Intrusion Detection Systems]] [[Deep Packet Inspection]] [[NetFlow Analysis]]