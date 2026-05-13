# Security Rules

## What it is

In **Doom (2016)**, the Mars facility runs on a rigid access hierarchy. Praetor Suit tokens unlock specific doors. Yellow keycards open yellow doors. Blue keycards open blue doors. UAC security clearances gate elevators and lab sectors. Olivia Pierce has admin access everywhere; a janitor possessed by a Hell Knight does not. When the breach happens, the demons don't politely scan their badges — they pour through every door someone left propped open with a chair. Every unlocked terminal, every disabled turret, every "we'll fix that later" service running on a forgotten console is an entry point. The Slayer wins because he understands the layout and exploits exactly those gaps.

That's exactly what **security rules** are — the documented, enforced decisions about who gets to talk to what on your network, on which port, from where, and under what conditions. Everything else gets dropped.

In CompTIA N10-009 language: security rules are the collection of configuration policies — ACLs, port security, NAC, MAC filtering, 802.1X, content filtering, zone definitions, and hardening baselines — that together enforce **least privilege** at the network layer. Rules are explicit. Defaults are deny. Exceptions are documented.

## Why it matters

Every breach starts at a rule that wasn't written, wasn't enforced, or was written and then forgotten. The CompTIA exam tests this domain heavily because it's where junior network techs get fired. You'll get asked which control stops a rogue laptop in a conference room jack (port security or 802.1X), which control stops a user from reaching gambling sites (content/URL filtering), and which device sits between trusted and untrusted zones (firewall on a screened subnet).

Objective 4.3 expects you to read a scenario and pick the right control. Not the coolest control. The right one. *A firewall is not an IDS, a VPN is not zero trust, and MAC filtering is not authentication — it's a speed bump for the lazy.*

## Key facts

### Trusted vs. untrusted zones

The whole model rests on this. You divide the network into zones based on how much you trust the traffic and the hosts.

| Zone | Trust level | Examples |
|---|---|---|
| **Trusted (internal)** | High | Corporate LAN, internal servers, employee VLANs |
| **Untrusted (external)** | None | The internet, guest Wi-Fi, partner networks |
| **Screened subnet (DMZ)** | Medium | Public web servers, mail relays, reverse proxies |

The **screened subnet** — CompTIA's preferred term, the old name was DMZ — is the demilitarized strip between trusted and untrusted. Public-facing services live there. If the web server gets popped, the attacker is stuck in the screened subnet and still has to break through a second firewall to reach the internal network.

> **CompTIA exam trap:** the exam uses "screened subnet" not "DMZ." If you see DMZ in a question, it means the same thing, but the correct answer choice will likely be worded "screened subnet." Two firewalls flank it — one facing the internet, one facing the LAN.

### Access control lists (ACLs)

An ACL is an ordered list of permit/deny rules evaluated top-down. First match wins. Implicit deny at the bottom catches anything not explicitly permitted.

```
permit tcp any host 10.1.1.10 eq 443
permit tcp 10.0.0.0/24 host 10.1.1.10 eq 22
deny   ip any any
```

Rules can match on source IP, destination IP, protocol, port, and direction (inbound/outbound on an interface). ACLs run on routers, layer-3 switches, and firewalls. The exam loves the ordering trick:

> **CompTIA exam trap:** ACL order matters. A `permit ip any any` at line 10 makes every `deny` after it useless — because the permit fires first and the packet is already gone. Specific rules go on top. Broad rules go on bottom. Implicit deny is always last.

### Device hardening

Hardening is the process of reducing a device's attack surface before it ever sees production traffic.

- **Change default passwords.** `admin/admin` is how botnets are built. Shodan indexes every device still running factory creds.
- **Disable unused ports and services.** Telnet, HTTP management, SNMPv1, unused switchports — turn them off. If a service isn't running, it can't be exploited.
- **Update firmware** on a schedule. Out-of-date IOS, FortiOS, or Junos is an open invitation.
- **Use SSH, not Telnet. Use HTTPS, not HTTP. Use SNMPv3, not v1/v2c.** Encryption and authentication, not plaintext.
- **Limit management access** to a dedicated management VLAN or out-of-band network. The web GUI of your core switch should not be reachable from the guest Wi-Fi.

*The single highest-ROI security action you can take on any network is walking through your switches and shutting down every port that isn't actively in use.*

### Port security (switchport-level)

Port security restricts which devices can use a physical switchport. Configured on the switch:

- **Maximum MAC addresses per port** — usually 1 or 2 (host + VoIP phone)
- **Sticky MAC** — switch learns the first MAC it sees and pins the port to it
- **Violation action** — `shutdown` (port goes err-disabled), `restrict` (drop + log), or `protect` (drop silently)

Useful in conference rooms and lobbies where someone could plug in an unknown laptop. Defeated trivially by anyone who clones a known MAC, which is why port security alone is not authentication.

