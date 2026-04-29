# TryHackMe SOC Level 1 Path

A structured learning pathway on TryHackMe designed to build foundational Security Operations Center (SOC) skills, covering threat detection, incident response, and security monitoring fundamentals.

## Overview
The SOC Level 1 path provides hands‑on training for aspiring SOC analysts and security operations professionals, focusing on practical defensive security techniques and real‑world scenarios.

## Key Learning Areas
- Threat detection and analysis  
- Incident response procedures  
- Security monitoring and alerting  
- Log analysis and [[SIEM]] concepts  
- Network traffic analysis  
- Malware analysis basics  
- Incident handling workflows  

## Resource Type
- **Platform:** [[TryHackMe]]  
- **Level:** Beginner/Intermediate  
- **Format:** Interactive labs and modules  

## Tags
#soc #incident-response #threat-detection #security-operations #training  

---

## What Is It? (Feynman Version)  
Think of the SOC path as a boot camp for digital guards. Instead of training soldiers on the front line, it trains analysts to patrol a network’s telemetry, spot suspicious patterns, and kick off containment when something goes wrong.

## Why Does It Exist?  
Before SOC training existed, companies relied on ad‑hoc, reaction‑only defenses: someone noticed a breach late and then tried to fix it. The SOC path solves that by teaching a systematic, proactive playbook so incidents are caught early, containment is automated, and recovery costs shrink. A real failure: a bank suffered a ransomware attack because analysts had no structured alert‑to‑response workflow, costing millions in downtime.

## How It Works (Under The Hood)  
1. **Data Ingestion** – Devices, logs, network taps, and endpoint telemetry stream into a central hub.  
2. **Normalization** – Raw logs are parsed into a common schema (e.g., Syslog, Windows Event Log, NetFlow).  
3. **Correlation** – Rules or machine‑learning models compare events across sources; for example, a failed SSH login followed by a successful privileged command.  
4. **Alerting** – When a rule fires, an alert is generated with severity, context, and recommended actions.  
5. **Investigation** – Analysts dig deeper using dashboards, queries, and timeline views; they may pull raw packet captures or user‑agent data.  
6. **Response** – Depending on the playbook, the analyst may isolate a host, revoke a token, or deploy a remedial script.  
7. **Post‑Mortem** – Findings are documented, indicators are shared, and controls are tightened.

## What Breaks When It Goes Wrong?  
When ingestion stops, analysts never see the red flag—think of a broken sensor in a fire‑alarm system. If normalization fails, alerts are garbled and missed. Correlation rule errors cause false positives that overwhelm analysts, leading to alert fatigue. A single misconfigured firewall can let an attacker pivot, causing data exfiltration that hits revenue targets and erodes customer trust.

## Exam Angle  
- **Security+/CySA+/CCNA**: Look for questions that ask you to map a scenario to an SOC workflow, or to identify the correct alert‑to‑response sequence.  
- **Common Traps**: Mixing up “alert” (notification) with “incident” (full‑scale response). Remember that an incident is the event after an alert is validated.  
- **Mnemonic**: **“I CAN R”** – *Ingest, Correlate, Alert, Notify, Respond* – the five core steps of SOC operations.  

_Ingested: 2026-04-15 20:20 | Source: https://tryhackme.com/path/outline/soc1_