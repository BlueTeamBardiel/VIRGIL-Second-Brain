# Cortex

## What it is
Think of Cortex as the nervous system that receives raw threat signals from across your entire body and decides how to respond — automatically. Cortex (by Palo Alto Networks) is a cloud-based detection and response platform that integrates EDR, XDR, and SOAR capabilities into a unified engine. It ingests telemetry from endpoints, networks, and cloud environments, then uses behavioral analytics and machine learning to detect and respond to threats.

## Why it matters
During a ransomware incident, a SOC analyst using Cortex XDR can observe the full attack chain — from a phishing email opening a malicious macro, to lateral movement via PsExec, to file encryption — all correlated in a single incident view. Without this stitched-together context, analysts see only disconnected alerts and waste critical response time. Cortex can automatically isolate the infected endpoint before the encryption spreads, compressing hours of manual triage into seconds.

## Key facts
- **Cortex XDR** extends detection beyond endpoints (EDR) to include network, cloud, and third-party log sources — the "X" stands for *extended*
- Uses **behavioral analytics** (not just signatures) to detect living-off-the-land attacks like malicious PowerShell or LOLBins abuse
- **Cortex XSOAR** is the SOAR component — it automates playbook-driven responses such as blocking IPs, quarantining hosts, or opening tickets
- Correlates alerts into **causality chains** using a patented Causality Analysis Engine (CAE), reducing alert fatigue significantly
- Relevant to CySA+ objectives covering **threat intelligence integration**, **incident response automation**, and **security orchestration**

## Related concepts
[[XDR]] [[SIEM]] [[SOAR]] [[EDR]] [[Behavioral Analytics]]