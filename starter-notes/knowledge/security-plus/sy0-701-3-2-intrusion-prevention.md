---
domain: "3.0 - Security Architecture"
section: "3.2"
tags: [security-plus, sy0-701, domain-3, intrusion-prevention, ids-ips, active-passive-monitoring]
---

# 3.2 - Intrusion Prevention

Intrusion Prevention is a critical defensive technology that monitors network traffic for malicious activity and either alerts administrators (detection) or actively blocks threats (prevention). This section covers the distinction between [[IDS]] (Intrusion Detection System) and [[IPS]] (Intrusion Prevention System), their deployment modes, and failure considerations. Understanding when to use passive versus active monitoring, and how these systems fit into a layered [[Security Architecture]], is essential for the exam and real-world network defense.

## Key Concepts

- **[[IDS]] (Intrusion Detection System)**
  - Passively monitors network traffic
  - Generates alerts and alarms when suspicious activity is detected
  - Cannot block traffic in real-time
  - Useful for visibility and forensic analysis
  - Often deployed using a network tap or port mirroring

- **[[IPS]] (Intrusion Prevention System)**
  - Actively monitors and can block malicious traffic
  - Deployed inline in the network path
  - Makes real-time decisions to allow or deny traffic
  - Combines detection with active prevention capabilities
  - Can cause performance impact and potential false-positive disruptions

- **Active Monitoring**
  - System is connected *inline* to the network traffic path
  - All traffic passes directly through the monitoring device
  - Real-time blocking and prevention is possible
  - Associated with [[IPS]] deployments
  - Risk: Device failure can block all traffic (fail-closed)

- **Passive Monitoring**
  - System monitors a *copy* of network traffic via network tap or port mirroring
  - Original traffic continues unaffected to its destination
  - No real-time blocking capability
  - Associated with [[IDS]] deployments
  - Advantage: Device failure does not disrupt network operations

- **Network Traffic Intrusions**
  - [[Buffer Overflow]] attacks
  - [[Cross-Site Scripting (XSS)]] exploits
  - Operating system and application vulnerabilities
  - Malformed protocol packets
  - Command injection attacks

- **Failure Modes**
  - **Fail-Open**: When the security device fails, traffic continues to flow normally (safer for availability)
  - **Fail-Closed**: When the security device fails, all traffic is blocked (prioritizes security but impacts availability)
  - Passive systems inherently fail-open; inline active systems must be configured for graceful failure

- **Detection vs. Prevention**
  - Detection: System identifies and alerts on suspicious activity (IDS behavior)
  - Prevention: System identifies and blocks suspicious activity before it enters the network (IPS behavior)
  - Prevention provides stronger security posture but requires careful tuning to avoid blocking legitimate traffic

## How It Works (Feynman Analogy)

Think of a [[Firewall]] as a gate guard at the entrance to a building, checking IDs. An [[IDS]] is like a security camera inside the building that records and alerts when it sees suspicious behavior—it doesn't stop the person, just documents what happened. An [[IPS]] is like a security guard stationed at a checkpoint *inside* the hallway who can physically stop someone from proceeding if they look suspicious.

In the active monitoring setup, all network traffic must pass *through* the [[IPS]] inline (like going through a metal detector at an airport). The [[IPS]] examines each "packet" in real-time and decides whether to allow it or block it. If the [[IPS]] fails, the metal detector breaks and nothing can get through (fail-closed)—bad for operations but safe.

In passive monitoring, a copy of the traffic is sent to an [[IDS]] using a network tap (like a mirror on the side of the road). The [[IDS]] watches and alerts, but the actual traffic flows normally. If the [[IDS]] fails, nobody even notices because it was never in the way (fail-open)—great for availability, but no real-time protection.

The trade-off: **Active = stronger security but higher risk to availability. Passive = safer availability but weaker real-time protection.**

## Exam Tips

- **IDS vs. IPS distinction**: The exam will test whether you know that IDS only *detects* (alerts) while IPS *prevents* (blocks). This is the most commonly tested distinction in this section.

