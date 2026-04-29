# Microchip IStaX

## What it is
Think of it as the operating system firmware baked directly into a managed industrial switch — the invisible brain deciding which VLAN traffic flows where before a human ever logs in. IStaX (Industrial Switch Software Stack) is Microchip Technology's embedded software stack that runs on their managed Ethernet switch chips, providing Layer 2/3 switching features including VLAN management, RSTP, IGMP snooping, and port security in industrial and enterprise environments.

## Why it matters
In 2023, vulnerabilities were disclosed in IStaX-based switches where improper input validation in the web management interface allowed unauthenticated remote attackers to execute arbitrary OS commands — a classic pre-auth RCE scenario. An attacker on the same network segment could fully compromise the switch, reroute traffic, disable port security, or pivot deeper into OT/ICS environments where these switches are common. This illustrates why firmware-level switch software is a high-value OT attack surface often overlooked during network security assessments.

## Key facts
- IStaX powers Microchip's SMB-8000 and similar managed switch product lines commonly deployed in industrial control and SCADA environments
- CVE-2023-49695 and related CVEs documented critical vulnerabilities including OS command injection and cross-site scripting in the IStaX web UI
- The attack surface includes the HTTP/HTTPS management interface, SNMP, and CLI — all exposed by default in factory configurations
- Affected devices often run in air-gapped or OT networks, meaning patching cadence is slow and exposure windows are long
- CISA issued an ICS advisory (ICSA-23-353-01) specifically for IStaX vulnerabilities, flagging critical infrastructure risk

## Related concepts
[[Industrial Control System (ICS) Security]] [[Firmware Vulnerability]] [[VLAN Hopping]] [[OT Network Segmentation]] [[CVE Disclosure Process]]