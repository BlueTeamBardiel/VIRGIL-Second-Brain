# Latency

## What it is
Like the pause between striking a match and seeing the flame, latency is the delay between a request being sent and a response being received. Technically, it is the time elapsed between a stimulus and its corresponding action across a network or system, measured in milliseconds. It reflects transmission delay, propagation delay, processing time, and queuing — all summed together.

## Why it matters
Timing-based side-channel attacks exploit latency differences to extract secrets. For example, in a timing attack against a login system, an attacker measures whether "wrong username" responses return slightly faster than "wrong password" responses — revealing which usernames are valid. Defenders use constant-time comparison algorithms and artificial response delays to eliminate these measurable differences.

## Key facts
- **Baseline latency matters**: Network monitoring tools (like SolarWinds or Zeek) establish normal latency baselines; sudden spikes can indicate DDoS attacks, network congestion, or covert tunneling activity.
- **Jitter** is the variation in latency over time — high jitter in VoIP or real-time systems can indicate network interference or active traffic manipulation.
- **Round-Trip Time (RTT)** is the total latency for a packet to travel to a destination and back; measured with `ping` and used in performance and threat analysis.
- **Covert channel detection**: Unusually low or suspiciously consistent latency in outbound traffic can indicate data exfiltration through timing channels.
- **Security tools**: IDS/IPS systems use latency thresholds as anomaly indicators; inserting artificial latency (rate limiting, tarpitting) is a defensive tactic against brute-force and scanning attacks.

## Related concepts
[[Side-Channel Attack]] [[Network Baseline]] [[DDoS]] [[Timing Attack]] [[Jitter]]