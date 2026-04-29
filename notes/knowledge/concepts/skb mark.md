# skb mark

## What it is
Think of it like a sticky Post-it note slapped on a package moving through a sorting facility — workers downstream can read it to decide how to route or handle the package without opening it. An `skb mark` (socket buffer mark) is a 32-bit metadata field embedded in every Linux kernel network packet (the `sk_buff` struct) that can be read and written by kernel subsystems like Netfilter, traffic control (tc), and routing rules to influence how that packet is processed — all without modifying the actual packet payload.

## Why it matters
Defenders use `skb mark` in policy-based routing to route VPN traffic differently from regular traffic — for example, marking packets originating from a specific UID with `SO_MARK` so `ip rule` can force them through a separate routing table and prevent VPN leaks. Attackers who gain local privilege escalation may manipulate socket marks to bypass firewall rules implemented with `iptables -m mark --mark`, selectively exempting their traffic from filtering or logging.

## Key facts
- The mark is stored in the `sk_buff.mark` field and is **zero by default**; it persists through the kernel networking stack but is **stripped before the packet hits the wire**
- Set via `iptables`/`nftables` (`MARK`/`CONNMARK` targets), the `SO_MARK` socket option (requires `CAP_NET_ADMIN`), or BPF programs
- `CONNMARK` allows the mark to be saved/restored across individual packets in the same connection, enabling stateful policy decisions
- Used in Android's per-UID network isolation to enforce which app traffic goes through which interface
- Misuse of `CAP_NET_ADMIN` to set `SO_MARK` is a known privilege abuse vector in container escapes and sandboxed environments

## Related concepts
[[Netfilter]] [[iptables]] [[Linux Capabilities]] [[Policy-Based Routing]] [[eBPF]]