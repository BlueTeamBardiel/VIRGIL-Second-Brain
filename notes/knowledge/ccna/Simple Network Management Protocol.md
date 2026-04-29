# Simple Network Management Protocol
**Tagline:** Master SNMP to monitor, manage, and troubleshoot networks remotely—the foundation of enterprise network observability.

---

## Overview: What is SNMP and Why It Matters

Think of [[SNMP]] like a hospital's vital signs monitoring system. Devices continuously report their health metrics (CPU, memory, interfaces) to a central station, and administrators can query devices or receive alerts when something goes wrong. SNMP is the protocol that enables this network-wide visibility.

**Why it matters for CCNA:** SNMP is fundamental to network operations. Without it, you're flying blind—no visibility into device health, interface statistics, or performance trends. The exam tests your understanding of SNMP architecture, message types, versions, and security models deeply.

---

## Key Concepts

### SNMP Architecture: The Management Triangle

SNMP operates on a **manager-agent model**:

- **Manager (NMS):** The central monitoring station that sends requests and receives notifications. Examples: Cisco Prime Infrastructure, Nagios, Zabbix.
- **Agent:** The software running on managed devices (routers, switches, servers) that collects and reports data.
- **Managed Device:** The network equipment being monitored (your Cisco router, switch, etc.).

**Simple analogy first:** A manager is like a doctor; an agent is like the nurse taking vital signs; the managed device is the patient.

**With detail:** The manager sends queries (Get, GetNext, GetBulk) to agents on UDP port 161. Agents respond with requested data or perform configuration changes (Set). Separately, agents send unsolicited notifications (Traps, Informs) to the manager on UDP port 162 when something notable happens—a link goes down, CPU spikes, or a threshold is exceeded.

---

## SNMP Operations and Components

### Read Operations

| Operation | Purpose | Use Case |
|-----------|---------|----------|
| **Get** | Retrieve a single OID value | Check interface status |
| **GetNext** | Retrieve the next OID in the MIB tree | Walk through a list of interfaces |
| **GetBulk** | Retrieve multiple OIDs efficiently | Retrieve entire routing table at once |

**Deep dive:** GetBulk (SNMPv2c+) retrieves up to N objects in one request, dramatically reducing query overhead compared to repeated GetNext calls. On high-latency WAN links, this matters.

### Write Operations

| Operation | Purpose | Security Risk |
|-----------|---------|---|
| **Set** | Modify an OID value on a device | Requires strong authentication; SNMPv1/v2c uses plaintext community strings |

Example: Remotely enable/disable an interface or change a device hostname.

### Notification Operations

| Operation | Direction | Reliability |
|-----------|-----------|---|
| **Trap** | Agent → Manager | Unreliable (UDP, fire-and-forget) |
| **Inform** | Agent → Manager | Reliable (manager sends acknowledgment) |

**Practical difference:** A Trap tells the manager "your link went down" once and hopes the message arrives. An Inform repeats until confirmed. Use Informs for critical events; use Traps for high-volume, non-critical notifications to reduce traffic.

---

## SNMP Management Information Base (MIB)

The **MIB** is the database of all objects (variables) that an agent can report. Think of it as a dictionary—you look up an OID (Object Identifier) to find what metric you want.

### Common MIB Objects (OIDs)

| OID | Name | Example Value |
|-----|------|---|
| `1.3.6.1.2.1.1.1.0` | **sysDescr** | "Cisco IOS Software, C2900 Software..." |
| `1.3.6.1.2.1.1.3.0` | **sysUpTime** | 12345600 (in hundredths of a second) |
| `1.3.6.1.2.1.1.5.0` | **sysName** | "Router1" |
| `1.3.6.1.2.1.25.3.2.1.5.1` | **hrProcessorLoad** | 45 (CPU %) |
| `1.3.6.1.2.1.2.2.1.5` | **ifSpeed** | 1000000000 (1 Gbps in bps) |
| `1.3.6.1.2.1.2.2.1.10` | **ifInOctets** | Bytes received on interface |

OIDs are hierarchical numbers separated by dots. Vendors define proprietary OIDs under their enterprise tree (Cisco: 1.3.6.1.4.1.9).

---

## SNMP Versions and Security

### SNMPv1 and SNMPv2c: Community String Authentication

**Simple analogy:** Like a library card—anyone with the right number can access the system, but there's no validation the person holding the card is who they claim to be.

| Aspect | SNMPv1 | SNMPv2c |
|--------|--------|---------|
| **Authentication** | Community string (plaintext) | Community string (plaintext) |
| **Encryption** | None | None |
| **Operations** | Get, GetNext, Set, Trap | Get, GetNext, **GetBulk**, Set, Trap, Inform |
| **Security Level** | Weak | Weak |
| **Use Case** | Legacy/isolated networks only | Lab/non-critical environments |

**Critical exam point:** SNMPv1 and SNMPv2c transmit community strings in **clear text**. An attacker sniffing traffic can read them. This is a major vulnerability—never use these in production.

### SNMPv3: User-Based Security Model (USM)

**With detail:** SNMPv3 introduces:

1. **Authentication** (optional): HMAC-MD5 or HMAC-SHA verify the sender's identity.
2. **Encryption** (optional): DES, 3DES, or AES encrypt the payload.
3. **Username/Password**: Instead of community strings.
4. **Security Levels:**
   - **NoAuthNoPriv:** Username only (like SNMPv2c, but with a username).
   - **AuthNoPriv:** Username + authentication (integrity check).
   - **AuthPriv:** Username + authentication + encryption (full security).

