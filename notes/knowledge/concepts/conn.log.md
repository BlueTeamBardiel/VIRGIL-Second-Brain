# conn.log

## What it is
Think of it as a phone company's call detail records — not the conversation itself, but who called whom, when, for how long, and how much data moved. Precisely, `conn.log` is Zeek's (formerly Bro) primary network log file that records metadata for every completed network connection observed on the wire, including source/destination IPs, ports, protocol, duration, and bytes transferred.

## Why it matters
During a ransomware investigation, analysts used `conn.log` to identify a compromised host making thousands of short-duration connections to an external IP over port 443 — a classic beaconing pattern from C2 malware. The regularity of connection intervals (every 60 seconds, nearly identical byte counts) exposed the infection even though the traffic was encrypted, because the *behavior* was visible in the metadata.

## Key facts
- Every entry includes a unique connection UID (`uid`) that links across all other Zeek logs (dns.log, http.log, ssl.log) for full session reconstruction
- The `conn_state` field encodes the TCP handshake outcome: `SF` = normal established+closed, `S0` = SYN sent but no response (common in port scans), `REJ` = connection refused
- `orig_bytes` and `resp_bytes` track data volume in each direction — massive `resp_bytes` with tiny `orig_bytes` can indicate data exfiltration or drive-by downloads
- Duration field enables detection of long-lived connections (persistent shells, tunneling) vs. beaconing (many short, periodic connections)
- `conn.log` is a primary data source for CySA+ threat hunting scenarios involving lateral movement detection and C2 identification

## Related concepts
[[Zeek Network Security Monitor]] [[Network Flow Analysis]] [[Beaconing Detection]] [[SIEM Log Ingestion]] [[NetFlow]]