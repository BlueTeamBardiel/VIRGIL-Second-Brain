# Time Protocols

## What it is

In **Far Cry 3**, you and your buddies are scattered across Rook Island trying to coordinate a raid on an outpost. If your watch says it's noon and your buddy's says it's 3am, you'll never converge on the rendezvous. Worse — the radio tower you just liberated logs every event with a timestamp, and if those timestamps disagree with the outpost's logs, you can't reconstruct what happened or when. The whole campaign is a chain of synchronized events. Lose sync, lose the plot.

That's exactly what **time protocols** do — keep every device on a network agreeing on what time it is, down to the millisecond, so that logs, certificates, authentication tickets, and scheduled jobs all line up.

**Technical definition:** **Network Time Protocol (NTP)** is a UDP-based protocol on **port 123** that synchronizes clocks across networked devices to a common reference, typically traceable back to atomic clocks or GPS. NTP organizes time sources into a hierarchy of **strata** (stratum 0 = the reference clock itself, stratum 1 = directly attached, stratum 2 = one hop away, and so on down to stratum 15; stratum 16 means unsynchronized). The protocol corrects for network latency by measuring round-trip time and adjusting the offset, achieving accuracy within milliseconds over the public internet and microseconds on a LAN.

NTP's modern cousin is **Precision Time Protocol (PTP)**, defined in IEEE 1588, which uses hardware timestamps to reach sub-microsecond accuracy. PTP is what financial trading firms and broadcast studios use when "close enough" isn't close enough. Net+ mostly cares about NTP, but know that PTP exists and outclasses it.

## Why it matters

Time sync is the silent foundation of everything else in IT. **[[Kerberos]] authentication** breaks if client and domain controller clocks drift more than 5 minutes apart — users get cryptic "clock skew too great" errors and can't log in. **TLS certificates** look expired or not-yet-valid if the clock is wrong, and browsers throw scary warnings. **[[Syslog]]** entries from different devices become impossible to correlate during an incident if every server reports a different time. **MFA tokens** (TOTP) literally derive their 6-digit codes from the current time — drift past 30 seconds and the codes won't validate.

In the real world: a domain controller's CMOS battery dies, the clock resets to 2003, the entire Active Directory forest starts rejecting logins on Monday morning, and you spend two hours figuring out why "nothing works" when it's just one bad clock poisoning every Kerberos ticket downstream.

Exam relevance: **N10-009 Objective 1.4** lists NTP on **port 123** as one of the protocols you must memorize. CompTIA will absolutely ask you the port number, the transport (UDP, not TCP), and what it does. Time sync also shows up indirectly in 4.0 (security) and 5.0 (troubleshooting) — Kerberos failures and certificate errors are time-protocol problems wearing a disguise.

## Key facts

### NTP — the workhorse

| Property | Value |
|---|---|
| **Port** | 123 |
| **Transport** | UDP |
| **Accuracy** | Milliseconds over WAN, sub-millisecond on LAN |
| **Hierarchy** | Stratum 0 → 15 (16 = unsynced) |
| **Reference** | Atomic clock, GPS, radio (WWVB, DCF77) |
| **Public servers** | `pool.ntp.org`, `time.google.com`, `time.windows.com` |

NTP works by exchanging timestamps. Client sends a packet with its current time. Server stamps when it received and when it replied. Client stamps when the reply arrived. With four timestamps, the client calculates network delay and clock offset and adjusts its own clock — usually by **slewing** (gradually speeding up or slowing down) rather than **stepping** (jumping instantly), because applications hate when time jumps backward.

### Stratum levels

- **Stratum 0:** The reference itself — atomic clock, GPS receiver. Not networked. The source of truth.
- **Stratum 1:** Server directly attached to a stratum 0 device. The top of the network hierarchy.
- **Stratum 2–15:** Each layer is one NTP hop further from the reference. More hops = more potential drift.
- **Stratum 16:** Unsynchronized. The clock is on its own and doesn't trust itself.

In practice: your internal NTP server (often a domain controller in a Windows shop) is stratum 2 or 3, pulling from public stratum 1 servers, and every workstation and server in the org syncs from it. *Don't have every device on your network hammering pool.ntp.org directly. Run one or two internal NTP servers and point everything else at them.*

### SNTP — Simple NTP

**SNTP** is a stripped-down NTP that skips the statistical filtering and clock discipline algorithms. Same port (123), same packet format, dumber client. Embedded devices and printers often use SNTP because they don't need millisecond precision and can't spare the CPU. Functionally interchangeable from the server's perspective — if it speaks NTP, it'll answer SNTP.

### PTP — Precision Time Protocol (IEEE 1588)

PTP achieves nanosecond-to-microsecond accuracy by:
- Hardware-stamping packets at the NIC level (not in software, where OS jitter destroys precision)
- Using a master-slave hierarchy with a **Best Master Clock Algorithm (BMCA)** to elect the grandmaster
- Requiring PTP-aware switches (boundary clocks, transparent clocks) to maintain accuracy across hops

PTP is overkill for general IT. It matters in:
- High-frequency trading (microseconds = millions of dollars)
- Broadcast audio/video (lip sync, frame sync)
- Industrial automation, [[SCADA]], 5G fronthaul
- Scientific instrumentation

