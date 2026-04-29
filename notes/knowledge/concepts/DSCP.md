# DSCP

## What it is
Like a postal service stamping packages "FRAGILE," "EXPRESS," or "BULK MAIL" to determine handling priority, DSCP (Differentiated Services Code Point) is a 6-bit field in the IP packet header that marks traffic so network devices can apply Quality of Service (QoS) policies. It operates at Layer 3 and replaces the older IP Precedence system, allowing routers and switches to prioritize VoIP over file downloads, for example, without inspecting packet contents.

## Why it matters
Attackers can manipulate DSCP markings to abuse QoS policies — for example, marking malicious bulk data exfiltration traffic with high-priority DSCP values (like EF/Expedited Forwarding) to ensure it moves through congested networks faster and avoids rate-limiting controls. Defenders must enforce DSCP re-marking at network ingress points so that untrusted endpoints cannot self-elevate their traffic priority, which is a form of policy enforcement critical in zero-trust network segmentation.

## Key facts
- DSCP uses **6 bits** of the Differentiated Services (DS) field in the IPv4/IPv6 header, allowing **64 possible values** (0–63)
- Common DSCP values: **EF (46)** = voice/real-time traffic; **AF** classes = assured forwarding for tiered business traffic; **CS0 (0)** = best-effort/default
- DSCP markings are **advisory, not enforced** — routers must be configured to trust or re-mark them; untrusted endpoints can set any value
- Network ingress policies should **strip or re-mark** DSCP values from external/untrusted sources to prevent QoS abuse
- DSCP operates within the **DiffServ architecture (RFC 2474)**, a scalable QoS model designed to replace IntServ for large networks

## Related concepts
[[Quality of Service (QoS)]] [[Traffic Shaping]] [[Network Segmentation]] [[Zero Trust Architecture]] [[IP Header Fields]]