# Network Solutions

## What it is

In **Valorant**, the moment you queue ranked, Vanguard is already inspecting your kernel, Riot's matchmaker is validating your account, your input is being checked against server-side movement bounds, and the agent select screen locks you out of picks your team already took. Every layer is doing a different job — anti-cheat at the OS, authentication at the login, validation at the server, access control at the lobby. No single check defends the match. They stack. That's exactly what network security solutions do — defense in depth, built from a stack of independent controls so that any one failure doesn't open the whole map.

**Network security solutions** are the configured controls on switches, routers, firewalls, and endpoints that enforce who can connect, what they can reach, and what traffic is allowed once they're on. Not a product. A discipline. Objective 4.3 is the catalog of techniques you're expected to recognize, configure, and pick between under pressure.

## Why it matters

Every breach post-mortem you'll read names at least one of these controls as missing or misconfigured. Default admin password on the edge router. No 802.1X on the conference room jacks. Flat network, no zones, ransomware walks from reception to the domain controller in 40 minutes. CompTIA crams a dozen distinct controls into one bullet because in production you apply them all at once.

This is the section that separates the helpdesk tech who resets passwords from the network admin who owns the firewall. Knowing the difference between an ACL, MAC filtering, and 802.1X is the difference between "we have security" and *security*.

## Key facts

### Device hardening

Every switch, router, firewall, AP, and server ships in a permissive default state because the vendor wants it to work out of the box. Your job is to lock it down.

- **Change default passwords** — every device, every account. Shodan indexes devices with default creds. *If you remember one thing from this objective, remember this one.*
- **Disable unused ports and services** — Telnet off, HTTP off (HTTPS only), SNMPv1/v2c off (SNMPv3 only), unused switchports administratively shut down.
- **Patch firmware** — unpatched CVEs are how Mirai built a botnet of 600,000 cameras.
- **Restrict management access** — management VLAN, ACL on the VTY lines, SSH keys instead of passwords where possible.
- **Central syslog** — if you can't see it, you can't investigate it.

### Zones — trusted vs. untrusted

A **zone** is a logical grouping of interfaces with a shared trust level. The firewall enforces policy *between* zones.

| Zone | Trust | Example contents |
|------|-------|------------------|
| Trusted (inside) | High | Corporate LAN, user VLANs, internal servers |
| Untrusted (outside) | None | The internet, anything you don't own |
| DMZ / screened subnet | Medium | Public-facing web servers, mail relays, reverse proxies |
| Guest | Low | BYOD Wi-Fi, contractor VLAN |

Rule of thumb: traffic from a lower-trust zone to a higher-trust zone is denied by default. Trusted to untrusted is allowed (with inspection). Untrusted to trusted is dropped unless explicitly permitted.

### Screened subnet (DMZ)

A **screened subnet** is the network segment between two firewalls (or two interfaces of one firewall) where you put servers that the public internet needs to reach. Web server, mail server, public DNS, reverse proxy.

If the public web server gets popped, the attacker is in the screened subnet — not in your internal LAN. The second firewall stops lateral movement to the [[Active Directory]] domain controller. *A web server in your trusted zone is a breach waiting to be backdated.*

CompTIA still uses "screened subnet" because "DMZ" is being phased out. Know both. Same thing.

### Security rules and ACLs

An **Access Control List (ACL)** is an ordered list of permit/deny statements evaluated top-down. First match wins. Implicit deny at the bottom.

ACLs live on routers (L3 between subnets), switches (VLAN ACLs, port ACLs), and firewalls (the ruleset *is* an ACL with stateful inspection bolted on).

A typical entry: `permit tcp any host 10.0.0.50 eq 443`. Allow any source to reach 10.0.0.50 on TCP 443. Everything not explicitly permitted is denied.

Order matters. A `permit any any` at line 10 makes lines 11+ unreachable. *I have spent two hours debugging a "broken" ACL that worked exactly as written — the rule above mine was eating the traffic.*

### Network Access Control (NAC) and 802.1X

**NAC** answers: *should this device be on the network at all?* It checks posture before granting access — is the OS patched, is AV running, is the device domain-joined, is the cert valid.

**802.1X** is the port-based authentication protocol NAC rides on. Three roles:

| Role | What it is |
|------|------------|
| Supplicant | The device trying to connect (laptop, phone) |
| Authenticator | The switch or AP the device plugs into |
| Authentication server | RADIUS server (often tied to AD) that says yes/no |

The flow: device plugs in → switch port is unauthorized, only EAPOL allowed → supplicant sends credentials/cert → switch relays to RADIUS → RADIUS validates → switch opens the port and (often) assigns a VLAN dynamically.

802.1X is how enterprises stop the "I plugged my personal laptop into the conference room and got an IP" attack. *Without 802.1X, every Ethernet jack in your building is a free network port for anyone who walks in.*

