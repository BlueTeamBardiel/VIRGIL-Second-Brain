# Cisco DNA Center

## What it is
Think of it like an air traffic control tower for your entire network — instead of manually directing each plane, controllers see everything from one dashboard and enforce rules across the whole airspace automatically. Cisco DNA Center (Digital Network Architecture Center) is a centralized network management and intent-based networking platform that automates network provisioning, policy enforcement, and analytics across Cisco enterprise environments. It translates high-level business intent into network configurations, pushing policies consistently to switches, routers, and wireless access points.

## Why it matters
During a ransomware incident response, a security team can use DNA Center's **macro-segmentation** capabilities to instantly quarantine infected endpoints by pushing updated Group-Based Policy (GBP) rules across the entire network — no manual device-by-device ACL changes needed. Without this centralized control, an attacker can exploit the window of manual remediation to move laterally before administrators can close off network paths. DNA Center compresses that response window from hours to minutes.

## Key facts
- DNA Center uses **Software-Defined Access (SD-Access)** to create a policy-driven fabric where endpoints are assigned to virtual networks and Security Group Tags (SGTs) that control traffic regardless of physical location
- Integrates with **Cisco ISE (Identity Services Engine)** to tie network access policy to user/device identity, enabling dynamic segmentation
- Provides **AI/ML-driven network analytics** through Cisco AI Network Analytics, detecting anomalies like unusual device behavior or traffic spikes
- Acts as a **RESTful API platform**, allowing SIEM and SOAR tools to programmatically trigger network responses (e.g., isolating a host via API call)
- DNA Center's **Device 360 and Client 360** views give full visibility into device health, onboarding history, and policy application — critical for forensic investigation

## Related concepts
[[Cisco ISE]] [[Software-Defined Networking]] [[Network Segmentation]] [[Zero Trust Architecture]] [[Security Group Tags]]