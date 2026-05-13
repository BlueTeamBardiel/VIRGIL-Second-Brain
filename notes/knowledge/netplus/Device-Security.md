# Device Security

## What it is

In **Dark Souls**, you don't walk into Sen's Fortress with your starting loadout and hope for the best. You upgrade the armor at Andre, you bind the spells you actually need, you unequip the dead weight that fat-rolls you into the swinging axes. Every slot matters. And the moment you leave a soapstone sign down in a zone you haven't cleared, you're inviting whatever invader wants to walk through your door.

That's device security. **Device hardening is unequipping everything you don't need, locking down every interface you do, and assuming the network is full of invaders looking for a soft target.**

Technically: device security is the set of configurations, controls, and policies applied to network infrastructure (routers, switches, firewalls, APs) and endpoints to reduce attack surface, enforce access boundaries, and contain breaches when — not if — something gets through. CompTIA Objective 4.3 frames it as defense techniques applied per-scenario: harden the device, segment the network, control who and what gets on it.

## Why it matters

Every breach post-mortem has the same three findings in some order: **default credentials still in place, unused services still running, no segmentation between the compromised host and the crown jewels.** These are not exotic failures. They're the same boss fight every shop loses.

For the exam: Objective 4.3 is dense. CompTIA will hand you a scenario — "a contractor's laptop got onto the production VLAN" — and ask which control would have stopped it. You need to know which tool does which job, and which tools get confused with each other (ACL vs. firewall rule; MAC filtering vs. 802.1X vs. NAC).

For the job: this is what separates a tech who plugs in a switch and walks away from one who actually deploys it. The first one creates tickets. The second one closes them.

## Key facts

### Device hardening

Hardening reduces a device's attack surface. The fewer doors, the fewer locks to pick.

| Hardening step | What it does | Why it matters |
|---|---|---|
| **[[Change default passwords]]** | Replaces vendor creds (admin/admin) | Default creds are Shodan-searchable |
| **[[Disable unused ports and services]]** | Shuts off Telnet, HTTP mgmt, SNMPv1, unused switchports | Every running service is a CVE waiting to be filed |
| **Patch firmware** | Closes known vulns | Unpatched IOS = free lateral movement |
| **Enable logging** | Sends syslog to a central collector | You can't investigate what you didn't record |
| **Use encrypted mgmt** | SSH not Telnet, HTTPS not HTTP, SNMPv3 not v1/v2c | Cleartext mgmt = creds on the wire |
| **Disable auto-config** | CDP/LLDP off on edge ports, DTP off | Stops attackers fingerprinting your topology |

*The first thing I do on a new switch isn't configure VLANs — it's `no ip http server`, `transport input ssh`, and a fresh enable secret. Hardening is a checklist, not an instinct.*

### Change default passwords

The single highest-ROI control in the entire syllabus. Default creds for every consumer router, every enterprise switch, every IP camera, every printer are searchable in 10 seconds. Change them on day one. Use unique credentials per device class. Store them in a password manager, not `passwords_final_v3.xlsx`.

> **CompTIA exam trap:** "First step in hardening a new device" — the answer is almost always **change the default password**, not "apply patches" or "disable services." CompTIA tests order-of-operations. Creds first, because if the creds are default, nothing else you do matters.

### Trusted vs. untrusted zones

A **zone** is a logical grouping of network segments that share a trust level. Firewalls enforce rules *between* zones.

- **Trusted** — internal LAN, corporate VLANs
- **Untrusted** — the internet, guest Wi-Fi, IoT segments
- **Semi-trusted / screened subnet** — public-facing servers that need to talk to both sides

### Screened subnet (formerly DMZ)

A **screened subnet** is a network segment isolated by firewalls on both sides — one facing the internet, one facing the internal network. Public services live here. If the web server gets popped, the attacker is stuck in the screened subnet and still has a firewall between them and the database.

```
Internet → [Outer FW] → Screened Subnet (web, mail) → [Inner FW] → Internal LAN
```

*CompTIA renamed DMZ to screened subnet because the control is what matters: two firewalls, one subnet between them, public services in the middle.*

### Access Control List (ACL)

An **ACL** is an ordered list of permit/deny rules applied to a router or switch interface. Rules match on source IP, destination IP, protocol, and port. **Order matters** — the first match wins. There's an **implicit deny** at the bottom of every ACL.

```
permit tcp 10.1.1.0/24 any eq 443
permit tcp 10.1.1.0/24 any eq 80
deny ip any any  ← implicit, but write it explicitly for logging
```

ACLs are stateless on most routers (every packet evaluated independently). Firewalls are stateful (track sessions). Know the difference.

> **CompTIA exam trap:** ACL rules are evaluated top-down, first-match-wins. A `deny` rule placed *after* a broad `permit` does nothing. CompTIA loves the question where the rules are in the wrong order and the "correct" traffic gets blocked.

### Security rules (firewall rules)

Firewall rules extend ACL logic with **state tracking** — they remember that 10.1.1.5 initiated a connection to 8.8.8.8:443, so return traffic is automatically allowed. Next-gen firewalls also match on application, user identity, and content. Same first-match-wins logic. Same implicit deny.

### Disable unused ports and services

Two flavors:

