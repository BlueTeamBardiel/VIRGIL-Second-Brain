---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 39
source: rewritten
---

# Denial of Service
**An attack that renders services inaccessible by overwhelming resources or exploiting system weaknesses.**

---

## Overview

A [[Denial of Service (DoS)]] attack intentionally cripples a system's ability to function, making it impossible for legitimate users to access services they depend on. For A+ candidates, understanding how attackers disable services—whether through brute-force traffic or clever exploits—is critical because you'll need to recognize, prevent, and mitigate these attacks in real-world support scenarios.

---

## Key Concepts

### Denial of Service Attack

**Analogy**: Imagine a popular restaurant with one entrance. If someone recruits 500 people to stand in the doorway doing nothing, actual customers can't get in—not because the food is gone, but because the entrance is blocked.

**Definition**: A [[DoS]] attack deliberately makes a [[Service|network service]] or [[System Resource|system resource]] unavailable to authorized users by flooding it with malicious requests or exploiting [[Vulnerability|vulnerabilities]] that cause the service to crash.

| DoS Method | How It Works | Impact |
|---|---|---|
| **Resource Flooding** | Sends massive traffic to overwhelm [[Bandwidth]] | Server becomes unresponsive |
| **Exploitation** | Triggers a [[Software Vulnerability]] causing system failure | Service crashes unexpectedly |
| **Physical Sabotage** | Disables power, network connections, or hardware | Complete service outage |

### Distributed Denial of Service (DDoS)

**Analogy**: Instead of one person blocking the restaurant door, an attacker controls hundreds of people (via [[Botnet]]) to do it simultaneously—far harder to stop.

**Definition**: A [[DDoS]] attack uses multiple compromised devices (a [[Botnet]]) to launch coordinated DoS attacks from many sources, making the attack harder to trace and block than a single-source attack.

### Attack Vectors

| Vector | Description | Example |
|---|---|---|
| **Volumetric** | Consumes all available [[Bandwidth]] | [[ICMP Flood]], [[UDP Flood]] |
| **Protocol-Based** | Exploits [[Protocol]] weaknesses | [[SYN Flood]], [[DNS Amplification]] |
| **Application-Layer** | Targets specific software services | [[HTTP Flood]], database queries |

### Unintentional DoS

**Definition**: Service unavailability caused by your own organization—not malicious attackers. Examples include misconfigured [[Firewall|firewalls]], resource leaks, or someone physically unplugging the main power.

---

## Exam Tips

### Question Type 1: Recognition & Identification
- *"Your web server becomes unresponsive after a sudden spike in traffic from unknown IP addresses. What type of attack is this most likely?"* → [[DDoS]] attack; check [[Firewall]] logs and [[Network Monitoring|network monitoring tools]]
- **Trick**: Don't assume all DoS attacks are network-based—physical disruptions (power outage, severed cables) count too.

### Question Type 2: Mitigation & Prevention
- *"How can you protect against volumetric DDoS attacks?"* → Implement [[Rate Limiting]], use a [[Content Delivery Network|CDN]] or DDoS mitigation service, configure [[Firewall]] rules
- **Trick**: A+ expects you to know basic mitigation, not advanced DDoS mitigation—focus on [[Firewall]] configuration, [[IDS]]/[[IPS]], and resource management.

### Question Type 3: Scenario-Based
- *"An attacker floods your mail server with connection requests, causing it to stop accepting new emails. Is this a violation of [[Confidentiality]], [[Integrity]], or [[Availability]]?"* → [[Availability]] (the "A" in the CIA Triad)
- **Trick**: DoS attacks always target [[Availability]]—not data theft or modification.

---

## Common Mistakes

### Mistake 1: Confusing DoS with Data Theft
**Wrong**: "A DoS attack means hackers stole my data."
**Right**: A DoS attack only disables service access—it doesn't compromise [[Confidentiality]] or [[Integrity]]. Attackers may use DoS as a *distraction* while exploiting other systems.
**Impact on Exam**: You'll lose points if you select a "data breach" answer when the question asks about DoS.

### Mistake 2: Thinking DoS Requires Complex Hacking
**Wrong**: "DoS attacks are always sophisticated and take months to plan."
**Right**: A DoS can be as simple as cutting power to a server room or misconfiguring a [[Load Balancer]]. Physical attacks and unintentional misconfigurations are legitimate DoS vectors.
**Impact on Exam**: Don't overthink—recognize that simple actions cause service outages.

### Mistake 3: Ignoring Internal DoS Threats
**Wrong**: "DoS only comes from external attackers."
**Right**: Unintentional DoS happens frequently from within—bad updates, misconfigured [[Cron Job|cron jobs]], resource leaks, or employee error.
**Impact on Exam**: A+ expects you to understand that not all outages are attacks; some are self-inflicted.

### Mistake 4: Assuming All Traffic Spikes Are Attacks
**Wrong**: "Every time traffic increases, it's a DDoS."
**Right**: Legitimate traffic surges (sales events, viral content, news coverage) can appear like DoS. Use [[Baseline|baselines]] and [[Network Monitoring|monitoring]] to distinguish.
**Impact on Exam**: Context matters—don't jump to "malicious" when legitimate reasons exist.

---

## Related Topics
- [[Distributed Denial of Service (DDoS)]]
- [[Botnet]]
- [[Firewall]] configuration and protection
- [[Rate Limiting]]
- [[Content Delivery Network (CDN)]]
- [[Intrusion Detection System (IDS)]]
- [[Intrusion Prevention System (IPS)]]
- [[CIA Triad]] (Availability pillar)
- [[Network Monitoring]]
- [[Baseline]] establishment
- [[SYN Flood]]
- [[ICMP Flood]]
- [[DNS Amplification]]

---

*Source: CompTIA A+ Core 2 (220-1202) Security & DoS Concepts | [[A+]]*