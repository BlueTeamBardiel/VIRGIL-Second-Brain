# Automated Discovery

## What it is
Like a robotic mail carrier that photographs every house, mailbox, and doorbell on a street before a burglar even picks a target — automated discovery is the systematic, tool-driven process of identifying assets, services, open ports, vulnerabilities, and configurations across a network without manual enumeration. It replaces slow, error-prone human reconnaissance with repeatable, scalable scanning workflows.

## Why it matters
During the SolarWinds supply chain attack, defenders who had automated asset discovery tools detected anomalous new processes and unexpected outbound connections faster than organizations relying on manual audits. Without knowing what "normal" looks like across every asset, defenders cannot distinguish compromised hosts from clean ones — automated discovery provides that baseline continuously.

## Key facts
- **Nmap** is the canonical port/service discovery tool; `-sV` detects service versions, `-O` fingerprints the OS — both critical for vulnerability mapping
- Automated discovery feeds directly into **vulnerability scanners** (e.g., Nessus, Qualys) which correlate open services against CVE databases
- **Passive discovery** (listening to traffic) vs. **active discovery** (sending probes) — active scanning can trigger IDS alerts and is illegal without authorization
- On Security+/CySA+, automated discovery is a core phase of **reconnaissance** in both offensive (red team) and defensive (asset inventory) contexts
- **CMDB (Configuration Management Database)** is the structured output of ongoing automated discovery — used to track asset state over time

## Related concepts
[[Network Scanning]] [[Vulnerability Assessment]] [[Asset Inventory]] [[Reconnaissance]] [[CMDB]]