- **Physical switchports** — `shutdown` every port not in use. An attacker who plugs a Raspberry Pi into a live wall jack just got onto your network.
- **Services on the device** — Telnet, HTTP mgmt, TFTP, CDP on edge ports, SNMPv1/v2c. If you're not using it, turn it off.

### Port security

**Port security** is a switch feature that limits which MAC addresses can use a given port and how many. Common config: max 1 MAC, sticky learn, violation = shutdown.

```
switchport port-security
switchport port-security maximum 1
switchport port-security mac-address sticky
switchport port-security violation shutdown
```

Unplug the desk phone, plug in a rogue laptop, port shuts down. Helpdesk gets a ticket. The intrusion stops at L2.

### MAC filtering

**MAC filtering** is an allow-list of MAC addresses permitted on a network — typically on wireless APs or as a weak NAC substitute. Worth knowing for the exam, worth ignoring as a real control: **MAC addresses are trivially spoofed.** Sniff one valid MAC off the air, change your NIC's MAC, you're in.

*MAC filtering is a speed bump, not a wall. It stops your neighbor's kid. It does not stop anyone with `macchanger` and 30 seconds.*

### 802.1X

**802.1X** is port-based network access control. Before a device gets an IP, before it gets onto a VLAN, it authenticates. Three roles:

| Role | What it is |
|---|---|
| **Supplicant** | The client device requesting access |
| **Authenticator** | The switch or AP the client connects to |
| **Authentication Server** | RADIUS server holding credentials/certs |

The supplicant sends credentials via **EAP** to the authenticator, which forwards them to RADIUS. RADIUS says yes or no. On yes, the switch puts the port into the assigned VLAN. On no, the port stays quarantined or drops traffic.

This is the real control. MAC filtering is the lie. 802.1X is the truth.

### Network Access Control (NAC)

**NAC** extends 802.1X with **posture checking**. Before letting a device on, NAC verifies:

- OS is patched
- Antivirus is current and running
- Disk is encrypted
- Device is enrolled in MDM

Fail any check, the device gets shunted to a **remediation VLAN** with internet access for patches but no access to internal resources. Pass, full access.

### URL filtering and content filtering

**URL filtering** blocks or allows web requests based on URL or domain. Run by a proxy, NGFW, or DNS filter. Categories (gambling, malware, social media) are vendor-maintained.

**Content filtering** is broader — inspects the *content* of traffic for keywords, file types, data patterns. Overlaps with DLP. Both fail open on encrypted traffic unless you're doing TLS inspection (which has its own privacy and certificate-pinning headaches).

### Key management

**Key management** is the lifecycle of cryptographic keys: generation, distribution, storage, rotation, revocation, destruction. For network devices:

- **SSH host keys** — regenerate on deployment, don't ship with vendor defaults
- **TLS certificates** — for mgmt interfaces; rotate before expiry
- **WPA2/WPA3 PSKs** — rotate on staff departure; better, use WPA2/3-Enterprise and skip PSKs entirely
- **VPN pre-shared keys and certs** — store in an HSM or secure vault, never in config backups checked into Git

*The breach you'll read about next year started with a private key committed to a public repo in 2019. Key management is boring. Boring is what keeps you employed.*

### CompTIA exam traps

> **Trap:** MAC filtering vs. 802.1X — MAC filtering is L2 allow-listing, easily bypassed by spoofing. 802.1X is authenticated port access using EAP and RADIUS. When CompTIA asks "strongest control to prevent unauthorized devices," the answer is **802.1X**.

> **Trap:** Screened subnet vs. internal VLAN — public-facing services go in the **screened subnet**. Internal services (file, AD) stay on internal VLANs. Putting your file server in the screened subnet is the wrong answer every time.

> **Trap:** ACL implicit deny — if no rule matches, traffic is denied. CompTIA will show an ACL with only `permit` statements and ask why legitimate traffic is being dropped. Answer: it didn't match any permit and hit the implicit deny.

## Helpdesk reality

- **User says:** "I plugged in my laptop in the conference room and there's no internet." **Tech checks:** port security violation log on the switch. Port shut down because the MAC didn't match the sticky-learned one. Fix: re-enable, document, decide if policy needs to change.
- **User says:** "I can't get to [site] from work but I can from home." **Tech checks:** URL filter category. Site is flagged "social media" or "uncategorized." Escalate to security for business justification, don't promise an unblock.
- **User says:** "The new laptop won't connect to Wi-Fi." **Tech checks:** 802.1X supplicant config and machine certificate. Nine times out of ten the cert didn't push from MDM, or the user account isn't in the right RADIUS group.
- **Never promise:** "I'll just open the firewall for you." Firewall changes are change-managed. You don't punch holes for one user's convenience.
- **Escalation point:** if a device fails NAC posture and the user needs access *now*, the answer is remediate, not bypass. Bypass is a security-team decision with a paper trail, not a helpdesk one.

## Related concepts

[[Firewalls]] · [[VLANs]] · [[802.1X]] · [[NAC]] · [[RADIUS]] · [[Screened subnet]] · [[ACL]] · [[Port security]] · [[Zero Trust]] · [[Defense in depth]] · [[Change management]] · [[Network segmentation]]

*Source: VIRGIL knowledge base — 2026-05-11*