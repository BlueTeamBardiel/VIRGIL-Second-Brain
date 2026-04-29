# Testing and Validation

## What it is
Like a pilot running pre-flight checklists before trusting their instruments with lives, testing and validation is the structured process of verifying that security controls actually perform as intended — not just as designed. It encompasses active techniques (penetration testing, fuzzing, red team exercises) and passive verification (log review, configuration audits) to confirm defenses work under real-world conditions.

## Why it matters
In 2017, Equifax suffered a breach exposing 147 million records partly because a vulnerability scanner flagged Apache Struts as unpatched — but the alert was missed due to a broken SSL inspection certificate on the monitoring tool itself. Proper validation of the scanning infrastructure would have caught this blind spot before attackers did.

## Key facts
- **Penetration testing phases**: Reconnaissance → Scanning → Exploitation → Post-exploitation → Reporting; scope must be formally authorized in writing before testing begins
- **Vulnerability scanning vs. pen testing**: Scanning identifies potential weaknesses passively; pen testing actively exploits them to confirm impact — Security+ distinguishes these explicitly
- **False positives vs. false negatives**: False positives waste analyst time; false negatives (missed vulnerabilities) are the dangerous failure mode in security validation
- **Regression testing** ensures that patching one vulnerability didn't reintroduce a previously fixed one — critical in CI/CD security pipelines
- **CySA+ focus**: After remediation, a follow-up scan must confirm the finding is closed; simply applying a patch without re-scanning is incomplete validation

## Related concepts
[[Vulnerability Scanning]] [[Penetration Testing]] [[Security Audits]] [[Continuous Monitoring]]