### MAC filtering

MAC filtering maintains an allow-list of MAC addresses permitted on a network or wireless SSID. Sounds great. Isn't.

MAC addresses are sent in cleartext in every frame. Anyone running Wireshark for 30 seconds in a coffee shop has a list of valid MACs. Spoofing a MAC is a one-line command on Linux. MAC filtering is a speed bump, not a wall. It belongs in the "defense in depth" pile, not the "this is my authentication mechanism" pile.

> **CompTIA exam trap:** MAC filtering is NOT authentication. If a question asks for strong device authentication on a wired or wireless network, the answer is **802.1X** with certificates or EAP-TLS — not MAC filtering. MAC filtering is an access control supplement.

### 802.1X (port-based network access control)

This is the real authentication mechanism. 802.1X is the IEEE standard for port-based NAC. Three actors:

| Role | Who | What |
|---|---|---|
| **Supplicant** | The client device | Sends credentials |
| **Authenticator** | The switch or WAP | Gates the port, relays auth |
| **Authentication server** | RADIUS (often with AD or a CA) | Decides yes/no |

Until 802.1X authentication succeeds, the switchport passes only EAPOL frames — nothing else. No DHCP, no ARP, no traffic. Once the user/device authenticates (commonly via EAP-TLS certificates or PEAP-MSCHAPv2 with credentials), the port is unlocked and may be dynamically assigned to a VLAN based on identity.

This is how enterprises do "plug in anywhere and you land in the right VLAN." Finance laptop gets the finance VLAN. Contractor laptop gets the contractor VLAN. Unrecognized device gets the quarantine VLAN — or nothing at all.

### Network Access Control (NAC)

NAC is the broader architecture that 802.1X often implements. NAC asks two questions before letting a device on:

1. **Who are you?** (authentication — 802.1X, certificates, credentials)
2. **Are you healthy?** (posture check — patched OS, AV running, disk encrypted, no missing updates)

A device that authenticates but fails posture goes to a **remediation VLAN** where it can reach the patch server and nothing else. Once healthy, it gets promoted to the production VLAN. This is how zero-trust ideas show up at the network edge.

### Content filtering and URL filtering

Different layers, related goals.

- **URL filtering** blocks or allows specific URLs and domains. `facebook.com` blocked during work hours. `malware-c2-domain.ru` blocked always. Implemented on the firewall, web proxy, or DNS filter.
- **Content filtering** inspects the actual payload — categories like "gambling," "adult," "social media," "weapons," "known malware." Uses category databases that update constantly.

These overlap. A modern next-gen firewall does both. The distinction the exam wants: URL filtering is destination-based; content filtering is category- and payload-based.

### Key management

Encryption is only as good as the keys behind it. Key management covers generation, distribution, rotation, storage, and destruction of cryptographic keys — PSKs, certificates, RADIUS shared secrets, VPN keys, SSH host keys.

- Don't email private keys
- Don't reuse the same PSK on every site
- Rotate keys when employees with access leave
- Store keys in an HSM or vault, not a text file on the admin's desktop
- Certificate lifecycles need monitoring — *the most common production outage from "encryption" is an expired cert nobody renewed*

### Security rules — putting it together

A security rule isn't one technology. It's the documented intersection of: which zone, which device, which protocol, which port, which direction, which user/group, under what condition. A complete ruleset answers every one of those for every flow on your network. Anything not answered is implicit deny.

## Helpdesk reality

- User: *"I plugged my laptop into the conference room jack and the internet isn't working."* — Port security may have shut the port, or 802.1X is rejecting the device. Check switchport status (`show interface status` — look for `err-disabled`). Personal laptops on a corporate 802.1X network get rejected by design; this is not a bug.
- User: *"The website I need for work is blocked."* — Content filter category. Submit a category exception through proper channels. Never disable the filter "just for them."
- User: *"I changed offices and now my desk phone won't register."* — New port might not be configured for the voice VLAN, or port security pinned to the old phone's MAC. Switchport config is the first check.
- Never promise: that disabling MAC filtering or relaxing an ACL "just temporarily" will be safe. Temporary holes become permanent holes. *Every "temporary" ACL exception I've seen in production has outlived the person who requested it.*
- Escalation: if rule changes are needed on a firewall, core ACL, or NAC policy, that's a change-management ticket, not a helpdesk fix. Document the request, route it to network security.

## Related concepts

[[Firewalls]] · [[VLANs]] · [[Zero Trust]] · [[RADIUS and TACACS+]] · [[VPN]] · [[Network Segmentation]] · [[Defense in Depth]] · [[Intrusion Detection and Prevention]] · [[Authentication Authorization Accounting]] · [[Wireless Security]] · [[Screened Subnet]] · [[OSI Model]]

*Source: VIRGIL knowledge base — 2026-05-11*