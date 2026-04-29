# HVAC

## What it is
Like the circulatory system of a building — constantly moving air, heat, and cooling — HVAC (Heating, Ventilation, and Air Conditioning) systems are the physical infrastructure that regulates environmental conditions in facilities. In cybersecurity contexts, HVAC refers to these systems as critical physical infrastructure that is increasingly networked and therefore attackable as part of Industrial Control Systems (ICS) or Building Automation Systems (BAS).

## Why it matters
In the 2013 Target breach, attackers initially compromised a third-party HVAC vendor's network credentials to gain a foothold into Target's corporate network, ultimately stealing 40 million credit card records. This attack demonstrated that HVAC contractors with remote monitoring access represent a supply chain vulnerability — their trusted network connection became the attacker's entry point into a completely unrelated payment system.

## Key facts
- HVAC systems are commonly managed via Building Automation Systems (BAS) that use protocols like BACnet or Modbus, which were designed for availability — not security
- Remote access credentials given to HVAC vendors are a classic third-party/supply chain risk vector (relevant to vendor management controls)
- Compromised HVAC in data centers can cause physical damage: attackers can manipulate temperature thresholds to overheat servers, causing hardware failure — a non-malware physical attack
- HVAC networks should be air-gapped or placed in a dedicated VLAN, completely segmented from corporate IT networks
- HVAC vulnerabilities fall under the Physical Security and ICS/SCADA domains — testable on both Security+ and CySA+ as an example of converged IT/OT risk

## Related concepts
[[ICS/SCADA Security]] [[Network Segmentation]] [[Supply Chain Risk Management]] [[Physical Security Controls]] [[Lateral Movement]]