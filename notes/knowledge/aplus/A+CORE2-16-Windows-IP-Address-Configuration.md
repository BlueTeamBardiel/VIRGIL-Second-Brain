# Windows IP Address Configuration

## What it is

Your gaming rig boots, the NIC wakes up, and within a few seconds it has an IP, a subnet mask, a gateway, and DNS servers — usually handed to it by your router via DHCP. You never touched a setting. That's client network configuration working invisibly. The machine's **voice and ears** got plugged into the network without you having to dictate the rules.

Plain English: every device on a network needs an address (IP), a way to know which addresses are local versus remote (subnet mask), a doorway to everything not-local (default gateway), and a phonebook to turn names into addresses (DNS). Windows can get all four automatically (DHCP) or you can hardcode them (static).

Technically: Windows client network configuration is the per-adapter IPv4/IPv6 stack settings — addressing method, address, mask, gateway, DNS — plus the network profile classification (public/private/domain), firewall posture per profile, proxy settings, and the methods Windows uses to reach shared resources (mapped drives, UNC paths, VPN, WWAN).

## Why it matters

This is the bedrock of every helpdesk ticket that starts with "the internet's down." You will set static IPs on printers and servers, troubleshoot DHCP failures, fix DNS that's pointing at a dead resolver, and explain to a user why their laptop works at home but not on the guest Wi-Fi. CompTIA tests this hard under objective 220-1202 1.7 — they want to know you can configure a client cold, identify which of the four settings is wrong, and pick the right profile (public vs private) for the situation.

It also matters because static-vs-dynamic and public-vs-private profile decisions are where junior techs make security mistakes. Set a workstation profile to public on the corporate LAN and file sharing breaks. Set it to private on hotel Wi-Fi and you just exposed SMB to the lobby.

## In your build, in the enterprise

