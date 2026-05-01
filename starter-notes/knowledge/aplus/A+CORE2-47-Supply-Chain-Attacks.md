---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 47
source: rewritten
---

# Supply Chain Attacks
**Adversaries exploit trusted third-party vendors to breach your organization's defenses.**

---

## Overview

A [[supply chain attack]] targets the interconnected web of [[vendors]], [[suppliers]], [[manufacturers]], and [[distributors]] that feed components and services into your organization—treating the entire ecosystem as a backdoor into your network. For the A+ exam, understanding supply chain vulnerabilities is critical because modern IT security isn't just about protecting your own systems; it's about acknowledging that every third-party connection represents a potential attack surface you don't fully control.

---

## Key Concepts

### Supply Chain

**Analogy**: Think of a supply chain like a restaurant's ingredient delivery network. The restaurant can perfectly sanitize its kitchen and train staff flawlessly, but if the tomato supplier gets contaminated produce from a farm, the restaurant's food gets poisoned anyway—no amount of internal hygiene prevents that.

**Definition**: The complete journey from raw material extraction through manufacturers, logistics providers, and resellers until a finished product reaches the end consumer. Each node in this chain represents a potential security vulnerability.

| Chain Component | Security Risk | Control Level |
|---|---|---|
| [[Raw Materials Supplier]] | Compromised components embedded in products | Low (external) |
| [[Manufacturer]] | Malicious code injected during production | Low (external) |
| [[Distributor/Logistics]] | Interception or tampering in transit | Low (external) |
| [[Vendor Portals]] | Direct network access for business operations | Medium (monitored access) |
| [[End Customer]] | User-level compromise post-delivery | Low (external) |

---

### Third-Party Vendor Risk

**Analogy**: Hiring a contractor to fix your house's electrical system—you can't watch them 24/7, you don't know their hiring practices, and if they install faulty wiring, it burns your house down regardless of your own fire extinguishers.

**Definition**: The security exposure created when external organizations have access to your [[network]], [[data]], or [[infrastructure]], yet you have minimal visibility into their internal security controls.

**Key Risk**: [[Vendor Portals]] and [[API Integrations]] grant third parties direct pathways into your systems. If an attacker compromises the vendor first, they inherit legitimate access credentials.

---

### Attack Vector: Compromised Supplier

**Analogy**: A criminal gang doesn't rob the bank—they rob the armored truck delivering money to the bank, exploiting the chain before it reaches the vault.

**Definition**: An adversary penetrates a [[third-party vendor]]'s security infrastructure, then uses that foothold to pivot into your organization's network through pre-established trust relationships.

**Real-World Example**: An attacker infiltrates a software vendor's development pipeline, embeds [[malware]] in an update, then distributes it to thousands of customers simultaneously—each organization trusts the update because it comes from a legitimate supplier.

---

### Visibility Gap

**Analogy**: You're responsible for a house, but the electrician, plumber, and HVAC contractor all have keys and work unsupervised. You hope they're trustworthy, but you'll never fully know what they're doing inside your walls.

**Definition**: The security blind spot created when your organization cannot monitor, audit, or validate the internal security practices of external vendors and suppliers.

**Impact**: You cannot prevent a breach in someone else's infrastructure, but you will bear the consequences when their compromise becomes yours.

---

## Exam Tips

### Question Type 1: Identifying Supply Chain Vulnerabilities
- *"Your organization purchases network switches from a manufacturer. A vulnerability is discovered in the firmware. Where is your primary exposure?"* → **The manufacturer's supply chain and your trust in their patching timeline.** You have no control over when/if they issue fixes.
- *"A third-party vendor has access to your internal ticketing system via a web portal. What is the primary risk?"* → **Compromising the vendor's credentials grants attackers direct network access.** The vendor is an attack surface.

**Trick**: Don't confuse [[supply chain attacks]] with [[social engineering]]. Supply chain is about structural trust relationships, not manipulation of individual users.

### Question Type 2: Mitigation Strategies
- *"Which approach best reduces supply chain risk?"* → **Vendor assessment, contract security requirements, and continuous monitoring.** (Not "isolating all vendors"—that's impractical.)
- *"What should be included in a vendor agreement?"* → **Security standards, audit rights, incident notification requirements, and liability clauses.**

**Trick**: The exam may ask about "which vendor practice is best"—remember that [[code signing]], [[secure development practices]], and [[software verification]] are vendor-side controls that protect you downstream.

---

## Common Mistakes

### Mistake 1: Believing You Can Fully Control Vendor Security
**Wrong**: "We'll audit our vendors quarterly, so we're fully protected from supply chain attacks."

**Right**: Vendor audits reduce risk but don't eliminate it. Compromises can occur between audits, and you have no real-time visibility into their operations. The goal is risk *reduction*, not elimination.

**Impact on Exam**: Questions may test whether you understand the *limits* of vendor oversight. A+ expects you to know that external threats exist beyond your security perimeter.

---

### Mistake 2: Confusing "Supply Chain Attack" with "Vendor Goes Offline"
**Wrong**: "The supply chain attack means the vendor's service is down."

**Right**: A supply chain *attack* is a deliberate exploitation of the vendor relationship to gain unauthorized access. A vendor outage is an [[availability]] issue, not a security compromise.

**Impact on Exam**: Watch for answer choices that describe downtime vs. malicious compromise. The test will distinguish between [[disaster recovery]] scenarios and active security breaches.

---

### Mistake 3: Assuming Only Software Gets Compromised
**Wrong**: "Supply chain attacks only apply to software updates."

**Right**: Hardware components (motherboards, routers, USB devices), firmware, firmware updates, and physical components can all be compromised during manufacturing or distribution.

**Impact on Exam**: A+ may ask about [[firmware]] vulnerabilities or compromised [[hardware components]]. Supply chain risk spans both software and hardware.

---

## Related Topics
- [[Third-Party Risk Management]]
- [[Vendor Assessment]]
- [[Software Verification]] and [[Code Signing]]
- [[Network Segmentation]] (isolating vendor access)
- [[Least Privilege Access]]
- [[Zero Trust Architecture]]
- [[Incident Response]] Planning
- [[Malware]] and [[Trojan Distribution]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*