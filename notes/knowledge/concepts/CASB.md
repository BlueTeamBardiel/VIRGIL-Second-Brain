# CASB

## What it is
Think of a CASB like a customs officer stationed between your employees and every cloud service they use — inspecting what goes in and out, enforcing policies, and stopping contraband. A Cloud Access Security Broker is a security enforcement point, either on-premises or cloud-hosted, that sits between enterprise users and cloud service providers to apply security policies, enforce compliance, and provide visibility into shadow IT.

## Why it matters
A healthcare employee uploads a spreadsheet containing 10,000 patient records to their personal Dropbox account — a HIPAA violation that the company's firewall never sees. A CASB deployed in API mode detects the upload by integrating directly with Dropbox's API, identifies the sensitive data via DLP inspection, blocks the transfer, and alerts the security team — all without touching network traffic. Without the CASB, this data exfiltration would be invisible.

## Key facts
- CASBs operate across **four pillars**: Visibility, Compliance, Data Security, and Threat Protection
- **Three deployment modes**: Forward proxy (inline, agent-based), Reverse proxy (agentless, session-based), and API mode (out-of-band, integrates with cloud provider APIs)
- CASBs are a primary tool for discovering and controlling **shadow IT** — unauthorized cloud apps employees use without IT approval
- CASBs can enforce **UEBA** (User and Entity Behavior Analytics) to detect anomalies like logins from impossible geographic locations
- Gartner coined the term "CASB" in 2012; today it is often integrated into **SASE** (Secure Access Service Edge) architectures

## Related concepts
[[Shadow IT]] [[Data Loss Prevention]] [[Zero Trust Architecture]] [[SASE]] [[Cloud Security]]