# ICMP — Internet Control Message Protocol

## What it is

In **Pokemon**, every battle opens with the same ritual: the trainer throws the ball, the Pokemon appears, and the game flashes a tiny status line — "It's super effective!" or "The attack missed!" or "Pidgey used Tackle!" Those flashes aren't the battle. They're the *control messages* telling you what the battle is doing. You can't play without them, but they were never meant to carry the fight itself. Now imagine a glitched cartridge where someone hides Pokedex data inside those status flashes — packing payload into a channel built for one-line announcements. That's exactly what ICMP abuse looks like — a protocol designed for short network status messages, repurposed to carry data it was never meant to carry.

**ICMP** is the Internet Control Message Protocol — a Layer 3 helper protocol that lives alongside IP and exists to report network conditions. It doesn't carry user data. It carries metadata *about* the network: "host unreachable," "TTL exceeded," "fragmentation needed," "echo request" (ping), "echo reply" (pong). Routers and endpoints use it to tell each other when things are broken or when someone is checking liveness.

ICMP has no port number — it's its own IP protocol (protocol number 1 for ICMPv4, 58 for ICMPv6). It rides directly on top of IP, which is why firewall rules for ICMP look different from rules for TCP/UDP and why "block ICMP" is a separate checkbox in every firewall console you'll ever touch.

## Why it matters

ICMP is one of the most abused protocols on the wire and CompTIA knows it. **Objective 1.2** wants you to recognize indicators of malicious activity — and ICMP shows up as the signal in at least four of them: scans/sweeps, beaconing, data exfiltration, and unusual traffic spikes. It's the canonical example of a "trusted" protocol attackers ride because defenders are nervous about blocking it. Break ICMP entirely and PMTUD breaks, traceroute breaks, half your monitoring breaks. So most networks leave it half-open and that's where the attackers live.

The career relevance: every SOC analyst will look at ICMP traffic. Every one. Either because someone is sweeping your /24, or because a host is pinging an external IP every 60 seconds at exactly the same offset, or because a 1400-byte echo request just left the DMZ and no one can explain why. You need to know what normal looks like so you can name abnormal.

## Key facts

### ICMP message types worth knowing

| Type | Name | What it means | Attacker use |
|---|---|---|---|
| 0 | Echo Reply | "I'm alive" (pong) | Tunneling payload back |
| 3 | Destination Unreachable | "Can't get there" + code (host, port, network) | Recon — distinguishes filtered vs closed |
| 5 | Redirect | "Use a better gateway" | MITM redirection (legacy) |
| 8 | Echo Request | "Are you alive?" (ping) | Sweep / tunneling payload out |
| 11 | Time Exceeded | "TTL hit zero" | Traceroute — maps your network |
| 13/14 | Timestamp Request/Reply | Clock sync | Recon — fingerprints OS |

For ICMPv6 the type numbers shift (echo is 128/129) and types 133–137 carry Neighbor Discovery — the IPv6 equivalent of ARP. Same abuse patterns, different field.

### The four ICMP indicators CompTIA cares about

**1. Scans and sweeps.** Classic ping sweep: attacker sends ICMP echo requests to every host in a subnet to enumerate live targets. Your SIEM sees one source IP hit `.1` through `.254` inside 30 seconds. That's not a user. That's [[Nmap]] or a worm or an internal pivot. The Layer 3 cousins — TCP SYN scan, UDP scan — show up in different logs but the *behavior shape* is identical: one source, many destinations, short window.

**2. Beaconing.** Malware C2 channels can ride ICMP. Tools like **icmpsh**, **Loki**, and **PingTunnel** stuff command-and-control data inside the payload field of echo requests. Echo packets can carry up to ~1472 bytes of arbitrary data and almost no one inspects it. The beacon pattern: regular interval (60s, 300s, 3600s), same source-destination pair, similar packet size, low jitter. *A workstation that pings the same external IP every five minutes for eight hours is not troubleshooting — it's calling home.*

**3. Data exfiltration.** Same mechanism as beaconing, larger volume. Attacker compresses and chunks stolen data into the payload of repeated echo requests. From a [[NetFlow]] view you'll see sustained ICMP volume from an internal host to a single external IP — kilobytes or megabytes where you'd expect a couple hundred bytes of legitimate ping. **ICMP tunneling** is the term. Same family as [[DNS tunneling]] — abuse a protocol firewalls won't block.

**4. Unusual traffic spikes / bandwidth consumption.** Smurf attacks (ICMP echo to a broadcast address with a spoofed source — amplification DDoS), ping floods, and tunneling spikes all show up as ICMP volume anomalies on flow dashboards. Baseline first, then alert on deviation.

### What normal ICMP looks like

