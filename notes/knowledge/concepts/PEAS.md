# PEAS

## What it is
Like a hunter scoping out a target before pulling the trigger, PEAS is the reconnaissance framework that defines the *hunting ground* for an autonomous agent or penetration tester. PEAS stands for **Performance measure, Environment, Actuators, and Sensors** — a structured way to define what an AI agent (or attacker emulating one) is optimizing for, where it operates, what actions it can take, and what information it can perceive.

## Why it matters
In adversarial AI security and red team exercises, PEAS framing is used to model autonomous attack agents — for example, mapping out a malware bot's performance measure (exfiltrate credentials), environment (corporate Windows network), actuators (lateral movement commands, keyloggers), and sensors (network traffic sniffing, OS API calls). Defenders use this same lens to anticipate attacker behavior and identify detection gaps in SIEM rules or endpoint controls. Blue teams who can *think in PEAS* can better predict what an automated threat actor will do next.

## Key facts
- **P – Performance Measure**: The attacker's success criteria (e.g., data exfiltration volume, persistence duration, access level achieved)
- **E – Environment**: The operational context — network topology, OS type, air-gapped vs. internet-connected, user behavior patterns
- **A – Actuators**: The tools and techniques used to act — exploitation frameworks, lateral movement tools, C2 beacons (maps to MITRE ATT&CK techniques)
- **S – Sensors**: Inputs the agent uses — port scan results, credential dumps, log data, API responses
- PEAS originates from AI/ML theory (Russell & Norvig) but is increasingly applied in **autonomous threat modeling** and adversarial machine learning research
- Useful for threat modeling in CySA+ scenarios involving **automated threat actors and AI-driven malware**

## Related concepts
[[Threat Modeling]] [[MITRE ATT&CK]] [[Autonomous Malware]] [[Red Team Operations]] [[Adversarial AI]]