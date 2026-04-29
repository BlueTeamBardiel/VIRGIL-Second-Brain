# CoS

## What it is
Like a nightclub bouncer who waves VIPs past the velvet rope while making everyone else wait, Class of Service (CoS) is a Layer 2 QoS mechanism that marks network traffic with priority levels so switches can give preferential treatment to certain packets. It uses a 3-bit field in the 802.1Q VLAN tag (called the Priority Code Point, or PCP) to assign one of eight priority levels (0–7) to Ethernet frames.

## Why it matters
Attackers can manipulate CoS markings to launch a denial-of-service attack against voice or video traffic — by flooding the network with low-priority packets marked as priority 7, they can exhaust high-priority queues and degrade VoIP calls even when bandwidth is nominally available. Defenders counter this by configuring trust boundaries at network edges so that only authorized devices (like IP phones) can set high CoS values, stripping or re-marking untrusted markings at ingress.

## Key facts
- CoS operates at **Layer 2** using the **3-bit PCP field** in the IEEE 802.1Q tag, supporting values **0–7** (7 = highest priority)
- It differs from **DSCP (Layer 3)**, which marks IP packet headers — CoS markings are lost when a frame is routed between subnets
- CoS value **5** is conventionally used for **voice (VoIP)** traffic; **6–7** are reserved for network control protocols
- A **trust boundary** defines where the network stops honoring a device's self-assigned CoS markings — typically set at the access switch port
- CoS abuse can be used to **privilege escalate network traffic**, bypassing bandwidth limits and starving legitimate flows

## Related concepts
[[Quality of Service (QoS)]] [[DSCP]] [[802.1Q VLAN Tagging]] [[Denial of Service]] [[Network Traffic Analysis]]