**Beat 1 — Technical depth.** The four settings every IPv4 client needs: address (e.g., 192.168.1.50), subnet mask (255.255.255.0 = /24, defines which addresses are on the same LAN), default gateway (the router's LAN IP, where non-local traffic goes), and DNS servers (primary + secondary, name-to-IP resolution). DHCP hands all four out on a lease — typically 24 hours on consumer routers, 8 days on Windows Server DHCP by default. Static means you typed them yourself and they don't change. APIPA (169.254.x.x) is what Windows assigns itself when DHCP fails — if you see it, the client never got a lease. IPv6 runs in parallel with its own addressing (link-local fe80::, SLAAC, DHCPv6). Windows network profiles — public, private, domain — are not just labels; each profile has its own firewall ruleset. Domain profile activates automatically when Windows authenticates against a domain controller; you can't pick it manually.

**Beat 2 — Feynman example via gaming/homelab.**

**The gaming PC:** DHCP. You plug it in, it gets 192.168.1.47 from the router, you launch Steam, you're done. *Dynamic is correct for anything that just consumes the network.*

**The Plex server in the closet:** Static — or DHCP reservation, same outcome. If the IP changes, your remote-access port forward breaks and your phone can't stream The Office at the airport. Set it to 192.168.1.10, mask 255.255.255.0, gateway 192.168.1.1, DNS 1.1.1.1 and 192.168.1.1. *Anything other devices need to find by address gets a static.*

**The pi-hole / homelab DNS box:** Static, and then you point every other client's DNS at it. Now the gaming PC's DNS isn't 1.1.1.1 anymore — it's 192.168.1.5 (the pi-hole), which forwards upstream. *DNS settings are where ad-blocking, content filtering, and split-horizon resolution all live.*

**The Wi-Fi laptop you take to coffee shops:** DHCP everywhere, and the first time you connect to a new network Windows asks "is this network private?" Say no. Always no. *Public profile locks down the firewall; private opens SMB and network discovery. Coffee shops get public.*

**Beat 3 — Bridge from homelab to enterprise.** Same four questions, different answers at scale. The corporate workstation: DHCP, lease from Windows Server DHCP, DNS pointing at the internal domain controllers (not 1.1.1.1 — DCs resolve both internal AD names and forward external queries). Network profile auto-flips to **domain** the moment it talks to a DC. The corporate file server: static, registered in DNS, joined to the domain. The corporate printer: DHCP reservation tied to its MAC, so it always gets the same IP without having to walk to it and configure statics through a four-button panel. The remote user's laptop on hotel Wi-Fi: DHCP from the hotel, VPN client dials home, gets a second virtual adapter with an internal IP from the corporate VPN pool, DNS now resolves internal names. Same fundamental decisions — dynamic vs static, which DNS, which profile — just with more moving pieces and policy enforcement via Group Policy or Intune instead of you clicking through adapter properties.

**Beat 4 — The point.** Every networked device answers the same four questions: what's my address, what's local, where's the door out, who's my phonebook. Get those into your bones and every networking ticket becomes a process of elimination. *The exam tests whether you can name which of the four is broken from the symptom.*

## Key facts

### Static vs. dynamic — when to use which

| Use static / DHCP reservation | Use plain DHCP |
|---|---|
| Servers, NAS, hypervisors | User workstations |
| Network printers | Laptops, tablets |
| Routers, switches, APs | Phones |
| Anything with a port-forward | Guest devices |
| Domain controllers (always static) | IoT (usually) |

DHCP reservation is the best of both worlds for printers and lightly-managed devices: configured once on the DHCP server, the device still uses DHCP but always gets the same IP via MAC binding. No walking to the device.

### Where to configure it in Windows

- **Settings → Network & Internet → [adapter] → Edit IP assignment** — modern UI, Windows 11
- **Control Panel → Network and Sharing Center → Change adapter settings → [adapter] → Properties → IPv4** — classic UI, still works, every tech uses this
- **`ncpa.cpl`** — Run dialog shortcut straight to adapter list. Learn it.
- **PowerShell:** `Get-NetIPAddress`, `Set-NetIPAddress`, `Set-DnsClientServerAddress`, `New-NetIPAddress`

### Network profiles — public, private, domain

| Profile | When it applies | Firewall posture | Discovery/sharing |
|---|---|---|---|
| **Public** | Untrusted networks (coffee shop, hotel, airport) | Strict — inbound mostly blocked | Off |
| **Private** | Trusted home/small office | Relaxed — allows discovery, SMB | On |
| **Domain** | Auto-set when machine authenticates to AD domain | Defined by Group Policy | Defined by GPO |

You cannot manually pick Domain. Windows assigns it automatically when it sees a domain controller. The other two you toggle in Settings → Network → [network] → Network profile type.

### CompTIA exam traps

> **CompTIA exam trap:** 169.254.x.x means the client failed DHCP — it's APIPA, self-assigned. The fix is not to change the IP; it's to figure out why DHCP didn't respond (cable, switch port, DHCP scope exhausted, VLAN mismatch).

> **CompTIA exam trap:** Wrong subnet mask doesn't kill internet — it kills *local* traffic. A client with mask /16 on a /24 network will think hosts outside its real subnet are local and try to ARP for them instead of sending through the gateway. Symptom: can ping some hosts, can't ping others, no clear pattern.

> **CompTIA exam trap:** Wrong gateway = no internet but local LAN still works. Wrong DNS = internet works by IP but not by name (ping 8.8.8.8 succeeds, ping google.com fails). Memorize these two — they're the most-tested troubleshooting distinctions on Core 2.

> **CompTIA exam trap:** Domain joined vs workgroup — domain machines authenticate against Active Directory and obey Group Policy; workgroup machines have local accounts only and trust no one. A workgroup machine cannot access domain SMB shares without supplying domain credentials manually.

### Establishing network connections — the full menu

- **Wired Ethernet** — plug in, DHCP, done. Most reliable.
- **Wireless (Wi-Fi)** — SSID + passphrase (WPA2/WPA3-Personal) or 802.1X (WPA2/WPA3-Enterprise with RADIUS in corporate environments)
- **WWAN / cellular** — laptop with a SIM or a tethered phone hotspot. Windows treats this as a separate adapter. Often **metered** by default.
- **VPN** — Settings → Network → VPN → Add. Built-in client supports IKEv2, L2TP/IPsec, SSTP, PPTP (don't use PPTP). Most enterprises ship a third-party client (Cisco AnyConnect, GlobalProtect, FortiClient).
- **Mapped drives** — File Explorer → This PC → Map network drive, or `net use Z: \\server\share /persistent:yes`. The mapped letter persists across reboots if you check the box.
- **UNC paths** — `\\server\share\folder` typed straight into File Explorer's address bar. No drive letter needed.
- **Shared resources** — printers via `\\server\printername`, file shares via UNC, both depend on the network profile allowing discovery.

### Metered connections

Cellular and tethered hotspots default to **metered** in Windows. Metered changes behavior: Windows Update defers non-critical patches, OneDrive pauses sync, Store apps stop auto-updating, some telemetry throttles. You can manually mark any Wi-Fi network metered (Settings → Network → Wi-Fi → [network] → Metered connection). Useful for hotel Wi-Fi with data caps or satellite links.

### Proxy settings

Settings → Network → Proxy. Two modes: **automatic** (PAC file URL or WPAD auto-discovery) or **manual** (IP + port). Corporate environments push proxy config via Group Policy and the user never sees it. The **exceptions** list (sometimes called "bypass list") tells Windows which addresses to reach directly without going through the proxy — internal servers, localhost, specific app endpoints. Get this wrong and internal apps break while external browsing works, or vice versa.

### File Explorer network paths

- **`\\server\share`** — direct UNC to a share
- **`\\server\share\subfolder\file.txt`** — drill straight to a file
- **`\\192.168.1.10\backup`** — UNC by IP when DNS is broken or untrusted
- **Network** node in File Explorer left pane — browses discovered devices (requires Network Discovery on, only works on private/domain profiles)

## Helpdesk reality

- **"I have no internet."** First question: do you have an IP? `ipconfig`. If it's 169.254.x.x, DHCP failed — check cable, check Wi-Fi connection, restart adapter. If the IP looks normal but `ping 8.8.8.8` fails, it's gateway/routing. If 8.8.8.8 pings but google.com doesn't, it's DNS.
- **"I can't get to the file share."** Check the network profile first. Public profile blocks SMB discovery. Also check whether they're on VPN if the share is internal-only.
- **"My printer disappeared."** Printer probably got a new DHCP lease and the workstation's print queue still has the old IP. Set a DHCP reservation, or static the printer.
- **"It works at home but not at the office"** (or reverse). Different DNS, different proxy, different network profile, possibly a captive portal they didn't complete. Walk through each.
- **Never promise** that a static IP will "fix" anything by itself. Static is a configuration choice with tradeoffs — duplicate IPs cause outages, and forgetting to update statics during a subnet change kills devices silently.

## Related concepts

[[Windows Firewall]] · [[DHCP and DNS Fundamentals]] · [[Active Directory Domain Services]] · [[VPN Client Configuration]] · [[Wireless Security Standards]] · [[ipconfig and Network Troubleshooting Commands]] · [[Network Profiles and Sharing]] · [[Subnetting Basics]]

*Source: VIRGIL knowledge base — 2026-05-10*