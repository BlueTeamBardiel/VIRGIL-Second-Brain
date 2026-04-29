# Mitigation Strategy

## What it is
Like a doctor prescribing both a bandage *and* antibiotics rather than choosing one, a mitigation strategy is a layered plan combining multiple controls to reduce the likelihood or impact of a security threat. Precisely: it is a documented set of technical, administrative, and physical countermeasures selected to address a specific identified risk, lowering residual risk to an acceptable level.

## Why it matters
After the 2017 WannaCry ransomware outbreak, organizations without a mitigation strategy were crippled — they lacked patching schedules (fix MS17-010), network segmentation (stop lateral movement), and offline backups (enable recovery). Organizations with documented mitigation strategies recovered in hours; others paid ransoms or rebuilt from scratch over weeks.

## Key facts
- Mitigation strategies are chosen based on a **risk assessment**: they target threats with high likelihood × high impact first
- The four core risk responses are **Avoid, Transfer, Mitigate, Accept** — mitigation specifically *reduces* risk rather than eliminating or shifting it
- Effective strategies combine **preventive** (patch management), **detective** (SIEM alerts), and **corrective** (incident response playbooks) controls
- **Compensating controls** are a mitigation sub-type used when a primary control cannot be implemented (e.g., isolating a legacy system that can't be patched)
- NIST SP 800-61 and the **MITRE ATT&CK framework** are standard references for mapping threats to specific mitigations

## Related concepts
[[Risk Management]] [[Defense in Depth]] [[Compensating Controls]] [[Patch Management]] [[Incident Response]]