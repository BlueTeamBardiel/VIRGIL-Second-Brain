# Microsoft Edge

## What it is
Think of it as a renovated building on the same street as Internet Explorer — same address, completely different interior. Microsoft Edge is a Chromium-based web browser developed by Microsoft, replacing the legacy EdgeHTML engine in 2020, and sharing the same rendering engine as Google Chrome while maintaining distinct security configurations and enterprise controls.

## Why it matters
In 2021, attackers exploited a zero-day in the Chromium engine (CVE-2021-21224) that affected both Chrome and Edge simultaneously — demonstrating that shared codebases create shared attack surfaces. Organizations relying on Edge's "different browser = different risk" assumption were caught off guard, highlighting why browser engine lineage matters for vulnerability management and patch prioritization.

## Key facts
- Edge uses the **Chromium rendering engine (Blink)**, meaning Chrome CVEs frequently apply to Edge as well — patch cadence alignment is critical
- **Microsoft Defender SmartScreen** is built into Edge, providing real-time phishing and malicious download protection distinct from Chrome's Safe Browsing
- Edge supports **Application Guard** (MDAG) — an enterprise feature that opens untrusted sites inside a Hyper-V isolated container, preventing host compromise
- Edge has a **Password Monitor** feature that checks stored credentials against known breach databases (HaveIBeenPwned-style), relevant for credential hygiene
- Edge enforces **Enhanced Security Mode**, which disables JIT compilation in the V8 JavaScript engine for unfamiliar sites, reducing memory exploitation surface

## Related concepts
[[Browser Security]] [[Chromium Vulnerabilities]] [[Microsoft Defender SmartScreen]] [[Application Sandboxing]] [[Zero-Day Exploits]]