### MAC filtering

The switch maintains a list of permitted MAC addresses per port. Unknown MAC → port shuts down or traffic is dropped.

**Useful for:** IoT segments, OT/SCADA networks where devices are static and known.
**Useless for:** general user access. MAC addresses are trivially spoofed — `ip link set dev eth0 address aa:bb:cc:dd:ee:ff` and you're someone else.

CompTIA offers MAC filtering as a wrong answer to "how do you stop unauthorized devices on the corporate LAN." The right answer is 802.1X. MAC filtering is a speed bump, not a wall.

### Port security

Different from MAC filtering — port security limits *how many* MAC addresses can be learned on a single port, and what happens when the limit is exceeded.

Three violation modes:
- **Protect** — drop violating traffic, no log
- **Restrict** — drop, log, increment counter
- **Shutdown** — err-disable the port (default, loudest)

Classic use case: stop someone from plugging a rogue switch into a wall port and connecting five devices where there should be one. Set `switchport port-security maximum 1` and the first unauthorized device trips err-disable.

### Content filtering and URL filtering

**URL filtering** inspects HTTP/HTTPS destinations and blocks by category — gambling, adult, malware, social media.

**Content filtering** is broader — payload inspection, file-type blocking, keyword filtering, SSL/TLS decryption for inspection.

Lives on next-gen firewalls (NGFW), web proxies (Squid, Zscaler, Cisco Umbrella), or DNS-layer filtering (block the lookup before the connection even forms).

Compliance angle: schools filter under CIPA, healthcare under HIPAA-adjacent rules, finance under various regs. Career angle: this is one of the first tickets you'll touch as a junior — *"the website I need for work is blocked, can you whitelist it."*

### Key management

Encryption is only as good as the keys. **Key management** is the lifecycle: generation, distribution, storage, rotation, revocation, destruction.

Where it shows up on Net+:
- **PKI** — CA issues certs, devices trust the CA, certs expire and rotate
- **HSM** — tamper-resistant device that stores private keys and performs crypto without the keys ever leaving
- **IPsec / VPN pre-shared keys** — rotate them, don't hardcode them in scripts committed to GitHub
- **WPA3-Enterprise** — 802.1X with per-session keys instead of a single PSK
- **SSH keys** — better than passwords, but unmanaged SSH keys are how ex-employees still have root on production

The expired-cert outage is a rite of passage. *Calendar your cert expirations. The cert that crashed production on Sunday morning is the one you forgot to track.*

### CompTIA exam traps

> **CompTIA exam trap:** MAC filtering vs. 802.1X — both control device access, but MAC filtering is trivially defeated by spoofing and CompTIA knows it. If the question mentions "strong" or "enterprise" or "prevent unauthorized devices," the answer is 802.1X. MAC filtering is only correct when the threat model is explicitly "casual" or "low-cost" or describes an IoT/OT scenario.

> **CompTIA exam trap:** Screened subnet vs. internal network — public-facing servers go in the screened subnet, not the trusted LAN. If the question describes a web server reachable from the internet sitting on the same VLAN as workstations, the answer is "move it to a screened subnet."

> **CompTIA exam trap:** Port security ≠ MAC filtering. Port security limits the *count* of MACs per port. MAC filtering allows/denies based on a *list* of MACs. CompTIA will offer both as options.

> **CompTIA exam trap:** ACLs are top-down, first-match-wins, with an implicit deny. A rule list showing `permit any any` near the top means everything below it is dead code.

## Helpdesk reality

- User says: *"I plugged in my laptop and the port doesn't work."* Check: is 802.1X enabled, does the laptop have the cert/credentials, is the port err-disabled from a port-security violation. Link light amber, not green — that's your tell.
- User says: *"This website is blocked, I need it for work."* You don't unblock it. File the URL filtering exception ticket with the user's manager CC'd. Never promise same-day — content filter changes go through change management.
- User says: *"My VPN cert expired."* Re-enroll them in PKI. Also check the cert template — if this is happening to everyone, the lifetime is too short or auto-renewal is broken.
- Never promise a firewall rule change is instant. The change board exists for a reason. *The fastest way to take down production is to "just quickly" add a rule on a Friday afternoon.*
- Escalation: if 802.1X is denying a device that should be allowed and RADIUS logs show "user not found" or "cert untrusted," it's a network/identity team ticket. Don't bypass by removing 802.1X from the port — that's how audit findings happen.

## Related concepts

[[Firewalls]] · [[VLAN]] · [[RADIUS]] · [[TACACS+]] · [[802.1X]] · [[PKI]] · [[VPN]] · [[Zero Trust]] · [[Defense in Depth]] · [[Network Segmentation]] · [[NGFW]] · [[Proxy Server]] · [[DMZ]] · [[Active Directory]] · [[Change Management]]

*Source: VIRGIL knowledge base — 2026-05-11*