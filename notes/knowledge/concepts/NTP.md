# NTP

## What it is
Like a universal clock tower that every device in a city synchronizes its watch to, NTP (Network Time Protocol) ensures all computers on a network agree on the exact same time. It operates on UDP port 123 and uses a hierarchical system of "stratum" servers to distribute time from authoritative atomic clocks down to end devices.

## Why it matters
Kerberos authentication breaks completely if clocks are more than 5 minutes out of sync — an attacker who can manipulate NTP can desynchronize a target's clock and lock users out of Active Directory environments entirely. Conversely, defenders rely on accurate timestamps to correlate log events across systems; without synchronized time, a SIEM becomes useless for incident reconstruction.

## Key facts
- NTP amplification attacks exploit publicly accessible NTP servers using the `monlist` command, which returns a list of the last 600 clients — enabling a **556x amplification factor** for DDoS attacks
- Uses **UDP port 123**; the connectionless nature of UDP makes it trivially spoofable for reflection attacks
- **Stratum 0** = atomic/GPS reference clocks; **Stratum 1** = servers directly connected to Stratum 0; each hop adds one stratum level (max 15)
- **NTPsec** and **NTP authentication** using symmetric keys or Autokey help mitigate man-in-the-middle time poisoning attacks
- Kerberos requires clocks within **300 seconds (5 minutes)** of each other — this is a direct Security+ testable fact

## Related concepts
[[DDoS Amplification]] [[Kerberos]] [[UDP Spoofing]] [[SIEM]] [[Stratum Hierarchy]]