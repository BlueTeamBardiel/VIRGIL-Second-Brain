# Windows Network Connections

## What it is

You just built a new gaming rig. You boot Windows, finish OOBE, and the first thing the OS asks — after the Microsoft account dance — is whether this network is private or public. That single click decides whether your PC can see your NAS, whether your printer shows up, and whether the firewall lets your roommate's laptop ping you back.

In plain English: Windows network connections is the whole stack of settings that tells the OS *how* to talk to the network — IP address, DNS, gateway, firewall posture, file sharing visibility, VPN tunnels, proxies, and which network it's currently on. The OS is the personality, but the network stack is its **voice and ears** — and the voice has settings.

Technically: a Windows network connection is a binding between a network adapter (Ethernet, Wi-Fi, WWAN, VPN virtual adapter) and a TCP/IP configuration profile, scoped to a network location type (Public, Private, or Domain) that drives firewall rules and discovery behavior.

## Why it matters

This is the objective the helpdesk lives in. Every "I can't get to the file share" ticket, every "the printer disappeared," every "my VPN won't connect," every "Outlook is offline at the hotel" — all of it routes through these settings. CompTIA tests it because A+ techs configure this daily on user machines.

Exam-relevant: **Objective 220-1202 1.7** covers domain vs workgroup, network connection establishment (wired, wireless, WWAN, VPN, printers, file servers, mapped drives), local firewall, proxy, public vs private profiles, File Explorer network paths, metered connections, and client IP configuration (static vs DHCP, subnet, gateway, DNS).

## In your build, in the enterprise

