# DNS validation

## What it is
Like a postal clerk verifying that a return address actually belongs to the sender before processing mail, DNS validation is the process of verifying that DNS responses are authentic and haven't been tampered with in transit. Specifically, it refers to mechanisms—primarily DNSSEC—that use cryptographic signatures to confirm that DNS records originated from the legitimate zone authority and were not altered.

## Why it matters
In a DNS cache poisoning attack (demonstrated by Dan Kaminsky in 2008), an attacker floods a resolver with forged responses, hoping to get a malicious IP address cached for a legitimate domain—redirecting thousands of users to a fake banking site before anyone notices. DNS validation via DNSSEC would have made this attack fail, because the forged response would lack a valid cryptographic signature from the real zone authority.

## Key facts
- **DNSSEC** uses asymmetric cryptography to sign DNS records; resolvers validate signatures using a chain of trust anchored at the root zone
- **Resource Record Signature (RRSIG)** is the DNSSEC record type that contains the actual cryptographic signature for a DNS record set
- DNS validation does **not** encrypt DNS traffic—it only provides integrity and authenticity (confidentiality requires DNS-over-HTTPS or DNS-over-TLS)
- **DANE (DNS-Based Authentication of Named Entities)** extends DNS validation to bind TLS certificates to domain names via TLSA records, reducing reliance on CAs
- Failure of DNSSEC validation returns a **SERVFAIL** response to the client rather than serving the potentially fraudulent record

## Related concepts
[[DNSSEC]] [[DNS Cache Poisoning]] [[DNS-over-HTTPS]] [[Public Key Infrastructure]] [[Man-in-the-Middle Attack]]
