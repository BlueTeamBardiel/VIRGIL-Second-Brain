# Common Event Format

## What it is
Think of CEF like a universal power adapter for log data — no matter what device generated the event, it plugs into the same standard shape. Common Event Format (CEF) is a vendor-neutral, text-based log format developed by ArcSight (HP) that standardizes how security devices write event data, using a fixed header plus extensible key-value pairs.

## Why it matters
During a ransomware investigation, a SOC analyst must correlate logs from a Palo Alto firewall, a CrowdStrike EDR agent, and a Cisco IDS — three vendors with three completely different native formats. Because all three are configured to output CEF, the SIEM ingests and parses them identically, allowing the analyst to reconstruct the kill chain in minutes rather than hours spent writing custom parsers.

## Key facts
- CEF uses a pipe-delimited header with exactly 7 fixed fields: Version, Device Vendor, Device Product, Device Version, Signature ID, Name, and Severity.
- The header is followed by an extension field containing arbitrary key-value pairs (e.g., `src=192.168.1.5 dst=10.0.0.2 dpt=443`), making it highly flexible.
- Severity is expressed as a numeric value from **0 (lowest) to 10 (highest)**, enabling consistent prioritization across sources.
- CEF is transmitted over syslog (typically UDP/TCP port 514 or encrypted on 6514), making it natively compatible with most SIEM ingestion pipelines.
- It is commonly contrasted with **LEEF** (Log Event Extended Format), IBM's competing standard used by QRadar, and **JSON**-based log formats used in cloud-native environments.

## Related concepts
[[SIEM]] [[Syslog]] [[Log Aggregation]] [[Security Information and Event Management]] [[LEEF]]