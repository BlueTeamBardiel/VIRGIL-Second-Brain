# dns.log

## What it is
Like a postal sorting facility's manifest — every package that comes through gets logged with sender, recipient, and type — dns.log is Zeek's (formerly Bro's) structured record of every DNS query and response observed on the network. It captures the full conversation: who asked, what they asked for, what type of record was requested, and what the server answered.

## Why it matters
DNS tunneling attacks — like those using tools such as iodine or dnscat2 — use DNS queries to smuggle data out of a network, encoding payloads in abnormally long subdomains like `aGVsbG8gd29ybGQ=.evil.com`. Analysts hunting this technique look in dns.log for anomalously high query volumes from a single host, unusually long subdomain strings, or repeated queries to rare top-level domains that never resolve — patterns invisible in raw packet captures but obvious in structured log analysis.

## Key facts
- Zeek's dns.log records fields including `ts`, `uid`, `id.orig_h` (querying host), `query` (domain name), `qtype_name` (e.g., A, AAAA, TXT, MX), `rcode_name` (NOERROR, NXDOMAIN), and `answers`
- A high rate of `NXDOMAIN` responses from one host is a classic indicator of DGA (Domain Generation Algorithm) malware trying to phone home
- TXT record queries are disproportionately rare in normal traffic; a spike signals potential DNS tunneling or C2 beaconing
- dns.log is a primary data source in threat hunting platforms like SIEM tools — it can be ingested directly into Elastic Stack or Splunk for correlation
- `uid` field links dns.log entries to conn.log entries, enabling full session reconstruction across Zeek log files

## Related concepts
[[DNS Tunneling]] [[Domain Generation Algorithm (DGA)]] [[Zeek (Bro) Network Monitoring]] [[C2 Beaconing]] [[SIEM Log Correlation]]
