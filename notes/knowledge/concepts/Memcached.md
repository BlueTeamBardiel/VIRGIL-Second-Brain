# Memcached

## What it is
Imagine a sticky-note board next to a chef's workstation — instead of walking to the pantry every time, they grab ingredients already prepped nearby. Memcached is an open-source, in-memory key-value caching system that stores frequently accessed data in RAM to reduce database load and accelerate application response times. It operates over UDP (port 11211) and was designed for speed, not security — authentication is absent by default.

## Why it matters
In 2018, attackers exploited publicly exposed Memcached servers to launch the largest DDoS amplification attack ever recorded at the time, peaking at **1.7 Tbps against GitHub**. Because Memcached responds to spoofed UDP requests with replies up to 51,000× larger than the request, threat actors could send a tiny forged packet and direct a devastating flood of traffic at any target. Defenders must firewall port 11211 from the public internet and disable UDP if reflection amplification is a concern.

## Key facts
- **Amplification factor**: Memcached UDP amplification can reach a ratio of ~51,000:1, making it the highest amplification factor of any known reflection attack vector.
- **Default port**: TCP/UDP **11211**; UDP is the dangerous surface for amplification attacks.
- **No authentication**: Vanilla Memcached has zero built-in access controls — anyone who can reach the port can read, write, or delete cached data.
- **Data exposure risk**: Sensitive session tokens, API keys, or PII cached improperly can be directly dumped by an attacker with network access.
- **Mitigation**: Bind Memcached to localhost (127.0.0.1), disable UDP with `--disable-udp`, and use firewall rules to block external access to port 11211.

## Related concepts
[[DDoS Amplification Attack]] [[UDP Spoofing]] [[Reflection Attack]] [[Network Segmentation]] [[NoSQL Injection]]