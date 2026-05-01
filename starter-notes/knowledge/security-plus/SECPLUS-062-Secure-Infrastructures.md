---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 062
source: rewritten
---

# Secure Infrastructures
**Building protective layers into network design to defend against threats while maintaining legitimate operations.**

---

## Overview
Every organization's network reflects its unique operational requirements—a hospital network looks nothing like a factory floor. However, despite these differences, all secure networks share common defensive principles and architectural patterns. For the Security+ exam, you need to understand how to design and implement network structures that separate trusted from untrusted traffic while deploying multiple security technologies in coordinated defense.

---

## Key Concepts

### Network Segmentation with Firewalls
**Analogy**: Think of a firewall like a bouncer at a club entrance who checks credentials and decides who gets in, who stays out, and which areas of the venue each person can access.

**Definition**: A [[firewall]] is a network security device that controls traffic flow between network segments by enforcing predetermined rules about which data packets are permitted to pass through. [[Firewalls]] create boundaries that keep external threats outside your network perimeter while allowing authorized communications to flow freely.

[[Network Segmentation]] | [[Firewall Rules]] | [[Access Control Lists (ACLs)]]

---

### Security Zones
**Analogy**: Security zones are like different security clearance areas in an airport—departures, international terminals, and employee-only areas are physically separated and have different access requirements based on who's entering and where they need to go.

**Definition**: A [[security zone]] is a logical grouping of network resources organized by their security requirements and trust levels, rather than by traditional network topology like subnets. Zones classify network sections based on what traffic should be allowed in and out, creating trust boundaries.

| Zone Type | Characteristics | Typical Inhabitants |
|-----------|-----------------|-------------------|
| **Trusted Zone** | Internal, controlled access | Employee workstations, secure servers |
| **Untrusted Zone** | External, open access | Internet, guest networks, public systems |
| **DMZ (Demilitarized Zone)** | Semi-restricted access | Web servers, email gateways, public-facing applications |
| **Restricted Zone** | Highly controlled, minimal access | Critical infrastructure, databases, administrative systems |

[[Trust Boundaries]] | [[DMZ]] | [[Network Architecture]]

---

### Supporting Security Technologies
**Analogy**: If the firewall is your castle wall, these devices are the towers, gates, archers, and watchers that add layers of defense and intelligence throughout your fortification.

**Definition**: Multiple security appliances work together within infrastructure design to provide defense-in-depth:

- **[[Honeypots]]**: Decoy systems that attract attackers and reveal attack patterns without exposing real assets
- **[[Jump Servers]]** (Bastion Hosts): Controlled gateway systems that administrators use to access sensitive infrastructure, reducing direct exposure of critical systems
- **[[Network Sensors]]**: Detection devices that monitor traffic and alert on suspicious activity
- **[[Load Balancers]]**: Distribute traffic across multiple servers while providing redundancy and DDoS mitigation

| Technology | Primary Function | Security Benefit |
|------------|-----------------|-----------------|
| Honeypot | Deception & research | Detect attacks, study attacker behavior |
| Jump Server | Access control | Reduce admin exposure, audit access |
| Network Sensor | Monitoring & detection | Identify threats in real-time |
| Load Balancer | Traffic distribution | Prevent overload attacks, ensure availability |

[[Defense in Depth]] | [[Network Architecture]] | [[Intrusion Detection]]

---

## Exam Tips

### Question Type 1: Zone Classification
- *"A company wants to isolate its web server from internal databases. Which security zone should host the web server?"* → **DMZ (Demilitarized Zone)** — it's accessible from the internet but restricted from internal networks
- **Trick**: Confusing "trusted" with "important"—a system can be important but still untrusted if it faces the internet

### Question Type 2: Device Placement
- *"Where should a jump server be positioned in network architecture?"* → **Between untrusted and trusted zones**, allowing controlled access without direct exposure of critical systems
- **Trick**: Forgetting that jump servers *reduce* attack surface rather than *increase* it

### Question Type 3: Technology Selection
- *"An organization wants to understand attacker tactics without risking production systems. Which technology is most appropriate?"* → **Honeypot** — legitimate decoys that don't impact real operations
- **Trick**: Confusing honeypots with honeynets (honeypots are single systems; honeynets are networks of them)

---

## Common Mistakes

### Mistake 1: Treating Security Zones as IP Subnets
**Wrong**: "We created three security zones by dividing our network into three /24 subnets"
**Right**: Security zones are logical trust groupings based on *function and access requirements*, not just IP ranges. You could have multiple zones within one subnet or one zone spanning multiple subnets
**Impact on Exam**: Questions about zone design test whether you understand *security principle* (trust levels) vs. *network topology* (IP addressing). This distinction appears frequently on scenario-based questions.

### Mistake 2: Assuming Firewalls Are Sufficient Defense
**Wrong**: "We deployed a firewall, so our network is secure"
**Right**: Firewalls are essential but incomplete—you need firewalls *plus* segmentation, monitoring sensors, honeypots, and access controls working together
**Impact on Exam**: Expect questions asking what *additional* technologies complement firewalls. The exam emphasizes defense-in-depth over single-point solutions.

### Mistake 3: Misplacing the DMZ
**Wrong**: "Our DMZ is where we keep our most sensitive customer databases"
**Right**: The DMZ is specifically for systems that must be accessible from untrusted networks (like the internet). Sensitive data belongs in restricted internal zones behind the DMZ
**Impact on Exam**: Scenario questions often test whether you understand DMZ purpose. DMZ = "accessible to internet but separated from internal systems," not "highly secure."

### Mistake 4: Confusing Jump Servers with VPN
**Wrong**: "Jump servers and VPN are the same thing—both control remote access"
**Right**: Jump servers are intermediary hosts used for administrative access; VPNs encrypt the *connection*. Jump servers and VPNs often work together but serve different purposes
**Impact on Exam**: Watch for questions distinguishing administrative access controls from user access controls. This is a nuanced distinction the exam tests.

---

## Related Topics
- [[Firewalls]]
- [[Network Segmentation]]
- [[DMZ Architecture]]
- [[Defense in Depth]]
- [[Intrusion Detection Systems]]
- [[Access Control]]
- [[Network Monitoring]]
- [[Security Appliances]]

---

*Source: Rewritten from Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*