# iptables

## What it is
Think of iptables like a bouncer at a nightclub who checks every person against three lists — who can enter (INPUT), who can leave (OUTPUT), and who gets redirected somewhere else (FORWARD). Precisely, iptables is a user-space utility for Linux that configures the kernel's Netfilter framework to inspect, filter, accept, drop, or manipulate network packets based on ordered rule chains.

## Why it matters
During a Linux server compromise, attackers often use iptables to silently block outbound traffic from security tools or open backdoor ports while keeping the system appearing functional. Defenders use it to implement host-based firewall rules — for example, whitelisting only port 443 inbound and dropping everything else — as a critical layer of defense-in-depth when a perimeter firewall fails or is misconfigured.

## Key facts
- Rules are evaluated **top-down** within a chain; the first match wins, so rule order is critical — a permissive rule placed before a restrictive one will override it
- Three default built-in chains: **INPUT** (traffic destined for the host), **OUTPUT** (traffic originating from the host), **FORWARD** (traffic routed through the host)
- Default policies (ACCEPT or DROP) apply when no rule matches; setting `DROP` as the default policy is the **fail-closed** security posture
- Rules are **not persistent by default** — they flush on reboot unless saved with `iptables-save` or managed by services like `iptables-persistent`
- **Tables** organize chains by purpose: `filter` (default, for firewalling), `nat` (address translation), `mangle` (packet modification) — Security+ often tests the distinction

## Related concepts
[[Netfilter]] [[Stateful Packet Inspection]] [[Network Access Control]] [[Host-Based Firewall]] [[UFW]]