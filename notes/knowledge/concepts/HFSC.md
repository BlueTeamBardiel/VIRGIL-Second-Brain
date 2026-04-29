# HFSC

## What it is
Like a traffic cop who can simultaneously manage rush-hour lanes by both the *number* of cars and their *urgency*, HFSC (Hierarchical Fair Service Curve) is a Linux kernel queuing discipline (qdisc) that controls network bandwidth using a mathematical curve to guarantee both throughput and latency for different traffic classes simultaneously. Unlike simpler schedulers, it decouples bandwidth allocation from delay guarantees through a dual-curve model.

## Why it matters
In a network under a bandwidth exhaustion DoS attack, an unprotected system treats all packets equally — attacker traffic starves legitimate VoIP or critical management traffic. Deploying HFSC via Linux `tc` (traffic control) allows defenders to hard-guarantee minimum bandwidth and maximum latency for priority traffic classes, ensuring SSH management sessions survive even during a flood, making it a practical network resilience control.

## Key facts
- HFSC uses **two service curves**: a real-time curve (RT) for latency-sensitive guarantees and a link-sharing curve (LS) for fair bandwidth distribution among classes
- Configured using Linux `tc` with `qdisc` and `class` commands; part of the `iproute2` toolset
- Unlike HTB (Hierarchical Token Bucket), HFSC can guarantee **both delay AND throughput** simultaneously — HTB can only guarantee throughput
- Traffic classes are arranged in a **hierarchy (tree structure)**, with child classes borrowing unused bandwidth from parents
- Relevant to **network segmentation and QoS hardening** — a defense-in-depth control that limits blast radius of bandwidth-based attacks on critical services

## Related concepts
[[Quality of Service (QoS)]] [[Traffic Shaping]] [[Denial of Service (DoS)]] [[Network Segmentation]] [[Linux iptables]]