---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# Domain 1 - Security operations (33%)
**Master the foundational tools, mindsets, and frameworks that let security analysts detect, investigate, and stop threats in real time.**

---

## Overview

Security operations is the nerve center where defenders actively hunt threats, manage access, share intelligence, and respond to incidents. A SOC analyst lives here—you're the person who needs to understand how networks are protected, why threat intelligence matters, and how to keep bad actors out (or find them if they're already in). This domain covers everything from the philosophical shift toward "assume breach" thinking to the practical tools that make defense possible.

---

## Key Concepts

### The CIA Triad

**Analogy**: Think of a bank vault. **Confidentiality** is the locked door (only authorized people see the money). **Integrity** is the seal that proves no one tampered with the contents. **Availability** is making sure the vault opens when you actually need your money—not when it's convenient for someone else.

**Definition**: The three pillars of information security. [[Confidentiality]] prevents unauthorized disclosure. [[Integrity]] prevents unauthorized modification. [[Availability]] ensures resources are accessible when needed.

This isn't just theory—it's the lens through which you evaluate every security decision. When building a detection rule, ask: "Which of these am I protecting?"

---

### Assumption of Compromise (Zero Trust Mentality)

**Analogy**: Instead of building one massive castle wall and trusting everything inside it, imagine a mansion where every door is locked, every guest shows ID at every room, and you're actively patrolling even when you think it's empty.

**Definition**: The modern security posture that assumes attackers have already breached your environment. This shifts focus from "keep them out" to "find them and remove them." It underpins [[Zero Trust Architecture]] and [[Threat Hunting]].

**Why analysts need this**: You stop asking "are we safe?" and start asking "what's already here that shouldn't be?" This mindset changes how you prioritize alerts and where you look for threats.

---

### Threat Actor Taxonomy

**Analogy**: Not all dangers are created equal. A neighborhood prankster, a organized crime family, and a hostile military are completely different threats—different skills, different goals, different damage potential.

**Definition**: Categorizing adversaries by capability and intent.

| Actor Type | Skill Level | Resources | Motivation | Persistence |
|---|---|---|---|---|
| [[Script Kiddies]] | Low | Minimal | Fame/curiosity | Low—hit and run |
| [[Hacktivists]] | Moderate | Self-funded | Ideology/politics | Medium—campaign-based |
| [[Insider Threats]] | Variable | Already inside | Money/revenge/coercion | High—access advantage |
| [[APT (Advanced Persistent Threat)]] | Extreme | Nation-state funded | Strategic/espionage | Very high—years-long |

**Analyst relevance**: An APT attack requires different detection rules than a script kiddie. You won't find nation-state tooling with basic signatures; you need behavioral analysis and patience.

---

### Zero-Day Vulnerabilities and the Window of Exposure

**Analogy**: Imagine a fire exit that nobody knows about except the arsonist. The moment the fire department discovers it (vulnerability disclosure), the clock starts ticking until they patch it (fix it). During that window, only the arsonist knows how to use it—that's your zero-day risk period.

**Definition**: Security flaws unknown to the vendor and public. The [[Window of Vulnerability]] (or exposure window) begins when someone discovers it and ends when a patch is released and deployed. Zero-days are highly valued on the dark market because defenders have no protection.

**Why it matters**: You can't detect what you don't know exists. This is why [[Behavioral Analysis]] and [[Anomaly Detection]] matter more than signature-based detection.

---

### Threat Classification: The Johari Window Model

**Analogy**: Four types of secrets exist: ones you and your friend both know (gossip at lunch), ones you know but your friend doesn't (your PIN), ones your friend knows but you don't (they saw you trip), and ones neither of you knows (a surprise party being planned for you).

**Definition**: A framework for categorizing threat visibility:

| Category | You Know? | Adversaries Know? | Implication |
|---|---|---|---|
| [[Known Knowns]] | ✓ | ✓ | Public vulnerabilities; both sides aware |
| [[Known Unknowns]] | ✓ | ✗ | Your internal weaknesses; keep them secret |
| [[Unknown Knowns]] | ✗ | ✓ | Zero-days and exploits in the wild |
| [[Unknown Unknowns]] | ✗ | ✗ | Future threats; requires research and hunts |

