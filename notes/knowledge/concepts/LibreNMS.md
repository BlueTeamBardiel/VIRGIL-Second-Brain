# LibreNMS

## What it is
Like a hospital's central monitoring station tracking every patient's vitals simultaneously, LibreNMS is an open-source auto-discovering network monitoring system (NMS) that continuously polls devices via SNMP, ICMP, and other protocols to track health, performance, and availability across your entire infrastructure. It builds and maintains a live map of your network topology, alerting operators when devices deviate from baseline behavior.

## Why it matters
During an incident response engagement, a blue team analyst used LibreNMS's historical bandwidth graphs to identify a compromised router that had been exfiltrating data at 2 AM for three weeks — traffic invisible to the SOC because no one had set a baseline alert threshold. This illustrates why continuous network baselining is critical: anomaly detection only works if you've captured what "normal" looks like. Conversely, attackers who compromise a LibreNMS instance gain a complete, labeled map of the network — making the NMS itself a high-value target.

## Key facts
- Uses **SNMPv1/v2c/v3** for device polling; SNMPv3 is the only version offering authentication and encryption, making it the CySA+ recommended standard
- Auto-discovery uses **ARP tables, CDP/LLDP, and SNMP walks** to map network topology without manual entry
- Supports **threshold-based and rate-of-change alerting**, enabling both static (CPU > 90%) and behavioral anomaly detection
- LibreNMS stores metrics in **RRDtool or InfluxDB**, enabling long-term trend analysis relevant to forensic timelines
- Default credentials and unauthenticated API endpoints in misconfigured deployments have been exploited in real CVEs (e.g., **CVE-2018-20434**, remote code execution via device name injection)

## Related concepts
[[SNMP]] [[Network Baseline]] [[Network Discovery]] [[Syslog]] [[SIEM]]