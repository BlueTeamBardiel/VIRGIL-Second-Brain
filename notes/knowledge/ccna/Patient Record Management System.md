# Patient Record Management System

## What it is
Think of it like a hospital's master filing cabinet — except instead of paper folders, it's a networked database holding every lab result, prescription, and diagnosis for thousands of patients. A Patient Record Management System (PRMS) is a software platform used by healthcare organizations to store, retrieve, and manage electronic health records (EHRs), subject to strict regulatory and security requirements. It sits at the intersection of clinical operations and sensitive PII/PHI data handling.

## Why it matters
In 2015, Anthem Inc. suffered a breach exposing nearly 78.8 million patient records after attackers used stolen credentials to query the PRMS database directly — no encryption on stored data meant records were exfiltrated in plaintext. This incident became a textbook case for why healthcare systems require both access controls and encryption at rest, not just perimeter defenses. Regulators responded by intensifying HIPAA audit enforcement around database-layer security controls.

## Key facts
- PRMS platforms must comply with **HIPAA** (Health Insurance Portability and Accountability Act), which mandates administrative, physical, and technical safeguards for Protected Health Information (PHI).
- **Role-Based Access Control (RBAC)** is the standard model — a billing clerk should never have the same database privileges as an attending physician.
- **Audit logging** of all PHI access is a HIPAA Technical Safeguard requirement; logs must be regularly reviewed as part of CySA+ threat-hunting workflows.
- SQL injection is a top attack vector against PRMS databases; parameterized queries and input validation are mandatory defensive controls.
- Under HIPAA's **Breach Notification Rule**, covered entities must notify affected individuals within 60 days of discovering a breach involving unsecured PHI.

## Related concepts
[[HIPAA Compliance]] [[Role-Based Access Control]] [[SQL Injection]] [[Data Encryption at Rest]] [[Audit Logging]]