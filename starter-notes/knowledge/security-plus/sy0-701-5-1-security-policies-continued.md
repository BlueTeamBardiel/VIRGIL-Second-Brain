---
domain: "5.0 - Security Program Management and Oversight"
section: "5.1"
tags: [security-plus, sy0-701, domain-5, incident-response, sdlc, change-management]
---

# 5.1 - Security Policies (continued)

Security policies extend far beyond documentation—they define the organizational structure, processes, and procedures that enable effective incident response, controlled software development, and managed change. This section covers three critical operational pillars: the incident response framework (rooted in [[NIST]] SP 800-61), the [[Software Development Lifecycle]] (SDLC), and change management. Mastering these topics is essential for the Security+ exam, as they represent real-world practices that directly impact an organization's security posture and resilience.

---

## Key Concepts

### Incident Response Roles & Team Structure
- **Incident Response Team**: A specialized, trained, and regularly tested group responsible for coordinating response activities
- **IT Security Management**: Corporate-level support and decision-making authority during incidents
- **Compliance Officers**: Subject-matter experts on regulatory requirements (HIPAA, PCI-DSS, GDPR, SOX, etc.) who ensure incident handling aligns with legal obligations
- **Technical Staff**: The operational "boots on the ground"—system administrators, network engineers, and security analysts who execute containment and eradication
- **User Community**: Often the first to detect anomalies; critical for early warning and situational awareness

### NIST SP 800-61 (Computer Security Incident Handling Guide)
- **National Institute of Standards and Technology** Special Publication 800-61 Revision 2—the industry-standard framework for incident response
- **Four-Phase Incident Response Lifecycle**:
  1. **Preparation**: Building tools, training, processes, and detection capabilities
  2. **Detection and Analysis**: Identifying and investigating security events
  3. **Containment, Eradication, and Recovery**: Stopping the attack, removing the threat, and restoring systems
  4. **Post-Incident Activity**: Lessons learned, process improvement, evidence preservation

### Software Development Lifecycle (SDLC)
- **Definition**: A structured process governing how applications progress from concept through deployment, maintenance, and retirement
- **Alternative name**: Systems Development Life Cycle or Application Development Life Cycle
- **Key Variables**:
  - Customer requirements and business objectives
  - Schedule and timeline constraints
  - Budget limitations
  - Resource availability
- **No "one-size-fits-all" approach**: SDLC frameworks vary (Waterfall, Agile, DevOps, spiral models) but all benefit from defined structure and governance
- **Purpose**: Reduce risk, improve quality, maintain control, and ensure security integration throughout development

### Change Management
- **Definition**: The formal process and policies governing modifications to systems, configurations, applications, and infrastructure
- **Scope of Changes**: Software upgrades, firewall rule modifications, switch port configurations, patch deployment, policy updates
- **Risk Profile**: One of the most frequent and commonly overlooked sources of security incidents and outages in enterprises
- **Essential Policy Elements**:
  - Change frequency and scheduling windows
  - Approval workflows and authorization levels
  - Installation procedures and testing requirements
  - Rollback and fallback procedures
  - Documentation and change logs
  - Impact assessment and communication plans
- **Implementation Challenge**: Often difficult due to organizational culture, legacy systems, and resistance to process discipline

---

## How It Works (Feynman Analogy)

**Incident Response = A Fire Department**  
Think of an organization's incident response program like a well-trained fire department. Just as the fire department has specialized roles (fire chief, paramedics, firefighters, dispatch), incident response has [[IT security management]], compliance officers, technical staff, and user community members—each with a defined role. A fire department doesn't respond randomly; they follow a protocol: **preparation** (training, equipment, station readiness), **detection and analysis** (911 calls and dispatch assessment), **containment and recovery** (extinguishing the fire, medical aid, rebuilding), and **post-incident activity** (debrief, equipment maintenance, process improvement). [[NIST]] SP 800-61 is essentially the national fire code for cybersecurity—a standardized framework that says, "Here's how to organize and execute incident response."

**SDLC = Building a House**  
Building an application is like constructing a house. You don't just start hammering nails; you get requirements from the homeowner, create blueprints, obtain permits (compliance), follow building codes (security), manage the budget and schedule, and inspect at each phase. Different construction methodologies exist (Waterfall = plan everything upfront; Agile = iterative, feedback-driven), but all require structure to avoid catastrophic failures mid-construction.

**Change Management = Airline Maintenance**  
Airlines don't change engines on a whim during a flight. They follow strict change procedures: a maintenance request is filed, documented, reviewed, scheduled during a maintenance window, performed by certified technicians, tested, and if problems arise, there's a rollback procedure. Similarly, change management ensures that infrastructure modifications don't introduce chaos, data loss, or security gaps into production systems.

---

## Exam Tips