**Beat 1 — Technical depth.** A Windows client speaks TCP/IP, which means every connection needs four things: an **IP address** (who am I), a **subnet mask** (what's local vs remote), a **default gateway** (where to send non-local traffic), and **DNS servers** (how to turn names into IPs). These come from DHCP by default — the router hands them out on a lease — or you set them statically in adapter properties. Windows assigns the network a **location profile**: Private (trusted home/office, discovery on, firewall relaxed), Public (coffee shop, discovery off, firewall locked down), or Domain (auto-applied when the machine authenticates to a domain controller, group-policy-managed). The local firewall — Windows Defender Firewall with Advanced Security — has three separate rule sets, one per profile. **Workgroup** machines are peer-to-peer with local SAM accounts; **domain-joined** machines authenticate against Active Directory and inherit policy from Group Policy Objects.

**Beat 2 — Feynman example via gaming/homelab.** You build a homelab. One gaming PC, one TrueNAS box, one Pi running Pi-hole as DNS.

**First boot:** Windows asks Private or Public. You click Private. *That single click unlocks SMB discovery, lets the NAS show up in File Explorer's Network pane, and tells the firewall to chill on inbound rules from your subnet.*

**Pi-hole DNS:** You go into adapter properties, set DNS manually to the Pi's IP (192.168.1.10), leave IP itself on DHCP. Now every DNS query hits Pi-hole first and ad domains get nulled. *Static DNS, dynamic IP — mix and match per field.*

**Mapping the NAS:** File Explorer → right-click This PC → Map Network Drive → `\\truenas\media` → assign Z:. Now `Z:\` is a permanent path. Same UNC works without mapping: type `\\truenas\media` straight into File Explorer. *Mapped drives are a convenience layer over UNC paths — same protocol underneath.*

**Coffee shop:** Laptop joins the café Wi-Fi. Windows asks Private or Public. You click **Public**. Firewall slams shut, no SMB, no discovery, no random laptop sees your shares. *Public is the right answer literally every time outside your own walls.*

**Beat 3 — Bridge from homelab to enterprise.** Same machine walks into an office on Monday. It auto-detects the domain controller during boot, authenticates, and Windows tags the connection **Domain** — not Public, not Private, a third profile. Group Policy pushes the firewall rules, the proxy settings (because corporate traffic routes through a forward proxy at `proxy.corp.local:8080` with exceptions for `*.corp.local` and `*.microsoft.com`), the DNS servers (internal AD-integrated DNS, not Pi-hole), the mapped drives (login script maps `H:` to the user's home folder and `S:` to the department share), and the printers (auto-deployed via GPO from the print server). The user touches none of this. IT defined it once in Group Policy and every domain-joined machine inherits.

**Beat 4 — The point.** Same fundamental question — *what does this machine need to talk to, and who do I trust on this network* — different workloads, different right answers. Home: you are the admin, you click Private, you map the NAS by hand. Enterprise: a domain controller is the admin, GPO does the clicking, and the user gets a fully configured network stack on first login. Get this question into your bones — you'll ask it at every ticket for the rest of your career.

## Key facts

### Client IP configuration — the four things

| Setting | What it does | Static or DHCP |
|---|---|---|
| **IP address** | Identifies this host on the network | DHCP for clients, static for servers/printers |
| **Subnet mask** | Defines local subnet boundary (e.g., 255.255.255.0 = /24) | Matches network design |
| **Default gateway** | Where to send traffic outside the subnet (the router) | DHCP-assigned or static |
| **DNS servers** | Name resolution — turns `google.com` into an IP | DHCP, static, or hybrid |

APIPA (169.254.x.x) means the client tried DHCP and got nothing. That's a symptom, not a configuration — it means the DHCP server is down, the cable is unplugged, or the VLAN is wrong.

### Public vs Private vs Domain

| Profile | When to use | Discovery | Firewall posture |
|---|---|---|---|
| **Public** | Coffee shop, hotel, airport, any untrusted network | Off | Most restrictive — inbound blocked by default |
| **Private** | Home, small office, trusted LAN | On | Relaxed — file/printer sharing allowed |
| **Domain** | Auto-applied when authenticated to AD domain controller | Per Group Policy | Per Group Policy |

Change profile: Settings → Network & Internet → click the connection → Network profile type.

### Domain joined vs workgroup

- **Workgroup**: peer-to-peer. Each PC has its own local user database (SAM). No central authority. Default for home PCs and Windows Home edition. Windows Home **cannot** join a domain — that's a Pro/Enterprise feature.
- **Domain**: machine and user accounts live in Active Directory on a domain controller. Single sign-on, centralized policy via GPO, login script-driven drive mapping, centralized printer deployment. The user logs in with `DOMAIN\username` (or `username@domain.local`).

### Establishing network connections

| Connection type | How to establish |
|---|---|
| **Wired (Ethernet)** | Plug cable. DHCP usually handles the rest. |
| **Wireless (Wi-Fi)** | Click network icon → select SSID → enter PSK or 802.1X creds. |
| **WWAN / cellular** | Built-in modem with SIM, or USB dongle. Settings → Network & Internet → Cellular. |
| **VPN** | Settings → VPN → Add VPN. Type (IKEv2, L2TP, SSTP, OpenVPN via app), server address, auth method. |
| **File servers (SMB)** | UNC path: `\\server\share` in File Explorer address bar. |
| **Mapped drives** | File Explorer → This PC → Map Network Drive → UNC + drive letter. Persistent across reboots if checked. |
| **Printers** | Settings → Bluetooth & devices → Printers → Add. Network printers via IP, hostname, or `\\printserver\printername`. |
| **Shared resources** | Right-click folder → Properties → Sharing tab. Permissions are share-level AND NTFS-level — most restrictive wins. |

### File Explorer network paths

- **UNC (Universal Naming Convention)**: `\\server\share\subfolder\file.ext` — works without mapping.
- **Mapped drive**: `Z:\subfolder\file.ext` — same path, prettier letter.
- **Network pane**: lists discovered devices. Requires network discovery on (Private profile) and the Function Discovery Resource Publication service running.

### Local firewall (Windows Defender Firewall)

Three rule sets, one per profile (Public/Private/Domain). Settings → Privacy & Security → Windows Security → Firewall & network protection. Advanced rules: `wf.msc`. You can allow an app (Inbound Rule → Program), allow a port, or scope rules to specific IPs/subnets. Block by default inbound, allow by default outbound is the standard posture.

### Proxy settings

Settings → Network & Internet → Proxy. Three modes:
- **Automatically detect settings (WPAD)** — looks for `wpad.domain` on the network.
- **Setup script (PAC file)** — URL pointing to a `.pac` JavaScript file that returns proxy or DIRECT per destination.
- **Manual proxy** — server address + port. **Exceptions** field for hosts that should bypass (typically internal `*.corp.local`, `localhost`, `127.0.0.1`).

Enterprise environments push proxy config via GPO. Bypass list matters: if `*.corp.local` isn't in exceptions, internal traffic gets routed through the external proxy and breaks.

### Metered connections

Settings → Network & Internet → click the connection → Metered connection toggle. When on, Windows:
- Pauses non-critical Windows Update downloads
- Throttles OneDrive sync
- Suppresses background app data
- Doesn't auto-download Store updates

Default behavior: cellular is metered, Wi-Fi and Ethernet are not. Override per network. *Tell users on hotspot plans to flip this toggle before Windows Update eats their data cap.*

### CompTIA exam traps

> **CompTIA exam trap: APIPA address (169.254.x.x).** This is not a configuration choice — it's a *failure indicator*. The client wanted DHCP, didn't get a response, and self-assigned. The fix is upstream (DHCP server, switch port, cable), not on the client.

> **CompTIA exam trap: Workgroup ≠ no security.** Workgroup machines still have local user accounts and NTFS permissions. The difference is *centralization*, not *security existence*. CompTIA loves this distinction.

> **CompTIA exam trap: Mapped drive disappears after reboot.** "Reconnect at sign-in" checkbox wasn't ticked. Or the credentials weren't saved. Or the user's roaming profile didn't sync the mapping. Know all three.

> **CompTIA exam trap: Public vs Private — Public is *more* restrictive, not less.** New techs flip this. Public = untrusted = locked down. Private = trusted = relaxed.

## Helpdesk reality

- **"I can't see the file server in Network."** — Profile is Public. Flip to Private (assuming it's a trusted network), or just type `\\servername` into File Explorer directly. UNC works regardless of discovery.
- **"My mapped drive has a red X."** — Server unreachable, credentials expired, or the user is off-VPN. Check connectivity first, then reauthenticate, then remap.
- **"Internet works but I can't reach internal sites."** — DNS is wrong. They're on public DNS (8.8.8.8) instead of corporate DNS. Or they're off-VPN trying to hit internal-only resources. `ipconfig /all` tells you which.
- **"VPN connects but nothing works."** — Split tunnel vs full tunnel misconfig, or DNS isn't being pushed by the VPN profile. Check `ipconfig /all` while connected.
- **"My laptop is slow on hotel Wi-Fi."** — Often it's not slow, it's metered-off. Windows is pulling updates over a 5 Mbps shared connection. Toggle metered on.
- **Never promise** a network change will survive a GPO refresh. If a user manually changes proxy settings on a domain machine, GPO will reset it at the next policy cycle (90 minutes default).

## Related concepts

[[Windows Editions]] · [[Active Directory]] · [[Group Policy]] · [[Windows Firewall]] · [[VPN Configuration]] · [[DHCP and DNS Fundamentals]] · [[SMB and File Sharing]] · [[ipconfig and Network Troubleshooting]] · [[Wireless Security Standards]]

*Source: VIRGIL knowledge base — 2026-05-10*