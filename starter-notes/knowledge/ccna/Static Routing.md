# static routing

## What it is
Like hand-writing every single destination address into a GPS that will never update itself, static routing means an administrator manually configures fixed paths that tell routers exactly where to send traffic for specific networks. Unlike dynamic routing protocols that discover and adapt routes automatically, static routes are hardcoded entries in a routing table that persist until explicitly removed by an administrator.

## Why it matters
In a network segmentation defense strategy, administrators deliberately use static routes to enforce strict traffic control between sensitive VLANs — if a route doesn't exist, the traffic simply can't flow, limiting lateral movement after a breach. Conversely, attackers who gain access to a router can inject or modify static routes to redirect traffic through a malicious host, enabling a man-in-the-middle attack without touching dynamic routing protocols.

## Key facts
- Static routes have an **administrative distance of 1** (Cisco) — the most trusted route type, second only to directly connected interfaces (AD 0), meaning they override most dynamic routes
- Static routes create **no routing protocol overhead** — no broadcasts, no neighbor negotiations, making them harder to detect through protocol analysis but also fragile at scale
- A **default static route** (0.0.0.0/0) acts as a "catch-all" gateway of last resort; poisoning this on a compromised router redirects all unknown-destination traffic
- Static routing is **not scalable** for large networks but is preferred in small, high-security environments where predictability outweighs flexibility
- Security+ expects you to know that static routing **eliminates routing protocol attack surfaces** (no RIP poisoning, no OSPF spoofing) but introduces **human configuration error** as the primary risk

## Related concepts
[[network segmentation]] [[dynamic routing protocols]] [[man-in-the-middle attack]] [[administrative distance]] [[default gateway]]
