# Software Updates

## What it is
Think of software like a house being built in stages — the contractor discovers a cracked foundation after move-in and sends workers to fix it. A software update is a vendor-released modification to an existing program that patches vulnerabilities, fixes bugs, or adds features, delivered after the original deployment.

## Why it matters
In May 2017, the WannaCry ransomware exploited EternalBlue, a vulnerability in Windows SMBv1 — Microsoft had already released patch MS17-010 two months earlier. Organizations that delayed applying the update suffered catastrophic encryption of their systems, costing an estimated $4–8 billion globally. Timely patching is the single most impactful control against known exploits.

## Key facts
- **Patch vs. Update vs. Upgrade**: A *patch* fixes a specific vulnerability; an *update* bundles multiple fixes; an *upgrade* moves to a new major version — Security+ tests these distinctions
- **CVE and CVSS**: Patches are prioritized using Common Vulnerability Scoring System (CVSS) scores; critical vulnerabilities (CVSS ≥ 9.0) should be patched within 15 days under most enterprise SLAs
- **Zero-day risk window**: The period between vulnerability disclosure and patch release is the zero-day window — attackers actively weaponize this gap
- **Supply chain threat**: Malicious updates themselves can be attack vectors; the 2020 SolarWinds breach delivered malware via a signed, legitimate software update to ~18,000 organizations
- **Patch management lifecycle**: Inventory → Assess → Test → Deploy → Verify is the standard enterprise workflow; skipping the *test* phase can cause outages (change management controls this risk)

## Related concepts
[[Vulnerability Management]] [[Patch Management]] [[Zero-Day Vulnerability]] [[Change Management]] [[Supply Chain Attacks]]