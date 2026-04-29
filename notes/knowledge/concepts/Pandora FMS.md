# Pandora FMS

## What it is
Think of it as a control tower that watches every plane, runway, and radar system simultaneously — Pandora FMS (Flexible Monitoring System) is an open-source enterprise monitoring platform that tracks network devices, servers, applications, and security events from a single console. It collects metrics, generates alerts, and provides visibility across hybrid IT infrastructures.

## Why it matters
In 2021, a critical unauthenticated remote code execution vulnerability (CVE-2021-32099) was discovered in Pandora FMS that allowed attackers to exploit an SQL injection flaw in the web console to achieve full system compromise. Because Pandora FMS agents run with elevated privileges and the platform often has broad network access, a successful exploit effectively handed attackers keys to the entire monitored infrastructure — turning the watchtower into the attacker's command post.

## Key facts
- **CVE-2021-32099**: SQL injection in Pandora FMS versions before 7.0 NG 742 allowed unauthenticated RCE — a critical CVSS 9.8 vulnerability
- Pandora FMS uses **agents installed on monitored systems** that report back to a central server, creating a large attack surface if the server is compromised
- It supports **SNMP, WMI, and custom plugins**, making it common in mixed Windows/Linux enterprise environments
- The platform's **event correlation and alerting** capabilities overlap with SIEM functionality, so it often appears in SOC toolchains alongside dedicated SIEMs
- Default installations may expose the **web console on port 8080** without enforced authentication hardening, a common misconfiguration finding in penetration tests

## Related concepts
[[SIEM]] [[Network Monitoring]] [[Remote Code Execution]] [[SQL Injection]] [[Attack Surface Management]]