Before you can call something abnormal you need the baseline. Normal echo request payloads are tiny — Windows default is 32 bytes, Linux ping default is 56 bytes plus an 8-byte ICMP header. Normal echo traffic is bursty (a user troubleshoots, then stops) and short-lived. Normal Type 3 and Type 11 messages are scattered — routers reporting transient problems.

What's *not* normal: payloads of 1000+ bytes, sustained flows, identical inter-arrival timing, ICMP between two hosts that have no business talking, ICMP egress from a server that should never originate it (a database server pinging the internet is a finding).

### Detection on the wire

In Wireshark: filter `icmp` and look at the data field. Legitimate pings have repeating ASCII (`abcdefghij...` on Windows) or zero-padded payloads. Tunneled ICMP has high-entropy bytes — random-looking — because it's encrypted or compressed C2 data. Entropy analysis flags this even without decoding.

In Zeek/Suricata: track `icmp` connection logs for unusually long flows, high `orig_bytes` on echo traffic, and src/dst pairs that repeat too cleanly. Suricata rules can match payload length thresholds (`dsize:>800`) on ICMP type 8.

In [[SIEM]] correlation: alert on (a) one source, many destinations, ICMP-only, short window → sweep; (b) one source, one destination, ICMP, regular interval, >1 hour duration → beaconing/tunneling.

> **CompTIA exam trap:** ICMP has no port. If a question says "block ICMP on port 7" or "ICMP uses port 1," it's wrong. ICMP is IP protocol number 1 (v4) or 58 (v6) — *protocol number*, not port number. Ports are a Layer 4 (TCP/UDP) concept. CompTIA loves to mix this up in firewall-rule questions.

> **CompTIA exam trap:** Don't confuse ICMP with IGMP. **ICMP** = Internet Control Message Protocol (error/diagnostic). **IGMP** = Internet Group Management Protocol (multicast group membership). They look similar in acronym form and CompTIA will put both in the answer list. IGMP is protocol 2.

> **CompTIA exam trap:** "Block all ICMP" is rarely the right answer in scenario questions. The correct posture is **rate-limit ICMP** at the perimeter, allow Type 3 Code 4 (Fragmentation Needed) inbound for PMTUD, and **monitor** payload size and flow duration. Total blocks break legitimate network behavior and are an exam-recognized over-correction.

### Defenses

- **Rate limiting** at the perimeter firewall — caps sweep and flood volume without breaking diagnostics.
- **Egress filtering** — most internal hosts have no reason to send ICMP to the internet. Block ICMP outbound except from approved monitoring sources.
- **Payload inspection** — DPI on ICMP, or IDS rules on echo payload size and entropy.
- **Flow analysis** — NetFlow/IPFIX dashboards baselined per host. Beaconing patterns are obvious in flow metadata even when payloads are encrypted.
- **Disable IPv4 broadcast forwarding** on routers — kills Smurf amplification.

## SOC reality

- **The 3am alert.** "Sustained ICMP egress from HR-FILESHARE-03 to 185.x.x.x — 47 minutes, 12MB." That's not a network admin checking connectivity. That's exfil in progress. L1 acknowledges, pulls the [[PCAP]], confirms payload entropy is high, escalates to L2 inside ten minutes. Containment call goes out — host gets network-isolated via [[EDR]], not shut down (you want the memory image).
- **What the CISO asks first.** "What left the building?" Not "how did they get in." Not yet. Scope of exfil drives breach notification timelines and that drives legal's clock. Have the byte count and the destination IP ready before you get on the bridge.
- **What never to say.** "It's just ping traffic." That sentence has ended careers. Ping traffic with a 1400-byte payload running for six hours is not just ping traffic.
- **The L1 first action.** Check the source host's process tree in EDR. ICMP tunneling tools run as a process. If you see `ping.exe` running for an hour straight, or a non-standard binary opening raw sockets, you have the malicious process and the network indicator correlated — that's the IoC bundle the IR team wants.
- **The handoff.** L1 confirms anomaly → L2 validates with PCAP and correlates with host telemetry → IR team owns containment, eradication, and the post-incident report. Legal gets looped the moment data leaving the environment is confirmed.

*The lesson that costs people their weekend: defenders who treat ICMP as harmless give attackers a free covert channel through the perimeter. The protocol was built to be quiet and helpful. Attackers love quiet and helpful.*

## Related concepts

[[Network traffic analysis]] · [[Beaconing]] · [[Data exfiltration]] · [[DNS tunneling]] · [[NetFlow]] · [[Wireshark]] · [[Nmap]] · [[SIEM]] · [[EDR]] · [[PCAP]] · [[Egress filtering]] · [[Indicators of compromise]] · [[C2 traffic]] · [[Ping sweep]] · [[Smurf attack]] · [[IGMP]]

*Source: VIRGIL knowledge base — 2026-05-11*