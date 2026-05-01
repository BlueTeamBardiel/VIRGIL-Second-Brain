# DNSSEC

## What it is
Think of DNS responses like postcards — anyone handling them en route can forge or alter them, and the recipient has no way to know. DNSSEC adds a wax seal with a verifiable signature chain: each DNS record is cryptographically signed so resolvers can confirm the data came from the authoritative source and wasn't tampered with in transit. It is a suite of IETF extensions to DNS that uses public-key cryptography to provide origin authentication and data integrity for DNS records — but notably *not* confidentiality.

## Why it matters
Without DNSSEC, attackers can execute **DNS cache poisoning** (Kaminsky Attack, 2008): by flooding a resolver with forged responses containing a fake IP for a legitimate domain, an attacker redirects all users hitting that resolver to a malicious server — silently. DNSSEC forces resolvers to reject any response that fails signature validation, making cache poisoning cryptographically impractical rather than merely probabilistically difficult.

## Key facts
- DNSSEC uses two key pairs per zone: the **Zone Signing Key (ZSK)** signs individual records, and the **Key Signing Key (KSK)** signs the ZSK — creating a two-tier trust model.
- The **chain of trust** flows from the DNS root zone downward; the root's public key (Trust Anchor) is hardcoded into resolvers.
- DNSSEC adds new record types: **RRSIG** (signature), **DNSKEY** (public key), **DS** (delegation signer), and **NSEC/NSEC3** (authenticated denial of existence).
- DNSSEC provides **integrity and authentication**, but NOT encryption — DNS traffic remains plaintext (see DNS over HTTPS/TLS for confidentiality).
- A failed DNSSEC validation causes the resolver to return **SERVFAIL**, not the poisoned record — protecting users at the cost of availability if misconfigured.

## Related concepts
[[DNS Cache Poisoning]] [[Public Key Infrastructure]] [[DNS over HTTPS]] [[Zone Transfer]] [[Chain of Trust]]
