# Dataflow module

## What it is
Think of it like a plumber's blueprint that shows exactly where water enters, where it travels, and where it exits a building — except instead of water, it's data. A **dataflow module** is a component within a Data Flow Diagram (DFD) that represents a bounded process or system element through which data passes, is transformed, and is transmitted between external entities, data stores, and other processes. It formally maps inputs, outputs, and transformation logic to expose where sensitive data is handled.

## Why it matters
During threat modeling with STRIDE, security analysts use dataflow modules to identify where trust boundaries are crossed — for example, pinpointing the exact process where user credentials move from a web form to an authentication server across an unencrypted internal network. The Equifax breach (2017) involved sensitive data flowing through an unpatched Apache Struts component; a properly analyzed dataflow module would have flagged that process as a high-risk trust boundary requiring scrutiny. Dataflow analysis turns abstract architecture into concrete attack surface.

## Key facts
- Dataflow modules are core elements of **Data Flow Diagrams (DFDs)**, which are a required artifact in formal threat modeling methodologies like Microsoft STRIDE and PASTA
- Each module sits at or between **trust boundaries** — crossings are prime locations for injection, tampering, and interception attacks
- In STRIDE analysis, processes (modules) are evaluated for **Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, and Elevation of Privilege**
- Dataflow modules must document both **data at rest** (data stores) and **data in transit** (flows) to satisfy compliance requirements like PCI-DSS and NIST SP 800-53
- Failure to model a dataflow module means that component is **invisible to threat modeling** — attackers exploit what defenders haven't mapped

## Related concepts
[[Threat Modeling]] [[Trust Boundaries]] [[STRIDE Framework]] [[Data Flow Diagram]] [[Attack Surface Analysis]]