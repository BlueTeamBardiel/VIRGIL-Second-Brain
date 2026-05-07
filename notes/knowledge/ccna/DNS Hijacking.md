# DNS hijacking

## What it is
Imagine a city's street sign network being secretly swapped overnight — residents follow the signs but end up at the wrong buildings. DNS hijacking is exactly that: an attacker corrupts or intercepts DNS resolution so that legitimate domain queries return malicious IP addresses, redirecting users to attacker-controlled servers without their knowledge.

## Why it matters
In 2019, the U.S. CISA issued an emergency directive after attackers hijacked DNS records for multiple U.S. government domains by compromising DNS registrar credentials, then redirecting traffic through attacker infrastructure to harvest credentials via forged TLS certificates. Defenders responded by implementing multi-factor authentication on registrar accounts and monitoring for unauthorized NS record changes.

## Key facts
- **Four main attack vectors:** router DNS setting manipulation, hosts file poisoning, DNS server compromise, and registrar account takeover
- **DNS cache poisoning** (Kaminsky attack) is a specific hijacking technique where forged UDP responses inject false records into a resolver's cache — DNSSEC was designed to counter this
- **DNSSEC** (DNS Security Extensions) uses cryptographic signatures to validate DNS responses but does *not* encrypt them — it prevents tampering, not eavesdropping
- Attackers often pair DNS hijacking with **valid TLS certificates** (via Let's Encrypt) to avoid browser warnings on fraudulent sites, making detection harder for end users
- Detection indicators include unexpected changes to **NS, A, or MX records**, TTL anomalies, and certificate transparency log entries for domains you own

## Related concepts
[[DNS Cache Poisoning]] [[DNSSEC]] [[Man-in-the-Middle Attack]] [[BGP Hijacking]] [[Domain Registrar Security]]