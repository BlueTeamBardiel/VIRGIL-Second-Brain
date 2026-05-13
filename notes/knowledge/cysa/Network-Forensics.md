# Network Forensics

## What it is

In **Doom (2016)**, every demon you kill drops a glory kill animation, but the real story is in the combat log — the rune you picked up in Foundry, the BFG ammo you spent on the Cyberdemon, the secret you missed in Argent Facility. The game tracks every shot fired, every door opened, every glory kill executed. If you wanted to reconstruct exactly how a speedrunner cleared Ultra-Nightmare, you wouldn't watch their face — you'd pull the demo file and scrub frame by frame through inputs, positions, and damage events.

That's exactly what network forensics does — reconstruct an attack by replaying what crossed the wire.

**Technical definition:** Network forensics is the capture, recording, and analysis of network traffic and metadata to investigate security incidents, attribute activity, and preserve evidence. It covers full-packet capture (PCAP), flow data (NetFlow/IPFIX/sFlow), session metadata, DNS/proxy/firewall logs, and any artifact that moved across the network during the incident window.

It is the IR muscle that answers the four questions leadership always asks: **What got in? What did it touch? What left? Do we have proof?**

## Why it matters

When endpoint logs are wiped, when the threat actor deletes the bash history, when ransomware encrypts the SIEM forwarder before it ships — the network still saw it. Routers, switches, firewalls, proxies, and span ports don't trust the endpoint to be honest. Network telemetry is the second witness, often the only one left standing after an attacker cleans up.

For CySA+, this lives squarely under **Objective 3.2 — incident response activities**: evidence acquisition, scope determination, chain of custody, data integrity, containment, and eradication. Almost every IR scenario question expects you to know what network artifacts you'd pull, in what order, and what you'd refuse to touch without a legal hold in place.

Career-wise: network forensics is the skill that gets an L2 analyst into the IR team. Anyone can read a Wireshark filter tutorial. The analyst who can pull the right PCAP, validate its hash, write up the timeline, and hand it to legal without breaking chain of custody — that's the one staffed on the next breach.

## Key facts

### Sources of network evidence

| Source | What it gives you | Retention reality |
|---|---|---|
| **Full PCAP** | Every byte, every payload, every handshake | Days to weeks — storage cost is brutal |
| **NetFlow / IPFIX / sFlow** | 5-tuple metadata (src, dst, sport, dport, proto) + bytes/packets | Months to a year — cheap |
| **DNS query logs** | Every domain resolved by every host | Weeks to months |
| **Proxy logs** | URLs, user-agents, HTTP method, response size | Months |
| **Firewall logs** | Allow/deny decisions, NAT translations | Weeks |
| **IDS/IPS alerts** | Signature hits, anomaly scores | Indefinite (low volume) |
| **TLS metadata (JA3/JA3S)** | Client+server fingerprints without decryption | Months |

*PCAP is the body camera. Flow data is the dashcam GPS log. You need both. Flow tells you the chase happened; PCAP tells you what was said inside the car.*

### Common tools

- **[[Wireshark]]** — GUI packet analysis, follows TCP streams, decodes hundreds of protocols. The forensic scalpel.
- **tcpdump** — CLI capture, the field tool. Lives on every Linux box. Use `-w` to write PCAP, never `-v` while writing.
- **tshark** — Wireshark's CLI brain. Scriptable, scales to large captures.
- **Zeek (formerly Bro)** — turns raw traffic into structured logs (conn.log, dns.log, http.log, ssl.log). What the SOC actually queries.
- **Suricata** — IDS/IPS that also produces Zeek-style flow logs and extracts files.
- **NetworkMiner** — parses PCAPs into reconstructed sessions, extracted files, credentials, images. Built for IR triage.
- **Arkime (Moloch)** — full-packet capture indexed and searchable. Enterprise scale.
- **RITA** — beaconing detection on Zeek logs. C2 hunting without signatures.

### The IR lifecycle, network-forensics view

**1. Detection and analysis.** An alert fires — IDS signature, beaconing heuristic, DLP, threat intel match on a destination IP. The analyst pulls Zeek conn.log for the host, looks at every external connection in a 4-hour window, identifies the suspicious session, then pivots to PCAP for that specific 5-tuple. You don't open a 40GB capture in Wireshark and start scrolling. You query, then carve.

**2. Containment.** Network containment is **isolation** — VLAN quarantine, ACL block at the perimeter, EDR network-isolate the host, sinkhole the C2 domain at the resolver. The trap: containment can also destroy evidence. If you reboot the box to re-image it, volatile memory is gone, and any in-memory implant goes with it. Capture first, contain second — unless the bleeding is active exfil, in which case you cut the wire and accept the forensic cost.

**3. Eradication and recovery.** Remove the implant, rotate credentials, patch the entry vector, **re-image** the host. Network forensics drives this — you can't eradicate what you haven't scoped. If PCAP shows the attacker also hit four other internal hosts via SMB, those four hosts go into the eradication queue too.

**4. Post-incident.** Lessons learned, IoC publication, detection tuning. The PCAP becomes a training case. The Suricata rule that should have fired but didn't gets written.

### Evidence acquisition and chain of custody

The rules of network evidence handling:

