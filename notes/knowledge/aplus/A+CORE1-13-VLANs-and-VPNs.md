# VLANs and VPNs

## What it is

You bought a 24-port managed switch off eBay for the homelab. Plug everything in and every device — your gaming PC, your kid's tablet, the IoT camera, the Plex server, the work laptop — sits on the same flat network. The IoT camera can talk to your work laptop. That's a problem.

A **VLAN (Virtual LAN)** carves one physical switch into multiple logical networks. Same hardware, same cables, but the switch tags traffic so devices on VLAN 10 can't see devices on VLAN 20 without a router deciding to allow it. Network segmentation without buying more switches.

A **VPN (Virtual Private Network)** does the opposite trick. It takes two networks separated by the public internet and makes them feel like one. Your laptop at the coffee shop builds an encrypted tunnel to the office network, gets an internal IP, and behaves as if it's plugged into the wall jack at your desk.

Both are *virtual* — no new copper, no new fiber. Software draws the boundaries.

The machine-as-body frame: VLANs are the **immune system's compartments** — keeping the IoT cameras quarantined from the file server. VPNs are the **encrypted voice** — your laptop calling home through a public, hostile environment without anyone overhearing.

## Why it matters

VLANs and VPNs are how real networks are actually built. Every office, every campus, every datacenter runs segmented VLANs. Every remote worker connects over VPN. If you can't explain both fluently in a job interview, you're not getting the job.

Exam-relevant: **CompTIA 220-1201 Objective 2.4** lists VLAN and VPN as required network config concepts. Core 2 Objective 2.9 revisits VPN under secure remote access. You'll see both on both exams.

Career-relevant: the first time you trace a connectivity issue at a real job, you'll discover the user is on the wrong VLAN, or their VPN client is dropping the tunnel every 90 seconds, or DNS is failing because the VPN didn't push the right resolver. This is daily work.

## In your build, in the enterprise

**Beat 1 — Technical depth.**

VLANs operate at Layer 2. The standard is **IEEE 802.1Q**, which adds a 4-byte tag to the Ethernet frame containing a 12-bit VLAN ID (1–4094 usable). A switch port is either an **access port** (untagged, belongs to one VLAN) or a **trunk port** (tagged, carries multiple VLANs between switches or to a router). The **native VLAN** on a trunk is the one untagged frames belong to — usually VLAN 1, and you should change that for security. Inter-VLAN routing requires a Layer 3 device — a router, a Layer 3 switch, or a "router-on-a-stick" config where one trunk link to a router handles all VLAN routing.

VPNs come in flavors. **Site-to-site VPN** connects two networks permanently — branch office to HQ — usually IPsec tunnels between firewalls. **Client-to-site (remote access) VPN** is what end users run: a client app on the laptop builds a tunnel to a VPN concentrator. Common protocols: **IPsec** (IKEv2), **SSL/TLS VPN** (OpenVPN, AnyConnect), and **WireGuard** (modern, fast, lean). **Split tunnel** sends only corporate traffic through the tunnel; **full tunnel** sends everything, including your YouTube traffic, through the office. Full tunnel is more secure and slower.

**Beat 2 — Feynman example via homelab.**

You're building out the homelab on a Ubiquiti switch and a pfSense box. Here's the segmentation that actually matters:

**VLAN 10 — Trusted.** Your gaming PC, your laptop, the NAS. Full internet, full inter-device access. *This is the network you trust.*

**VLAN 20 — IoT.** The smart bulbs, the camera, the robot vacuum, the smart TV that phones home to six analytics servers a minute. Internet access yes, talking to VLAN 10 no. *Quarantine the chatty garbage.*

**VLAN 30 — Guest.** Friend comes over for a LAN party, gets the guest SSID, lands on VLAN 30. Internet only, can't see your NAS, can't see the printer, can't see anything. *Hospitality without exposure.*

**VLAN 40 — Lab.** Where you run vulnerable VMs, test malware samples, spin up the deliberately-broken DVWA box. Firewalled hard from everything else. *Where things are allowed to be on fire.*

The trunk port from the switch to the pfSense box carries all four tagged. pfSense does inter-VLAN routing and enforces firewall rules between them. *One switch, four networks, zero extra hardware.*

**Beat 3 — Bridge from homelab to enterprise.**

Same question — "who should be able to talk to whom?" — scaled up:

- **Homelab:** 4 VLANs, one pfSense box, you're the admin.
- **Small office:** 8–12 VLANs (users, voice/VoIP, printers, servers, guest, management, IoT, security cameras), a Layer 3 switch handling routing, ACLs between VLANs.
- **Enterprise:** hundreds of VLANs, often segmented per department, per building, per security zone. Voice gets its own VLAN with QoS priority. Servers live in DMZ VLANs. The management VLAN is locked down so only IT workstations can reach switch admin interfaces. Inter-VLAN traffic goes through internal firewalls, not just routers.

Same VPN question scales the same way:

- **Homelab:** WireGuard on the pfSense box, you connect from your phone to access Plex from a hotel.
- **Small office:** OpenVPN on the firewall, 20 employees connect from home.
- **Enterprise:** redundant VPN concentrators, SSO integration, MFA enforced, posture checks (is your laptop patched? Is the AV running?), conditional access policies.

**Beat 4 — The point.**

Same fundamental questions — *who can reach what, and how do remote users get in safely* — different scales, different right answers. *Get these questions into your bones. You'll ask them every day for the rest of your career.*

## Key facts

### VLAN essentials

