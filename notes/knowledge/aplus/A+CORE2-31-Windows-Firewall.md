# Windows Firewall

## What it is

Every packet that hits your machine is a stranger knocking on the door. The firewall is the bouncer — checks the guest list, decides who gets in, who gets thrown out, and who gets ignored entirely. It's the **immune system** at the network layer: the OS deciding which connections are allowed to reach the kernel and which die at the boundary.

Plain English: Windows Firewall is a host-based, stateful packet filter built into Windows. It inspects inbound and outbound traffic against a ruleset and allows or blocks it. "Host-based" means it protects this one machine, not the network. "Stateful" means it remembers conversations — if you initiated a connection out, the reply is allowed back in automatically without an explicit inbound rule.

Technically: Windows Defender Firewall with Advanced Security (WFAS), powered by the Windows Filtering Platform (WFP) in the kernel. It enforces rules per **network profile** — Domain, Private, Public — and rules can match on program, port, protocol, IP scope, user, computer, and service.

## Why it matters

The firewall is the difference between "I clicked on coffee shop Wi-Fi" and "some script kiddie is now mapping my SMB shares." It's the last line between a vulnerable service and the open internet. When EternalBlue tore through unpatched Windows boxes in 2017, the machines that survived were the ones where SMB wasn't reachable — patched, segmented, or firewalled.

For the exam, CompTIA tests this under **220-1202 Objective 2.2** (configure and apply Windows OS security settings) and **2.5** (workstation security best practices). You need to know the three profiles, how to enable/disable per profile, where exceptions live, and the relationship between local firewall rules and Group Policy.

For your career: every helpdesk ticket that ends in "can you reach the server now?" is one tier away from a firewall question. Every "this app worked at home but not at the office" is a profile mismatch. Get fluent.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Three profiles, evaluated by Windows when a network adapter connects: **Domain** (machine is authenticated to an AD domain controller), **Private** (you marked the network as trusted — your home), **Public** (default for anything else — coffee shops, hotels, conferences). Each profile has its own ruleset and its own on/off state. Rules are evaluated in this order: explicit Block rules win, then Allow rules, then the default action (inbound = block, outbound = allow). Rules can be scoped by **program** (path to the .exe), **port/protocol** (TCP 3389), **predefined service** (Remote Desktop, File and Printer Sharing), or **custom** combinations. Connection Security Rules are separate — those handle IPsec for authenticated/encrypted traffic.

**Beat 2 — Feynman example via your gaming rig.**

**You install a dedicated Minecraft server on your desktop.** Friends can't connect. The server is listening on TCP 25565, but Windows Firewall is silently dropping the inbound SYNs because no rule allows it. *Default-deny inbound is the firewall doing its job.*

**You add an inbound rule:** TCP 25565, allow, scope = Private profile only. Friends on your LAN connect fine. You take your laptop to a coffee shop and connect to your home VPN — still works, because the VPN adapter is on the Private profile. *Profile-scoped rules are how you say "trust the LAN, distrust the world."*

**Then you accidentally click "Public" when Windows asks about a new network.** Suddenly your home network is firewalled like a hostile airport. File sharing breaks. Plex stops streaming to your TV. Network discovery dies. You spend twenty minutes troubleshooting before realizing the profile flipped. *Half the "my network broke" tickets in your future career are profile-assignment problems.*

**The kicker:** You enable Remote Desktop for convenience. Windows auto-creates an inbound rule for TCP 3389 scoped to Domain + Private. Fine. Six months later you're traveling, your laptop joins a hotel Wi-Fi, and you forget to mark it Public — the laptop sits there with 3389 open to every other guest on that flat network. *The firewall protected you. Right up until you told it not to.*

**Beat 3 — Bridge to the enterprise.** Same machine, same firewall engine, completely different management model. At home, you click through Windows Security → Firewall & network protection and toggle things. In the enterprise, individual users never touch the firewall — it's locked down by **Group Policy**. A GPO at the OU level pushes a baseline ruleset to every domain-joined workstation: block inbound everything except management agents (SCCM, Intune, remote assistance), allow outbound to corporate proxies, block direct internet egress. The Domain profile activates automatically when the machine sees a domain controller, and that profile's rules supersede whatever the local admin set. A user who tries to add a local rule finds the GPO overwrites it at the next refresh.

**Beat 4 — The point.** Same firewall, same three profiles, completely different operational reality. At home you are the policy. In the enterprise, policy is centralized, audited, and non-negotiable — and the firewall on every workstation is one node in a defense-in-depth stack that also includes network firewalls, NAC, EDR, and proxy egress filtering. Get the question into your bones: *who writes the rules, and what's the default action when no rule matches?* That's the entire conversation.

## Key facts

### The three profiles

