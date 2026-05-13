# Remote Access

## What it is

You're on the couch. The gaming rig is upstairs, mid-Tarkov-raid render, and you want to check why the Plex server is throwing transcoding errors. You pull out the laptop, fire up RDP, and now you're sitting at the upstairs machine without moving. That's remote access — the network stack as your voice and ears, reaching into a machine that isn't in front of you.

**Plain English:** Remote access is any technology that lets you control or transfer data to a computer over a network instead of touching it physically. The remote machine renders its screen, accepts your keyboard and mouse, runs your commands, and ships files back to you.

**Technical definition:** A category of protocols and tools that establish authenticated, typically encrypted sessions between a client and a remote host for the purposes of interactive console access (RDP, VNC, SPICE), shell/command execution (SSH, WinRM), file transfer (SFTP, SCP, FTPS), network-layer tunneling (VPN), or operator-assisted support (screen-sharing, RMM). Each protocol has a default port, an authentication model, and an encryption posture — and CompTIA wants you to know all three.

## Why it matters

Remote work is the default. Your first helpdesk job will spend 60–80% of its tickets on machines you'll never physically touch. Knowing which tool to reach for — and which one to refuse to use — is the job.

It also matters because remote access is the #1 attack surface in the modern enterprise. Exposed RDP on port 3389 is how ransomware gangs got into hospitals in 2020–2024. Unpatched VPN appliances were the entry point for some of the largest breaches of the decade. The exam tests this hard.

Exam-relevant for **Objective 220-1202 4.9** (remote access methods and security considerations).

## In your build, in the enterprise

