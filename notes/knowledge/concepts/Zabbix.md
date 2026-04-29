# Zabbix

## What it is
Think of Zabbix as a hospital's vital-signs monitor — constantly polling every device on your network for heartbeat, temperature, and blood pressure, then alerting staff the moment something flatlines. Precisely, Zabbix is an open-source enterprise network monitoring platform that tracks availability, performance metrics, and health of servers, network devices, and applications using agent-based or agentless collection. It stores metrics in a database and triggers configurable alerts when thresholds are breached.

## Why it matters
In 2022, attackers exploited **CVE-2022-23131** — a critical SAML SSO authentication bypass in Zabbix's web frontend — allowing unauthenticated users to hijack admin sessions by manipulating a session cookie without knowing credentials. A compromised Zabbix server is catastrophically dangerous because it has authenticated network access to *every monitored host* and often stores credentials used for agentless checks. Defenders must treat monitoring infrastructure as Tier-0 assets, patching aggressively and isolating Zabbix servers behind strict firewall rules.

## Key facts
- **Default credentials risk**: Zabbix historically ships with default credentials (`Admin`/`zabbix`), a common misconfiguration finding in penetration tests and audits
- **Agent ports**: Zabbix Agent listens on **TCP 10050**; the Zabbix Server communicates on **TCP 10051** — both are IOCs worth flagging in network traffic analysis
- **CVE-2022-23131**: CVSS 9.8 — unauthenticated RCE via SAML session bypass affecting Zabbix versions before 5.4.9/6.0.0beta1
- **Lateral movement vector**: Compromised Zabbix servers can execute remote commands on all monitored agents, making them a high-value pivot point for post-exploitation
- **Compliance relevance**: Zabbix is commonly deployed to satisfy continuous monitoring requirements under **NIST SP 800-137** and **PCI DSS Requirement 10**

## Related concepts
[[SIEM]] [[Network Monitoring]] [[CVE Exploitation]] [[Lateral Movement]] [[Default Credentials]]