- **Capture to write-once or hash-verified storage.** SHA-256 the PCAP at capture, again on transfer, again on analyst workstation. Document every hash.
- **Chain of custody log.** Who captured, when, on which interface, who received the file, when, on what media. Every transfer logged. Gaps in the chain are how defense attorneys win cases.
- **Working copies only.** The original PCAP is sealed. Analysts work on copies. If the working copy gets corrupted during analysis, you re-clone from the original.
- **Time sync matters.** NTP drift across capture points will scramble your timeline. Note the time source for every device involved.
- **Legal hold.** If counsel or HR declares legal hold, retention policies are suspended for that scope. You do not delete, overwrite, or rotate logs covered by hold — even when the storage team screams about disk.

> **CompTIA exam trap:** Chain of custody is not just "who has the evidence now." It's **every transfer logged**, including the moment of acquisition. A PCAP with no documented capture interface, capture host, and capture time fails chain of custody — even if you have it sitting on a forensic workstation right now.

### Validating data integrity

Hash the capture immediately. Re-hash on every move. Hash mismatches mean the file changed — either corruption or tampering — and the evidence is suspect until reconciled. SHA-256 minimum; MD5 alone is no longer defensible.

For live captures, use a hardware tap or a properly configured SPAN port. A SPAN port under load drops packets silently and your "complete" capture will have holes you can't see.

### Scope and impact

**Scope** — how far did it spread? Network forensics answers this by pivoting on IoCs. The attacker C2 IP is the seed; pull every internal host that talked to it, then every host those hosts talked to inside the window. Lateral movement leaves SMB, RDP, WinRM, and PsExec traces in flow data.

**Impact** — what did it cost? Exfil volume from flow data (bytes outbound to the C2 over the window), data classification of touched systems, regulatory exposure. CFOs want a number. Network forensics gives you the upper-bound number: *"4.7 GB left the network to this destination between 02:14 and 03:46 UTC."*

### Indicators of compromise from the wire

- **Beaconing** — regular outbound connections to the same destination at fixed intervals with jitter. RITA, Zeek+statistical analysis.
- **DNS tunneling** — abnormally long TXT records, high query volume to a single domain, base64-looking subdomains.
- **Data exfil** — large outbound transfers to unusual destinations, especially to cloud storage or paste sites outside business hours.
- **Protocol mismatch** — HTTPS to a destination that's actually plaintext on inspection, or DNS over a non-53 port.
- **JA3 hash matches** — known malware TLS fingerprints, even when traffic is encrypted.

*Encryption doesn't blind you. It changes what you look at. Beaconing patterns, JA3, SNI, certificate metadata, packet sizes, and timing all survive TLS.*

### Compensating controls

When you can't eradicate immediately — legacy system that can't be patched, vendor refuses to fix the appliance, change board won't approve a Friday push — you compensate. Network-layer compensating controls:

- Tighten egress firewall rules (deny-by-default outbound on the affected segment)
- ACL the host away from sensitive subnets
- DNS sinkhole for the known C2 infrastructure
- Increased logging and alerting on the host's traffic
- Web proxy block list updates

Compensating controls are not remediation. They are duct tape with a documented expiration date.

### CompTIA exam traps

> **Exam trap:** Network containment versus host containment. CompTIA will offer "re-image the host" and "isolate at the switch port" as IR options. **Isolation comes first** — re-imaging destroys evidence. Capture, isolate, then eradicate.

> **Exam trap:** "Network forensics can attribute the attack to a specific actor." Wrong as stated. Network data supports **context and scope**, rarely definitive attribution. Source IPs can be VPNs, Tor, compromised proxies. Attribution requires correlation across telemetry, threat intel, and TTP analysis — not a single PCAP.

> **Exam trap:** Legal hold suspends retention but does **not** suspend the capture itself. You keep capturing, you keep logging, you stop deleting. Conflating "hold" with "freeze everything" is a wrong-answer favorite.

## SOC reality

- The 3am alert is rarely a clean PCAP — it's a Suricata hit with a destination IP, and your first job is to pull the last 24 hours of Zeek conn.log for every host that touched that IP and rank them by bytes-out. The PCAP gets pulled second, for the top-talker only.
- The CISO's first question is always **"is it contained?"** The honest answer at minute fifteen is *"the host is isolated, we're scoping for lateral movement, I'll have a number in 30 minutes."* Never say "we've contained it" until you've scoped the blast radius.
- Legal will ask about chain of custody before they ask about impact. Have the capture host, interface, hash, and acquisition timestamp ready before the call.
- Full PCAP storage cost is the silent killer — most orgs keep 3–7 days of full capture and 90+ days of flow. By the time a breach is detected at the industry average dwell time, the PCAP is gone. Flow data is what you'll actually have.
- The handoff from L2 to IR happens when you can name the C2 IP, the affected hosts, the rough exfil volume, and the entry vector hypothesis. Below that bar, it's still triage.

## Related concepts

[[Wireshark]] · [[PCAP]] · [[NetFlow]] · [[Zeek]] · [[Suricata]] · [[Chain of Custody]] · [[Legal Hold]] · [[Evidence Acquisition]] · [[Indicators of Compromise]] · [[Beaconing]] · [[Data Exfiltration]] · [[DNS Tunneling]] · [[Lateral Movement]] · [[Containment Eradication Recovery]] · [[Compensating Controls]] · [[Re-imaging]] · [[Forensics]] · [[SIEM]] · [[EDR]]

*Source: VIRGIL knowledge base — 2026-05-11*