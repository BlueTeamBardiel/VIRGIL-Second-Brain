# security control coverage

## What it is
Like a security camera system where each camera has a field of view — gaps between cameras leave blind spots where theft goes undetected — security control coverage describes how completely your implemented controls protect assets across all threat vectors and attack surfaces. It measures the proportion of identified risks that have at least one compensating control actively addressing them, leaving no exploitable gaps unmitigated.

## Why it matters
During the 2013 Target breach, attackers entered through an HVAC vendor — a third-party access vector that fell outside Target's primary security control coverage. Network segmentation controls existed but didn't extend to vendor connections, meaning that entire attack path had zero effective coverage, allowing lateral movement from the vendor network directly to POS systems containing 40 million credit card numbers.

## Key facts
- Coverage gaps are identified through **control mapping** — aligning each risk in your risk register to specific controls (NIST CSF, ISO 27001, or CIS Controls frameworks are commonly used)
- **Defense-in-depth** intentionally creates overlapping coverage so a single control failure doesn't expose an asset — overlapping coverage is a feature, not redundancy waste
- Coverage is measured in three dimensions: **asset coverage** (which assets are protected), **threat coverage** (which attack types are addressed), and **detection coverage** (which attacks can you *see* happening)
- On CySA+ exams, coverage gaps found during a **security assessment** feed directly into a remediation roadmap prioritized by risk score
- **Control inheritance** in cloud environments (e.g., AWS shared responsibility model) means some coverage is provided by the vendor — misunderstanding this boundary is a common real-world gap

## Related concepts
[[defense in depth]] [[risk register]] [[security control frameworks]] [[attack surface]] [[compensating controls]]