# RIPv2

## What it is
Like a mail carrier who asks neighbors "how far is the post office?" and trusts every answer without checking ID — RIPv2 is a distance-vector routing protocol that shares hop-count-based routing tables with neighboring routers every 30 seconds. It is an improvement over RIPv1, adding subnet mask support (CIDR), multicast updates (224.0.0.9), and optional MD5 authentication.

## Why it matters
An attacker on a network segment running unauthenticated RIPv2 can broadcast crafted RIP UPDATE packets claiming a shorter route to a target subnet, poisoning the routing table and redirecting traffic through an attacker-controlled router — a classic route injection / man-in-the-middle attack. This was demonstrated in legacy enterprise networks where RIPv2 was left running without MD5 authentication enabled, allowing full traffic interception with tools like Quagga or Scapy.

## Key facts
- **Maximum hop count is 15**; a hop count of 16 means "unreachable," limiting RIPv2 to small networks
- **Updates are sent every 30 seconds** via multicast to 224.0.0.9, making convergence slow compared to OSPF or EIGRP
- **MD5 authentication** is supported but must be explicitly configured — it is OFF by default, leaving many deployments vulnerable to route injection
- **Classless routing** (VLSM support) distinguishes RIPv2 from RIPv1, which broadcasts and assumes classful addressing
- RIPv2 is vulnerable to **routing table poisoning** and **black-hole attacks** if authentication is not enforced

## Related concepts
[[Route Poisoning]] [[OSPF Security]] [[Man-in-the-Middle Attack]] [[MD5 Authentication]] [[Network Routing Protocols]]