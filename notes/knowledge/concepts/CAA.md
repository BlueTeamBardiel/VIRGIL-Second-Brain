# CAA

## What it is
Like a property owner filing paperwork saying "only ABC Locksmith is allowed to make keys for my house," a CAA record tells the entire internet which Certificate Authorities are permitted to issue SSL/TLS certificates for your domain. It's a DNS record type (RFC 6844) that lets domain owners restrict certificate issuance, preventing unauthorized CAs from minting certs for your domain even if they're technically capable of doing so.

## Why it matters
In 2011, the rogue CA DigiNotar issued fraudulent certificates for Google.com, enabling Iranian authorities to intercept encrypted Gmail traffic for ~300,000 users via MITM attacks. Had Google published a CAA record authorizing only their own trusted CAs, any compliant CA receiving a certificate request for google.com would have been required to check and refuse — stopping the issuance before the attack could begin.

## Key facts
- CAA records use three tags: **issue** (allows a CA to issue standard certs), **issuewild** (allows wildcard certs), and **iodef** (specifies where CAs should report policy violations, typically an email or URL)
- Since **September 2017**, all publicly trusted CAs are **required by CA/Browser Forum** to check CAA records before issuing certificates
- An **empty CAA record** (no authorized CAs listed) means **no CA** is permitted to issue — a powerful lockdown posture
- CAA records are **DNS-based**, meaning they inherit DNS weaknesses — DNSSEC should be used alongside CAA to prevent spoofed DNS responses undermining the protection
- CAA does **not** revoke existing certificates; it only controls future issuance

## Related concepts
[[DNSSEC]] [[Certificate Transparency]] [[TLS Certificate Pinning]]