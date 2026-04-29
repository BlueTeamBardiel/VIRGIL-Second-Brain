# Extended Detection and Response

## What it is
Think of XDR as the difference between having separate smoke detectors in every room versus a smart home system that correlates the smoke alarm, the heat sensor, and the door lock activity to tell you *exactly* where the fire started and how the intruder got in. XDR is a unified security platform that integrates telemetry across endpoints, networks, email, cloud workloads, and identity systems to detect, investigate, and respond to threats through a single correlated view. Unlike siloed tools, XDR breaks down data boundaries to surface attack patterns that individual products would miss.

## Why it matters
During a real-world supply chain attack like SolarWinds, an endpoint solution alone would see suspicious PowerShell activity, but a network tool would separately log unusual DNS beaconing — and neither would connect the dots automatically. XDR correlates those signals across layers, compressing what might be weeks of manual investigation into hours by mapping the full attack chain through a single console. This dramatically reduces mean time to detect (MTTD) and mean time to respond (MTTR).

## Key facts
- XDR evolved from EDR (Endpoint Detection and Response) by expanding telemetry ingestion beyond the endpoint to include network, cloud, and email sources
- Native XDR integrates vendor-proprietary tools; Open XDR (or Hybrid XDR) ingests third-party data via APIs and open standards
- XDR reduces alert fatigue by correlating individual low-fidelity alerts into high-confidence incident stories
- Key differentiator from SIEM: XDR includes built-in automated response actions, not just detection and logging
- CySA+ exam distinguishes XDR from SOAR — SOAR orchestrates workflows across tools, while XDR provides the integrated detection layer

## Related concepts
[[Endpoint Detection and Response]] [[Security Information and Event Management]] [[Security Orchestration Automation and Response]]