**Exam focus:** SNMPv3 with AuthPriv is the only SNMP version suitable for production networks. Know the three security levels cold.

---

## SNMP Message Classes

### Read Message Class
The manager requests data from an agent.

```
Manager sends: Get request for ifInOctets on interface Gi0/1
Agent responds: "12,345,678 octets"
```

### Write Message Class
The manager modifies configuration on an agent.

```
Manager sends: Set sysName to "NewRouterName"
Agent responds: Success or error
```

**Danger zone:** Set operations with SNMPv1/v2c are extremely risky without encryption. Attackers can modify critical settings (routing tables, ACLs, IP addresses).

### Notification Message Class
The agent sends unsolicited alerts to the manager.

**Trap example:**
```
Router detects link down on Gi0/1
Agent sends Trap: "linkDown notification, ifIndex=1"
```

**Inform example:**
```
Agent sends Inform: "linkDown"
Manager receives and sends acknowledgment
Agent stops retransmitting
```

### Response Message Class
The agent responds to any request (Get, GetNext, Set) with the requested data or an error code.

Error codes include:
- `noError (0)`: Success
- `noSuchName (2)`: OID doesn't exist
- `badValue (3)`: Invalid value in Set request
- `genErr (5)`: Generic error

---

## Lab Relevance: Cisco IOS SNMP Commands

### Enable SNMP on a Device

```ios
! SNMPv2c read-only access
Router(config)# snmp-server community PUBLIC ro

! SNMPv2c read-write access (dangerous!)
Router(config)# snmp-server community PRIVATE rw

! SNMPv3 user with authentication and encryption
Router(config)# snmp-server user admin authgroup v3 auth sha PASSWORD priv aes 256 ENCRYPTIONKEY

! Define SNMPv3 group with security level
Router(config)# snmp-server group authgroup v3 priv

! Set trap destination (manager IP)
Router(config)# snmp-server host 192.168.1.100 version 3 priv admin

! Enable specific trap types
Router(config)# snmp-server enable traps linkdown linkup
Router(config)# snmp-server enable traps bgp
```

### Verify SNMP Configuration

```ios
! Show SNMP configuration
Router# show snmp

! Show SNMP community strings
Router# show snmp community

! Show SNMP users (v3)
Router# show snmp user

! Show SNMP groups (v3)
Router# show snmp group

! Show trap destinations
Router# show snmp host

! Test SNMP connectivity (from manager or another device)
Router# snmp get -c PUBLIC 192.168.1.1 1.3.6.1.2.1.1.1.0
```

### Set Trap Severity Level (Syslog Integration)

```ios
! Only send traps with severity INFO and above
Router(config)# snmp-server trap-source Loopback0

! Specify trap version
Router(config)# snmp-server host 192.168.1.100 version 2c PUBLIC
```

### Common MIB Queries from Linux/Mac

```bash
# Get system description (requires snmp tools installed)
snmpget -v 2c -c PUBLIC 192.168.1.1 sysDescr.0

# Get system uptime
snmpget -v 2c -c PUBLIC 192.168.1.1 sysUpTime.0

# Walk entire MIB tree (generates huge output!)
snmpwalk -v 2c -c PUBLIC 192.168.1.1

# Get interface statistics
snmpget -v 2c -c PUBLIC 192.168.1.1 ifInOctets.1
```

---

## Exam Tips

### What the CCNA Exam Specifically Tests on SNMP

1. **Version Differences:** Know that SNMPv1 and v2c use plaintext community strings; SNMPv3 adds authentication and encryption. Expect scenario questions where you must recommend the correct version.

2. **Security Models:** Understand the three SNMPv3 security levels (NoAuthNoPriv, AuthNoPriv, AuthPriv). Exam may ask: *"Which security level provides authentication without encryption?"* Answer: AuthNoPriv.

3. **Port Numbers:** SNMP uses **UDP 161** (agent listens for requests), SNMP Traps use **UDP 162** (manager listens for notifications). Expect a firewall/ACL question where you must permit these ports.

4. **Trap vs. Inform:** Distinguish between unreliable Traps and reliable Informs. Exam may ask when to use each—Informs for critical alerts, Traps for high-volume monitoring.

5. **Manager-Agent Architecture:** Understand the roles. Expect a diagram question: "Which device sends a Get request?" (Manager.) "Which device sends a Trap?" (Agent.)

6. **MIB Basics:** You don't need to memorize OIDs, but know that MIBs define what objects agents can report. Understand that sysUpTime, sysDescr, and interface counters (ifInOctets, ifOutOctets) are common objects.

7. **Configuration Syntax:** Know how to configure SNMP on Cisco IOS:
   - `snmp-server community STRING [ro|rw]`
   - `snmp-server host IP version [1|2c|3] [COMMUNITY|USERNAME]`
   - `snmp-server user USERNAME GROUP v3 auth sha PASSWORD priv aes ENCKEY`

8. **Scenario Analysis:** Expect a question like: *"A manager cannot receive traps from a router. The firewall allows UDP 162. What else might be wrong?"* Common answers: SNMP

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 6 | [[CCNA]]*