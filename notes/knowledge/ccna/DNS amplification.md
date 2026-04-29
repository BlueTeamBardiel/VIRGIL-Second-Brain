# DNS amplification

## What it is
Imagine whispering a stranger's address to a megaphone operator and asking them to shout the reply to that address — you spend almost no effort, but the target gets blasted. DNS amplification is a volumetric DDoS attack where an attacker sends small, spoofed DNS queries (using the victim's IP as the source) to open resolvers, which return responses many times larger — flooding the victim with traffic they never requested.

## Why it matters
In 2013, Spamhaus suffered one of the largest DDoS attacks ever recorded — peaking at ~300 Gbps — driven largely by DNS amplification via open resolvers. Defenders counter this by configuring resolvers to answer only for authorized clients (closed recursion) and by ISPs implementing BCP38 ingress filtering to block spoofed source IPs at the network edge.

## Key facts
- **Amplification factor:** DNS responses can be 28–54× larger than the query; using ANY or DNSSEC records can push this even higher (up to ~70×).
- **Spoofing dependency:** The attack requires IP source address spoofing (UDP has no handshake), making BCP38 filtering the single most effective network-level mitigation.
- **Open resolvers are the weapon:** Publicly accessible recursive DNS servers that answer queries from any source are the exploitable resource; Shodan regularly indexes millions of them.
- **UDP-based:** Because DNS uses UDP by default, there is no three-way handshake to verify the requester's IP — this is the fundamental property that enables the spoof.
- **Mitigation on the resolver side:** Rate limiting (Response Rate Limiting / RRL) and restricting recursion to known IP ranges are the primary defenses for DNS server operators.

## Related concepts
[[DDoS attacks]] [[IP spoofing]] [[UDP flood]] [[BCP38]] [[NTP amplification]]