# Bandwidth Hijacking

## What it is
Imagine someone secretly splicing into your garden hose to water their own lawn — you get a trickle while they drain your supply. Bandwidth hijacking is the unauthorized consumption or redirection of a victim's network capacity, either by abusing their infrastructure (like an open proxy or misconfigured router) or by flooding their link to crowd out legitimate traffic. The attacker essentially turns the victim's own resources into a tool for their benefit or the victim's detriment.

## Why it matters
In 2016, the Mirai botnet hijacked bandwidth from hundreds of thousands of IoT devices to launch a 1.2 Tbps DDoS attack against Dyn DNS, taking down Twitter, Reddit, and Netflix. The enslaved devices' owners lost usable bandwidth without knowing their cameras and routers were participating in the assault. Defenders monitor for unusual egress spikes and use rate limiting and netflow analysis to detect compromised endpoints.

## Key facts
- **Amplification attacks** (DNS, NTP, SSDP) hijack third-party server bandwidth to multiply attack volume — amplification ratios can exceed 500:1
- **Cryptojacking** is a form of bandwidth hijacking where malware steals CPU *and* network resources to mine cryptocurrency without user consent
- **BGP hijacking** redirects entire IP prefixes at the routing level, hijacking traffic flows across the internet — not just a single host
- Detecting bandwidth hijacking typically involves **baseline anomaly detection** — flagging deviations from normal traffic volume or destination patterns
- Open resolvers and misconfigured NTP servers are primary **reflectors/amplifiers** exploited for bandwidth theft; closing them is a core hardening step

## Related concepts
[[DDoS Attack]] [[BGP Hijacking]] [[Amplification Attack]] [[Cryptojacking]] [[Botnet]]