### Windows Time service (W32Time)

Windows uses **W32Time**, which speaks NTP but historically with relaxed accuracy (within seconds, not milliseconds — Microsoft only guaranteed Kerberos-grade sync until Server 2016). In an AD domain, the **PDC Emulator** FSMO role-holder in the forest root is the authoritative time source for the entire forest. Everything else syncs up the domain hierarchy to that one server. Point your PDC Emulator at a reliable external NTP source and the rest of the forest follows.

### Common time sync chain in a real network

```
GPS satellite (Stratum 0)
        ↓
time.nist.gov (Stratum 1, public)
        ↓
PDC Emulator / internal NTP server (Stratum 2)
        ↓
Domain controllers, app servers (Stratum 3)
        ↓
Workstations, switches, firewalls (Stratum 4)
```

### CompTIA exam traps

> **CompTIA exam trap:** NTP runs on **UDP port 123**, not TCP. CompTIA loves baiting you with TCP/123 as a distractor. NTP is connectionless — fire-and-forget timestamp exchanges. If a packet drops, the client just sends another. TCP's overhead would defeat the precision NTP is trying to achieve.

> **CompTIA exam trap:** Stratum **0 is the reference clock itself, not a server**. The lowest-numbered *server* is stratum 1. Easy to flip if you're rushed. Stratum **16 means unsynchronized** — not "the worst working stratum."

> **CompTIA exam trap:** Kerberos clock skew tolerance is **5 minutes by default**. CompTIA may ask why a user can suddenly not log in to the domain after a power outage — answer is almost always clock drift on the workstation or DC, not the password, not the cable, not the DNS.

### NTP security — yes, it's a thing

NTP was designed in 1985 when the internet was friendly. It has historically been:

- **Amplification-attacked:** Attackers spoof source IPs and send `monlist` queries to NTP servers, which reply with massive packets to the victim. Mitigation: disable `monlist`, use modern NTP (4.2.7+), or switch to chrony.
- **Manipulated:** Bad actors injecting fake time to expire valid certificates or de-expire revoked ones. Mitigation: **NTS (Network Time Security)**, RFC 8915, which adds authenticated time over TLS.
- **Spoofed:** No authentication by default. Modern deployments use **symmetric key authentication** or **NTS**.

Net+ doesn't test deeply on NTS, but know it exists and that NTP without authentication is a trust-the-network protocol.

### Troubleshooting time sync

Following the **CompTIA 7-step methodology** for a Kerberos-skew ticket:

1. **Identify the problem.** User can't log in. Error: "The clock on the client and server machines are skewed."
2. **Theory of probable cause.** Clock drift on either the client or the DC. Recent reboot? Dead CMOS battery? Lost NTP sync?
3. **Test the theory.** On the client: `w32tm /query /status` (Windows) or `chronyc tracking` / `timedatectl` (Linux). Compare to the DC's time. Anything more than a few minutes off is your culprit.
4. **Plan of action.** Force resync: `w32tm /resync /force`. Verify the client's NTP source is reachable. If the DC itself is drifting, check the PDC Emulator's upstream source.
5. **Implement.** Resync, replace CMOS battery if hardware is the cause, fix firewall rules if UDP/123 is being blocked outbound.
6. **Verify.** User logs in. `w32tm /query /status` shows recent successful sync.
7. **Document.** Note the cause in the ticket. If multiple machines drifted, the NTP infrastructure is the root cause, not the individual workstations — open a separate ticket for the network team.

## Helpdesk reality

- **User says:** "My computer says it's 2003 and I can't log in." **You check:** CMOS battery. The clock reset, Kerberos refuses the auth ticket, login fails. Replace the battery, force NTP resync, done. *This happens more than you'd think on older desktops that sit unplugged over a long weekend.*
- **User says:** "My MFA codes aren't working — the app says the code is wrong every time." **You check:** The phone's automatic time setting. If they manually set the time to mess with an app, TOTP breaks. Re-enable network-provided time on the phone.
- **User says:** "Websites are telling me certificates are expired but I just visited them yesterday." **You check:** System clock. A wrong year makes every valid certificate look expired or not-yet-valid. *Never tell the user the websites are broken — verify your clock before you call vendors.*
- **Never promise:** That time sync "just works." It works until a firewall rule blocks UDP/123 outbound, until a CMOS battery dies, until someone fat-fingers the NTP server config on the PDC Emulator. Time sync is silent infrastructure — when it breaks, everything breaks at once.
- **Escalation point:** If individual workstations are drifting, fix them. If the domain controller itself is drifting, or if Kerberos errors are happening fleet-wide, the NTP infrastructure is broken — that's a network/AD team ticket, not a desktop ticket.

## Related concepts

[[NTP]] · [[Kerberos]] · [[Active Directory]] · [[Syslog]] · [[TLS]] · [[Certificate Authority]] · [[MFA]] · [[TOTP]] · [[UDP]] · [[Port Numbers]] · [[PTP]] · [[Domain Controllers]] · [[FSMO Roles]] · [[Troubleshooting Methodology]]

*Source: VIRGIL knowledge base — 2026-05-11*