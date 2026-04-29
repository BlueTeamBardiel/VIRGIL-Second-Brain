# Blast Radius

## What it is
Like a bomb detonating in a crowded stadium versus an empty field, the damage depends entirely on what surrounds the explosion. Blast radius in cybersecurity describes the maximum scope of damage an attacker can cause after compromising a single account, system, or credential — essentially, how far the breach can spread given existing access controls and trust relationships.

## Why it matters
In the 2020 SolarWinds supply chain attack, the blast radius was catastrophic: because the compromised Orion software had privileged access to thousands of customer networks, a single trojanized update gave attackers lateral movement across 18,000 organizations including U.S. federal agencies. Organizations that had enforced least privilege and network segmentation suffered significantly smaller blast radii, limiting attacker reach even after initial compromise.

## Key facts
- **Least privilege principle** is the primary engineering control for reducing blast radius — accounts should have only the permissions required for their specific function
- **Privileged accounts** (domain admins, service accounts with broad access) represent the largest blast radius risk; compromising one can yield full domain takeover
- **Network segmentation and micro-segmentation** limit lateral movement, directly shrinking blast radius across infrastructure
- **Zero Trust architecture** assumes breach and is explicitly designed to minimize blast radius by requiring continuous verification rather than implicit trust
- **Service account misuse** is a top blast radius amplifier — service accounts often run with excessive privileges and are rarely monitored

## Related concepts
[[Least Privilege]] [[Lateral Movement]] [[Zero Trust Architecture]] [[Network Segmentation]] [[Privilege Escalation]]