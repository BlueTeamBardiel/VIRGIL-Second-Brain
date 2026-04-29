# Zeek Scripting

## What it is
Like a building inspector who doesn't just check if the door is locked but reads every contract signed inside, Zeek scripting lets you write custom logic that reasons about *network behavior* rather than just packet bytes. Zeek (formerly Bro) is a network analysis framework where scripts written in its domain-specific language define event handlers that fire when specific network conditions occur — a TCP handshake completes, a DNS query resolves, an SSL certificate is presented. The result is structured, contextual logs rather than raw packet captures.

## Why it matters
During the SolarWinds supply chain attack, defenders needed to identify C2 beaconing hidden inside legitimate-looking HTTPS traffic. A Zeek script could correlate SSL certificate fields, connection intervals, and byte ratios to flag statistically regular outbound connections — something a simple firewall rule or signature-based IDS would never catch. This demonstrates Zeek's power as a behavioral detection tool rather than a reactive signature engine.

## Key facts
- Zeek uses an **event-driven model**: scripts define handlers like `event http_request()` or `event dns_request()` that trigger automatically on parsed protocol activity
- Zeek produces **structured log files** (conn.log, dns.log, http.log, ssl.log) consumable by SIEMs like Splunk — critical for CySA+ log analysis scenarios
- Scripts can maintain **state across connections** using tables and sets, enabling detection of slow-burn attacks like port scanning or credential stuffing
- Zeek operates **passively on a network tap or SPAN port**, making it invisible to attackers — no inline blocking like an IPS
- The `Intel Framework` in Zeek allows scripts to match live traffic against **threat intelligence feeds** (IPs, domains, file hashes) in real time

## Related concepts
[[Network Traffic Analysis]] [[SIEM Log Aggregation]] [[Intrusion Detection Systems]] [[Threat Intelligence Feeds]] [[Protocol Dissection]]