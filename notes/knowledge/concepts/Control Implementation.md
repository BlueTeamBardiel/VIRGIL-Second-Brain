# Control Implementation

## What it is
Like choosing between a deadbolt, a security camera, or a guard dog to protect your house — each stops the same threat differently — control implementation is the deliberate selection and deployment of security mechanisms to satisfy a specific security requirement. It defines *how* a control is realized: technically (firewall rules), administratively (policy), or physically (badge reader).

## Why it matters
During the 2020 SolarWinds attack, the adversary succeeded partly because network segmentation controls existed on paper but were never properly implemented — monitoring agents had excessive network reach that a correctly implemented least-privilege control would have blocked. Proper implementation, not just selection, determines whether a control actually reduces risk.

## Key facts
- Controls are implemented across three types: **Technical** (encryption, MFA), **Administrative** (policies, training), and **Physical** (locks, cameras) — Security+ expects you to distinguish all three.
- **Control categories** cross-cut types: Preventive, Detective, Corrective, Deterrent, Compensating, and Directive — a single control can span multiple categories.
- A **compensating control** is implemented when the primary control cannot be deployed (e.g., legacy system can't support MFA, so network isolation is used instead).
- **NIST SP 800-53** provides a control catalog; control implementation details are documented in a **System Security Plan (SSP)**.
- Implementation gaps — controls selected but misconfigured or partially deployed — are often discovered during **control assessments** and represent residual risk even when the control appears "in place."

## Related concepts
[[Security Controls]] [[Defense in Depth]] [[System Security Plan]] [[Risk Treatment]] [[Compensating Controls]]