| Profile | When it applies | Default behavior |
|---|---|---|
| **Domain** | Adapter authenticated to an AD domain controller | Tuned by GPO; usually permissive for management traffic |
| **Private** | User-tagged "trusted" network (home, small office without AD) | Moderately permissive — network discovery, file sharing often allowed |
| **Public** | Default for unrecognized networks | Most restrictive — discovery off, sharing off, ICMP often blocked |

A machine can only be on one profile per adapter at a time. Multi-homed machines (Wi-Fi + Ethernet) can have different profiles per adapter simultaneously.

### Where to configure it

- **Windows Security app** — Firewall & network protection. Per-profile on/off, "Allow an app through firewall." Consumer-grade UI.
- **`wf.msc`** — Windows Defender Firewall with Advanced Security. The real console. Inbound rules, outbound rules, connection security rules, monitoring.
- **Control Panel → Windows Defender Firewall** — legacy UI, still works, redirects to the same engine.
- **PowerShell** — `Get-NetFirewallRule`, `New-NetFirewallRule`, `Set-NetFirewallProfile`. Scriptable, GPO-compatible.
- **Group Policy** — `Computer Configuration → Policies → Windows Settings → Security Settings → Windows Defender Firewall with Advanced Security`. Enterprise control plane.
- **Intune / MDM** — for cloud-managed and hybrid-joined devices.

### Rule anatomy

Every rule has:
- **Direction** — inbound or outbound
- **Action** — Allow, Block, or Allow if secure (requires IPsec)
- **Program** — full path to executable, or "any"
- **Protocol and ports** — TCP/UDP/ICMP, specific ports or ranges
- **Scope** — local and remote IP addresses or subnets
- **Profile** — which profile(s) the rule applies to
- **Users/Computers** — for authenticated rules, AD principals allowed

### CompTIA exam traps

> **CompTIA exam trap:** "Disable the firewall to troubleshoot connectivity." Wrong move. The right move is to **temporarily allow** the specific traffic, or check the firewall log (`%SystemRoot%\System32\LogFiles\Firewall\pfirewall.log` once enabled). Turning the whole firewall off is the lazy answer the exam will mark wrong because it violates least privilege.

> **CompTIA exam trap:** Confusing **Windows Firewall** with **Windows Defender Antivirus**. Both live in Windows Security, both have "Defender" in branding now (Windows Defender Firewall, Microsoft Defender Antivirus). The firewall filters network traffic. The antivirus scans files and processes. They are separate subsystems.

> **CompTIA exam trap:** Assuming rules are per-machine. Rules are **per-profile**. A rule allowing RDP on Domain does nothing when the laptop is on Public. Read the profile column on every exam question that shows a firewall ruleset.

> **CompTIA exam trap:** Default outbound action. Windows Firewall default is **inbound = block, outbound = allow.** Many candidates flip these. Most malware exfiltration succeeds because of that outbound default — enterprise environments tighten it; home machines don't.

### Port security in context

Objective 2.2 lists "port security" under firewall sub-bullets. Two meanings, know both:

- **Host-based port filtering** — what Windows Firewall does. Allow or block specific TCP/UDP ports per profile.
- **Switchport security** (802.1X, MAC filtering, sticky MAC) — network-side, configured on managed switches, not on the workstation. Out of scope for the Windows Firewall topic but easy to confuse on the exam.

## Helpdesk reality

- **"I can't reach the network printer from my laptop."** → Check the network profile. Laptop joined a new SSID, Windows asked "is this network private or public," user clicked Public, network discovery is off. Set the profile to Private (or Domain if it's the office). Ticket closed in two minutes.
- **"This app worked yesterday and now it doesn't."** → Windows Update or a GPO refresh may have reset firewall rules. Open `wf.msc`, sort inbound rules by date, look for the app. If the rule got disabled or deleted, recreate it — and check whether GPO is fighting you.
- **"Just turn off the firewall, it's blocking me."** → No. Never do this on a domain-joined machine; the GPO will turn it back on at next refresh and you'll look like you don't know what you're doing. Find the specific rule needed. Document it. Submit it for approval if policy requires.
- **"I need to RDP into my office desktop from home."** → Not your call. RDP exposed to the internet is how ransomware crews get in. Direct user to the corporate VPN or remote access portal. Never open 3389 on a workstation firewall pointed at the internet, and never recommend it.
- **"The firewall log is empty."** → Logging is off by default. Enable it in `wf.msc` → Properties → per-profile → Logging → set log file path and enable dropped packets / successful connections. Then reproduce the issue.

## Related concepts

[[Windows Defender Antivirus]] · [[BitLocker]] · [[User Account Control (UAC)]] · [[Active Directory]] · [[Group Policy]] · [[NTFS vs Share Permissions]] · [[Network Profiles]] · [[Remote Desktop Protocol (RDP)]] · [[Host-Based vs Network Firewalls]] · [[IPsec and Connection Security Rules]]

*Source: VIRGIL knowledge base — 2026-05-10*