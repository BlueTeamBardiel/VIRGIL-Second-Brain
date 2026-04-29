# Windows Update

## What it is
Think of Windows Update as a pit crew that races to your car mid-race, patching hairline cracks in the chassis before a competitor exploits them. Technically, it is Microsoft's automated service (via the Windows Update Agent and WSUS/WUfB infrastructure) that delivers security patches, cumulative updates, and driver updates to Windows endpoints through signed CAB or MSI packages verified against Microsoft's PKI.

## Why it matters
In May 2017, WannaCry ransomware tore through 200,000 systems in 150 countries by exploiting EternalBlue (MS17-010) — a vulnerability Microsoft had patched two months earlier in March 2017. Every infected machine that ran Windows Update on schedule was immune; every unpatched machine became a propagation node, illustrating that patch cadence is a direct, measurable attack surface metric.

## Key facts
- Microsoft releases patches on **Patch Tuesday** (second Tuesday of each month), with out-of-band updates reserved for zero-days under active exploitation
- **WSUS (Windows Server Update Services)** allows enterprises to centrally approve, test, and deploy updates before they reach endpoints — reducing the risk of a bad patch bricking production systems
- **Windows Update for Business (WUfB)** integrates with Intune/Azure AD to enforce deferral policies, targeting rings for staged rollouts
- Updates are signed using Microsoft's code-signing certificates; a tampered update without a valid signature will be rejected by the Windows Update Agent
- **CVE patching priority** on Security+ exams: critical RCE vulnerabilities should be patched within 72 hours per NIST SP 800-40 guidance

## Related concepts
[[Patch Management]] [[WSUS]] [[EternalBlue]] [[Vulnerability Scanning]] [[CVE]]