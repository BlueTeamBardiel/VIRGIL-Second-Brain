# zero trust

## What it is
Like a casino that checks your ID *and* your chip balance *and* watches your behavior at every hand — not just at the door — Zero Trust assumes no user or device is inherently trustworthy, even inside the network. It is a security model built on the principle of "never trust, always verify," requiring continuous authentication, strict least-privilege access, and micro-segmentation regardless of network location.

## Why it matters
In the 2020 SolarWinds attack, adversaries moved laterally for months inside trusted corporate networks because perimeter-based security assumed internal traffic was safe. A Zero Trust architecture would have forced re-verification at each resource boundary and flagged the unusual lateral movement patterns before significant damage occurred. This attack became a primary catalyst for the U.S. government's 2021 executive order mandating Zero Trust adoption across federal agencies.

## Key facts
- **Never trust, always verify**: authentication and authorization must occur at every access request, not just at login
- **Least privilege access**: users and devices receive only the minimum permissions required for the specific task
- **Micro-segmentation**: the network is divided into small zones so a compromised segment cannot freely reach others
- **Device health is part of identity**: Zero Trust evaluates device posture (patch level, EDR status) alongside user credentials before granting access
- **NIST SP 800-207** is the definitive framework defining Zero Trust Architecture (ZTA) — exam-relevant reference

## Related concepts
[[least privilege]] [[micro-segmentation]] [[multi-factor authentication]] [[identity and access management]] [[lateral movement]]