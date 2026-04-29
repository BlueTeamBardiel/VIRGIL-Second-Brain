# Simulation

## What it is
Like a flight simulator that lets pilots crash without dying, a security simulation recreates real attack conditions in a controlled environment without causing actual harm. Precisely, simulation is the practice of mimicking threat actor behaviors, system failures, or attack scenarios to test defenses, train personnel, or validate controls — all without touching production systems or real adversaries.

## Why it matters
In a purple team exercise, a security team runs a simulated ransomware campaign — using tools like Atomic Red Team mapped to MITRE ATT&CK — to test whether endpoint detection catches lateral movement before encryption begins. This reveals gaps in SIEM alerting rules and EDR configurations that only surface under realistic attack conditions, not in checklist-based audits.

## Key facts
- **Simulation vs. emulation**: Simulation mimics *behavior* (e.g., beaconing patterns); emulation replicates the *actual tool or malware* (e.g., running Cobalt Strike). Both appear on CySA+ as distinct concepts.
- **Tabletop exercises** are a low-fidelity simulation — discussion-based, no technical execution — used to test incident response plans against hypothetical scenarios.
- **Breach and Attack Simulation (BAS)** tools (e.g., SafeBreach, AttackIQ) automate continuous simulations against MITRE ATT&CK, providing ongoing control validation rather than point-in-time testing.
- **MITRE ATT&CK** is the foundational framework for simulation fidelity — mapping simulated techniques to real adversary TTPs ensures exercises reflect genuine threat actor behavior.
- Simulation is a core component of **security control assessments** and is explicitly referenced in NIST SP 800-53 under CA (Assessment, Authorization, and Monitoring) controls.

## Related concepts
[[Purple Team Exercise]] [[MITRE ATT&CK]] [[Tabletop Exercise]] [[Breach and Attack Simulation]] [[Threat Emulation]]