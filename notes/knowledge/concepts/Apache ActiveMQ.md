# Apache ActiveMQ

## What it is
Think of it as a busy postal sorting facility — applications drop off messages, ActiveMQ routes them to the right recipients, even when the recipient isn't available yet. Precisely, Apache ActiveMQ is an open-source message broker that implements the Java Message Service (JMS) protocol, enabling asynchronous communication between distributed applications. It acts as middleware that decouples producers and consumers of data across enterprise systems.

## Why it matters
In November 2023, CVE-2023-46604 (CVSS 10.0) rocked enterprise environments — a critical RCE vulnerability in ActiveMQ's OpenWire protocol allowed unauthenticated attackers to execute arbitrary shell commands by sending a specially crafted ClassInfo packet. Ransomware groups including HelloKitty actively exploited this within days of disclosure, targeting exposed port 61616 to deploy payloads on unpatched brokers. Defenders had to race to patch or firewall-restrict that port before mass exploitation.

## Key facts
- **CVE-2023-46604** is the landmark ActiveMQ vulnerability — unauthenticated RCE via the OpenWire protocol on **port 61616** (the default broker port)
- ActiveMQ runs on **Java**, making it susceptible to Java deserialization attacks — a recurring attack class in enterprise middleware
- Default web admin console runs on **port 8161** with default credentials (`admin/admin`), a frequent misconfiguration finding
- Affected versions include ActiveMQ **< 5.15.16, < 5.16.7, < 5.17.6, < 5.18.3** — patch version knowledge matters for CySA+ triage scenarios
- Classified under **CWE-502 (Deserialization of Untrusted Data)** — a top-ranked weakness in enterprise Java applications

## Related concepts
[[Message Queue Poisoning]] [[Java Deserialization Attacks]] [[Remote Code Execution]] [[CVE Vulnerability Scoring]] [[Default Credential Exploitation]]