**Analyst relevance**: You spend most of your time trying to convert "Unknown Knowns" (threats you don't see yet) into detectable alerts.

---

### Threat Intelligence Quality Standards

**Analogy**: Raw intelligence is like gossip—unreliable until verified. You wouldn't make a major life decision based on a rumor from a stranger. Intelligence needs sources, recency, and relevance.

**Definition**: Evaluating intelligence on three axes:

- **[[Timeliness]]**: Is this current or stale? A zero-day report from last week is gold; a vulnerability from five years ago is historical noise.
- **[[Accuracy]]**: How reliable is the source? Intelligence from CISA is high-confidence; anonymous Twitter posts are low-confidence.
- **[[Relevance]]**: Does this matter to *your* environment? Threats targeting industrial control systems matter little if you're a healthcare provider—well, actually, relevance is contextual.

**Analyst relevance**: When you ingest threat feeds, you're filtering for signal in noise. Bad analysts chase every indicator; good ones ask, "Could this actually affect us?"

---

### Standardized Intelligence Frameworks: CybOX, STIX, and TAXII

**Analogy**: Before credit cards, every store had different payment systems. Then standardized cards (Visa, Mastercard) made transactions universal. CybOX/STIX/TAXII do the same for security data.

**Definitions**:

- **[[CybOX]] (Cyber Observables eXpression)**: A standardized XML schema for describing security observations—malware hashes, IP addresses, file paths, anything concrete you find during analysis.
- **[[STIX]] (Structured Threat Information eXpression)**: The language layer that says "this malware is linked to this campaign and this actor." It wraps CybOX objects in relationships and context.
- **[[TAXII]] (Trusted Automated eXchange of Indicator Information)**: The delivery truck. It's the protocol for securely sending STIX-formatted intelligence between organizations.

**Analyst relevance**: When your SIEM ingests threat feeds, they're often in STIX format. Understanding the structure helps you write better correlation rules.

---

### ISACs: Industry-Specific Intelligence Sharing

**Analogy**: Competitors normally don't share secrets. But if a hacker is targeting all banks, every bank benefits from warning the others—so they form a trusted council where they share threats anonymously.

**Definition**: **[[ISACs]] (Information Sharing and Analysis Centers)** are non-profit organizations where companies in the same industry share threat intelligence confidentially. Examples: FS-ISAC (financial services), H-ISAC (healthcare), E-ISAC (energy).

**Analyst relevance**: Your organization likely subscribes to relevant ISACs. The intelligence from these groups is usually higher-quality and more relevant than generic feeds because it's from peers in your industry.

---

### Network Segmentation: Zones and Trust Boundaries

**Analogy**: A castle doesn't leave the throne room door wide open just because guests are in the courtyard. Different zones have different access rules.

**Definitions**:

- **[[Intranet]]**: Your internal trusted network where most systems live. Not fully trusted (insiders can be compromised) but more trusted than the internet.
- **[[DMZ]] (Demilitarized Zone)**: A screened subnet between your intranet and the internet. Web servers, mail servers, and other externally-facing systems live here. If they're compromised, attackers don't immediately access your internal network.
- **[[Extranet]]**: Segments accessible to external partners, often protected by [[VPN]] tunnels. More controlled than the public internet but less trusted than the intranet.
- **[[Darknet]]**: IP address space that's never assigned. Any traffic here is reconnaissance or misconfiguration; it's always suspicious.

**Analyst relevance**: When you see a connection from the intranet to the DMZ, that's expected. From the DMZ to the intranet? Red flag. Segmentation creates natural detection boundaries.

---

### Zero Trust Architecture

**Analogy**: Old security said "the perimeter is the moat." Zero Trust says "every person and device must prove they belong here, even if they're already inside the castle."

**Definition**: A security model that rejects implicit trust based on network location. Instead, every access request requires **strong identity authentication**, verification of device health, and least-privilege authorization—whether you're on the corporate network or at a coffee shop.

**Core principles**:
- Never trust, always verify
- Assume breach
- Verify explicitly (identity, device, context)
- Use least privilege
- Inspect and log all traffic

**Analyst relevance**: In a Zero Trust environment, you have better identity data in your logs. You can correlate user identity with actions, making insider threat detection much sharper.

---

### SASE (Secure Access Service Edge)

**Analogy**: Instead of a traditional moat-and-castle setup with a single security checkpoint, SASE is like having security checkpoints everywhere—at the entry point, on the path, and at the destination.

**Definition**: A cloud-native architecture combining [[Software-Defined Networking]] (SDN), [[Zero Trust]], and security services (firewall, DLP, threat prevention) into a single cloud-delivered platform. Replaces the traditional corporate perimeter.

**Why it matters**: SASE shifts the security model away from "protect the network" to "protect the connection." It's where the industry is moving, so expect SASE concepts on the exam.

---

### Software-Defined Networking (SDN)

**Analogy**: Traditional networking is like a city where every intersection decides traffic rules independently. SDN is like a traffic control center that decides all routing and rules from one place.

**Definition**: Separating the **[[Control Plane]]** (decisions about where traffic goes) from the **[[Data Plane]]** (the actual movement of packets). This makes networks programmable and allows centralized policy enforcement.

**Analyst relevance**: SDN allows security policies to be applied uniformly across the network and changed dynamically—crucial for rapid threat response.

---

### VLANs and Logical Segmentation

**Analogy**: Virtual LANs are like apartment buildings where you can draw invisible lines through the same physical building to separate different tenants.

**Definition**: **[[VLANs]] (Virtual Local Area Networks)** logically group systems regardless of physical location. VLAN 10 might contain all servers; VLAN 20, all workstations; VLAN 30, all IoT devices. Traffic between VLANs is filtered at Layer 3 (routing), not Layer 2 (switching).

**Key concept**: **[[VLAN Trunking]]** allows multiple VLANs to traverse a single physical link between switches.

**Analyst relevance**: VLAN segmentation is a low-cost way to enforce network boundaries. Detecting VLAN hopping or inter-VLAN traffic violations is a common detection use case.

---

### Cloud Security Models and Responsibility

**Analogy**: Renting an apartment vs. owning a house. As a renter, the landlord handles the building structure. You handle your furniture. Different models shift these responsibilities differently.

**Definitions**:

| Model | Network Security Responsibility |
|---|---|
| [[SaaS]] | Vendor (you can't control it) |
| [[PaaS]] | Shared (vendor handles infrastructure, you handle application) |
| [[IaaS]] | Customer (you control everything via Security Groups) |

**Additional concept**: The **[[Management Plane]]** is a separate, highly restricted network for administering the underlying cloud infrastructure. Compromising this means compromising everything.

**Analyst relevance**: In IaaS (AWS, Azure, GCP), *you* are responsible for network security rules. Missing this responsibility is a