| Concept | Detail |
|---|---|
| Standard | IEEE 802.1Q |
| VLAN ID range | 1–4094 (VLAN 1 is default, avoid for production) |
| Tag size | 4 bytes added to Ethernet frame |
| Access port | Untagged, single VLAN, end device |
| Trunk port | Tagged, multiple VLANs, switch-to-switch or switch-to-router |
| Native VLAN | Untagged VLAN on a trunk link |
| Inter-VLAN routing | Requires Layer 3 device |

### VPN types and protocols

| Type | Use case |
|---|---|
| Site-to-site | Branch office ↔ HQ, always-on tunnel between firewalls |
| Client-to-site | End-user remote access from laptop |
| Split tunnel | Only corporate traffic in tunnel, rest goes direct |
| Full tunnel | All traffic through the tunnel, more secure, slower |

| Protocol | Notes |
|---|---|
| IPsec (IKEv2) | Industry standard, often site-to-site |
| SSL/TLS VPN | Browser-friendly, OpenVPN, AnyConnect |
| WireGuard | Modern, fast, simple config, growing fast |
| L2TP/IPsec | Older, still seen on legacy gear |
| PPTP | Dead. Broken crypto. Never deploy. |

### DHCP — the support cast

VLANs and VPNs both depend on **DHCP** to actually hand out IPs once a device lands on a network. Worth knowing the vocabulary cold:

| Term | Meaning |
|---|---|
| **Scope** | The range of IPs the DHCP server is allowed to hand out on a given subnet (e.g., 192.168.10.100–192.168.10.250) |
| **Lease** | The time-bounded assignment — device gets IP for X hours/days, then must renew |
| **Reservation** | A specific MAC address always gets the same IP from the scope (printer, server, NAS) |
| **Exclusion** | IPs inside the scope range that DHCP must not hand out (used for static-IP devices) |

In a multi-VLAN setup, each VLAN typically has its own DHCP scope, and the router/firewall acts as a **DHCP relay** to forward requests to a central DHCP server. *One DHCP server, many VLANs.*

### DNS — the other support cast

Once you have an IP, you need names. **DNS** translates `plex.lab.local` to `192.168.10.50`. Records you must know for the exam:

| Record | Purpose |
|---|---|
| **A** | Hostname → IPv4 address |
| **AAAA** | Hostname → IPv6 address |
| **CNAME** | Alias — one hostname points to another |
| **MX** | Mail exchanger — where email for this domain goes |
| **TXT** | Arbitrary text — used for SPF, DKIM, DMARC, domain verification |

Email security records all live as TXT records:

- **SPF (Sender Policy Framework)** — lists which servers are allowed to send mail for this domain
- **DKIM (DomainKeys Identified Mail)** — cryptographic signature proving the mail wasn't tampered with
- **DMARC (Domain-based Message Authentication, Reporting, and Conformance)** — tells receiving servers what to do when SPF/DKIM fail (reject, quarantine, allow), and where to send reports

*All three together = spam and spoofing defense.* Miss one and your domain becomes a forgery target.

### CompTIA exam traps

> **CompTIA exam trap:** VLAN ≠ subnet. They usually overlap one-to-one (VLAN 10 = 192.168.10.0/24), but VLAN is Layer 2, subnet is Layer 3. Two different concepts. The exam will test whether you know the distinction.

> **CompTIA exam trap:** Trunk vs access port. An access port carries one untagged VLAN to an end device. A trunk port carries multiple tagged VLANs between switches. Plugging a laptop into a trunk port is a misconfiguration.

> **CompTIA exam trap:** VPN encrypts traffic in transit, not at rest. A VPN protects your data while it's traveling between your laptop and the VPN concentrator. Once it leaves the concentrator and hits the internal network, it's whatever the internal network is. VPN is not a magic security blanket.

> **CompTIA exam trap:** DHCP reservation vs static IP. Reservation: DHCP server always gives this MAC the same IP. Static: the device is configured manually with no DHCP involvement. Reservations are managed centrally — preferred. Statics are set on the device — risky and easy to forget.

> **CompTIA exam trap:** SPF, DKIM, DMARC are all **TXT records**. Don't pick "MX" for SPF. MX is where mail goes. TXT is where the auth policies live.

## Helpdesk reality

- "The VPN keeps disconnecting." Usually one of three things: flaky home Wi-Fi, the user's ISP is blocking the VPN protocol, or the corporate VPN concentrator is overloaded. Check the client logs first, then escalate if it's a concentrator issue.
- "I'm on the VPN but I can't reach the file server." Probably split-tunnel config not pushing the right routes, or DNS isn't resolving the internal hostname because the VPN client didn't pick up the corporate DNS server.
- "The new IoT thermostat works on my home network but not at the office." It's on the user VLAN. It needs to be on the IoT VLAN. Or, more likely, it shouldn't be on the corporate network at all — explain that politely.
- "Can I use my personal VPN at work?" That's a policy question, not a technical one. Escalate to security/management. Personal VPNs bypass corporate monitoring and DLP — most orgs forbid them.
- Never promise a user that VPN makes them "untraceable" or "anonymous." It doesn't. It encrypts the tunnel. The exit point still sees the traffic.

## Related concepts

[[IP Addressing and Subnetting]] · [[DNS Records]] · [[DHCP]] · [[Network Cabling and Connectors]] · [[SOHO Router Configuration]] · [[Firewalls]] · [[Remote Access]] · [[Network Topologies]] · [[Wireless Security]]

*Source: VIRGIL knowledge base — 2026-05-10*