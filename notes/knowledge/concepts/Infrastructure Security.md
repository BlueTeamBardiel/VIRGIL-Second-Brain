# Infrastructure Security

## What it is
Think of infrastructure security like hardening a medieval castle — it's not just the front gate, but the moat, the walls, the guard towers, and the secret passages that all need protecting simultaneously. Infrastructure security is the discipline of protecting the foundational hardware, software, networks, and facilities that support an organization's operations. It encompasses physical controls, network segmentation, patch management, and configuration hardening applied across servers, routers, power systems, and cloud environments.

## Why it matters
In 2021, attackers compromised a Florida water treatment facility by exploiting remote access software (TeamViewer) left enabled on an operational technology (OT) network, briefly raising sodium hydroxide levels to dangerous concentrations. This attack demonstrated that unpatched, internet-exposed industrial control systems connected to critical infrastructure can cause physical, life-threatening harm — not just data breaches.

## Key facts
- **Defense-in-depth** is the core infrastructure security principle: layer multiple controls so that failure of one doesn't compromise the entire system
- **Network segmentation** (using VLANs, firewalls, and DMZs) limits lateral movement — a compromised endpoint shouldn't reach a SCADA controller
- **Hardening baselines** like CIS Benchmarks or DISA STIGs provide specific configuration standards for reducing attack surface on servers and network devices
- **Change management** is a critical control — unauthorized configuration changes are a top vector for infrastructure compromise and are tracked via CMDBs
- **CISA's 16 Critical Infrastructure Sectors** (energy, water, transportation, etc.) have specific regulatory frameworks like NERC CIP (energy) governing their security requirements

## Related concepts
[[Network Segmentation]] [[Defense in Depth]] [[Industrial Control Systems (ICS/SCADA)]] [[Hardening and Baselines]] [[Change Management]]