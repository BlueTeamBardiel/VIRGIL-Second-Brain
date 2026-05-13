# VPNs

## What it is

In **Tekken**, when you queue ranked from Texas and the matchmaker drops you against a Mishima main in Osaka, the netcode opens a direct point-to-point connection between your console and theirs. Every electric wind god fist input, every sidestep, every frame of Heihachi's hitbox — encoded, packetized, and tunneled across the public internet. Anyone sniffing the wire between you sees encrypted noise. They can't read your inputs, they can't inject a fake hit, they can't tell whether you just whiff-punished or got launched. That private channel running across hostile infrastructure — that's a VPN.

A **Virtual Private Network (VPN)** is an encrypted tunnel that carries traffic between two endpoints across an untrusted network, usually the internet, in a way that makes the endpoints behave as if they're on the same private LAN. The tunnel handles three jobs: **confidentiality** (encryption), **integrity** (hashing), and **authentication** (keys/certs/credentials — both ends prove who they are before the tunnel opens).

Two architectures dominate the exam:

- **Site-to-site VPN** — two routers/firewalls build a permanent tunnel between offices. Users on either side don't install anything. The gateways do the work.
- **Client-to-site VPN (remote access)** — a single user runs VPN client software, authenticates, and gets dropped into the corporate network as if they're at their desk.

## Why it matters

Every remote-work job posting in the last decade assumes you can stand up, troubleshoot, and harden a VPN. Sales reps in hotel Wi-Fi, devs working from a cabin, the entire 2020 workforce migration — none of it happens without VPNs. CompTIA tests them under **Objective 4.3** (network security features) and adjacent to **Objective 4.1**. Expect questions on tunnel modes, protocols, split vs. full tunnel, and how VPNs interact with [[NAC]], [[firewalls]], and [[zones]].

In the **circulatory system** metaphor: a VPN is a diplomatic pouch. Encrypted, sealed at both ends, routed through hostile territory without inspection. The body it enters treats it like internal blood, not foreign matter.

## Key facts

### Tunnel modes — split vs. full

| Mode | What it does | Trade-off |
|---|---|---|
| **Full tunnel** | All client traffic — corporate AND personal — goes through the VPN | Maximum security, maximum bandwidth cost on the corporate gateway |
| **Split tunnel** | Only corporate-destined traffic goes through the VPN; personal traffic exits the local ISP normally | Saves bandwidth, faster general internet, but personal traffic isn't protected and DLP can't see it |

*Full tunnel for the paranoid finance firm. Split tunnel for the company that doesn't want to pay to backhaul TikTok traffic through HQ.*

### VPN protocols (exam-relevant)

| Protocol | Port/Proto | Notes |
|---|---|---|
| **IPsec** | UDP 500 (IKE), UDP 4500 (NAT-T), proto 50 (ESP), proto 51 (AH) | Workhorse for site-to-site. Two modes: **transport** (encrypts payload only) and **tunnel** (encrypts entire packet, adds new IP header). Use tunnel mode for gateway-to-gateway. |
| **SSL/TLS VPN** | TCP 443 | Client-to-site favorite. Rides HTTPS, punches through hotel firewalls that block IPsec. |
| **GRE** | Proto 47 | Tunneling, NOT encryption. Often wrapped inside IPsec to add the crypto. |
| **L2TP** | UDP 1701 | No encryption by itself. Pair with IPsec → "L2TP/IPsec." |
| **WireGuard** | UDP 51820 (default) | Modern, fast, minimal codebase. Increasingly tested. |

> **CompTIA exam trap:** IPsec uses **two** primary protocols — **AH (Authentication Header)** for integrity/auth only, and **ESP (Encapsulating Security Payload)** for encryption + integrity + auth. AH does NOT encrypt. If the question asks "which IPsec component provides confidentiality?" the answer is ESP. AH is also fragile through NAT because it hashes the IP header — which NAT rewrites. Use ESP with NAT-T (UDP 4500) when traversing NAT.

### Key management

A VPN is only as strong as how the keys are handled. Two authentication methods:

- **Pre-shared key (PSK)** — both sides share the same secret string. Easy to deploy, terrible to rotate, and a leaked PSK compromises every tunnel using it.
- **Certificate-based auth** — each side has an X.509 cert signed by a trusted CA. Scales. Revocable. The right answer for any organization larger than a closet.

**IKE (Internet Key Exchange)** is the IPsec negotiation protocol. **IKEv2** is the modern default — faster reconnect, MOBIKE for roaming clients, cleaner state machine.

*PSKs are fine for two routers. They are not fine for 400 laptops. The day someone leaves the company with a PSK on their laptop is the day you rotate it on every gateway.*

### VPN concentrators and the screened subnet

The device that terminates inbound VPN tunnels is the **VPN concentrator** — usually the corporate firewall or a dedicated appliance. It lives in the **[[screened subnet]]** (the modern term for DMZ), between the **untrusted** outside and the **trusted** inside.

```
Internet → [Outer firewall] → Screened subnet (VPN concentrator, web servers) → [Inner firewall] → Internal LAN
```

The concentrator authenticates the tunnel, then the inner firewall enforces [[ACLs]] on what the now-trusted client can actually reach inside.

