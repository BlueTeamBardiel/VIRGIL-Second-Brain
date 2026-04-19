```yaml
---
domain: "1.0 - General Security Concepts"
section: "1.2"
tags: [security-plus, sy0-701, domain-1, zero-trust, network-architecture, access-control]
---
```

# 1.2 - Zero Trust

Zero Trust is a fundamental security philosophy that rejects the traditional "trust but verify" model in favor of "never trust, always verify." This topic covers the architectural principles, operational planes, and enforcement mechanisms required to implement Zero Trust across modern networks—whether physical, virtual, or cloud-based. Understanding Zero Trust is critical for the Security+ exam because it represents the modern industry shift away from perimeter-based security and toward continuous verification of every user, device, and process.

---

## Key Concepts

- **Zero Trust Principle**: A holistic network security approach that assumes nothing is inherently trustworthy—not users, devices, applications, or network segments. Every access request must be authenticated and authorized before granting access, regardless of source.

- **Traditional Network Model (Legacy Approach)**: Networks designed with a hard perimeter (firewall) that protect internal resources. Once traffic passes the firewall, internal security controls are minimal, creating a "soft inside, hard outside" architecture. This is the antithesis of Zero Trust.

- **Continuous Verification**: The core requirement of Zero Trust—every device, process, and person must be continually authenticated and authorized. This is enforced through [[Multi-Factor Authentication (MFA)]], [[Encryption]], system permissions, monitoring, and analytics.

- **Data Plane**: The operational layer responsible for processing and forwarding actual network frames, packets, and data. Functions include packet processing, forwarding, trunking, encryption, and [[Network Address Translation (NAT)]].

- **Control Plane**: The management layer that defines policies, rules, and how data should be forwarded. Maintains routing tables, session tables, and [[NAT]] tables. The control plane determines the *what* and *why*; the data plane executes the *how*.

- **Planes of Operation**: Zero Trust splits network functionality into logical planes (data, control, and policy enforcement) to apply security at each layer. This applies across physical infrastructure, [[virtualization]], and cloud deployments.

- **Adaptive Identity**: A risk-based approach to authentication and authorization that evaluates multiple contextual factors beyond username and password:
  - Source of the request (trusted network, unknown, geolocation)
  - Requested resources and sensitivity level
  - Device health and posture
  - Connection type (VPN, direct, cloud)
  - IP reputation and behavioral anomalies
  - User role and relationship to the organization

- **Policy Enforcement Point (PEP)**: The gatekeeper mechanism that implements Zero Trust policies. Acts as the enforcement boundary that allows, monitors, or terminates connections based on policy decisions from the control plane.

- **Subjects and Systems**: The entities requesting access in a Zero Trust model:
  - End users (human actors)
  - Applications (services, microservices, containers)
  - Non-human entities (service accounts, APIs, IoT devices, servers)

- **Trust Verification Components**: The multi-layered controls that enable continuous verification:
  - [[Multi-Factor Authentication (MFA)]] for user identity
  - [[Encryption]] for data confidentiality and integrity in transit
  - System permissions and role-based access control ([[RBAC]])
  - Additional firewalls and microsegmentation
  - [[Monitoring]] and analytics (SIEM, threat detection)
  - Device posture checking and compliance validation

- **Implicit vs. Explicit Trust**: Zero Trust eliminates *implicit* trust (based on network location or perimeter status) and requires *explicit* trust (based on verified identity, device state, and contextual factors).

---

## How It Works (Feynman Analogy)

**The Airport Security Model:**

Imagine an airport where the old model (legacy networks) only checks your ID once at the front entrance. Once you're past security, you can access gates, shops, and lounges freely—no questions asked. However, a Zero Trust airport checks your boarding pass at every gate, requires you to prove your identity multiple times, and monitors your behavior throughout your journey. If something looks suspicious (wrong gate for your flight, accessing restricted areas, unusual patterns), additional verification is triggered or access is denied.

**Technical Reality:**

In traditional networks, the firewall is the sole gatekeeper. Once internal traffic crosses the perimeter, it flows freely with minimal restrictions. In Zero Trust, every connection is treated as potentially hostile:

1. **Initial Request**: A user, device, or service requests access to a resource (e.g., a database).
2. **Control Plane Decision**: The control plane evaluates the request using adaptive identity criteria (who you are, where you're connecting from, what device, what you're requesting).
3. **PEP Enforcement**: The Policy Enforcement Point (gatekeeper) allows, monitors, or blocks the connection based on control plane policy.
4. **Continuous Monitoring**: Even after access is granted, [[SIEM]] systems and analytics monitor the connection for anomalous behavior. If risk indicators spike, the connection can be terminated.
5. **No Implicit Trust**: Location inside the network perimeter doesn't grant trust. Every packet, process, and session is subject to the same scrutiny.

