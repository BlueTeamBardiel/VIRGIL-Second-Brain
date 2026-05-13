# NTP — Network Time Protocol

## What it is

In **Doom**, the demo lump (`.lmp`) records your playthrough as a tick-by-tick stream of inputs — 35 tics per second, every shotgun blast and every imp scream timestamped against the same engine clock. Replay it on another machine and it desyncs the moment the tic counters disagree. A demo from the original `DOOM.EXE` won't play on a build with a different tic rate; the cyberdemon dodges a rocket that hit him in your recording because the two engines stopped agreeing on *when*. That's NTP's problem in a network. Every host has its own clock. If they drift apart, the demo of your incident — your logs — desyncs and you can't reconstruct what happened.

**Plain English:** NTP keeps every server, switch, firewall, and laptop on the same wall clock so that when you stitch their logs together, the events line up.

**Technical:** Network Time Protocol (RFC 5905, current is NTPv4) is a UDP-based protocol on **port 123** that synchronizes system clocks across packet-switched networks. It uses a hierarchical **stratum** model — stratum 0 is the reference (atomic clock, GPS); stratum 1 is the server directly attached to a stratum-0 source; stratum 2 syncs from stratum 1, and so on down to stratum 15. Stratum 16 means unsynchronized. NTP accounts for round-trip delay and clock offset using a four-timestamp exchange (T1 originate, T2 receive, T3 transmit, T4 destination) and disciplines the local clock toward the calculated offset — typically holding LAN hosts within a few milliseconds of each other.

## Why it matters

Without synchronized time, a SOC is blind to sequence. You have a firewall log saying a packet hit at 02:14:07, an EDR log saying a process spawned at 02:13:51, and a domain controller log saying a Kerberos ticket issued at 02:14:23 — but if those three boxes are drifting against each other by tens of seconds, you cannot tell whether the process spawned *because* of the inbound packet or before it. Correlation collapses. [[SIEM]] timeline reconstruction collapses. [[Chain of custody]] for forensic evidence weakens — defense counsel loves a clock that wasn't disciplined.

It also breaks security mechanisms that *depend* on time. **Kerberos** rejects authentication if the client and KDC drift more than 5 minutes apart by default — your users get locked out across the whole AD forest. **TLS/SSL certificate validation** fails if the host clock is wildly off — `NotBefore`/`NotAfter` checks reject valid certs or accept expired ones. **MFA TOTP codes** (the rolling 30-second one from your authenticator) desync. Log retention windows, scheduled tasks, audit policies, [[GDPR]] 72-hour breach notification timers — all of it assumes the clock is true.

Exam-relevant: **CS0-003 Objective 1.1** lists *time synchronization* as a system and network architecture concept. CompTIA expects you to know NTP's role in log ingestion, forensic correlation, and security-control plumbing.

## Key facts

### Stratum hierarchy

| Stratum | Role | Example |
|---|---|---|
| 0 | Reference clock | GPS receiver, atomic clock, radio (WWVB), PTP grandmaster |
| 1 | Directly attached to stratum 0 | Hardened NTP appliance, time.nist.gov |
| 2 | Syncs from stratum 1 | Enterprise internal NTP server |
| 3–15 | Each syncs from the layer above | Branch office relays, endpoint clients |
| 16 | Unsynchronized (invalid) | Box that lost its upstream |

Lower stratum = closer to truth, not "better" by definition. Stratum 15 is still valid; stratum 16 is not.

### The four-timestamp exchange

Client sends a request stamped with **T1** (client send). Server receives it at **T2**, processes, sends reply at **T3**. Client receives reply at **T4**.

- **Offset** (how wrong the client is): `((T2 - T1) + (T3 - T4)) / 2`
- **Delay** (round-trip time): `(T4 - T1) - (T3 - T2)`

NTP uses both to discipline the local clock smoothly — it doesn't just slam the time, it *slews* (gradually adjusts the rate) for small offsets and *steps* (jumps) only for large ones. Slewing avoids breaking log timestamps and database transactions mid-flight.

### NTP variants you should know

- **NTPv4** — the current standard. UDP/123. Symmetric key + Autokey (deprecated) + **NTS** (Network Time Security, RFC 8915) for authenticated time.
- **SNTP** (Simple NTP) — stripped-down NTP, same wire format, no clock discipline algorithms. Fine for endpoints, bad for servers.
- **PTP** (Precision Time Protocol, IEEE 1588) — microsecond/nanosecond accuracy for finance, telecom, ICS. Different protocol, different ports, requires hardware timestamping in switches.
- **Windows Time Service (W32Time)** — Microsoft's SNTP-ish implementation. Domain controllers form a hierarchy where the PDC emulator of the forest root is the authoritative source; clients sync from their domain controller. Adequate for Kerberos, not adequate for forensic-grade correlation by itself.

### Enterprise NTP architecture (the way you actually deploy it)

The pattern that survives audits:

1. **Two or more stratum-1 appliances** on-prem with GPS antennas, physically segmented in a [[network segmentation]]ed time-services VLAN.
2. **Internal stratum-2 servers** sync from the appliances, serve the rest of the enterprise.
3. **All endpoints, servers, network devices** point at the internal stratum-2 pool — never the public internet directly.
4. **Egress firewall blocks outbound UDP/123** except from the stratum-1 appliances (and only if they need external peers as backup).
5. **Logging** of NTP sync status into the [[SIEM]] — alert on stratum 16, large offset corrections, or unauthorized NTP peers.

