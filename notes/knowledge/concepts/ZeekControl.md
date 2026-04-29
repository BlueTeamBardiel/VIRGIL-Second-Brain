# ZeekControl

## What it is
Think of ZeekControl as the cockpit dashboard for a commercial airliner — it doesn't fly the plane itself, but it's where you start engines, monitor systems, and coordinate everything. ZeekControl (`zeekctl`) is the command-line management framework used to deploy, configure, start, stop, and monitor Zeek (formerly Bro) network security monitoring instances. It abstracts the complexity of managing single-node or clustered Zeek deployments into simple, repeatable commands.

## Why it matters
During a threat hunting operation after a suspected data exfiltration event, a SOC analyst uses ZeekControl to deploy Zeek across multiple network tap points simultaneously, then runs `zeekctl deploy` to push a new configuration that increases logging verbosity for DNS and HTTP traffic. Without ZeekControl, managing a multi-sensor Zeek cluster would require manually SSHing into each node — a slow, error-prone process that costs critical response time during an active incident.

## Key facts
- Core commands: `zeekctl start`, `zeekctl stop`, `zeekctl deploy`, `zeekctl status`, and `zeekctl check` — `deploy` is required to push config changes
- ZeekControl reads from `zeekctl.cfg` (global settings) and `node.cfg` (defines cluster roles: manager, proxy, worker)
- Log rotation and archiving are handled automatically by ZeekControl's cron-based `zeekctl cron` command, which also checks for crashed processes
- Workers handle packet capture and analysis; the manager aggregates logs — ZeekControl orchestrates this division of labor
- Zeek produces rich, structured logs (conn.log, dns.log, http.log, ssl.log) that feed directly into SIEMs like Splunk or Elastic Stack for detection and analysis

## Related concepts
[[Zeek Network Monitor]] [[Network Security Monitoring]] [[SIEM Integration]] [[Packet Capture]] [[Intrusion Detection System]]