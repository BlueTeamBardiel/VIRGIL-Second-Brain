# nfq

## What it is
Think of it like a bouncer at a club who pauses each person at the door and radios to a back-office manager for a final yes/no decision — that's exactly what NFQUEUE (nfq) does for network packets. It is a Linux netfilter target that queues packets from kernel space to a userspace application, allowing custom programs to inspect and render verdicts (ACCEPT, DROP, MODIFY) on live network traffic before forwarding continues.

## Why it matters
Security tools like Suricata (in IPS mode) and custom honeypot controllers use nfq to intercept packets in real time and make inline blocking decisions. An attacker who gains local privilege escalation can potentially inject crafted verdicts or starve the queue (queue overflow causes packets to be dropped or auto-accepted depending on policy), turning a defensive mechanism into a denial-of-service vector or a bypass.

## Key facts
- **Queue overflow behavior is policy-defined**: if the userspace application can't keep up, packets are either dropped (`--queue-bypass` off) or auto-accepted (`--queue-bypass` on) — a critical misconfiguration risk
- **Verdict types**: ACCEPT, DROP, REPEAT (re-enter netfilter), STOP, and MODIFY (alter packet content before forwarding)
- **Multiple queues**: traffic can be load-balanced across queue IDs (e.g., `--queue-balance 0:3`) for multi-threaded IPS performance
- **Binding**: userspace binds to a queue via `libnetfilter_queue`; only root or `CAP_NET_ADMIN` capability allows this — privilege escalation here means full traffic interception
- **Used by Suricata, Snort (DAQ module), and custom firewall scripts** as the primary inline IPS integration point on Linux systems

## Related concepts
[[netfilter]] [[iptables]] [[Suricata]] [[intrusion prevention system]] [[Linux capabilities]]