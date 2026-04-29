# Distributed Denial of Service

## What it is
Imagine thousands of people simultaneously calling every phone line at a hospital, preventing real emergencies from getting through — none of them are patients, just noise. A Distributed Denial of Service (DDoS) attack works the same way: a threat actor coordinates massive volumes of traffic from many geographically dispersed sources (often a botnet) to exhaust a target's bandwidth, connection capacity, or processing resources, rendering legitimate services unavailable.

## Why it matters
In October 2016, the Mirai botnet hijacked ~600,000 IoT devices and launched a DDoS attack against Dyn, a major DNS provider, taking down Twitter, Netflix, Reddit, and GitHub for hours across the U.S. East Coast. This attack demonstrated that poorly secured consumer devices (default credentials, no firmware updates) can be weaponized at scale to collapse critical internet infrastructure — not just single targets.

## Key facts
- **Three primary attack categories**: Volumetric (flood bandwidth — UDP flood, ICMP flood), Protocol (exhaust stateful devices — SYN flood, Ping of Death), and Application Layer (target specific services — HTTP GET flood, Slowloris).
- **Amplification attacks** exploit protocols like DNS, NTP, and SSDP to multiply traffic volume; a single spoofed 1-byte request can generate hundreds of bytes in response — DNS amplification can achieve a 50x amplification factor.
- **SYN flood** exploits the TCP three-way handshake by sending SYN packets without completing the connection, exhausting the server's half-open connection table.
- **Mitigations** include rate limiting, blackhole routing (null-routing), anycast diffusion, scrubbing centers, and upstream ISP filtering (ingress/egress filtering per BCP38).
- On the Security+ exam, DDoS is classified as an **availability attack** within the CIA triad — not confidentiality or integrity.

## Related concepts
[[Botnet]] [[SYN Flood]] [[Amplification Attack]] [[DNS Security]] [[Rate Limiting]]