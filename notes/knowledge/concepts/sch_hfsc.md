# sch_hfsc

## What it is
Like a hospital triage system that guarantees the trauma surgeon always gets an OR while also fairly distributing remaining rooms among routine cases — `sch_hfsc` (Hierarchical Fair Service Curve) is a Linux kernel traffic shaping scheduler that provides simultaneous bandwidth guarantees AND fair sharing across traffic classes using a mathematical service curve model. It operates at the qdisc (queueing discipline) layer of the Linux networking stack, allowing precise control over both latency and throughput for classified traffic flows.

## Why it matters
Attackers conducting bandwidth exhaustion DoS attacks rely on flooding a link so legitimate traffic starves. A properly configured `sch_hfsc` policy can guarantee minimum bandwidth to critical services (e.g., SSH management traffic or VPN tunnels) even during a flood, ensuring administrators retain access to remediate the attack. This makes it a defensive tool in network traffic engineering hardening on Linux-based firewalls and routers.

## Key facts
- `sch_hfsc` is loaded as a kernel module and configured via the `tc` (traffic control) command from the `iproute2` package
- It supports **two independent service curves**: a real-time curve (latency-sensitive guarantees) and a link-sharing curve (fair bandwidth distribution)
- Unlike `sch_htb` (HTB), HFSC can bound **delay**, not just throughput — critical for VoIP or interactive traffic protection
- Misconfigured HFSC rules can inadvertently deprioritize security monitoring traffic, creating blind spots during high-load incidents
- Kernel vulnerability CVE-2023-0590 was a use-after-free bug specifically in the `sch_hfsc` module, exploitable for local privilege escalation — patch status matters for CySA+ hardening checklists

## Related concepts
[[Traffic Shaping]] [[Quality of Service]] [[Linux Kernel Hardening]]