# Suricata

## What it is
Think of Suricata as a highway weigh station with a forensics lab built in — it doesn't just flag overweight trucks, it photographs, fingerprints, and logs every vehicle passing through. Precisely, Suricata is an open-source, multi-threaded network threat detection engine capable of functioning as an Intrusion Detection System (IDS), Intrusion Prevention System (IPS), or Network Security Monitor (NSM). Unlike single-threaded alternatives, it processes traffic across multiple CPU cores simultaneously, making it viable for high-throughput enterprise environments.

## Why it matters
During a ransomware campaign, attackers often use DNS beaconing to communicate with command-and-control servers at regular intervals. Suricata can detect this pattern using protocol anomaly detection and pre-written signatures from the Emerging Threats ruleset, generating alerts that a SOC analyst can pivot on — all while logging full packet captures for forensic reconstruction of the attacker's kill chain.

## Key facts
- Suricata operates in three modes: **IDS** (passive monitoring), **IPS** (inline blocking via NFQUEUE or AF_PACKET), and **NSM** (full network logging)
- Natively supports **Lua scripting** for custom detection logic beyond static signature rules, enabling behavioral detection
- Outputs logs in **EVE JSON format**, making it natively compatible with SIEMs like Splunk and Elastic Stack
- Supports **protocol identification via application-layer inspection** (HTTP, DNS, TLS, SMB) regardless of port number — defeating port-obfuscation techniques
- Shares the **Snort rule syntax** for signatures but extends it with additional keywords like `http.method` and `tls.sni`, meaning Snort rules are largely portable to Suricata

## Related concepts
[[Snort]] [[Intrusion Detection System]] [[Network Security Monitoring]] [[PCAP Analysis]] [[Emerging Threats Ruleset]]