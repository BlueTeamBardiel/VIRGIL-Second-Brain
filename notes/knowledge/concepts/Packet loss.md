# Packet loss

## What it is
Like letters dropped on the floor of a chaotic post office — some never reach their destination. Packet loss occurs when one or more data packets traveling across a network fail to reach their intended endpoint, requiring retransmission or resulting in degraded service. It's measured as a percentage of total packets sent versus received.

## Why it matters
Attackers deliberately induce packet loss through **packet drop attacks** on routers or switches — a compromised network device silently discards packets, causing intermittent connectivity failures that are hard to distinguish from hardware faults. This technique is used in insider threat scenarios to sabotage operations or force rerouting through attacker-controlled nodes. Defenders monitoring for abnormal packet loss spikes using tools like NetFlow can detect these anomalies before they escalate.

## Key facts
- Normal acceptable packet loss on a healthy network is **below 1%**; anything above 5% noticeably degrades VoIP and video conferencing
- **TCP handles packet loss** through retransmission via sequence numbers and acknowledgments; **UDP does not** — making UDP-based applications (VoIP, gaming) more sensitive to loss
- Packet loss can be weaponized in **Quality of Service (QoS) manipulation attacks** to degrade specific traffic types while leaving others functional
- Tools used to measure packet loss include **ping** (ICMP round-trip), **traceroute/tracert**, and **iperf3** for sustained throughput testing
- Sustained packet loss can be a **DDoS indicator** — volumetric attacks that overwhelm network buffers cause routers to drop packets as buffers fill (tail-drop or RED behavior)

## Related concepts
[[DDoS Attack]] [[Network Traffic Analysis]] [[TCP vs UDP]] [[NetFlow Monitoring]] [[Quality of Service (QoS)]]