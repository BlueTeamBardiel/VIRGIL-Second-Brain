# conntrack

## What it is
Like a maitre d' who remembers every table's order and throws out anyone who shows up claiming to be part of a meal they never started — conntrack (connection tracking) is the Linux kernel subsystem that records the state of every network connection flowing through a system. It enables stateful packet inspection by maintaining a table of active connections, so firewalls can distinguish legitimate return traffic from unsolicited packets.

## Why it matters
During a SYN flood attack, an attacker sends thousands of half-open TCP connections, exhausting the conntrack table (default ~65,536 entries on many systems). Once the table is full, the kernel drops all new connections — legitimate users get denied service even if bandwidth is available. Defenders monitor `/proc/net/nf_conntrack` and tune `nf_conntrack_max` to detect and mitigate this exact condition.

## Key facts
- Conntrack tracks four connection states relevant to iptables rules: **NEW**, **ESTABLISHED**, **RELATED**, and **INVALID**
- The conntrack table lives in kernel memory; exhausting it causes a denial-of-service without any bandwidth saturation
- `RELATED` state enables passive FTP to work — it recognizes data connections spawned from an already-tracked control session
- Conntrack is the engine behind `iptables -m state` and `nftables` stateful rules; without it, firewalls can only do stateless packet filtering
- Attackers can exploit conntrack by deliberately fragmenting packets or using INVALID-state packets to bypass poorly-written firewall rules

## Related concepts
[[stateful firewall]] [[iptables]] [[SYN flood]] [[nftables]] [[denial of service]]