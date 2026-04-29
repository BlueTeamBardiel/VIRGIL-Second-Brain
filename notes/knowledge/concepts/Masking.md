# masking

## What it is
Like a costume party where someone wears a name tag reading "John Smith" while their real identity is hidden underneath, masking replaces sensitive data with a non-sensitive substitute that preserves format but reveals nothing real. Precisely, data masking transforms original data (credit card numbers, SSNs, PII) into a fictitious but structurally valid version, either statically (stored permanently) or dynamically (on-the-fly during retrieval). The masked value looks real enough to be useful in testing or display contexts without exposing the actual secret.

## Why it matters
In 2019, Capital One's breach exposed over 100 million customer records partially because sensitive fields weren't masked in non-production environments used by developers. Had static data masking been applied to test databases, developers would have worked with fake but realistic card numbers, and the stolen data would have been worthless to the attacker. This scenario is a textbook justification for masking as a data minimization control.

## Key facts
- **Static Data Masking (SDM)** permanently alters data at rest — used for dev/test environments to prevent real data exposure.
- **Dynamic Data Masking (DDM)** masks data in real-time during queries without changing stored values — the database still holds the original, but unauthorized users see `XXXX-XXXX-XXXX-1234`.
- Masking differs from **encryption**: masked data cannot be "unmasked" by design (no key exists); it's a one-way transformation.
- Common techniques include substitution, shuffling, nulling, and format-preserving pseudonymization.
- Masking supports compliance with **PCI-DSS** (card numbers), **HIPAA** (PHI), and **GDPR** (personal data minimization requirements).

## Related concepts
[[data loss prevention]] [[tokenization]] [[encryption]] [[pseudonymization]] [[data classification]]