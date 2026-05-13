# Network Redundancy

## What it is

In **Minecraft**, you don't put the End Portal frame, the beacon, and the storage room all in the same chunk above the same lava pool. You build the nether hub with two routes home. You keep a backup bed. You park a second elytra in an ender chest. Veteran SMP players don't ask *if* something will despawn, burn, or get griefed — they assume it will, and they pre-stage the second copy.

That's redundancy. Plus, despite the objective title, this note's actual N10-009 lane is *how you reach the redundant gear when the primary path is on fire* — secure remote management, VPNs, jump boxes, out-of-band consoles. The exam frames it under **Objective 3.5: network access and management methods**, because there's no point having a redundant router if you can't log in to fail over to it.

**Technical definition:** Network redundancy is the duplication of components, paths, and management channels so that a single failure does not cause an outage. The management side — covered here — is the set of access methods (in-band, out-of-band, VPN, console, API, jump host) that let an admin reach a device whether the production network is healthy or actively burning down.

## Why it matters

When the primary link drops, you don't get to drive to the data center. You SSH in. If the SSH path is *through* the dead link, congratulations — you just bought a plane ticket. Every senior network engineer has a story about an outage that lasted six extra hours because the [[out-of-band management]] path was never tested, or the [[jump box]] credentials expired, or the [[VPN concentrator]] was on the wrong side of the failure.

Net+ tests this because it separates people who think "the network is a diagram" from people who think "the network is a thing that breaks at 3am and I need a way in."

## Key facts

### In-band vs. out-of-band management

| | **In-band** | **Out-of-band (OOB)** |
|---|---|---|
| Path | Through the production network | Separate, dedicated channel |
| Examples | SSH over the LAN, HTTPS to mgmt IP | Console cable, cellular modem on mgmt port |
| Cost | Free, already built | Extra hardware, extra circuit |
| Survives a production outage? | No | Yes |
| Survives a black-holing misconfig? | No | Yes |

**In-band** is SSH or HTTPS to the device's management IP over the regular network. Cheap. Dies the moment the path dies.

**Out-of-band** is the parachute. Common implementations:
- **Console server** — a box in the rack with serial cables fanned out to every device, reachable over a separate mgmt network or 4G/LTE uplink.
- **Dedicated management port** — iDRAC, iLO, IPMI on servers; mgmt VRF on enterprise switches.
- **Cellular failover modem** so even if the ISP is down, you have a path.

> **CompTIA exam trap:** "Out-of-band" doesn't mean "different protocol." It means **different physical or logical path**. SSH'ing to a switch over a dedicated management VLAN that still rides the same uplink is *not* truly out-of-band. True OOB has its own circuit.

*Build the OOB before you need it. Test it quarterly. The first time you try the cellular console server should not be during an outage.*

### Console access

The **console port** is the rollback to bedrock. Serial cable — USB-to-serial on a laptop these days — directly into the device. No IP stack required. The device could have zero configuration and you can still get in.

- Default settings on most enterprise gear: **9600 baud, 8N1**, no flow control.
- Works even with no IP, wrong IP, or a broken config.
- Requires physical presence — or a **console server** that aggregates console ports over IP/cellular.

*The console port has saved more careers than any monitoring tool. Learn it.*

### SSH vs. Telnet

[[SSH]] is the standard for in-band CLI management. **Port 22/TCP.** Encrypted, authenticated, replaced Telnet (port 23, plaintext, never use, exam will ask).

| Feature | SSH | Telnet |
|---|---|---|
| Port | 22/TCP | 23/TCP |
| Encryption | Yes | No |
| Auth | Keys or password | Password (plaintext) |
| Production-acceptable? | Yes | Never |

Key-based auth beats password auth — no password to phish. SSH also supports port forwarding for reaching a device behind a jump host.

### GUI and API

- **HTTP (80)** — plaintext, never expose. Exam expects you to know it exists.
- **HTTPS (443)** — the only acceptable web mgmt protocol.
- GUIs are slower for bulk work but better for discovery and visualization. Senior admins still live in the CLI.

The [[API]] is how you manage networks at scale. Instead of clicking 200 switches, you POST JSON to a controller. **REST APIs over HTTPS (443)** are the standard, used in SDN controllers (Cisco DNA, Meraki, Aruba Central), cloud network management, and automation tooling (Ansible, Terraform). Auth uses **tokens or API keys** — scoped, revocable, logged.

### VPN — site-to-site vs. client-to-site

[[VPN]]s are how you reach private network resources from outside. Two flavors:

