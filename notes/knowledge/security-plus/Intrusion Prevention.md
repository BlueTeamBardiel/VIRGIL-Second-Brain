# Intrusion Prevention

## What it is

In NBA 2K, when you see the AI defender read your pick-and-roll and step into the passing lane *before* you complete the pass — stealing the ball mid-flight rather than just contesting after the fact — that's intrusion prevention. The system doesn't just watch the play develop; it terminates the play in progress.

**Intrusion Prevention System (IPS)**: an inline security control that inspects network traffic in real time and actively blocks, drops, or resets connections matching malicious signatures, anomalous behavior, or policy violations.

## Why it matters

An [[IDS]] tells you the building is on fire; an IPS puts the fire out. Without active blocking, exploits like unpatched RCE vulnerabilities (think Log4Shell-class bugs) reach their targets before any human can respond. For SY0-701 Objective 3.2, you must distinguish **IDS vs. IPS** placement (passive/SPAN port vs. inline), recognize the four detection methodologies, and understand the failure modes. **CompTIA's favorite trap**: an IPS sits **inline** and can drop traffic; an IDS sits **out-of-band** and can only alert. If the question says "monitors a copy of traffic" — that's IDS. If it says "blocks" or "drops" — that's IPS.

## Key facts

### IPS placement and operation

- **Inline deployment**: traffic passes *through* the device — it can drop, reset, or modify packets.
- **Fail-open vs. fail-closed**: if the IPS dies, does traffic still flow ([[fail-open]]) or does the network halt ([[fail-closed]])? Pick your poison: availability vs. security.
- Often integrated into [[Next-Generation Firewall|NGFW]], [[UTM]] appliances, or cloud security stacks.

### Detection methodologies

| Method | How it works | Strength | Weakness |
|---|---|---|---|
| [[Signature-based detection]] | Matches traffic against known attack patterns | High accuracy on known threats | Blind to [[zero-day]] attacks |
| [[Anomaly-based detection]] | Compares against a learned baseline of "normal" | Can catch novel attacks | High [[false positive]] rate |
| [[Heuristic detection|Heuristic/behavioral]] | Rules-based scoring of suspicious behavior | Catches variants of known attacks | Tuning-heavy |
| [[Trend-based detection]] | Identifies deviations from historical patterns | Good for slow-burn attacks | Needs long baseline period |

### What an IPS actually does to bad traffic

- **Drop the packet** silently
- **Reset the TCP connection** (RST injection)
- **Block the source IP** for a configurable duration
- **Alert and log** to [[SIEM]] for correlation
- **Modify** the packet (rare — e.g., stripping malicious payloads)

### Tuning concerns

- **[[False positive]]**: legitimate traffic blocked → business outage, angry users.
- **[[False negative]]**: malicious traffic allowed → breach.
- **[[Tuning]]**: starts noisy, requires baseline period in monitor-mode before enforcement.
- **Encrypted traffic**: IPS is blind to TLS payloads without [[SSL/TLS inspection]] (decrypt-inspect-re-encrypt), which introduces its own attack surface and privacy issues.

### IDS vs. IPS — the exam distinction

| Feature | [[IDS]] | IPS |
|---|---|---|
| Placement | Out-of-band (SPAN/TAP) | Inline |
| Action | Detect & alert | Detect, alert, **block** |
| Latency impact | None | Adds processing latency |
| Failure risk | Misses attacks | Can block legitimate traffic |

### Host vs. network

- **[[NIPS]]** (Network IPS): protects network segments, sees broad traffic.
- **[[HIPS]]** (Host IPS): runs on the endpoint, sees decrypted traffic and process-level behavior. Often bundled into modern [[EDR]] platforms.

## Related concepts

[[IDS]] · [[NIDS]] · [[HIPS]] · [[NIPS]] · [[Next-Generation Firewall]] · [[SIEM]] · [[Signature-based detection]] · [[Anomaly-based detection]] · [[Zero-day]] · [[SSL/TLS inspection]] · [[EDR]] · [[Fail-open]] · [[False positive]]

---
*Source: VIRGIL knowledge base — 2026-05-08*