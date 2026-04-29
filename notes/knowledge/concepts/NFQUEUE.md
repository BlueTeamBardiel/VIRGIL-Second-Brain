# NFQUEUE

## What it is
Think of NFQUEUE as a pneumatic tube system in a bank — instead of processing transactions at the teller, packets get shot into a waiting queue where a userspace application inspects and decides their fate. Precisely: NFQUEUE is a Linux netfilter target that diverts network packets from kernel space into a userspace application queue, allowing custom programs to verdict each packet (accept, drop, modify) before it continues through the network stack.

## Why it matters
Security tools like Suricata in inline IPS mode use NFQUEUE to intercept live traffic, inspect payloads against signature rules, and drop malicious packets in real time — all without writing kernel modules. Attackers who compromise a Linux system may also abuse NFQUEUE to build stealthy userspace packet interceptors that manipulate traffic transparently, since the hook operates below the application layer and can evade process-level monitoring.

## Key facts
- NFQUEUE is invoked as an iptables/nftables target: `iptables -A FORWARD -j NFQUEUE --queue-num 0`
- Each queued packet waits for a **verdict** from userspace; if the application crashes or doesn't respond, packets are dropped by default (fail-closed behavior)
- Up to **65,535 separate queues** (queue numbers 0–65534) can exist simultaneously, allowing parallel processing pipelines
- Userspace programs interact with NFQUEUE via the **libnetfilter_queue** library; Scapy also supports it for rapid prototype-level packet manipulation
- NFQUEUE introduces measurable **latency** — it's unsuitable for high-throughput environments without careful tuning (e.g., `--queue-bypass` flag allows packets through if no listener exists, switching to fail-open)

## Related concepts
[[Netfilter]] [[iptables]] [[Intrusion Prevention System]] [[Packet Filtering]] [[Suricata]]