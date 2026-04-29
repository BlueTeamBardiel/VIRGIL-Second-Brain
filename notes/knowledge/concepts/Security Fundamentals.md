# Security Fundamentals

## What it is
Like a hospital that controls who enters the building, who can access patient records, and who gets alerted when someone breaks in — security is the layered practice of protecting assets through confidentiality, integrity, and availability (the CIA Triad). It is the foundational framework that governs how organizations identify threats, implement controls, and respond to incidents across people, processes, and technology.

## Why it matters
In the 2017 Equifax breach, attackers exploited an unpatched Apache Struts vulnerability — a failure of basic patch management, a core security fundamental. Had integrity checks and vulnerability management processes been in place, 147 million people's personal data would not have been exposed. Every advanced attack technique ultimately bypasses a fundamental control that was missing or misconfigured.

## Key facts
- **CIA Triad**: Confidentiality (only authorized access), Integrity (data is unaltered), Availability (systems remain accessible) — the three pillars every control maps to
- **AAA Framework**: Authentication (who are you?), Authorization (what can you do?), Accounting (what did you do?) — foundational to access control design
- **Defense in Depth**: Layering multiple independent controls so that failure of one does not compromise the whole system
- **Least Privilege**: Users and processes receive only the minimum permissions necessary — reduces blast radius of any compromise
- **Non-repudiation**: Cryptographic proof that an action occurred and cannot be denied — critical for audit trails and legal accountability
- **Risk = Threat × Vulnerability × Impact**: Risk is never zero; the goal is reduction to an acceptable level through controls

## Related concepts
[[CIA Triad]] [[Defense in Depth]] [[Risk Management]] [[Access Control]] [[Authentication]]