- **Distinguish "Incident Response Roles" from "Incident Response Phase"**: The exam tests whether you know *who does what* (roles) versus *what phase the organization is in* (NIST phases). A question might ask "Who approves incident response actions?" (answer: IT Security Management or leadership) versus "What happens after detection?" (answer: Containment, Eradication, Recovery).

- **NIST SP 800-61 is THE Standard**: Expect multiple questions directly referencing the four-phase lifecycle. Know them cold: **Preparation → Detection and Analysis → Containment/Eradication/Recovery → Post-Incident Activity**. Memorize what each phase accomplishes, not just the names.

- **Change Management is a "Hidden Risk"**: The exam often tests awareness that change management—despite being unglamorous—is one of the *most common sources of security incidents*. Watch for scenario questions like "A critical system went down after an uncontrolled patch deployment." The correct answer often highlights the need for formal change control, not just technical skill.

- **SDLC Frameworks Are Options, Not Mandates**: The exam won't ask you to choose the "best" SDLC—it will test that you understand *why* an SDLC framework matters (reduces risk, maintains control, integrates security) and that multiple valid approaches exist. Don't overthink methodology comparisons.

- **Compliance Officers in Incident Response**: A common weak point—candidates forget that compliance officers are *essential* incident response team members. They ensure legal notification timelines, regulatory reporting, and breach notification laws (like [[HIPAA]] breach notification) are followed. An incident response without compliance involvement is incomplete.

---

## Common Mistakes

- **Conflating SDLC with Incident Response**: These are separate security domains. SDLC is about *building* secure software; incident response is about *reacting to* security events. A question asking "Which SDLC phase includes threat modeling?" is different from "Which NIST 800-61 phase includes eradication?" Don't mix them up.

- **Assuming One Change Management Process Fits All Organizations**: Candidates sometimes pick "the most secure" change management answer without considering business context (schedule, budget, risk tolerance). The exam tests understanding that change policies must *fit the organization's culture and risk profile*, not just follow a textbook rule. A startup's change process will differ from a bank's.

- **Overlooking "Post-Incident Activity"**: Many candidates rush through the NIST phases and treat post-incident work as optional. It's not—it's the fourth phase and is critical for learning and continuous improvement. A scenario asking "What should happen after an incident is contained?" should prompt you to think about root cause analysis, process updates, and training, not just immediate recovery.

---

## Real-World Application

For you and the [[[YOUR-LAB]]] fleet, this section directly applies to operational security discipline. When a Wazuh alert fires, the incident response team (you, your compliance officer, your technical staff, and potentially your user community) must follow a structured process—not panic-driven ad hoc actions. Change management is equally critical: before pushing a firewall rule update via Tailscale, patching Active Directory, or upgrading Pi-hole DNS settings, a formal change procedure should be followed (documented change request, testing plan, fallback procedure, communication to stakeholders). In a homelab setting, this might seem overkill, but practicing [[NIST]] SP 800-61 and change discipline in your lab directly translates to professional competence and exam success.

---

## [[Wiki Links]]

- [[NIST]] - National Institute of Standards and Technology
- [[NIST SP 800-61]] - Computer Security Incident Handling Guide (primary reference)
- [[Incident Response]] - Organizational capability and process
- [[Security Policy]] - Foundational governance document
- [[Incident Response Team]] - Multi-disciplinary group
- [[Compliance Officer]] - Role in incident response
- [[IT Security Management]] - Leadership function
- [[Software Development Lifecycle]] (SDLC) - Structured development process
- [[Change Management]] - Controlled modification process
- [[Containment]] - Incident response phase
- [[Eradication]] - Incident response phase
- [[Recovery]] - Incident response phase
- [[Detection and Analysis]] - Incident response phase
- [[Preparation]] - Incident response phase
- [[Post-Incident Activity]] - Lessons learned and improvement
- [[HIPAA]] - Compliance requirement affecting incident notification
- [[PCI-DSS]] - Compliance requirement affecting incident handling
- [[GDPR]] - Compliance requirement affecting incident notification
- [[Breach Notification]] - Legal requirement tied to incident response
- [[Root Cause Analysis]] - Post-incident investigation technique
- [[Waterfall]] - SDLC methodology
- [[Agile]] - SDLC methodology
- [[DevOps]] - Modern SDLC approach
- [[Threat Modeling]] - SDLC security activity
- [[Active Directory]] - System subject to change management
- [[Tailscale]] - VPN/network tool requiring change control
- [[Wazuh]] - [[SIEM]] tool for detection and analysis
- [[Pi-hole]] - DNS tool requiring change management
- [[Homelab]] - Practice environment for security discipline

---

## Tags

#domain-5 #security-plus #sy0-701 #incident-response #sdlc #change-management #nist-sp800-61 #governance #policy #roles-responsibilities

---
_Ingested: 2026-04-16 00:23 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