### Zones — trusted vs. untrusted

A VPN takes a client sitting in the **untrusted** zone (internet, public Wi-Fi) and, after authentication, treats their traffic as if it originated in the **trusted** zone — or a dedicated **VPN zone** with its own ACL set, which is the smarter design. The **screened subnet** is the in-between, where outward-facing services live.

### NAC integration — the bouncer checks ID twice

A VPN gateway should not just check credentials. Modern deployments chain VPN auth with **[[Network Access Control (NAC)]]** posture assessment:

- Is the client's OS patched?
- Is antivirus running and updated?
- Is full-disk encryption on?
- Is the device's [[MAC address]] on the corporate inventory?

Fail any check → the tunnel drops or the client is shunted to a **quarantine VLAN** that can only reach the patch server. **802.1X** is the wired/wireless equivalent.

*A VPN that only checks username+password is a 2012 VPN. In 2026 you want MFA on the tunnel and posture checks on the device.*

### Device hardening — VPN concentrator edition

The concentrator sits in the screened subnet with a public IP. It is being scanned right now.

- **Change default passwords** — still on the exam, still ignored in the wild.
- **Disable unused ports and services** — kill Telnet listeners. SSH only.
- **MFA on the management interface** — and on the tunnel itself.
- **ACLs on the management plane** — admin access only from a jump host inside, never from the public internet.
- **Certificate-based tunnel auth** instead of PSK wherever possible.
- **Logging to a central SIEM** — auth failures on the VPN gateway are the #1 early indicator of a credential-stuffing campaign.

### Security rules inside the tunnel

VPN clients arriving from home networks are not trusted just because the tunnel is encrypted:

- **ACLs** restrict which internal subnets the VPN zone can reach. Sales doesn't need the finance VLAN.
- **URL/content filtering** still applies — full-tunnel users hit the same web proxy as on-prem users.
- **DLP** inspects outbound traffic for exfiltration. Easy on full tunnel, blind on split tunnel — that's the trade.

### Always-on VPN

VPN client launches at boot, authenticates with a device cert, and stays up before the user even logs in. Lets you push GPOs and patches to remote machines as if they're on the LAN. The user can't "forget to connect."

> **CompTIA exam trap:** A VPN encrypts data **in transit**. It does NOT encrypt data **at rest**, does NOT replace antivirus, does NOT inspect malicious payloads inside the tunnel, and does NOT make a compromised endpoint safe. *A VPN protects the wire, not the machine.* If a question implies a VPN alone provides "complete security" — wrong. Defense in depth means VPN + NAC + endpoint protection + ACLs + monitoring.

> **CompTIA exam trap:** Don't confuse a **VPN** with a **proxy**. A proxy forwards specific application-layer traffic (usually HTTP/S) on behalf of a client. A VPN tunnels arbitrary layer 3 traffic between two endpoints. Proxies are about anonymity or content filtering; VPNs are about encrypted private connectivity.

### Common deployment failures

| Symptom | Likely cause |
|---|---|
| Tunnel comes up but no traffic flows | Phase 2 (IPsec SA) mismatch on encryption/hash, or routing missing on one side |
| Tunnel drops every few hours | Mismatched IKE lifetimes — both sides need to agree |
| Can't establish tunnel through hotel Wi-Fi | Hotel blocks UDP 500/4500 or ESP — fall back to SSL VPN over TCP 443 |
| Client connects but can't resolve internal hostnames | Split-DNS misconfigured — VPN client using public DNS instead of corporate DNS |
| Site-to-site tunnel up, but one subnet unreachable | "Interesting traffic" ACL on the crypto map doesn't include that subnet |

## Helpdesk reality

- User says: *"The VPN isn't working."* What they mean: anything from "I'm not on Wi-Fi" to "I forgot my MFA token" to "the gateway is actually down." Ask: did it ever work? When did it stop? Are you on a network that might block VPN protocols?
- First check is always layer 1 and the obvious: are they on the internet at all? Can they hit google.com before they try the tunnel? You'd be amazed how often "VPN broken" means "Wi-Fi disconnected."
- Never promise a remote user the tunnel will be up in 5 minutes. VPN issues blur into ISP issues, DNS issues, cert expiration, MFA outages — any of which can be outside your team.
- If MFA push isn't arriving, check the user's phone has signal before you blame the auth server. If cert auth fails after a working session yesterday, check whether the cert just expired — this happens on a schedule, on a Sunday, when nobody's looking.
- Escalate when you've confirmed: client has internet, credentials are correct, MFA succeeded, and the tunnel still won't establish or pass traffic. That's a gateway-side or routing-side problem.

## Related concepts

[[IPsec]] · [[SSL TLS]] · [[WireGuard]] · [[Screened subnet]] · [[NAC]] · [[802.1X]] · [[ACL]] · [[Firewalls]] · [[Zones trusted untrusted]] · [[MFA]] · [[Site-to-site vs client-to-site]] · [[Split tunnel vs full tunnel]] · [[Certificate authentication]] · [[NAT traversal]] · [[Always-on VPN]]

*Source: VIRGIL knowledge base — 2026-05-11*