Cloud workloads ([[IaaS]], [[Containerization|containers]], [[Serverless|serverless]]) use the cloud provider's NTP service (e.g., 169.254.169.123 in AWS, metadata-served time in Azure). In [[Hybrid]] architectures, this creates two time domains — make sure they're both ultimately disciplined from the same stratum-0 family or your correlation across on-prem and cloud breaks.

### NTP and security controls

| Control | What breaks without NTP |
|---|---|
| Kerberos / Active Directory | Auth fails at >5 min skew; users locked out forest-wide |
| TLS / [[PKI]] cert validation | NotBefore/NotAfter checks misfire; expired certs accepted |
| MFA TOTP | 30-second window desyncs; valid codes rejected |
| [[SIEM]] log correlation | Events from different sources can't be ordered |
| Forensic timelines | [[Chain of custody]] weakened; defense impeaches your timeline |
| Scheduled hardening tasks | Patch windows, backup jobs, cert renewals miss their slot |
| Audit logs ([[PCI DSS]], SOX, [[HIPAA]]) | Non-compliant — PCI DSS Req 10.4 specifically mandates time sync |

### NTP attacks (and CompTIA wants you to recognize them)

- **NTP amplification DDoS** — attacker sends a small `monlist` query to a misconfigured NTP server with a spoofed source IP; server replies with up to 600 addresses (~206x amplification). Mitigation: disable `monlist`, restrict queries, rate-limit. This was the 2014 wave that took down major providers.
- **Time-shifting attack** — adversary on-path manipulates NTP responses to roll a host's clock backward, causing expired certs/credentials to validate again or audit logs to be obscured.
- **Rogue NTP server** — attacker stands up a peer on the network and convinces hosts to sync from it. With clocks rolled forward, Kerberos tickets, session tokens, and cached credentials can be forced to expire on demand — useful pre-pivot.
- **Mitigation:** **NTS** (Network Time Security) — RFC 8915, gives NTP TLS-grade authentication. Use NTS on internet-facing time sync. Internally, restrict UDP/123 to known servers, monitor stratum changes.

### CompTIA exam traps

> **CompTIA exam trap:** NTP uses **UDP/123**. Not TCP. CompTIA loves to slip a TCP variant into the multiple choice. UDP because time-sync needs low overhead and can tolerate occasional loss — TCP's retransmission would *add* latency uncertainty, which is the opposite of what you want.

> **CompTIA exam trap:** **Lower stratum number = closer to authoritative source**, not "better quality." Stratum 1 is not "higher" than stratum 3 — it's *closer* to stratum 0. The exam phrases this to trip up readers who assume bigger numbers are better.

> **CompTIA exam trap:** Time synchronization is listed under *system and network architecture* (Objective 1.1), not under logging or IR. If a question asks where time sync belongs architecturally, the answer is infrastructure/architecture — even though its *consequences* are felt in log ingestion and incident timelines.

> **CompTIA exam trap:** Kerberos default clock skew tolerance is **5 minutes**. Memorize it. CompTIA asks "why did all your domain users get locked out after the NTP server failed?" and the answer is the 5-minute skew limit.

## SOC reality

- The alert that fires at 3am is almost never "NTP failed" directly — it's **"Kerberos authentication failures spike on DC-03"** or **"certificate validation errors across the load balancer fleet."** You trace it back to a domain controller whose W32Time service died eight hours ago and drifted past skew. The L1 analyst who recognizes the time-sync root cause saves the incident bridge an hour of chasing a fake auth-attack ghost.
- During [[Incident response]], the **first thing the IR lead asks** when log timelines look weird: *"Are all these hosts NTP-synced to the same source? Show me the sync status."* If three boxes are pulling from three different stratum-2s and one of them is offset by 12 seconds, your timeline is fiction and you need to declare that openly in the report.
- Never promise leadership *"we have a complete forensic timeline"* until you've confirmed every relevant host was disciplined to the same time source during the incident window. *I learned this the hard way: defense counsel pulled apart a timeline because two endpoints were on different upstream NTP peers with a 3-second offset, and the prosecution had no answer.*
- Escalation path: NTP issues usually surface to L1 → infrastructure/sysadmin team for the actual fix → SOC stays in the loop because **clock manipulation is a known pre-attack tactic** (T1070.006 in MITRE ATT&CK — Indicator Removal: Timestomp is adjacent; T1565.001 Stored Data Manipulation can ride on time skew). A sudden unauthorized NTP peer appearing on the network is an [[IoC]], not a config drift.
- Hunt for it: query the [[SIEM]] for hosts whose stratum changed unexpectedly, hosts that started syncing from non-approved peers, or large `offset` corrections in W32Time event logs (Event ID 35, 37, 50). These are quiet signals that something — misconfig or adversary — touched your time plane.

## Related concepts

[[SIEM]] · [[Log ingestion]] · [[Chain of custody]] · [[Kerberos]] · [[PKI]] · [[TLS]] · [[MFA]] · [[Network segmentation]] · [[System hardening]] · [[Zero trust]] · [[Hybrid]] cloud · [[PCI DSS]] · [[IoC]] · [[Incident response]] · [[MITRE ATT&CK]]

*Source: VIRGIL knowledge base — 2026-05-11*