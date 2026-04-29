# Brownout

## What it is
Like a city's power grid deliberately running at reduced voltage — lights flicker, elevators slow, but the system technically stays "on" — a brownout in cybersecurity refers to a partial degradation of service availability, where a system remains operational but performs at significantly reduced capacity. It sits between full availability and a complete outage (blackout), often caused by resource exhaustion, throttling, or deliberate attack.

## Why it matters
Attackers can deliberately induce brownouts as a subtler alternative to full Denial-of-Service attacks — by sending just enough malicious traffic to degrade a web application's response times without triggering volumetric DDoS detection thresholds. This "slow torture" approach frustrates legitimate users while keeping defenders from seeing the clear spike signatures that would fire standard alerts, making the attack harder to attribute and remediate.

## Key facts
- Brownouts can be **unintentional** (infrastructure overload, hardware failure) or **intentional** (low-and-slow DoS attacks designed to evade detection)
- Distinguished from a **blackout/outage**: service is still reachable but SLA thresholds for response time or throughput are violated
- **Slowloris** and **R.U.D.Y.** attacks are classic tools that induce brownout conditions by holding connections open and exhausting server thread pools
- From a **CIA triad** perspective, brownouts are an **Availability** attack — even partial degradation can have financial and reputational consequences
- **Monitoring with baselines** is the key defense: brownouts are only detectable if you know what "normal" performance looks like, making capacity baselines critical for CySA+ scenarios

## Related concepts
[[Denial of Service]] [[Availability]] [[Slowloris Attack]] [[Rate Limiting]] [[Baseline Configuration]]