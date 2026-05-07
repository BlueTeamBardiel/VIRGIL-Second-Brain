# Simple Network Management Protocol

## What it is

Every networked device — switches, routers, printers, servers, UPS units — keeps a giant internal stat sheet. CPU load, interface speed, uptime, packet counters, fan RPM. SNMP is how a central monitoring box reads that stat sheet and how the device screams for help when something breaks.

Think of it like the scoreboard API in NBA 2K26. The game (the agent) is constantly tracking every stat. A second screen app (the manager) pulls those numbers on demand and pops up an alert when a player fouls out. Devices don't broadcast their state into the void — they hold it in a structured database, and the manager either polls for what it wants or listens for emergency pings.

The architecture is **manager-agent**:
- **Agent** runs on the monitored device, owns the stats, listens on **UDP 161**.
- **Manager** is the NMS (network management station) that polls agents and receives alerts on **UDP 162**.
- **MIB** (Management Information Base) is the schema — the master list of every variable the agent knows how to report.
- **OID** (Object Identifier) is the address of one specific variable inside the MIB, written as dotted numbers like `1.3.6.1.2.1.1.3.0`.

## Why it matters

A network with 400 switches and zero monitoring is Escape from Tarkov without a minimap — you only find out you got rolled when you're already dead. SNMP is the radar.

It's also the protocol that powers basically every NMS dashboard you've seen — PRTG, LibreNMS, Zabbix, SolarWinds, Cisco DNA. When you see a graph of interface throughput over 24 hours, that's `ifInOctets` being polled every 30 seconds and stored in a time-series database.

The catch: SNMPv1 and v2c send their auth credential (the "community string") in **plaintext**. Anyone with a packet capture on the wire reads it instantly. A read-write community string is effectively root on the device — `Set` operations can change configuration. This is why SNMPv3 exists, and why running v2c across untrusted links is the networking equivalent of typing your password in Twitch chat.

## Key facts

### The five operations

- **Get** — fetch one specific OID. "What's the uptime?" → returns one value.
- **GetNext** — fetch the OID immediately after the one you specified in the MIB tree. Used to walk the tree when you don't know what's there.
- **GetBulk** — fetch many OIDs in a single request. Like requesting a whole inventory page in Cyberpunk 2077 instead of clicking each item. Added in SNMPv2c.
- **Set** — write a value to an OID. Can change device config. Dangerous.
- **Response** — what the agent sends back to any of the above.

### Notifications (agent → manager)

- **Trap** — fire-and-forget. Agent sends, doesn't care if it arrived. UDP, no retry. Like sending a Discord message and immediately closing the app.
- **Inform** — sent with a required acknowledgment. If the manager doesn't ACK, the agent retries. Reliable but heavier. SNMPv2c+ only.

### Versions

- **SNMPv1** — original. Plaintext community string. Get/GetNext/Set/Trap only.
- **SNMPv2c** — same plaintext auth as v1, but adds **GetBulk** and **Inform**. The "c" is for community-based. Most common version in the wild despite being insecure.
- **SNMPv3** — proper security model. Per-user authentication and optional encryption.

### SNMPv3 security levels

Picking a level is like picking a difficulty mode that also picks who can read your save file:

- **NoAuthNoPriv** — username only, no auth check, no encryption. Pointless except for testing.
- **AuthNoPriv** — username + cryptographic auth (HMAC-MD5 or HMAC-SHA). Identity verified, but payload still readable on the wire.
- **AuthPriv** — username + auth + encryption (DES, 3DES, or AES). The actual production setting.

### MIB and OID structure

OIDs are hierarchical, dot-separated numbers. Each dot drills deeper into a tree, like folder paths. The standard system branch lives under `1.3.6.1.2.1.1`:

- `1.3.6.1.2.1.1.1.0` — **sysDescr** (device description string)
- `1.3.6.1.2.1.1.3.0` — **sysUpTime**
- `1.3.6.1.2.1.1.5.0` — **sysName** (hostname)
- `1.3.6.1.2.1.25.3.2.1.5.1` — **hrProcessorLoad** (CPU %)
- `1.3.6.1.2.1.2.2.1.5` — **ifSpeed** (interface speed, indexed per interface)
- `1.3.6.1.2.1.2.2.1.10` — **ifInOctets** (bytes received per interface)
- `1.3.6.1.4.1.9` — start of the **Cisco enterprise** branch. Every vendor gets their own subtree under `1.3.6.1.4.1`.

### Common response codes

- **0 — noError** — clean success.
- **2 — noSuchName** — that OID doesn't exist on this agent.
- **3 — badValue** — you tried to Set a value of the wrong type or out of range.
- **5 — genErr** — generic failure, the "something went wrong" of SNMP.

### Cisco IOS configuration commands

- `snmp-server community <string> <RO|RW>` — sets the v1/v2c community string and read-only or read-write access.
- `snmp-server group <name> v3 <auth|noauth|priv>` — defines a v3 group bound to a security level.
- `snmp-server user <user> <group> v3 auth sha <pass> priv aes 128 <key>` — creates a v3 user inside that group with auth and privacy keys.
- `snmp-server host <ip> version <ver> <community|user>` — points traps/informs at a specific NMS.
- `snmp-server enable traps <type>` — turns on specific trap categories (e.g., `bgp`, `ospf`, `config`, `entity`). Off by default — without this, your manager hears nothing even if the destination is configured.

## Related concepts

[[Syslog]] · [[NetFlow]] · [[Network Management Station (NMS)]] · [[MIB browser]] · [[UDP]] · [[HMAC]] · [[AES]] · [[RMON]] · [[Telemetry (model-driven / gNMI)]] · [[AAA]]