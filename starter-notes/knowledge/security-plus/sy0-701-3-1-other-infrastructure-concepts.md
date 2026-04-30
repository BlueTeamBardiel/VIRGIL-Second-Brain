---
domain: "3.0 - Security Architecture"
section: "3.1"
tags: [security-plus, sy0-701, domain-3, infrastructure-concepts, cloud-vs-onprem, virtualization, containerization, iot]
---

# 3.1 - Other Infrastructure Concepts

This section covers the architectural decisions and trade-offs between on-premises and cloud-based security models, along with modern deployment paradigms like virtualization, containerization, and [[IoT]] devices. Understanding these infrastructure concepts is critical for the Security+ exam because security posture depends heavily on *where* and *how* systems are deployed—and the inherent risks and benefits of each approach. Attackers exploit infrastructure weaknesses regardless of deployment model, so architects must understand centralized vs. decentralized management, resource isolation, and the unique attack surface of emerging technologies.

---

## Key Concepts

### On-Premises vs. Cloud Security Models

- **On-Premises Security**
  - Organization owns and operates all physical infrastructure, data centers, and security controls
  - Full customization of security posture but requires significant capital expenditure (CapEx) and operational expertise
  - Local [[IT]] team maintains direct control over uptime, availability, and patch management
  - Trade-off: Greater control but higher cost, staffing burden, and slower security changes due to procurement/deployment cycles
  
- **Cloud-Based Security**
  - Third-party provider (AWS, Azure, Google Cloud) manages infrastructure, physical security, and baseline controls
  - Centralized management reduces operational burden and cost (OpEx model); no need to build/maintain a data center
  - Shared responsibility model: cloud provider secures infrastructure; organization secures configuration and access
  - Trade-off: Less direct control, potential vendor lock-in, and reliance on provider's security posture

- **Key Distinction**: Neither is inherently "more secure"—security depends on implementation, configuration, and operational practices

### Centralized vs. Decentralized Management

- **Decentralized Reality**
  - Most organizations operate across multiple physical locations, cloud providers, and heterogeneous systems ([[Windows]], [[Linux]], cloud VMs, on-premises servers)
  - Creates management complexity and visibility gaps

- **Centralized Approach (Recommended)**
  - Aggregate and correlate security alerts from all systems and locations
  - Consolidated [[Syslog]]/log analysis (e.g., [[Wazuh]], [[Splunk]], [[ELK Stack]])
  - Comprehensive system status, maintenance scheduling, and patching from a single pane of glass
  - Enables rapid threat detection and consistent policy enforcement
  
- **Drawback**: Single point of failure; if the central management system goes down, visibility and response capability are compromised

### Virtualization

- **Core Function**: Run multiple isolated operating systems on a single physical host
  - Each application/workload gets its own [[VM]] (virtual machine) with dedicated OS, memory, and storage allocation
  - Host runs a [[Hypervisor]] ([[KVM]], [[Hyper-V]], [[VMware ESXi]]) to manage resource allocation and isolation

- **Security Implications**
  - Strong isolation between VMs (if hypervisor is secure)
  - Reduces hardware costs by consolidating workloads
  - Easier to snapshot, backup, and restore compromised systems
  
- **Overhead**: Each VM requires a full OS image—significant memory and disk overhead compared to containers
  - Slower boot times than containers
  - More CPU/memory consumption per application instance

- **Exam Angle**: Virtualization enables better resource utilization and disaster recovery but introduces hypervisor as a critical attack surface

### Application Containerization

- **Container (e.g., [[Docker]], [[Kubernetes]])**
  - Lightweight alternative to VMs; packages application code, dependencies, libraries, and runtime into a standardized, portable unit
  - Shares the host OS kernel (unlike VMs, which each run a full OS)
  - Faster to start, smaller footprint, more efficient resource use
  
- **Container Image**
  - Read-only template defining how a container runs
  - Includes all code, dependencies, and configuration
  - Portability: same image runs identically across dev, test, and production environments

- **Isolation**
  - Containers run in isolated sandboxes; one compromised container cannot easily interact with or compromise others
  - Relies on OS-level containerization (e.g., Linux namespaces, cgroups) rather than hypervisor isolation
  - Lighter security boundary than VMs but adequate for many use cases

