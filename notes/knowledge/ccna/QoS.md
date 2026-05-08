# QoS

## What it is

In Tetris, when the board is filling up and a vertical I-piece — the long blue one — is finally about to drop, that piece doesn't politely wait behind the S-blocks and Z-blocks queued up. The game's "next piece" preview and hold mechanic let you reserve and prioritize the piece you actually need to clear four lines and survive. That's exactly what QoS (Quality of Service) does — it decides which packets get the I-piece treatment and which ones get shoved to the back of the queue when the network is about to top out.

Technically, QoS is a collection of technologies and policies that manage network traffic so that critical applications — voice calls, video conferencing, real-time control traffic — get guaranteed bandwidth, low latency, and reduced jitter. It works in three steps: **classify** the traffic (what shape is this piece?), **mark** it with a priority value (stamp it), and **queue** it according to predefined rules (which slot does it drop into?).

The marking happens inside the IP header itself. The modern standard, **DSCP (Differentiated Services Code Point)**, uses a 6-bit field inside the old ToS (Type of Service) byte of the IPv4 header. Those 6 bits give 64 possible markings, replacing the older, clunkier IP Precedence model that only had 8 levels. A common DSCP value you'll see is **Expedited Forwarding (EF)** — the marking reserved for stuff like VoIP that absolutely cannot tolerate delay. It's the I-piece of the network: when it shows up, everything else moves out of the way.

## Why it matters

QoS is one of those features that sounds purely operational until you realize attackers love it precisely because nobody watches it.

The Watch Dogs angle: Aiden Pearce doesn't break the firewall — he piggybacks on traffic the system already trusts. QoS marking manipulation works the same way. An attacker re-marks their malicious traffic with a high-priority DSCP value (say, EF), and suddenly their C2 beacons or exfiltration flow get the express lane through every queue on the path. The traffic isn't necessarily *hidden*, but it's *prioritized* — and prioritized traffic often skips deep inspection because operators tuned their security tooling to focus on the slow, suspicious-looking lanes.

The inverse attack is **traffic shaping abuse**: an attacker (or insider) deprioritizes the telemetry from your security stack — SIEM forwarders, EDR check-ins, NetFlow exports. The logs still technically flow, but during congestion they get dropped or delayed enough to break detection windows. Your dashboard looks healthy because you're seeing yesterday's truth.

There's also a subtler problem: **side channels**. Different priority queues drain at different rates, and that timing difference is observable. An attacker on the same network can measure latency patterns to infer when a high-priority application (a VoIP call, a trading flow, a video stream) is active — leaking behavioral information without ever reading a packet's contents. Same principle as counting footsteps outside a door in a stealth game; you don't need to see the guard to know he's there.

## Key facts

### QoS Mechanics
- **Three-step pipeline**: classify → mark → queue. Like a bouncer checking IDs, stamping wrists, then routing people to different rooms.
- **DSCP field**: 6 bits, lives in the ToS byte of the IPv4 header. 64 possible values.
- **DSCP replaced IP Precedence**: the old model used only 3 bits (8 priority levels). DSCP is backward-compatible but far more granular.
- **Expedited Forwarding (EF)**: the "VIP table" DSCP value, typically used for latency-sensitive traffic like VoIP. DSCP 46 in decimal.
- **Queues drain at different rates**: a high-priority queue is served before lower ones during congestion, which is exactly why prioritization matters and exactly why it's abusable.

### Security Concerns
- **QoS marking manipulation**: attacker re-marks their own malicious packets with a high-priority DSCP value to get preferential routing and sometimes skip inspection paths.
- **Trust boundaries**: DSCP markings should only be trusted at defined network edges. Treat user-side endpoints like a Counter-Strike pub server — assume everyone is lying about their rank until you've verified it.
- **Don't let untrusted endpoints self-mark**: edge switches should rewrite or zero-out DSCP values coming from user ports. If your laptop says its torrent traffic is EF, the switch should laugh and remark it to best-effort.
- **Traffic shaping attacks**: deprioritizing security telemetry (SIEM, EDR, NetFlow) so logs arrive late or get dropped during congestion — creating detection blind spots without disabling anything outright.
- **Side-channel leakage**: queue timing differences let an observer infer application activity (call started, stream began, batch job kicked off) just from latency fingerprints.
- **Misconfiguration risk**: a QoS policy that exempts "high-priority" traffic from inspection or logging is a hole the size of an EF marking. Always pair QoS policies with monitoring that doesn't care about priority.

## Related concepts

[[DSCP]]
[[ToS field]]
[[IP Precedence]]
[[Expedited Forwarding]]
[[Trust Boundary]]
[[Network Side-Channel Attacks]]
[[Traffic Shaping]]
[[NetFlow]]
[[SIEM telemetry integrity]]
[[VoIP security]]