- **Inline vs. Tap deployment**: Active monitoring = inline (traffic passes through); Passive monitoring = tap/mirror (traffic is copied). Know which technology uses which deployment method.

- **Failure modes matter**: If the question asks what happens when a security device fails, inline active systems can cause complete network outage (fail-closed). Passive systems fail gracefully (fail-open). The exam may ask which is "safer" depending on context.

- **Real-time capability**: Remember that IPS can block *in real-time*, but IDS cannot. This is why IPS is inline and IDS is typically passive.

- **Performance and false positives**: Inline IPS can cause legitimate traffic to be blocked if misconfigured (false positives). Be ready to explain the trade-off between security and availability.

## Common Mistakes

- **Confusing IDS and IPS**: Candidates often reverse their capabilities. Remember: **Detection = IDS (alerts only), Prevention = IPS (blocks)**. The P in IPS stands for Prevention, not "Passive."

- **Thinking passive systems can block**: The exam may present a scenario where passive monitoring is offered as a solution to actively stop threats in real-time. This is incorrect—passive systems can only alert.

- **Overlooking failure modes**: Candidates sometimes forget that inline active devices are a single point of failure. If an [[IPS]] fails closed, the entire network goes down. The exam may test whether you understand this architectural risk and when to prefer passive monitoring for resilience.

## Real-World Application

In Morpheus's [[[YOUR-LAB]]] homelab, an inline [[IPS]] would be deployed at the network perimeter to actively block exploits before they reach internal systems running [[Active Directory]] and critical services. However, a passive [[IDS]] connected via a tap to the core switch provides visibility and alerting without risking network disruption—especially important in a lab where false positives could block legitimate experimental traffic. Morpheus can use both: [[Wazuh]] as the detection engine (IDS-like) with [[NIDS]] (Network Intrusion Detection System) rules, and a commercial [[IPS]] appliance inline for real-time prevention on the production segment. The [[Tailscale]] overlay network also benefits from IPS/IDS monitoring at key ingress/egress points.

## [[Wiki Links]]

- [[IDS]] – Intrusion Detection System
- [[IPS]] – Intrusion Prevention System
- [[Firewall]] – Network perimeter security
- [[Network Tap]] – Physical device for traffic copying
- [[Port Mirroring]] – VLAN-based traffic copying
- [[Buffer Overflow]] – Memory exploitation vulnerability
- [[Cross-Site Scripting (XSS)]] – Application-layer attack
- [[Active Monitoring]] – Inline security inspection
- [[Passive Monitoring]] – Out-of-band traffic inspection
- [[Fail-Open]] – System failure mode allowing traffic flow
- [[Fail-Closed]] – System failure mode blocking all traffic
- [[Security Architecture]] – Domain 3.0 overview
- [[CIA Triad]] – Foundational security principles
- [[Defense in Depth]] – Layered security approach
- [[NIDS]] – Network Intrusion Detection System
- [[HIDS]] – Host Intrusion Detection System
- [[Signature-Based Detection]] – Pattern matching for threats
- [[Anomaly-Based Detection]] – Deviation from baseline behavior
- [[Incident Response]] – Post-detection procedures
- [[Wazuh]] – SIEM and intrusion detection platform
- [[[YOUR-LAB]]] – Morpheus's homelab infrastructure
- [[Tailscale]] – Secure network overlay
- [[Active Directory]] – Windows domain management

## Tags

#domain-3 #security-plus #sy0-701 #ids-ips #intrusion-prevention #active-passive-monitoring #network-security #failure-modes #real-time-detection

---

**Study Notes for Morpheus:**

This section is high-yield for CompTIA Security+. Expect 1–2 questions on IDS vs. IPS, and be ready to identify which technology is appropriate for a given scenario. Watch for trick answers that describe IDS as blocking—it doesn't. Similarly, be alert for questions about failure modes; an inline system failure is a critical architectural consideration.

The diagram in your PDF shows the two deployment models clearly: the active [[IPS]] sits inline between the firewall and core switch, forcing all traffic through it; the passive [[IDS]] receives a mirrored copy via port monitoring. Commit this visual to memory.

---
_Ingested: 2026-04-15 23:54 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
