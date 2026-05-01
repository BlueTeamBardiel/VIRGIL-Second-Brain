# DNS CAA Records

## What it is
Think of a CAA record as a "approved vendor list" posted on your building's front door — only contractors on that list are allowed inside to do work. A DNS Certification Authority Authorization (CAA) record is a DNS resource record (type 257) that specifies which Certificate Authorities are permitted to issue SSL/TLS certificates for a given domain. It's a domain owner's cryptographic policy declaration, enforced at the CA level before any certificate is issued.

## Why it matters
In 2011, the Dutch CA DigiNotar was compromised and fraudulently issued certificates for Google.com, enabling man-in-the-middle attacks against Iranian Gmail users. CAA records directly address this threat vector — if google.com had a CAA record authorizing only its own internal CA, DigiNotar's systems would have been required to refuse issuance. Since September 2017, all public CAs are mandated by the CA/Browser Forum to check CAA records before issuing any certificate.

## Key facts
- CAA records support three property tags: **issue** (allows issuance), **issuewild** (allows wildcard certificates specifically), and **iodef** (specifies a URL/email for violation reports)
- If **no CAA record exists**, any CA may issue certificates for the domain — making an empty CAA policy equivalent to no access control
- CAA records are checked by the CA, not enforced by browsers — they prevent unauthorized *issuance*, not unauthorized *presentation* of a forged cert
- A domain can have **multiple CAA records** authorizing multiple CAs simultaneously
- CAA records do **not replace** Certificate Transparency (CT) logs — they are complementary controls

## Related concepts
[[Certificate Transparency]] [[DNS Security Extensions (DNSSEC)]] [[TLS Certificate Pinning]]
