# Security Patches

## What it is
Like a plumber fixing a cracked pipe before the flood reaches the living room, a security patch is a targeted code update issued by a vendor to close a specific vulnerability in software or firmware. Patches correct logic errors, memory flaws, or authentication weaknesses that attackers could otherwise exploit. They are distinct from feature updates — their sole purpose is eliminating a known security weakness.

## Why it matters
In May 2017, the WannaCry ransomware worm devastated over 200,000 systems across 150 countries by exploiting EternalBlue, a vulnerability in Windows SMBv1. Microsoft had issued patch MS17-010 a full 59 days before the outbreak — every infected machine was running unpatched software. Organizations that applied the patch promptly were completely immune, making this the textbook case for patch management discipline.

## Key facts
- **Patch Tuesday** refers to Microsoft's practice of releasing security updates on the second Tuesday of each month; emergency patches outside this cycle are called **out-of-band patches**
- A **zero-day vulnerability** has no patch available yet — the window between disclosure and patch release is called the **vulnerability window**
- **CVE (Common Vulnerabilities and Exposures)** numbers uniquely identify vulnerabilities; patches reference CVE IDs so administrators can correlate fixes to known risks
- CVSS scores (0–10) help prioritize patching; scores ≥ 9.0 are **Critical** and should be patched within 15–30 days per most frameworks
- **Regression testing** must follow patching to ensure the fix doesn't break legitimate functionality — skipping this causes operational outages

## Related concepts
[[Vulnerability Management]] [[CVE and CVSS]] [[Zero-Day Exploit]] [[Patch Tuesday]] [[Configuration Management]]