# DNS Cache Poisoning

## What it is
Imagine a city's phone book being secretly reprinted with fake addresses — callers look up "City Hall" and get directed to a criminal's warehouse instead. DNS cache poisoning works the same way: an attacker injects fraudulent DNS records into a resolver's cache, causing legitimate domain lookups to return malicious IP addresses without the victim ever knowing.

## Why it matters
In 2008, security researcher Dan Kaminsky discovered a critical flaw allowing attackers to poison nearly any DNS resolver by flooding it with forged responses that guessed the 16-bit transaction ID — a tiny search space easily brute-forced. This attack could redirect entire populations of users to phishing sites or malware servers, demonstrating that poisoned infrastructure silently betrays every user downstream who trusts that resolver.

## Key facts
- **Attack vector**: Attacker races to send a forged DNS response with a matching Transaction ID before the legitimate authoritative server responds (birthday attack variant)
- **Classic weakness**: Original DNS used only a 16-bit transaction ID (~65,535 possibilities) — trivial to brute-force within a short TTL window
- **Primary defense**: DNSSEC cryptographically signs DNS records, allowing resolvers to verify authenticity; source port randomization (Kaminsky's patch) adds ~32 bits of entropy as a mitigation
- **Persistence**: Poisoned records remain cached until TTL expires — attackers prefer high-TTL targets to maximize damage duration
- **Symptoms/detection**: Unexpected certificate warnings, traffic anomalies in DNS logs, or SIEM alerts on DNS response inconsistencies are common indicators

## Related concepts
[[DNSSEC]] [[Man-in-the-Middle Attack]] [[BGP Hijacking]] [[Pharming]] [[DNS Spoofing]]


<!-- merged from: Cache Poisoning.md -->

# Cache Poisoning