- **Exam Distinction**: Containers are *not* a replacement for VMs in all cases—they excel for microservices and rapid deployment but offer weaker isolation than full VMs

### Internet of Things ([[IoT]])

- **Definition**: Network-connected devices beyond traditional computers and servers—sensors, smart devices, wearables, and facility automation
  
- **Common IoT Categories**
  - **Sensors**: Temperature, humidity, pressure monitors (HVAC systems)
  - **Smart Devices**: Video doorbells, smart locks, smart speakers, home automation hubs
  - **Wearable Technology**: Smartwatches, fitness trackers, health monitors
  - **Facility Automation**: Lighting control, access systems, environmental monitoring
  
- **Security Risk: Weak Defaults**
  - [[IoT]] manufacturers prioritize functionality and cost over security
  - Default credentials (admin/admin), outdated firmware, unpatched vulnerabilities are common
  - Often no update mechanism or end-of-life support
  - Difficult to audit or patch in large deployments
  - Creates backdoors into corporate networks if connected to corporate infrastructure

- **Mitigation Strategies**
  - Isolate [[IoT]] on separate network segments ([[VLAN]]s)
  - Use network access control ([[NAC]]) to enforce compliance
  - Regular vulnerability scanning with tools like [[Nessus]], [[OpenVAS]]
  - Monitor traffic with [[IDS]]/[[IPS]] or [[SIEM]] ([[Wazuh]])
  - Change default credentials immediately
  - Deploy [[Firewall]] rules to restrict [[IoT]] device communication

---

## How It Works (Feynman Analogy)

**On-Premises vs. Cloud**: Think of a restaurant kitchen.
- **On-Premises** = You own the restaurant, buy all equipment, hire all staff, and control every recipe and procedure. You're responsible if something goes wrong, but you know exactly how things work. It's expensive and you need skilled people.
- **Cloud** = You rent a kitchen from a catering company. They handle the equipment, utilities, and basic hygiene. You still decide what to cook and how to serve it, but if the building burns down, that's their problem. It's cheaper, but you depend on their competence.

**Virtualization vs. Containerization**: Imagine a shipping analogy.
- **VMs** = You buy separate delivery trucks, each with its own driver, fuel tank, and maintenance crew. They can haul anything independently but cost a fortune to run.
- **Containers** = You stack standardized shipping containers on one truck. Each container is sealed and isolated from the others, the truck handles transport, and you save money. Containers are much more efficient but slightly less isolated.

**IoT Risk**: IoT devices are like hiring temporary workers who never got background checks and still have the default password "12345." You don't know what they might do or who might control them.

---

## Exam Tips

- **On-Prem vs. Cloud is NOT Binary Security**
  - The exam may ask "Which is more secure?" The correct answer is always: *"It depends on implementation."* Neither model is inherently more secure. Focus on trade-offs: cost, control, compliance, operational burden.
  
- **Centralized Management = Correlation & Visibility**
  - Expect questions about how to detect threats across decentralized infrastructure. The answer is usually "centralize logging and alerting." Tools like [[SIEM]], [[Wazuh]], and centralized [[Syslog]] servers are exam favorites.
  
- **Virtualization = Isolation + Snapshot/Recovery**
  - Questions may test whether you understand hypervisor security, VM escape risks, and the advantage of snapshots for rapid recovery. Know that [[VMs]] provide strong isolation if the hypervisor is secure.
  
- **Containers ≠ VMs**
  - Don't confuse them. Containers are lightweight, share the kernel, and are faster. VMs are heavier but more isolated. Exam may ask which is appropriate for a given scenario.
  
- **IoT = Weak Defaults + Network Isolation**
  - Expect questions about IoT security. The standard answer for protecting corporate networks from [[IoT]] is: isolate on [[VLANs]], use [[NAC]], monitor with [[IDS]]/[[IPS]], and change defaults. Manufacturers don't prioritize security—assume every [[IoT]] device is potentially compromised.

---

## Common Mistakes

- **"On-premises is always more secure"** – Incorrect. Security depends on people, processes, and technology—not location. A poorly managed on-prem environment can be less secure than a well-managed cloud environment.

