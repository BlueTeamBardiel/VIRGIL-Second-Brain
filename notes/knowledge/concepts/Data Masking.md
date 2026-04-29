# data masking

## What it is
Like a redacted government document where sensitive words are blacked out but the page structure remains intact, data masking replaces real sensitive data with realistic but fictitious values. The original data format and structure are preserved, but the actual values are obscured, making the data usable for testing or analytics without exposing the real information.

## Why it matters
A developer needs production-like data to test a new payment feature, but giving them actual credit card numbers creates massive PCI-DSS exposure. By masking the production dataset — replacing real card numbers with structurally valid but fake ones — the organization enables realistic testing while ensuring a breach of the dev environment leaks nothing exploitable.

## Key facts
- **Static data masking** transforms data at rest in a copied dataset; **dynamic data masking** obscures data in real-time at the query layer without altering stored values.
- Common masking techniques include substitution, shuffling, nulling, encryption, and character scrambling — each trades different levels of realism for protection strength.
- Data masking is a key control for satisfying **PCI-DSS**, **HIPAA**, and **GDPR** requirements when sharing data with third-party vendors or development teams.
- Unlike encryption, masked data **cannot be reversed** to its original form (in most implementations), making it a one-way transformation suitable for non-production environments.
- Masking differs from **tokenization**: tokenization replaces data with a token that maps back to the original via a secure vault; masking has no such reverse mapping.

## Related concepts
[[tokenization]] [[data classification]] [[privacy by design]]