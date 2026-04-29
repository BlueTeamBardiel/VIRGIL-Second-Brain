# Masscan

## What it is
Think of Masscan as a firehose compared to Nmap's garden hose — both deliver water, but one can drench an entire city block in seconds. Masscan is an open-source TCP port scanner capable of scanning the entire IPv4 internet (~4 billion addresses) in under 6 minutes by transmitting up to 25 million packets per second using asynchronous, stateless packet transmission.

## Why it matters
During a large-scale reconnaissance phase, an attacker or red team operator can use Masscan to rapidly identify every internet-exposed host running RDP (port 3389) across an entire ASN (Autonomous System Number) in minutes — work that would take Nmap hours. Defenders use it in asset discovery to find shadow IT or rogue devices that shouldn't be internet-facing before attackers do.

## Key facts
- Uses a **custom TCP/IP stack** (bypassing the OS network stack) to achieve its extreme speed — this also means it can overwhelm and crash poorly configured network equipment
- Outputs results in formats compatible with **Nmap** (XML), making it common to chain Masscan for fast discovery → Nmap for deep service fingerprinting
- Default rate is **100 packets/second** to prevent network disruption; operators must explicitly increase this with `--rate`
- Performs **stateless SYN scanning** — it sends SYN packets and listens for SYN-ACKs without maintaining connection state, similar to Nmap's `-sS` but at massive scale
- Because it generates massive traffic volumes, Masscan scans are **highly detectable** by IDS/IPS systems and will appear clearly in NetFlow analysis and firewall logs

## Related concepts
[[Nmap]] [[Port Scanning]] [[SYN Scan]] [[Network Reconnaissance]] [[Asset Discovery]]