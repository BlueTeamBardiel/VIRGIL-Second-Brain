# Conflict of Interest

## What it is
Like a judge who owns stock in a company whose case they're presiding over, a conflict of interest occurs when someone's personal stake compromises their ability to act impartially in their professional role. In cybersecurity, this means an individual has competing loyalties — financial, personal, or organizational — that could corrupt their security decisions, reviews, or audits.

## Why it matters
A classic scenario: an internal auditor tasked with reviewing access controls is also the administrator who *configured* those same controls. They have a direct incentive to overlook their own mistakes or cover their tracks, making the audit meaningless. This is why SOX compliance and frameworks like NIST explicitly require **separation of duties** to eliminate self-auditing scenarios.

## Key facts
- **Self-auditing is the canonical example** — no one should audit their own work; it violates objectivity and is explicitly flagged in compliance frameworks
- **Dual roles create inherent conflicts**: an IT admin who is also the security auditor cannot independently verify their own configurations
- **Vendor relationships matter**: a security consultant recommending products from a company in which they hold equity is a textbook conflict of interest
- **Disclosure and recusal** are the standard mitigations — conflicts must be declared, and the conflicted party must step aside from the decision
- **Security+ and CySA+ context**: conflicts of interest fall under governance, risk, and compliance (GRC) and are addressed through separation of duties, job rotation, and mandatory vacations (which expose fraud)

## Related concepts
[[Separation of Duties]] [[Least Privilege]] [[Job Rotation]] [[Due Diligence]] [[Insider Threat]]