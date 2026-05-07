# DNS Attacks

## What it is
DNS is the internet's phone book — DNS attacks are like bribing the operator to give callers a fake number, sending them to an imposter's address instead of the real destination. DNS attacks exploit the Domain Name System to redirect, intercept, or disrupt the process of resolving human-readable domain names into IP addresses. They range from cache poisoning to full hijacking of DNS infrastructure.

## Why it matters
In 2019, the Sea Turtle campaign compromised multiple DNS registrars and TLD operators, redirecting traffic for government and telecom organizations across the Middle East to attacker-controlled servers — harvesting credentials before passing victims to the real sites. Defenders responded by enforcing DNSSEC validation and monitoring for unauthorized NS record changes, since victims were unaware anything was wrong.

## Key facts
- **DNS Cache Poisoning (Kaminsky Attack)**: Attackers flood a resolver with forged responses to inject a malicious IP into cache, redirecting all users served by that resolver until TTL expires
- **DNS Hijacking**: Modifying DNS records at the registrar or resolver level, often via stolen credentials — distinct from poisoning because the authoritative record itself is changed
- **DNS Tunneling**: Encodes data (C2 commands, exfiltrated files) inside DNS queries/responses to bypass firewalls; tools like `dnscat2` and `iodine` are common examples
- **DNSSEC** mitigates poisoning by digitally signing DNS records, but adoption remains incomplete and it does not encrypt queries (DNS over HTTPS/DoT addresses that separately)
- **DNS Amplification (DDoS)**: Sends small queries with a spoofed victim IP to open resolvers; responses are 28–54x larger, flooding the victim — a classic volumetric DDoS vector

## Related concepts
[[DNSSEC]] [[DDoS Amplification Attacks]] [[Man-in-the-Middle Attack]] [[DNS over HTTPS]] [[Domain Hijacking]]