The result is a security model where trust is earned, verified, and continuously re-evaluated—not assumed based on network location.

---

## Exam Tips

- **Know the Core Philosophy**: The exam will test whether you understand that Zero Trust = "never trust, always verify." Traditional models are trust-centric; Zero Trust is verification-centric. Watch for answer choices that suggest implicit trust or perimeter-based security as the solution—these are wrong.

- **Planes of Operation Matter**: Understand the distinction between the **data plane** (executes forwarding) and **control plane** (defines policy). The exam may present scenarios asking which plane handles a specific function. Data plane = forwarding/processing; control plane = policy/routing decisions.

- **Adaptive Identity ≠ Just MFA**: While [[Multi-Factor Authentication (MFA)]] is part of Zero Trust, adaptive identity is broader. It includes contextual risk assessment (location, device health, time of access, resource sensitivity, IP reputation). Don't conflate MFA with the full adaptive identity model.

- **PEP is the Enforcement Layer**: Policy Enforcement Points can consist of multiple components working together (firewalls, proxies, [[API gateways]], microservices policies). The exam may ask what enforces policies—the answer is the PEP, even if it's distributed across multiple devices.

- **Beware of "Trust Once, Access Always"**: Legacy network questions may describe once-verified access lasting for a session or longer. In Zero Trust, continuous verification means trust is never permanent. Answer choices suggesting "verify once and then allow" are incorrect for Zero Trust scenarios.

---

## Common Mistakes

- **Confusing Zero Trust with Perimeter Security**: Candidates often think Zero Trust just means adding more firewalls or stricter perimeter rules. Zero Trust is about eliminating the concept of a "trusted inside" entirely. It's an architectural philosophy, not just a tool upgrade. Perimeter security alone is not Zero Trust.

- **Treating Adaptive Identity as Static**: Exam questions may present a scenario where a user is authenticated once, and then all future requests are trusted. Zero Trust requires continuous re-evaluation. Risk indicators are dynamic (location changes, device goes offline, behavior becomes anomalous), so identity assessment must be adaptive, not one-time.

- **Underestimating Microsegmentation**: Zero Trust requires segmenting the network into isolated zones with controlled access between them. Candidates often miss that Zero Trust is not just about strong authentication—it's also about limiting lateral movement within the network through microsegmentation and internal firewalls. The exam may ask about implementing Zero Trust in an existing network, and the answer involves both authentication AND network segmentation.

---

## Real-World Application

In Morpheus's [YOUR-LAB] fleet, Zero Trust principles would transform security posture significantly. Currently, systems connected to the homelab [[Active Directory]] domain may have implicit trust based on domain membership. A Zero Trust redesign would implement [[Tailscale]] [[Zero Trust Network Access]] for all remote connections, enforce [[Multi-Factor Authentication (MFA)]] for every administrative access, deploy [[Wazuh]] as a continuous monitoring and adaptive identity engine (monitoring device posture, IP changes, behavioral anomalies), and segment the network using firewall rules so that, for example, database servers don't trust web servers implicitly—every inter-service connection requires explicit authentication. This transforms the homelab from "trust the domain" to "verify every connection, every time."

---

## Wiki Links

- [[Zero Trust]]
- [[Zero Trust Network Access]]
- [[Multi-Factor Authentication (MFA)]]
- [[Encryption]]
- [[Network Address Translation (NAT)]]
- [[Active Directory]]
- [[RBAC]] (Role-Based Access Control)
- [[SIEM]] (Security Information and Event Management)
- [[Wazuh]]
- [[Tailscale]]
- [[Firewall]]
- [[Microsegmentation]]
- [[API Gateway]]
- [[Monitoring]]
- [[Adaptive Identity]]
- [[Policy Enforcement Point (PEP)]]
- [[Data Plane]]
- [[Control Plane]]
- [[Compliance]]
- [[Device Posture]]
- [[Lateral Movement]]
- [[Network Perimeter]]
- [[Authentication]]
- [[Authorization]]
- [[Threat Detection]]
- [[Anomaly Detection]]

---

## Tags

`domain-1` `security-plus` `sy0-701` `zero-trust` `network-architecture` `access-control` `adaptive-identity` `policy-enforcement` `continuous-verification` `microsegmentation`

---

## Study Checklist

- [ ] Can I explain why Zero Trust rejects the traditional perimeter model?
- [ ] Do I understand the difference between the data plane and control plane?
- [ ] Can I define adaptive identity and list at least three risk indicators?
- [ ] Do I know what a Policy Enforcement Point does and how it enforces policy?
- [ ] Can I distinguish between implicit trust (wrong) and continuous verification (Zero Trust)?
- [ ] Can I apply Zero Trust principles to a scenario in the homelab or a business environment?

---
_Ingested: 2026-04-15 23:24 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
