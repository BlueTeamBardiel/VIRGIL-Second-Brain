# Sparx Enterprise Architect

## What it is
Think of it as a master blueprint room for software systems — like the war room where generals lay out every troop position, supply line, and fortification on one giant map. Sparx Enterprise Architect (EA) is a UML/SysML-based modeling tool used to design, document, and analyze complex enterprise systems, architectures, and business processes. It centralizes technical diagrams, data flows, and system relationships into a single collaborative repository.

## Why it matters
During a threat modeling engagement, security architects use Sparx EA to generate Data Flow Diagrams (DFDs) that map exactly where sensitive data travels across system boundaries — making it far easier to identify trust boundaries where STRIDE threats like spoofing or information disclosure can occur. Conversely, an attacker who gains access to an organization's EA project repository has essentially stolen the full architectural blueprint, revealing internal network topology, authentication mechanisms, and integration points that dramatically accelerate lateral movement planning.

## Key facts
- Sparx EA supports **TOGAF**, **ArchiMate**, and **UML 2.x** standards — commonly used in enterprise security architecture documentation for compliance frameworks like ISO 27001
- EA repositories are often stored as shared **MySQL/SQLite databases or cloud repos**, making them high-value targets if not access-controlled
- The tool integrates with **TOGAF ADM phases**, enabling security architects to embed risk and control requirements directly into architecture deliverables
- EA can generate **threat model diagrams and traceability matrices**, linking security requirements to specific system components — useful for NIST RMF documentation
- Exporting EA models to unprotected formats (XML/XMI) can inadvertently **leak full system architecture** in readable plaintext

## Related concepts
[[Threat Modeling]] [[Data Flow Diagrams]] [[TOGAF Security Architecture]] [[STRIDE Framework]] [[Attack Surface Analysis]]