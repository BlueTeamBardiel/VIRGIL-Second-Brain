# SNMP

## What it is
Think of SNMP as a building superintendent who walks every floor with a clipboard, checking whether lights are on, HVAC is running, and doors are locked — then reports everything back to a central management desk. Simple Network Management Protocol (SNMP) is a UDP-based protocol (port 161/162) that allows network devices like routers, switches, and printers to expose operational data and accept configuration commands from a central management station.

## Why it matters
In 2002, researchers discovered that nearly every major SNMP implementation was vulnerable to buffer overflow attacks when processing malformed trap messages — affecting Cisco, Microsoft, and dozens of vendors simultaneously. Attackers with knowledge of the default community string "public" (which still appears in misconfigured devices today) can read an entire device's MIB tree, leaking network topology, interface details, and uptime — everything needed to map an attack surface silently.

## Key facts
- **SNMPv1 and v2c** transmit community strings (essentially passwords) in **plaintext** — trivially sniffable with Wireshark
- **SNMPv3** adds authentication (MD5/SHA) and encryption (DES/AES), making it the only version acceptable in secure environments
- Default community strings **"public"** (read) and **"private"** (read-write) are present on countless unpatched devices and are a known pentest target
- SNMP **traps** (port 162) are unsolicited alerts sent *from* devices *to* the manager — the reverse of normal polling
- The **MIB (Management Information Base)** is the structured database of variables a device exposes; enumerating it reveals interface names, connected subnets, and running processes

## Related concepts
[[UDP Security]] [[Network Enumeration]] [[Default Credentials]] [[MIB Walking]] [[Network Protocols]]