# Network Time Protocol
**Master clock synchronization across network devices—critical for security, logging, and troubleshooting**

---

## Why This Chapter Matters

Accurate time across network infrastructure isn't a luxury—it's a necessity. Without synchronized clocks:
- **Log correlation becomes impossible**: When device A logs an event at 17:10 and device B logs the same event at 09:49, you can't correlate what actually happened
- **Security protocols fail**: [[TLS]] and other time-dependent security mechanisms depend on accurate time
- **Troubleshooting becomes a nightmare**: OSPF adjacency changes, BGP flaps, and authentication failures all need consistent timestamps to diagnose

[[Network Time Protocol|NTP]] is the solution. It allows every device in your network—routers, switches, servers, endpoints—to automatically synchronize their clocks to a common, authoritative time source.

---

## Core Concept: The Clock Synchronization Problem

**Simple explanation**: Imagine a distributed team trying to coordinate by writing timestamps in a shared log, but everyone has a different watch. The logs are meaningless. NTP is like giving everyone the same atomic clock.

**More detail**: Network devices maintain two clocks:
- **Software clock**: The active clock used by the OS, displayed with `show clock`
- **Hardware calendar**: A battery-backed clock that survives power loss

When a device boots, the software clock reads from the hardware calendar. But without synchronization, the hardware calendar drifts, and soon all devices report different times.

---

## Manual Time Configuration (The Dinosaur Method)

Before learning NTP, understand what you're *avoiding* by setting time manually.

### Setting the Software Clock

```
R1# clock set 18:30:00 August 28 2023
R1# show clock detail
18:30:03.553 UTC Mon Aug 28 2023
Time source is user configuration
```

**Key detail**: The asterisk (*) that appeared before indicates *non-authoritative* time. Once you set it, the asterisk disappears.

### Setting the Hardware Calendar

```
R1# calendar set 18:35:00 August 28 2023
R1# show calendar
18:35:02 UTC Mon Aug 28 2023
```

### Synchronizing Clock to Calendar (One-Way Sync)

| Command | Purpose | Direction |
|---------|---------|-----------|
| `clock read-calendar` | Copy calendar time → software clock | Calendar → Clock |
| `clock update-calendar` | Copy software clock → hardware calendar | Clock → Calendar |

**Critical**: These are one-time operations. They don't keep the two in sync over time.

### Configuring Time Zone

```
R1(config)# clock timezone JST 9 0
R1(config)# do show clock
03:50:09.104 JST Tue Aug 29 2023
```

**Syntax**: `clock timezone NAME hours-offset minutes-offset`
- Japan Standard Time (JST): UTC+9 → `clock timezone JST 9 0`
- Eastern Standard Time (EST): UTC-5 → `clock timezone EST -5 0`

### Configuring Daylight Saving Time

```
R1(config)# clock summer-time EDT recurring 2 Sunday March 02:00 1 Sunday November 02:00
```

**Breakdown**:
- `EDT` = name of DST period
- `recurring` = repeat yearly
- `2 Sunday March 02:00` = starts 2nd Sunday of March at 02:00
- `1 Sunday November 02:00` = ends 1st Sunday of November at 02:00

---

## Network Time Protocol: How It Works

### The Stratum Hierarchy

[[NTP]] organizes time sources in a **stratum model**—a hierarchical trust system:

| Stratum | Source | Reliability | Example |
|---------|--------|-------------|---------|
| 0 | Atomic clock, GPS receiver, radio clock | Highest | Cesium atomic clock |
| 1 | Connected directly to Stratum 0 | Very high | GPS-disciplined oscillator |
| 2 | Synced to Stratum 1 | High | Cisco router synced to GPS NTP server |
| 3+ | Synced to lower stratum | Decreasing | Your switch synced to your router |

**Key insight**: Your network's NTP hierarchy bottoms out at Stratum 1 (usually an external NTP server on the internet). Every internal device syncs down from there.

### Client-Server Synchronization

**Simple analogy**: NTP clients are students asking the teacher (server) what time it is. The teacher responds, and the student sets their watch accordingly.

**Reality is more complex**: 
1. Client sends NTP query packet to server
2. Server responds with current time + transmission delay information
3. Client calculates **round-trip delay** and **time offset**
4. Client adjusts its clock accounting for network latency

**Why this matters**: If the server says "it's 12:00" and the query took 50ms round-trip, the client doesn't set to exactly 12:00—it adds half the delay (25ms) to account for the return trip time.

### NTP Modes

| Mode | Role | Direction | Use Case |
|------|------|-----------|----------|
| **Server** | Provides time to clients | Downstream | An NTP server or a local router serving other devices |
| **Client** | Requests time from servers | Upstream | A switch getting time from a router |
| **Peer/Symmetric** | Mutual synchronization | Bidirectional | Two routers keeping each other in sync (rare in CCNA labs) |

---

## NTP Configuration on Cisco IOS

### Basic NTP Server Configuration

```
R1(config)# ntp server 203.0.113.5
```

This tells R1 to sync its clock to the NTP server at 203.0.113.5. R1 becomes an NTP **client** to that server.

