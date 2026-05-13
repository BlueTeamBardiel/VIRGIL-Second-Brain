# SNMP — Simple Network Management Protocol

## What it is

In **Smash Bros**, the damage meter under each fighter ticks up every time they take a hit — 47%, 89%, 134% — and the whole match revolves around reading those numbers. You don't need to watch every frame; you glance at the percentage and you know who's about to get launched. The meter is the network's honest answer to "how cooked is this guy?" That's exactly what **SNMP** does for your infrastructure — every switch, router, firewall, printer, and UPS keeps a running tally of its own state, and SNMP is how the management station reads the meter.

Technically: **SNMP (Simple Network Management Protocol)** is a UDP-based application-layer protocol for polling and configuring managed devices. The **manager** (NMS — network management station) talks to the **agent** running on each device. The agent maintains a **MIB (Management Information Base)** — a tree of objects identified by **OIDs (Object Identifiers)** — and the manager queries those OIDs to read counters (bytes in/out, CPU%, interface state) or pushes **set** operations to change configuration. Agents send unsolicited **traps** (or **informs** in v2c+) when something interesting happens.

Ports: **UDP/161** for agent polling, **UDP/162** for traps to the manager.

## Why it matters

SNMP is everywhere and nobody loves it. It is also one of the most-abused legacy protocols on a corporate network. CySA+ tests it under **Objective 1.3** because SNMP shows up in three different SOC scenarios:

1. **As a legitimate telemetry source** feeding your SIEM and NMS — interface counters, link state, hardware faults
2. **As a reconnaissance target** — an attacker who finds SNMP v1/v2c with the community string `public` can walk the entire MIB and enumerate your infrastructure
3. **As an amplifier** for reflection DDoS attacks — small `GetBulkRequest`, huge response

If you can't read an SNMP packet capture in Wireshark and tell the difference between a normal poll cycle and a `snmpwalk` recon sweep, you're going to miss the early-stage scout in an intrusion. The version of SNMP a device runs is also one of the cheapest configuration-hardening findings on a vulnerability scan — and one of the most ignored by network teams who don't want to break monitoring.

## Key facts

### Versions — the only thing that matters for the exam

| Version | Auth | Encryption | Status |
|---|---|---|---|
| **SNMPv1** | Community string (plaintext) | None | Deprecated. Still everywhere. |
| **SNMPv2c** | Community string (plaintext) | None | The "c" is for "community." Same auth model as v1 with better bulk operations. |
| **SNMPv3** | User-based (USM) — username + auth hash + priv key | **authPriv** mode: HMAC-SHA + AES | The only version you should be deploying. |

SNMPv3 has three security levels:

- **noAuthNoPriv** — username only, no hash, no encryption. Useless.
- **authNoPriv** — authenticated (HMAC-MD5 or HMAC-SHA), still plaintext on the wire.
- **authPriv** — authenticated AND encrypted (DES, 3DES, or AES). The only acceptable production setting.

### The community string problem

In v1/v2c, the **community string** is the entire authentication mechanism. It's a shared secret sent in cleartext on every packet. The factory defaults are universally known:

- `public` — read-only community
- `private` — read-write community

A read-only `public` against a Cisco IOS device leaks: hostname, software version, every interface, every routing peer, ARP table, MAC address table, every running process. A read-write `private` lets you **upload a new config**, reboot the device, or pull the running config to TFTP. That is full administrative compromise of network gear over UDP/161 with no password worth the name.

### MIBs and OIDs — what the attacker is actually pulling

OIDs are dotted-decimal paths into a hierarchical namespace. A few worth recognizing on the exam and on the wire:

- `1.3.6.1.2.1.1.1.0` — sysDescr (hostname, OS, version banner)
- `1.3.6.1.2.1.1.5.0` — sysName
- `1.3.6.1.2.1.2.2.1` — ifTable (every interface, state, counters)
- `1.3.6.1.2.1.4.22.1` — ARP table
- `1.3.6.1.4.1.9.9.23` — Cisco CDP neighbor table (entire L2 topology, free)
- `1.3.6.1.4.1.77.1.2.25` — Windows user accounts (on older Windows SNMP service)

When you see `snmpwalk -v2c -c public 10.x.x.x` in a packet capture or a bash history, the attacker is dumping the entire MIB tree. That is unambiguous reconnaissance.

### Operations on the wire

| PDU | Direction | What it does |
|---|---|---|
| **GetRequest** | Manager → Agent | Read a single OID |
| **GetNextRequest** | Manager → Agent | Walk to the next OID in the tree |
| **GetBulkRequest** | Manager → Agent | v2c+. Pull many OIDs in one shot. **The DDoS amplifier.** |
| **SetRequest** | Manager → Agent | Write to an OID (config change) |
| **Trap / Inform** | Agent → Manager | Unsolicited event notification |
| **Response** | Agent → Manager | Reply to any of the above |

