# defense-in-depth

## What it is
Like a medieval castle with a moat, drawbridge, outer walls, inner walls, and a fortified keep — each layer forces an attacker to defeat a separate obstacle. Defense-in-depth is a layered security strategy where multiple independent controls are stacked so that the failure of any single control doesn't result in total compromise. No single technology or policy is trusted as a sufficient safeguard on its own.

## Why it matters
In the 2013 Target breach, attackers compromised an HVAC vendor's credentials to reach the network perimeter — but the absence of internal network segmentation allowed lateral movement directly to point-of-sale systems. A defense-in-depth approach with proper segmentation, privileged access controls, and anomaly detection at multiple layers could have stopped the breach even after the initial credential theft succeeded.

## Key facts
- Defense-in-depth is also called **layered security** and maps directly to the principle that no single point of failure should compromise the whole system
- The three primary layers are **administrative** (policies, training), **technical** (firewalls, encryption, EDR), and **physical** (badge access, locks, CCTV)
- It assumes **breach** — controls are designed to slow, detect, and contain attackers who have already bypassed earlier layers
- **Network segmentation** and **least privilege** are two of the most critical technical implementations of this principle
- On Security+/CySA+ exams, defense-in-depth is frequently contrasted with **security through obscurity**, which relies on a single hidden mechanism rather than multiple verifiable controls

## Related concepts
[[network-segmentation]] [[least-privilege]] [[zero-trust]] [[access-control]] [[security-controls]]