**Multiple servers (best practice)**:
```
R1(config)# ntp server 203.0.113.5 prefer
R1(config)# ntp server 203.0.113.6
R1(config)# ntp server 203.0.113.7
```

The `prefer` keyword marks this server as the primary choice. [[NTP]] will sync to it if available.

### Configuring a Device as NTP Server

To make R1 serve time to other devices:

```
R1(config)# ntp master 2
```

This makes R1 an NTP master at stratum 2. It will serve time to clients even if it isn't synced to an external source (useful for isolated networks).

**Better approach**: Configure R1 as a client AND a server:
```
R1(config)# ntp server 203.0.113.5        ← R1 is a client
R1(config)# ntp master 2                  ← R1 is also a server
```

Now R1 syncs to the external server and provides time to other devices.

### NTP Peer Configuration

For mutual synchronization (rarely tested):

```
R1(config)# ntp peer 10.0.0.2
```

### Setting NTP Authentication

NTP packets can be spoofed. Authentication prevents rogue time sources:

```
R1(config)# ntp authenticate
R1(config)# ntp authentication-key 1 md5 MySecretKey123
R1(config)# ntp trusted-key 1
R1(config)# ntp server 203.0.113.5 key 1
```

**Breakdown**:
- `ntp authenticate` = Enable authentication check
- `ntp authentication-key 1 md5 MySecretKey123` = Define key 1 with MD5 hash
- `ntp trusted-key 1` = Mark key 1 as trusted (accept from this server)
- `ntp server 203.0.113.5 key 1` = This server must use key 1

**Why it matters for CCNA**: This is tested. You must configure authentication on both client and server with matching keys.

### Verifying NTP Status

```
R1# show ntp status
Clock is synchronized
Stratum is 3
Reference ID is 203.0.113.5 (ntp-server.example.com)
Precision is 2^-24
Root delay is 50.00 msec
Root dispersion is 75.25 msec
Reference time is E8A4C1D2.8F2E1A1B (Feb 14 2024 10:30:02.560 UTC)
Clock offset is 5.234 msec
Frequency offset is 12.789 ppm
```

**What to look for**:
- `Clock is synchronized` = Success
- `Stratum is 3` = We're 3 hops from an atomic clock
- `Reference ID is 203.0.113.5` = We're synced to this server
- `Clock offset is 5.234 msec` = We're off by 5ms (small = good)

```
R1# show ntp associations
      address         ref clock   st  when  poll reach  delay  offset   disp
*203.0.113.5         .GPS.        1    32    64   377   8.345  -3.182  5.246
+203.0.113.6         .DCFa.       1    48    64   377  12.543  2.891   6.124
-203.0.113.7         .CDMA.       1    54    64   377  15.234  8.456   8.978
```

**Column meanings**:
- `*` = Synced to this server
- `+` = Candidate (good but not currently synced)
- `-` = Discarded (too much delay/offset)
- `st` = Stratum
- `offset` = Clock difference (negative = we're slow, positive = we're fast)

---

## Lab Relevance: Cisco IOS Commands

| Task | Command | Mode | Example |
|------|---------|------|---------|
| Set software clock | `clock set HH:MM:SS MONTH DAY YEAR` | Priv EXEC | `clock set 14:30:00 Aug 28 2023` |
| Set hardware calendar | `calendar set HH:MM:SS MONTH DAY YEAR` | Priv EXEC | `calendar set 14:30:00 Aug 28 2023` |
| Sync calendar to clock | `clock update-calendar` | Priv EXEC | `clock update-calendar` |
| Sync clock to calendar | `clock read-calendar` | Priv EXEC | `clock read-calendar` |
| Set time zone | `clock timezone NAME HOURS MINUTES` | Config | `clock timezone EST -5 0` |
| Set DST | `clock summer-time NAME recurring WEEK DAY MONTH TIME WEEK DAY MONTH TIME` | Config | `clock summer-time EDT recurring 2 Sunday March 02:00 1 Sunday November 02:00` |
| Configure NTP server | `ntp server IP-ADDRESS [prefer]` | Config | `ntp server 203.0.113.5 prefer` |
| Make device NTP master | `ntp master STRATUM` | Config | `ntp master 2` |
| Enable NTP auth | `ntp authenticate` | Config | `ntp authenticate` |
| Define auth key | `ntp authentication-key KEY-ID md5 PASSWORD` | Config | `ntp authentication-key 1 md5 Cisco123` |
| Trust auth key | `ntp trusted-key KEY-ID` | Config | `ntp trusted-key 1` |
| Apply key to server | `ntp server IP-ADDRESS key KEY-ID` | Config | `ntp server 203.0.113.5 key 1` |
| View clock | `show clock [detail]` | Any | `show clock detail` |
| View NTP status | `show ntp status` | Any | `show ntp status` |
| View NTP associations | `show ntp associations` | Any | `show ntp associations` |

---

## Exam Tips: What the CCNA Tests

### Concept-Level Questions

**Question type 1**: "You're configuring a network with three routers. R1 connects to an external NTP server. R2 and R3 should sync to R1. Which commands do you use?"

**Expected answer**:
- R1:

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 2 | [[CCNA]]*
