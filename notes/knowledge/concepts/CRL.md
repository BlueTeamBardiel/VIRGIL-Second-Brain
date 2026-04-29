# CRL

## What it is
Think of it like a bank's list of stolen credit card numbers — merchants check it before approving a transaction. A Certificate Revocation List (CRL) is a digitally signed list published by a Certificate Authority (CA) that contains the serial numbers of certificates that have been revoked before their expiration date. PKI clients download this list to verify that a certificate they've received hasn't been invalidated due to compromise, key exposure, or policy violation.

## Why it matters
In 2011, the DigiNotar CA was compromised and fraudulent certificates were issued for Google domains — attackers used these to intercept Iranian Gmail traffic via man-in-the-middle attacks. Proper CRL checking would have flagged the fraudulent certificates once DigiNotar began revoking them, but many clients either didn't check the CRL or the CA was removed from trust stores entirely before revocation could help.

## Key facts
- CRLs are published at a URL called the **CDP (CRL Distribution Point)**, embedded in the certificate's extensions field
- CRLs have a **validity window** (e.g., 7 days) — a certificate could be revoked but still pass CRL checks if the list hasn't been refreshed
- **Delta CRLs** contain only changes since the last full CRL, reducing download size and improving timeliness
- CRL checking is increasingly replaced by **OCSP** (Online Certificate Status Protocol), which queries revocation status in real time per-certificate rather than downloading a full list
- If a client **cannot reach the CRL** and is configured for "hard fail," it rejects the certificate; "soft fail" (the default in many browsers) allows the connection anyway — a known security weakness

## Related concepts
[[PKI]] [[OCSP]] [[Certificate Authority]] [[X.509]] [[Man-in-the-Middle Attack]]