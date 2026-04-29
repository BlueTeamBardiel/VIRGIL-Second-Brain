# incomplete remediation

## What it is
Like patching a single hole in a leaky boat while two more remain below the waterline — the boat still sinks. Incomplete remediation occurs when a vulnerability fix addresses the reported symptom but fails to eliminate the root cause or all affected components, leaving exploitable attack surface behind.

## Why it matters
In 2021, researchers demonstrated incomplete remediation against Microsoft Exchange (ProxyLogon family): organizations patched CVE-2021-26855 but left related CVEs (26857, 26858, 27065) unaddressed, allowing attackers to chain the remaining flaws for full Remote Code Execution. Defenders who checked the single CVE status believed they were protected — a false sense of closure that made triage harder.

## Key facts
- A patch may fix one code path but miss a **logically equivalent bypass** — common in SQL injection and authentication bypass vulnerabilities where multiple input vectors exist.
- CWE-693 (Protection Mechanism Failure) and CWE-1037 directly categorize flaws that arise from partial or bypassed mitigations.
- Penetration testers specifically re-test all variants of a vulnerability class after patching; finding a bypass is a hallmark of incomplete remediation.
- CVSS scores apply per CVE — related CVEs from the same root flaw may carry **different severity scores**, causing teams to deprioritize patches they should chain together.
- The remediation verification phase of an incident response cycle (per NIST SP 800-61) explicitly requires testing that the *root cause* is eliminated, not just that the reported indicator is gone.

## Related concepts
[[patch management]] [[vulnerability scanning]] [[root cause analysis]] [[defense in depth]] [[CVE]]