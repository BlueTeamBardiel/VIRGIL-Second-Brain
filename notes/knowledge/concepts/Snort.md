# Snort

## What it is
Think of Snort as a security guard reading every piece of mail entering a building — not just checking the envelope, but opening it and comparing the contents against a binder of known threat signatures. Snort is an open-source Network Intrusion Detection/Prevention System (NIDS/NIPS) that inspects network packets in real time, matching traffic against rule sets to detect or block malicious activity. It operates in three modes: packet sniffer, packet logger, and full NIDS/NIPS.

## Why it matters
During a SQL injection campaign, an attacker sends crafted HTTP requests containing strings like `' OR 1=1--` to a web server. A properly tuned Snort rule can detect that exact pattern in the packet payload, trigger an alert to the SOC, and — in inline (NIPS) mode — drop the packet before it ever reaches the database, stopping the attack mid-flight.

## Key facts
- **Three operational modes:** Sniffer (displays packets), Logger (saves packets to disk), NIDS/NIPS (applies rules to detect or prevent threats)
- **Rule anatomy:** Rules follow the structure `action protocol src_ip src_port -> dst_ip dst_port (options)` — knowing this format is exam-relevant
- **Detection method:** Primarily **signature-based** (rule-driven), but can perform **protocol anomaly detection** as well
- **Rule sets:** Snort uses community rules (free), Talos Subscriber rules (paid, updated faster), making rule currency critical for detection accuracy
- **Inline vs. passive:** In passive mode Snort only alerts; in inline (NIPS) mode it can actively drop, reject, or modify malicious packets

## Related concepts
[[Intrusion Detection System (IDS)]] [[Intrusion Prevention System (IPS)]] [[Signature-Based Detection]] [[Suricata]] [[Network Traffic Analysis]]