### Detection — what malicious SNMP looks like

[[Wireshark]] filter cheats:

- `snmp` — all SNMP traffic
- `snmp.community == "public"` — community-string traffic in plaintext (v1/v2c)
- `snmp.version == 0` — SNMPv1 (v2c is `1`, v3 is `3`)

Patterns to flag in SIEM correlation:

- **Sequential OID walking from a non-NMS source** — your NMS pulls a known, scheduled, narrow set. An attacker pulls everything. High packet count, monotonically increasing OIDs, unusual source IP → recon.
- **SNMP traffic to or from a workstation subnet** — workstations should not speak SNMP to network gear. NMS subnet only.
- **GetBulkRequest with spoofed source** — classic reflection-DDoS precursor. The response is sent to the victim, not the attacker.
- **SetRequest from anywhere that isn't the NMS** — alert immediately. That's a config-change attempt.
- **SNMP traps spiking** — link flaps, auth failures, or `coldStart` traps appearing on devices that didn't reboot. Could be normal; could be an attacker rebooting gear to clear forwarding state.

### CompTIA exam traps

> **CompTIA exam trap:** "SNMPv2 is encrypted." It is not. **SNMPv2c uses cleartext community strings.** Encryption first appears in **SNMPv3 with authPriv**. The "c" in v2c stands for *community*, not *crypto*.

> **CompTIA exam trap:** Ports. SNMP polling is **UDP/161**. SNMP traps go to **UDP/162**. CompTIA loves to swap them. The agent listens on 161; the manager listens on 162.

> **CompTIA exam trap:** SNMP vs syslog. Syslog (UDP/514) is push-only logging. SNMP is bidirectional management — you can both read state and *change configuration*. Confusing the two on a question about device configuration exposure will burn you.

> **CompTIA exam trap:** A finding of "SNMP community string 'public' enabled" on a vulnerability scan is **Information Disclosure** at minimum and **Privilege Escalation** if the same string is read-write. CVSS-wise, treat read-write `public` on a core router as critical regardless of what the scanner labels it.

### Hardening checklist (what the IR report will recommend)

- Disable SNMPv1 and v2c entirely. If you can't, restrict by ACL to the NMS source IPs only.
- Deploy SNMPv3 with **authPriv** — SHA + AES at minimum.
- Change all community strings off `public`/`private`. Treat them like passwords; rotate them; log who knows them.
- Restrict **read-write** community/user to a single hardened host.
- Bind the SNMP agent to a management VRF or out-of-band interface.
- Drop UDP/161 inbound at the perimeter. No excuses.
- Enable SNMP **view-based access control (VACM)** to expose only the OID subtrees the NMS actually needs.

## SOC reality

- At 2am the SIEM correlation rule fires: `SNMP GetNextRequest count > 500 from src=10.45.x.x to dst=core-rtr-01 within 60s`. L1 pulls the packet capture, sees community string `public`, sees the source is a finance laptop that has no business polling the core router. That's an attacker on the inside doing internal reconnaissance — likely post-initial-access enumeration. Escalate to L2 immediately.
- The CISO will ask three things: "Did they get read-write? Did they exfil the running-config? Is the network team rotating the community string tonight or are we waiting for change control?" Have answers ready. The third question is the hard one — change control will want to wait until Tuesday and you'll have to push back.
- Never tell leadership "we blocked SNMP at the firewall, we're fine." That blocks external. The threat actor pulling MIB data is already inside. Containment for SNMP recon means killing the user session, isolating the endpoint, and rotating the strings — in that order.
- The vuln-scan finding "SNMP v1/v2c enabled with default community string" sits in the backlog at every enterprise for months because the network team is afraid rotating the string will break monitoring. *I have watched a P2 finding from a quarterly scan become the post-mortem root cause on a P1 incident more than once. Rotate the string. Schedule the maintenance window. Stop deferring.*
- Handoff: L1 confirms anomalous SNMP → L2 pulls full PCAP and confirms scope of OIDs queried → IR lead engages network engineering to rotate strings and tighten ACLs → forensics on the source host. If a `SetRequest` was seen, escalate to the IR team lead immediately and assume device configuration is suspect until proven otherwise.

## Related concepts

[[Wireshark]] · [[Packet capture]] · [[Network reconnaissance]] · [[Syslog]] · [[NetFlow]] · [[Log analysis and correlation]] · [[Pattern recognition]] · [[Abnormal account activity]] · [[Vulnerability scanning]] · [[CVSS]] · [[Default credentials]] · [[Reflection DDoS]] · [[ACLs]] · [[Out-of-band management]] · [[Endpoint detection and response]] · [[SIEM correlation rules]]

*Source: VIRGIL knowledge base — 2026-05-11*