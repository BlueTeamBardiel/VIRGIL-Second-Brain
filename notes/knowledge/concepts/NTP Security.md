# NTP Security

## What it is
Like a town clock that everyone sets their watches by — if an attacker controls the clock tower, they can make the whole town run an hour behind without anyone noticing. Network Time Protocol (NTP) synchronizes clocks across networked devices, and NTP security encompasses the controls that prevent attackers from manipulating, abusing, or exploiting that time synchronization infrastructure.

## Why it matters
In 2014, attackers exploited misconfigured NTP servers using the `monlist` command to execute a massive amplification DDoS attack — sending a small 234-byte request that triggered a 48KB response, achieving a 206x amplification factor. Time manipulation attacks also undermine certificate validity checks, Kerberos authentication (which fails if clocks drift more than 5 minutes), and log correlation during incident response.

## Key facts
- **NTP Amplification (DDoS):** Attackers spoof the victim's IP and query NTP servers for `monlist` data; the massive response floods the victim — amplification ratios can exceed 200:1
- **NTPsec and NTP authentication** use symmetric keys or autokey to cryptographically verify time sources, preventing rogue NTP server injection
- **Kerberos dependency:** Active Directory environments require clocks synchronized within 5 minutes; skewing time beyond this threshold breaks authentication and can lock users out
- **Stratum hierarchy:** Stratum 0 = atomic/GPS reference clocks; Stratum 1 = directly connected servers; each hop adds a stratum level — trust decreases with higher stratum numbers
- **Hardening steps:** Disable `monlist` (restrict queries in `ntp.conf`), use NTP authentication, limit NTP to trusted upstream sources, and firewall UDP port 123 from external access

## Related concepts
[[DDoS Amplification Attacks]] [[Kerberos Authentication]] [[Network Hardening]] [[Protocol Abuse]] [[Log Analysis]]