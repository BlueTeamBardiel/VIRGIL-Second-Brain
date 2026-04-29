# PII

## What it is
Like a fingerprint that exists in data form — unique enough that finding it on a crime scene immediately points to one person — Personally Identifiable Information is any data that can be used alone or combined with other data to identify a specific individual. Precisely defined: PII includes direct identifiers (SSN, passport number) and quasi-identifiers (ZIP code + birthdate + gender) that, when linked, uniquely isolate a person.

## Why it matters
In the 2017 Equifax breach, attackers exfiltrated SSNs, birthdates, and addresses for 147 million people — a perfect storm of PII that enabled large-scale identity fraud and synthetic identity creation. The defense lesson: data minimization (collecting only what's necessary) and tokenization (replacing SSNs with non-sensitive tokens in databases) would have dramatically reduced the blast radius.

## Key facts
- **Two categories matter for exams:** Direct PII (SSN, driver's license, biometrics) vs. Indirect/quasi-identifiers (IP address, ZIP code, job title) that require combination to identify someone
- **NIST SP 800-122** is the federal guideline specifically defining and guiding PII protection — know this citation for Security+/CySA+
- **De-identification ≠ anonymization:** Removing obvious PII fields doesn't guarantee anonymity; re-identification attacks can reconstruct identities from "anonymous" datasets (Netflix Prize dataset attack, 2008)
- **Regulatory overlap:** HIPAA covers PHI (health-specific PII), GDPR covers EU residents' PII globally, CCPA covers California residents — violations carry fines up to 4% of global annual revenue under GDPR
- **Data at rest vs. in transit:** PII requires encryption in both states; AES-256 for storage and TLS 1.2+ for transmission are standard minimums

## Related concepts
[[Data Classification]] [[GDPR Compliance]] [[Data Loss Prevention]] [[Tokenization]] [[Privacy Impact Assessment]]