**Beat 1 — Technical depth.** Remote access splits into five functional buckets. **Graphical desktop:** RDP (TCP 3389, Microsoft, NLA-authenticated, encrypted), VNC (TCP 5900, cross-platform, encryption varies by implementation — RealVNC encrypts, TightVNC historically did not), SPICE (open-source, designed for KVM/QEMU virtualization, low-latency for VMs). **Shell:** SSH (TCP 22, key-based auth preferred, encrypted by default, the Linux/Unix standard), WinRM (TCP 5985 HTTP / 5986 HTTPS, Windows-native, the engine behind PowerShell Remoting and Ansible's Windows modules). **File transfer:** SFTP (TCP 22, runs over SSH), SCP (also over SSH, legacy), FTPS (TCP 990, FTP wrapped in TLS), TFTP (UDP 69, no auth, no encryption — only for switch configs on isolated networks). **Network tunneling:** VPN — IPsec, SSL/TLS VPN, WireGuard. Encrypts traffic between client and corporate network at the IP layer; you appear as if you're on the LAN. **Operator-assisted:** RMM platforms (ConnectWise, NinjaOne, Datto), screen-share tools (TeamViewer, AnyDesk, Splashtop), videoconferencing with screen-share (Teams, Zoom).

**Beat 2 — Feynman example via your homelab.** You've got a Proxmox host running three VMs: a Windows 11 gaming-stream VM, an Ubuntu Plex server, and a pfSense router.

**Windows VM:** RDP. You enable Remote Desktop, connect from your laptop on the LAN, full graphical session, audio redirected, clipboard shared. *RDP is Microsoft's home turf — graphical, fast, every Windows Pro edition supports it.*

**Ubuntu Plex server:** SSH from a terminal. No GUI needed — you're editing config files and tailing logs. You generated an ED25519 key, copied the public half to the server, disabled password auth. *Key-based SSH is faster to type and harder to brute-force than any password.*

**pfSense and the Proxmox host itself:** Proxmox exposes its KVM consoles over SPICE — designed for VM graphical access with better latency than VNC. *SPICE exists because VNC's protocol was designed in the '90s and shows it.*

**Now you leave the house.** None of those ports should be exposed to the internet. You set up WireGuard on pfSense. From the coffee shop, you VPN in first, then RDP/SSH/SPICE to whatever you need. *The VPN is the gatekeeper. Everything else lives behind it.*

**Beat 3 — Bridge from homelab to enterprise.** Same question — "how do I reach the machine?" — different right answers at scale.

- **Home gaming rig:** RDP over LAN, maybe WireGuard for remote-in. One user, one machine.
- **Small business (10–50 seats):** RMM agent on every endpoint (NinjaOne, ConnectWise). Tech connects through the RMM portal — no direct RDP exposure, no VPN required for the tech, session recording for audit. End users get a VPN for accessing internal file shares.
- **Mid-market enterprise (500–2,000 seats):** Always-on VPN client (Cisco AnyConnect, GlobalProtect) with certificate-based auth and MFA. Tech tools include the RMM plus PowerShell Remoting over WinRM for fleet-wide scripted changes. Servers are managed via jump hosts — you SSH/RDP to a bastion, then from the bastion to the target. Direct admin access from a workstation to a domain controller is blocked by policy.
- **Large enterprise / regulated:** Zero Trust Network Access (ZTNA) replacing traditional VPN. Privileged Access Management (PAM) systems (CyberArk, BeyondTrust) broker every admin session, check out time-limited credentials, record screen activity. SSH bastions log every keystroke. No standing access.

**Beat 4 — The point.** Same fundamental question — "what's the right way to reach this machine?" — answered differently at every scale. The homelab teaches you the protocols. The enterprise teaches you why those protocols are always wrapped in three more layers of access control. Get the question into your bones: *who's the user, what's the machine, what's the data, what's the threat model?* You'll answer it for the rest of your career.

## Key facts

### Protocol cheat sheet

| Tool | Port | Encrypted? | Use case |
|---|---|---|---|
| **RDP** | TCP 3389 | Yes (NLA + TLS) | Windows graphical remote |
| **VNC** | TCP 5900 | Depends on implementation | Cross-platform graphical remote |
| **SPICE** | TCP 5900–5999 range | Yes (TLS optional, usually on) | VM console access (KVM/QEMU) |
| **SSH** | TCP 22 | Yes (always) | Shell, file transfer, tunneling |
| **WinRM (HTTP)** | TCP 5985 | No by default | Windows remote management — avoid |
| **WinRM (HTTPS)** | TCP 5986 | Yes | Windows remote management — use this |
| **SFTP** | TCP 22 | Yes (over SSH) | Secure file transfer |
| **FTPS** | TCP 990 | Yes (TLS) | Legacy secure FTP |
| **FTP** | TCP 21 | No | Don't use over internet |
| **TFTP** | UDP 69 | No | Switch/router config on isolated LAN only |
| **VPN (IPsec)** | UDP 500, 4500 | Yes | Site-to-site, client-to-site |
| **VPN (SSL/TLS)** | TCP 443 | Yes | Client VPN through firewalls |
| **WireGuard** | UDP 51820 (configurable) | Yes | Modern, fast VPN |

### Graphical remote desktop: RDP vs VNC vs SPICE

- **RDP** — Microsoft proprietary, Windows-native. Network Level Authentication (NLA) authenticates the user *before* establishing the session, blocking pre-auth attacks. Supports clipboard, audio, printer, and drive redirection. Default in every Windows Pro/Enterprise edition.
- **VNC** — Cross-platform, multiple implementations (TightVNC, RealVNC, UltraVNC, TigerVNC). Sends raw framebuffer updates — works on anything but is slower than RDP. Encryption is not universal across implementations.
- **SPICE** — Simple Protocol for Independent Computing Environments. Open-source, built for virtualization (QEMU/KVM, Red Hat). Lower latency than VNC for VM consoles, supports USB redirection, audio, multi-monitor.

### Shell access: SSH and WinRM

- **SSH** — The universal Linux/Unix remote shell. Public-key authentication is the standard for any production system. Tunnels arbitrary TCP traffic, supports SFTP and SCP for file transfer, supports port forwarding. *If you're doing IT in 2026 and can't use SSH, you have homework.*
- **WinRM** — Windows Remote Management. Powers PowerShell Remoting (`Enter-PSSession`, `Invoke-Command`) and Ansible's Windows modules. Always configure HTTPS (port 5986), never HTTP. Domain-joined machines authenticate via Kerberos by default.

### VPN types

- **Client-to-site (remote access VPN)** — Single user from laptop into corporate network.
- **Site-to-site** — Two networks bridged permanently (branch office to HQ).
- **Split tunnel** — Only corporate traffic goes through the VPN; Netflix goes direct. Faster, less bandwidth on the corporate side. Higher risk if the endpoint is compromised.
- **Full tunnel** — All traffic through the corporate VPN. Slower, more bandwidth, but corporate security tools see everything.

### Third-party tools

- **RMM (Remote Monitoring and Management):** ConnectWise Automate, NinjaOne, Datto RMM, Kaseya. Agent on every endpoint, central console, scripted automation, patch management, often built-in remote control.
- **Screen-sharing/support tools:** TeamViewer, AnyDesk, Splashtop, ScreenConnect, LogMeIn. Designed for ad-hoc support — tech sends a code, user runs the client, session opens.
- **Videoconferencing with screen-share:** Microsoft Teams, Zoom, Google Meet. Screen-share is *view-only* unless the user explicitly grants remote control. Good for training, weak for actual troubleshooting.

### Security considerations

> **CompTIA exam trap:** RDP on port 3389 exposed to the internet — never the right answer. CompTIA always wants RDP behind a VPN or through an RMM/jump host. Exposed 3389 is a top-three ransomware entry vector.

> **CompTIA exam trap:** Telnet vs SSH — Telnet (TCP 23) is plaintext. Any question that mentions Telnet for remote management has SSH as the right answer.

> **CompTIA exam trap:** FTP vs SFTP vs FTPS — FTP is plaintext. SFTP runs over SSH (port 22). FTPS is FTP wrapped in TLS (port 990). Don't confuse SFTP and FTPS — they are completely different protocols.

**Always-true security rules:**

- **MFA on every remote access entry point.** VPN, RDP gateway, RMM portal, SSH bastion. No exceptions.
- **Disable password auth on SSH where possible.** Keys only.
- **Patch the VPN appliance immediately.** Fortinet, Pulse Secure, Citrix, Ivanti — every major VPN vendor has shipped critical CVEs. The patch cadence is non-negotiable.
- **Log everything.** Who connected, from where, when, what they did.
- **Session timeouts.** Idle sessions get killed. No "left the RDP open over the weekend."
- **Least privilege.** A helpdesk tech doesn't need domain admin to reset a printer queue.

## Helpdesk reality

- **"Can you just fix my computer real quick?"** — They mean "open a remote session in 30 seconds." You confirm consent in writing (the ticket), launch the RMM, walk through what you're doing. You don't surprise users by appearing on their screen.
- **"It says someone is connecting to my computer — is that you?"** — Good — they're paying attention. Confirm your session ID. Praise the suspicion. This is how social-engineering remote-access scams get caught.
- **"I can't connect to the VPN from home."** — Detective work: is it the client, the credentials, the MFA push, the home internet, or the VPN concentrator? Check the VPN status page first — if it's down for everyone, you're not debugging a single user.
- **"Some guy from Microsoft called and asked me to install AnyDesk."** — Stop them. Immediately. That's a scam, and you'll see this ticket more than once. Document, isolate the machine, change the user's password, run a full malware scan.
- **Never promise** that remote sessions are private from the company. RMM tools record. Corporate VPNs inspect traffic. Tell users honestly: "When you're on the corporate network, the corporate network sees you."

## Related concepts

[[VPN]] · [[SSH]] · [[RDP]] · [[Firewalls]] · [[MFA]] · [[Ports and Protocols]] · [[Zero Trust]] · [[Social Engineering]] · [[Patch Management]] · [[Ticketing Systems]]

*Source: VIRGIL knowledge base — 2026-05-11*