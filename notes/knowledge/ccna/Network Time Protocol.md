# Network Time Protocol

## What it is

In Sonic the Hedgehog 2's competitive multiplayer, the split-screen race only works because both Sonic and Tails are running on the same frame counter. If Player 1's clock thinks the race has been going for 47 seconds and Player 2's thinks 51, the goal-tape triggers at different moments and someone wins a race they actually lost. NTP is the protocol that keeps every device's clock running on the same tick.

Network Time Protocol synchronizes the clocks of network devices — routers, switches, servers, your laptop — against an upstream authoritative time source, then accounts for the network delay so the answer is actually accurate instead of "correct as of when the packet left, lol."

Devices typically keep two clocks side by side:
- **Software clock** — the running clock the OS uses for logs, sessions, certificates. Shown with `show clock`. Lost on reboot.
- **Hardware calendar** — battery-backed, keeps ticking when the device is unplugged. Like the CMOS clock on your PC's motherboard that remembers the date even after you yank the power.

On boot, the software clock reads from the calendar. You can also force the sync in either direction:
- `clock read-calendar` — calendar → software clock
- `clock update-calendar` — software clock → calendar

## Why it matters

Loot timers in Escape from Tarkov are useless if every player's watch is set to a different time. Same with security: a Kerberos ticket that's "valid for 5 minutes" means nothing if two servers disagree on what time it is by 10 minutes — auth just fails. Certificates expire at the wrong moment. TOTP codes (Google Authenticator) refuse to validate.

The bigger pain is forensics. When something gets popped at 02:14:33 on the firewall, you need the IDS, the switch, the DHCP server, and the domain controller to all agree on what 02:14:33 means. Otherwise you're stitching together a timeline from logs that all swear they're correct but disagree by 47 seconds. Without NTP, incident response becomes a Souls boss with no tells — you can't read the sequence of events.

NTP also enables:
- **Log correlation** across dozens of devices (SIEM tools depend on this).
- **Troubleshooting** where event order matters more than anything.
- **Security protocols** (Kerberos, TLS validity windows, MFA tokens).

## Key facts

### The stratum hierarchy
Think Dark Souls covenant ranks — your stratum number tells everyone how close you are to the actual source of truth.

- **Stratum 0** — the actual reference: atomic clocks, GPS receivers. Not on the network directly.
- **Stratum 1** — devices physically wired to a stratum 0 source. The high priests.
- **Stratum 2** — synced to a stratum 1. Stratum 3 syncs to stratum 2. And so on.
- Lower stratum = closer to truth = more trusted. A stratum 16 device is considered unsynchronized.

### How a client gets the time
Like checking ping in Apex before a ranked match — the client measures the round trip so it knows how stale the answer is.

- Client sends a query packet, server replies with timestamps.
- Client computes **round-trip delay** and **time offset** from those timestamps.
- To compensate for network latency, NTP adds **half the round-trip delay** to the server's reported time. (Assumption: the trip there and back took roughly equal time.)
- **Negative offset** = local clock is behind the server. **Positive offset** = local clock is ahead.

### NTP modes
- **Server mode** — hands time down to clients.
- **Client mode** — asks an upstream server for time.
- **Peer / symmetric mode** — two devices sync each other mutually, like a co-op revive in Helldivers 2 where either teammate can pick the other up.

### Manual clock and timezone config (Cisco IOS)
```
clock set HH:MM:SS DAY MONTH YEAR
calendar set HH:MM:SS DAY MONTH YEAR
clock timezone EST -5 0
clock summer-time EDT recurring
```
The timezone syntax is `NAME hours-offset minutes-offset`. The `recurring` keyword on summer-time auto-handles DST without you logging in twice a year.

### NTP configuration commands
- `ntp server 10.0.0.1` — point at an upstream server.
- `ntp server 10.0.0.1 prefer` — `prefer` marks it as the primary pick when multiple are configured. Like setting your main weapon loadout in CoD — you'll always grab that one first if it's available.
- `ntp master 3` — make this device act as an authoritative source at stratum 3 (used when there's no upstream available).
- `ntp peer 10.0.0.2` — symmetric peering.
- Configure **multiple servers** for redundancy and better accuracy. NTP picks the best candidate and discards outliers.

### NTP authentication
Stops a malicious device from impersonating your time source and rolling everyone's clocks back to invalidate certificates or replay tokens.
```
ntp authenticate
ntp authentication-key 1 md5 SuperSecret
ntp trusted-key 1
ntp server 10.0.0.1 key 1
```
The key has to be defined, marked trusted, *and* applied to the server line. Miss any one step and authentication silently doesn't work.

### Verification commands
**`show ntp status`** — am I synced, to what stratum, what's my reference?
- Reports sync state, stratum, reference ID, root delay, root dispersion.
- **Reference ID** = the IP/name of whatever this device is currently trusting for time.
- **Root delay** = total round-trip delay all the way back to the stratum 0 source.
- **Root dispersion** = how uncertain (spread out) the time estimates are. Higher = sketchier.

**`show ntp associations`** — the scoreboard of every server you've configured.
The leading character tells you the verdict, like the icons next to teammates in a lobby:
- `*` — currently synchronized to this server (your active main).
- `+` — candidate, eligible to be selected (on the bench, but viable).
- `-` — discarded by the selection algorithm (benched for being inconsistent).

**Offset** column shows the millisecond difference between your clock and that server's.

## Related concepts
[[Syslog]]
[[SNMP]]
[[Kerberos authentication]]
[[TLS certificate validation]]
[[Cisco IOS clock and calendar]]
[[Stratum hierarchy]]
[[NTP authentication and security]]
[[Log correlation and SIEM]]