- **"Containers replace VMs"** – Wrong context. Containers are for microservices and rapid scaling; VMs are for full isolation and heterogeneous workloads. They solve different problems.

- **Ignoring IoT as a threat vector** – Many candidates underestimate [[IoT]] risk. Remember: weak defaults, no updates, and manufacturers who aren't security experts mean [[IoT]] is a privileged entry point into networks. Always isolate and monitor.

---

## Real-World Application

In your [[[YOUR-LAB]]] homelab, these concepts are directly applicable:

- **Virtualization** powers the entire lab—each security tool ([[Wazuh]], [[Pi-hole]], domain controllers) runs as isolated VMs, allowing fast snapshots for testing and recovery without rebuilding physical infrastructure.

- **Centralization via Wazuh** mirrors the exam's emphasis on centralized logging and alerting. you correlate alerts across decentralized lab systems (local VMs, [[Tailscale]] remote nodes, cloud instances) from a single dashboard, simulating enterprise [[SIEM]] practices.

- **[[IoT]] in the lab** (smart home devices, temperature sensors, network cameras) must be isolated on separate [[VLANs]] and monitored by [[Wazuh]] agents to detect anomalies—a hands-on example of the "isolate and monitor" principle.

- **On-Prem vs. Cloud Decision**: Running the lab on-premises gives full control for learning but creates the staffing/cost burden the exam describes. Cloud alternatives (AWS, Azure labs) reduce that burden but introduce third-party dependency—both scenarios teach real trade-offs.

---

## Related Concepts & Wiki Links

### Core Security Architecture
- [[CIA Triad]] – Confidentiality, Integrity, Availability (applies to all infrastructure models)
- [[Zero Trust]] – Architectural approach relevant to both on-prem and cloud
- [[Defense in Depth]] – Layered security applicable across virtualization and containerization

### Infrastructure & Deployment
- [[Hypervisor]] – [[KVM]], [[Hyper-V]], [[VMware ESXi]]
- [[Docker]] – Most common container runtime
- [[Kubernetes]] – Container orchestration and management
- [[Cloud Computing Models]] – IaaS, PaaS, SaaS (aligns with security responsibility models)

### Network & Access Control
- [[VLAN]] – Isolate [[IoT]] and untrusted segments
- [[NAC]] (Network Access Control) – Enforce device compliance before network access
- [[VPN]] / [[Tailscale]] – Secure remote access (relevant to decentralized infrastructure)
- [[Firewall]] – Segment and restrict traffic between zones

### Monitoring & Detection
- [[SIEM]] – [[Wazuh]], [[Splunk]], [[ELK Stack]] for centralized logging and alerting
- [[IDS]] / [[IPS]] – Intrusion detection/prevention (especially for [[IoT]] monitoring)
- [[Syslog]] – Centralized log aggregation
- [[Wazuh]] – Open-source SIEM used in [[[YOUR-LAB]]]

### Identity & Access Management
- [[Active Directory]] – Central identity management (on-premises)
- [[LDAP]] – Directory protocol
- [[OAuth]] / [[SAML]] – Federation and cloud identity

### Security Tools & Frameworks
- [[NIST]] – Cybersecurity Framework (guides infrastructure security decisions)
- [[MITRE ATT&CK]] – Threat taxonomy (used to evaluate infrastructure against attack patterns)
- [[Incident Response]] – Faster with centralized logging and snapshots

### IoT & Emerging Tech
- [[IoT Security]] – OWASP IoT Top 10, firmware security, default credentials
- **Smart Devices** – Risk vectors in corporate networks
- **Facility Automation** – Convergence of IT and OT security

---

## Tags

#domain-3 #security-plus #sy0-701 #infrastructure-concepts #on-premises-vs-cloud #virtualization #containerization #iot-security #centralized-management #decentralized-networks #hypervisor-security #container-isolation #network-segmentation #siem-and-logging #iot-weak-defaults

---

**Last Updated**: 2024  
**Exam Weight**: Domain 3.0 (18% of SY0-701)  
**Confidence Level for Morpheus**: High — These are foundational concepts tested across multiple question types and scenarios.

---
_Ingested: 2026-04-15 23:52 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
