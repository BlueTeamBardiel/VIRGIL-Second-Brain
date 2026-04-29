# VRRPv3

## What it is
Like a backup pilot automatically taking the controls when the captain goes unresponsive, VRRPv3 (Virtual Router Redundancy Protocol version 3) allows multiple physical routers to share a single virtual IP address, with one acting as master and others as standby. If the master fails, a standby router seamlessly assumes the virtual IP with no manual intervention. VRRPv3 extends the original VRRPv2 to support both IPv4 and IPv6.

## Why it matters
An attacker on a LAN segment can craft malicious VRRP advertisement packets with a higher priority value (255) to fraudulently claim the master router role — a process called VRRP hijacking. Once crowned master, the attacker intercepts all traffic destined for the default gateway, enabling a transparent man-in-the-middle attack against every host on that subnet. Defenders mitigate this by configuring VRRP authentication and restricting which devices can send VRRP multicast traffic via ACLs.

## Key facts
- VRRPv3 uses multicast address **FF02::12** (IPv6) and **224.0.0.18** (IPv4) on IP protocol number **112**
- The master router is elected based on **priority value (1–254)**; default is 100, and 255 is reserved for the IP address owner
- VRRPv3 advertisements are sent every **1 second** by default; if three consecutive advertisements are missed, failover triggers
- Unlike HSRP (Cisco proprietary), VRRPv3 is an **open standard (RFC 5798)**, making it vendor-neutral
- VRRPv3 supports **authentication via text or MD5** in some implementations, though RFC 5798 deprecated built-in authentication in favor of IPsec

## Related concepts
[[HSRP]] [[GLBP]] [[Man-in-the-Middle Attack]] [[Default Gateway Redundancy]] [[IPsec]]