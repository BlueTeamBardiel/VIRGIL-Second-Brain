# HIPAA Security Rule

## What it is
Think of it as the building code for a hospital's digital infrastructure — just as construction law mandates fire exits and load-bearing walls, the HIPAA Security Rule mandates specific technical, physical, and administrative controls for any system that touches electronic Protected Health Information (ePHI). Enacted under HIPAA (1996) and strengthened by the HITECH Act (2009), it requires covered entities and their business associates to ensure confidentiality, integrity, and availability of ePHI through documented, enforceable safeguards.

## Why it matters
In 2015, Anthem Inc. suffered a breach exposing nearly 79 million patient records after attackers used stolen credentials to execute SQL injection against an unencrypted database — a direct violation of HIPAA's access control and encryption guidance. The resulting $16 million OCR settlement illustrates that HIPAA Security Rule failures carry both regulatory fines and reputational destruction, making compliance a hard security objective, not a checkbox exercise.

## Key facts
- **Three safeguard categories:** Administrative (risk analysis, workforce training), Physical (facility access controls, workstation security), and Technical (access controls, audit controls, encryption, integrity controls, transmission security)
- **Risk Analysis is mandatory** — not optional — and must be conducted regularly; it is the single most cited deficiency in OCR audits
- **Encryption is "addressable," not "required"** — but organizations must document why they chose an equivalent alternative, or implement it; in practice, skipping encryption is nearly indefensible
- **Business Associates (BAs)** are directly liable under HITECH — a breach by your EHR vendor can still land your organization in violation
- **Minimum necessary standard** restricts access to only the ePHI required to perform a specific job function, directly mapping to the principle of least privilege

## Related concepts
[[Principle of Least Privilege]] [[Data Classification]] [[Risk Assessment]] [[Access Control]] [[NIST 800-66]]