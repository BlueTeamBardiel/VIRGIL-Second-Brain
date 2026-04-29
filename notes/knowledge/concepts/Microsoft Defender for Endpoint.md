# Microsoft Defender for Endpoint

## What it is
Think of it as a security camera system that doesn't just record footage but also calls the police, locks the doors, and files the incident report automatically. Microsoft Defender for Endpoint (MDE) is a cloud-powered enterprise EDR (Endpoint Detection and Response) platform that continuously monitors endpoints for threats, provides behavioral analysis, automated investigation, and integrates threat intelligence to detect and respond to advanced attacks.

## Why it matters
During a ransomware campaign like the 2021 REvil attacks, MDE's behavioral monitoring could detect the anomalous process tree — a Word document spawning PowerShell spawning a network connection — and isolate the infected host before lateral movement occurs. Without EDR telemetry, security teams are essentially flying blind during the critical early minutes of an intrusion, relying on static signatures that modern attackers easily bypass.

## Key facts
- Uses **Microsoft Threat Intelligence** combined with behavioral sensors baked into the Windows OS kernel — no separate agent needed on Windows 10/11 Enterprise
- Provides **Attack Surface Reduction (ASR) rules** that block specific behaviors like Office spawning child processes, a common malware technique
- **Device isolation** allows remote containment of a compromised endpoint while maintaining the management channel for investigation
- Operates on a **"assume breach" model**, focusing on detection and containment rather than purely prevention — aligns with NIST CSF's Detect/Respond functions
- Integrates with **Microsoft Sentinel** for SIEM correlation and supports **automated remediation playbooks**, reducing mean time to respond (MTTR)

## Related concepts
[[Endpoint Detection and Response]] [[Attack Surface Reduction]] [[Behavioral Analysis]] [[SIEM Integration]] [[Threat Intelligence]]