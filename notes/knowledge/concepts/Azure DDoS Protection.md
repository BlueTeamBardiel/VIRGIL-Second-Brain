# Azure DDoS Protection

## What it is
Think of it as a bouncer at a nightclub who can instantly recognize and eject thousands of fake guests flooding the entrance, keeping the line moving for real patrons. Azure DDoS Protection is a cloud-native service that detects and mitigates volumetric, protocol, and application-layer distributed denial-of-service attacks against Azure-hosted resources in real time. It operates at the network perimeter, scrubbing malicious traffic before it ever reaches your virtual machines or load balancers.

## Why it matters
In 2021, Microsoft mitigated a 2.4 Tbps DDoS attack targeting an Azure customer in Europe — one of the largest ever recorded. Without Azure DDoS Protection, that flood of UDP reflection traffic would have saturated the target's bandwidth and taken services offline entirely. The service's adaptive tuning automatically baselins normal traffic patterns and throttles anomalies without requiring manual intervention.

## Key facts
- **Two tiers:** DDoS Network Protection (per-VNet, ~$2,944/month, covers up to 100 resources) and DDoS IP Protection (per-public IP, pay-per-resource, no VNet requirement)
- **Always-on monitoring:** Traffic telemetry is analyzed 24/7; mitigation triggers automatically when attack signatures are detected — no manual activation needed
- **Covers all three DDoS attack types:** Volumetric (bandwidth exhaustion), Protocol (TCP state exhaustion), and Application layer (Layer 7 HTTP floods — requires pairing with Azure WAF)
- **SLA-backed guarantee:** Azure DDoS Protection provides cost protection credits for resource scale-outs caused by a documented DDoS attack
- **Integration:** Works natively with Azure Monitor, Microsoft Sentinel, and DDoS Rapid Response (DRR) team support during active attacks for Network Protection tier

## Related concepts
[[Web Application Firewall]] [[Azure Firewall]] [[Network Security Groups]] [[Traffic Scrubbing]] [[Volumetric DDoS Attack]]