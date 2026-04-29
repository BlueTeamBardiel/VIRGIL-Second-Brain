# Launchpad

## What it is
Think of it like a criminal using a stolen rental car to commit a crime — the car traces back to the rental company, not them. A launchpad (also called a jump host or pivot point) is a compromised system that an attacker uses as an intermediate staging point to launch further attacks deeper into a network, masking the true origin of the activity. It decouples the attacker's identity from their malicious actions.

## Why it matters
In the 2020 SolarWinds supply chain attack, threat actors used compromised infrastructure within victim environments as launchpads to blend lateral movement traffic with legitimate network behavior, making detection extraordinarily difficult. Defenders monitoring only perimeter traffic missed the attack entirely because malicious commands originated from trusted internal systems. This is why network segmentation and internal east-west traffic monitoring are critical defensive controls.

## Key facts
- Launchpads are commonly established through initial access vectors like phishing or exploitation of public-facing applications, then used for **lateral movement** and **persistence**
- Attackers prefer launchpads hosted in the **target's own environment** (living off the land) to evade IP reputation blocklists and external firewall rules
- Cloud VMs, compromised web servers, and IoT devices are frequently weaponized as launchpads due to minimal security monitoring
- Detecting launchpad activity requires **behavioral analytics** (e.g., a printer suddenly making outbound SSH connections) rather than signature-based detection
- Mitigations include **privileged access workstations (PAWs)**, jump server controls with full session logging, and zero-trust network architecture that doesn't automatically trust internal traffic

## Related concepts
[[Pivoting]] [[Lateral Movement]] [[Command and Control (C2)]] [[Network Segmentation]] [[Living off the Land (LotL)]]