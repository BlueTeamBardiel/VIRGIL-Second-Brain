# PATCH

## What it is
Like a tailor sewing a torn seam before someone trips on it, a patch is a software update released specifically to fix a security flaw or bug in existing code. Technically, it's a set of changes applied to software that closes a vulnerability, corrects faulty logic, or removes malicious code introduced by a threat actor.

## Why it matters
In May 2017, the WannaCry ransomworm infected 200,000+ systems across 150 countries — exploiting EternalBlue, a Windows SMB vulnerability for which Microsoft had already released patch MS17-010 two months earlier. Organizations that delayed patching were devastated; those that applied the patch were immune. Patch management is often the single highest-ROI defensive action a security team can take.

## Key facts
- **Zero-day window**: The period between vulnerability discovery and patch availability is called the zero-day window — patches close it, but attackers exploit it aggressively
- **Patch Tuesday**: Microsoft releases security patches on the second Tuesday of each month; attackers reverse-engineer these to build exploits targeting unpatched systems ("Exploit Wednesday")
- **Mean Time to Patch (MTTP)**: A key metric for organizational security posture; industry guidance recommends critical patches be applied within 72 hours of release
- **Hotfix vs. patch vs. update**: A hotfix is an urgent single-issue fix; a patch addresses specific vulnerabilities; an update is a broader improvement package — Security+ distinguishes these
- **Regression risk**: Patches can break existing functionality; this is why organizations use test environments and staged rollouts before enterprise-wide deployment

## Related concepts
[[Vulnerability Management]] [[Zero-Day Exploit]] [[Change Management]] [[Attack Surface]] [[CVE]]