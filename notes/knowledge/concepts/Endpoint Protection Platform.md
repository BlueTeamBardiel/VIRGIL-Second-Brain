# Endpoint Protection Platform

## What it is
Think of an EPP as the immune system built into every laptop and workstation — it recognizes known pathogens (malware signatures) and kills them before symptoms appear. Precisely, an Endpoint Protection Platform is an integrated security solution deployed on endpoint devices that combines antivirus, anti-malware, firewall, data loss prevention, and device control into a single unified agent. Unlike standalone antivirus, EPP operates as a preventive-first platform managed centrally across an enterprise fleet.

## Why it matters
In the 2017 NotPetya attack, organizations without cohesive endpoint protection watched the wiper malware propagate laterally within minutes across unprotected Windows endpoints. A properly configured EPP with application whitelisting and exploit prevention could have blocked the malicious MBR overwrite before execution, containing the blast radius significantly. This scenario illustrates why EPP is the first line of defense before EDR (detection/response) capabilities even engage.

## Key facts
- EPP focuses on **prevention** — blocking known threats via signatures, heuristics, and behavioral rules — while EDR focuses on **detection and response** after suspicious activity occurs
- Modern EPPs integrate **Next-Gen AV (NGAV)**, which uses machine learning models rather than purely signature-based detection, catching zero-day variants
- EPP agents enforce **device control policies** — blocking unauthorized USB drives, which is a common data exfiltration and malware delivery vector
- On Security+/CySA+ exams, EPP is typically contrasted with **EDR** and **XDR**: EPP = prevent, EDR = detect/respond, XDR = cross-layer correlation
- EPPs are managed through a **centralized console** (cloud or on-prem), enabling policy enforcement, compliance reporting, and fleet-wide threat visibility

## Related concepts
[[Endpoint Detection and Response]] [[Next-Generation Antivirus]] [[Extended Detection and Response]] [[Application Whitelisting]] [[Data Loss Prevention]]