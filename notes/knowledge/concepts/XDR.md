# XDR

## What it is
Like a hospital's central monitoring station that pulls data from every ward's vitals monitor, lab system, and pharmacy log into one unified dashboard — XDR (Extended Detection and Response) correlates telemetry across endpoints, networks, email, cloud, and identity into a single detection and response platform. Unlike siloed tools, XDR automatically stitches together related alerts across layers to surface the full attack chain rather than isolated incidents.

## Why it matters
During a BEC (Business Email Compromise) campaign, an attacker compromises credentials via phishing, logs in from an anomalous IP, and begins exfiltrating data through cloud storage. A standalone EDR might flag the endpoint behavior; a standalone CASB might flag the cloud activity — but neither connects them. XDR correlates the email alert, the identity login anomaly, and the cloud data movement into a single incident, cutting mean time to detect (MTTD) from days to hours.

## Key facts
- XDR **extends EDR** by ingesting telemetry from multiple security domains: endpoint, network (NDR), email, cloud, and identity — not just endpoints
- Native XDR uses a single vendor's integrated tools; **Hybrid/Open XDR** integrates third-party tools via APIs
- XDR reduces **alert fatigue** by automatically correlating low-fidelity alerts into high-confidence incidents
- Key metric improvement: XDR is designed to reduce both **MTTD** (Mean Time to Detect) and **MTTR** (Mean Time to Respond)
- XDR sits above SIEM in the alert-triage hierarchy but may **complement rather than replace** SIEM, which handles compliance logging and long-term retention

## Related concepts
[[EDR]] [[SIEM]] [[SOAR]] [[NDR]] [[Threat Intelligence]]