**Site-to-site VPN** — connects two networks (branch-to-HQ, on-prem-to-AWS). Tunnel built between two VPN gateways. End users don't run anything; their traffic just routes into the tunnel.
- Protocol: **IPsec** (most common)
- Always-on, persistent
- Looks like a leased line, costs a fraction

**Client-to-site VPN** (remote-access) — connects one user to a network. The user runs a VPN client (AnyConnect, GlobalProtect, WireGuard) that builds a tunnel to the corporate concentrator.
- Protocols: **IPsec, SSL/TLS VPN, WireGuard**
- On-demand, per-user, ties to AD / SSO / MFA

**Clientless VPN** — user hits an HTTPS portal, no software install. Browser becomes the VPN client. Limited to web apps and a few proxied protocols. Useful for contractors and BYOD.

> **CompTIA exam trap:** "Clientless" doesn't mean "no authentication" or "no encryption." It means **no fat client installed** — the browser does the work over TLS.

### Split tunnel vs. full tunnel

When a remote user connects via client-to-site VPN, where does their *non-corporate* traffic go?

| | **Full tunnel** | **Split tunnel** |
|---|---|---|
| Corporate traffic | Through VPN | Through VPN |
| Internet traffic | Through VPN, out corporate edge | Direct to internet |
| Security visibility | Full — every packet inspected | Partial |
| Bandwidth on corporate edge | High | Low |
| User experience | Slower (hairpins) | Faster |

**Full tunnel** = corporate firewall sees everything, can apply DLP and content filtering. Cost: every YouTube video eats your corporate pipe.

**Split tunnel** = faster and cheaper but you lose visibility. Compromised endpoint? You won't see the C2 beacon if it's going to a public IP outside the tunnel.

*Most enterprises picked split tunnel during COVID and never went back. Zero-trust models lean back toward full tunnel + endpoint inspection.*

### Jump box / bastion host

A [[jump box]] is a hardened intermediate server that admins SSH into *first* before reaching internal systems. Internal systems are not reachable directly from outside.

```
Admin laptop → VPN → Jump box → Production switches/servers
```

Why bother?
- **Single chokepoint** for logging, MFA, session recording
- **Reduced attack surface** — internal systems don't need internet-facing SSH
- **Audit trail** — every admin session goes through one box that logs everything

The jump box should be hardened (minimal services, MFA-required), logged (every command, ideally session-recorded), and firewall-restricted to only the mgmt subnets it needs.

> **CompTIA exam trap:** A jump box is **not a VPN replacement** — it's usually *behind* the VPN. The VPN gets you onto the management network; the jump box gets you onto the production devices. Defense in depth means both.

## Connection methods — the full menu

| Method | Use case | Port/Protocol |
|---|---|---|
| **Console (serial)** | Last-resort OOB, initial config | 9600 8N1 |
| **SSH** | Standard in-band CLI | 22/TCP |
| **Telnet** | Never (legacy, plaintext) | 23/TCP |
| **HTTPS GUI** | Web mgmt | 443/TCP |
| **API (REST)** | Automation, SDN | 443/TCP |
| **Site-to-site VPN** | Branch-to-HQ, on-prem-to-cloud | IPsec (UDP 500, 4500, ESP) |
| **Client-to-site VPN** | Remote user access | IPsec or TLS (443) |
| **Clientless VPN** | Browser-based remote access | HTTPS (443) |
| **Jump box** | Hardened intermediate access | SSH (22) inbound, then onward |
| **OOB console server** | Mgmt during outages | Often cellular + SSH |

## Helpdesk reality

- User says: *"My VPN is connected but I can't reach the file server."* — Check split vs. full tunnel first. The file server might be on a subnet the VPN client doesn't have a route to. `route print` (Windows) or `netstat -rn` (macOS/Linux) shows what the VPN pushed.
- User says: *"VPN keeps disconnecting."* — UDP 500/4500 blocked by hotel Wi-Fi, NAT timeout on their home router, or MTU mismatch. TLS-based VPN over 443 usually punches through where IPsec fails.
- User says: *"I need direct SSH to the core switch from my laptop."* — No. Through the jump box. Always. That's the audit trail.
- Never promise: *"OOB will save us if everything else fails."* — Only if you've tested it. Untested OOB is decoration.
- Escalate when: in-band is down AND OOB is also unreachable — that's a site visit, not a ticket.

## Related concepts

[[SSH]] · [[VPN]] · [[Jump box]] · [[Out-of-band management]] · [[Site-to-site VPN]] · [[Client-to-site VPN]] · [[API]] · [[Console access]] · [[IPsec]] · [[TLS]] · [[Zero Trust]] · [[High Availability]] · [[Redundant Power]]

*Source: VIRGIL knowledge base — 2026-05-11*