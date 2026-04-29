# Velociraptor

## What it is
Like having a hunting pack of trained investigators that can simultaneously search every corner of a massive building in seconds — Velociraptor is an open-source endpoint detection, response, and digital forensics platform. It deploys lightweight agents (clients) across thousands of endpoints that report back to a central server, enabling real-time hunting, artifact collection, and forensic triage at enterprise scale.

## Why it matters
During an active ransomware incident, a security team needs to know within minutes which of 5,000 machines have a malicious process running or a specific registry key modified. Velociraptor can push a VQL (Velociraptor Query Language) hunt across all endpoints simultaneously and return results in under a minute, far faster than manually triaging hosts or waiting for SIEM correlation to catch up. This speed is the difference between containment and catastrophic lateral spread.

## Key facts
- Uses **VQL (Velociraptor Query Language)** — a SQL-like language purpose-built for querying endpoint state, artifacts, and forensic data in real time
- Supports collection of **forensic artifacts** including Windows event logs, prefetch files, MFT entries, registry hives, and browser history without installing additional tools
- Operates on a **client-server architecture** where the server issues hunts and clients (agents) execute them locally, reducing network overhead
- Artifacts are defined as **YAML templates**, making them shareable, version-controlled, and customizable — the community maintains a public artifact exchange
- Commonly used alongside **SIEM and SOAR platforms** to enrich detections; not a replacement for logging infrastructure but a rapid triage and hunting layer

## Related concepts
[[Digital Forensics and Incident Response (DFIR)]] [[Endpoint Detection and Response (EDR)]] [[Threat Hunting]] [[SIEM]] [[Indicators of Compromise (IOC)]]