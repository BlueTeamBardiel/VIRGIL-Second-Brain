# Windows Network Technologies

## What it is

You're at home. Your buddy's computer won't boot Windows past the spinning dots. You could drive 40 minutes to his apartment, or you could open a remote session, see his desktop on your monitor, and fix it in fifteen minutes while still in your chair. That's remote access — projecting your hands and eyes onto a machine somewhere else.

**Plain English:** Remote access technologies let you control, monitor, or move files to a computer that isn't physically in front of you. Some give you a full graphical desktop. Some give you a command line. Some just move files. Each one trades off speed, security, and what kind of work you can actually do.

**Technical:** A family of protocols and tools that establish authenticated sessions to remote endpoints — RDP, VNC, SSH, SPICE, WinRM, VPN, plus the third-party screen-share and RMM platforms layered on top. They differ in transport (TCP ports, encryption), in what they expose (desktop, shell, files, full network), and in how they authenticate.

## Why it matters

This is your daily life as a tech. The user is in Tampa, you're in Phoenix, and the ticket says "Outlook won't open." You're not flying out. You're opening a remote session. CompTIA tests this directly on **220-1202 Objective 4.9**, and they care less about which button to click and more about *which tool fits which scenario, and what the security tradeoffs are.* Pick the wrong tool — say, exposing RDP straight to the internet — and you've handed a ransomware crew the keys. Pick the right one, and you close tickets without leaving your desk.

The exam wants you to know the protocols, the ports, the encryption posture, and when each tool is appropriate. Real life wants the same thing, plus the muscle memory to use them.

## In your build, in the enterprise

**Beat 1 — Technical depth.**

The tools fall into rough buckets:

- **RDP (Remote Desktop Protocol)** — Microsoft's native graphical remote tool. TCP **3389**. Encrypted by default (TLS). Pro/Enterprise editions of Windows host it; Home edition can only connect *out*. Supports NLA (Network Level Authentication) — authenticate before the session opens, blocks brute-force pre-auth.
- **VNC (Virtual Network Computing)** — cross-platform graphical sharing. TCP **5900**. Vanilla VNC is *not encrypted* — tunnel it through SSH or a VPN, or use a variant (TightVNC, RealVNC) that bolts on TLS.
- **SSH (Secure Shell)** — encrypted command-line access. TCP **22**. The backbone of Linux admin, and now native to Windows via the OpenSSH client and server features. Supports password auth, but key-based auth is the right answer.
- **SPICE** — open-source remote desktop protocol built for VMs, especially on KVM/QEMU. Better video/audio performance than VNC for virtualized desktops. You'll see it in Linux-heavy virtualization shops, Proxmox homelabs.
- **WinRM (Windows Remote Management)** — Microsoft's remote shell/scripting endpoint. HTTP **5985**, HTTPS **5986**. Powers PowerShell remoting and `Enter-PSSession`. Not graphical — it's the API your scripts hit.
- **VPN** — not a remote control tool per se. It's the *tunnel* that puts your laptop logically inside the corporate network so the other tools work safely.
- **RMM (Remote Monitoring and Management)** — third-party platforms (ConnectWise, NinjaOne, Atera, Kaseya). Agent-based, runs as SYSTEM, lets MSP techs push patches, run scripts, open screen-share sessions at scale.
- **Screen-share / videoconferencing** — Teams, Zoom, Google Meet. The user clicks "share screen" and you watch, or request control. Not for unattended access — the user has to be there to grant it.

**Beat 2 — Feynman example via gaming/personal build.**

You build a homelab. One Windows gaming rig, one Proxmox box running a couple of VMs, one Raspberry Pi doing Pi-hole.

**RDP to the gaming rig:** From your laptop on the couch, you connect to the desktop upstairs to launch a game download before you head up. `mstsc.exe`, hostname, done. Smooth, encrypted, native. *Use RDP when both ends are Windows and you want a full desktop.*

**SSH to the Pi:** No GUI needed. You're editing `/etc/pihole/setupVars.conf`. `ssh pi@pihole.lan`, drop into the shell, fix the config, restart the service. Twenty seconds. *Use SSH when you want a shell, not a desktop, and especially when the box is Linux.*

**VNC into the Proxmox console:** You broke the VM's network stack and can't SSH in. Proxmox's web UI exposes a noVNC console — same as standing in front of the VM with a keyboard. *VNC is your "the network is broken but I still need in" tool.*

**WinRM from your scripts box:** You wrote a PowerShell script to pull event logs from three Windows VMs at once. `Invoke-Command -ComputerName vm1,vm2,vm3 -ScriptBlock {...}`. Behind the scenes, that's WinRM. *WinRM is automation, not eyeballs.*

**The kicker:** Then you decide to forward RDP port 3389 to the internet so you can game from a coffee shop. Within 48 hours your logs are a wall of failed logins from Belarus. *Never expose RDP directly to the internet. VPN in first, then RDP.* This is how ransomware gangs find their way into small businesses every single week.

**Beat 3 — Bridge from homelab to enterprise.**

Same tools, different scale and discipline.

- **Home:** You RDP directly to your gaming rig over your LAN. Maybe over a Tailscale or WireGuard tunnel if you're outside.
- **Enterprise:** Nobody RDPs directly to anything. You VPN into the corporate network (or hit a Remote Desktop Gateway, or use Azure Virtual Desktop / Windows 365), *then* RDP to a jump box, *then* RDP to the target server. Multiple layers, all logged, all MFA-gated.
- **Home:** SSH with a password is fine for your Pi.
- **Enterprise:** SSH with key-based auth only, password auth disabled in `sshd_config`, keys stored in a hardware token or PAM vault, sessions recorded.
- **Home:** TeamViewer free tier to help your mom.
- **Enterprise:** A licensed RMM platform with role-based access, MFA on the technician console, agent-based deployment via Group Policy or Intune, session recordings retained for 90 days for audit.

**Beat 4 — The point/generalization.**

Same fundamental question every time: *what's the minimum access I need, and what's the most-restricted tool that gets me there?* SSH instead of RDP when a shell will do. WinRM instead of RDP when a script will do. VPN-then-RDP instead of RDP-on-the-internet, always. Get this question into your bones — every remote-access decision you make for the next twenty years rides on it.

## Key facts

### The protocols at a glance

| Tool | Port | Encryption | Use case | Platform |
|---|---|---|---|---|
| RDP | TCP 3389 | TLS (built-in) | Full Windows desktop | Windows Pro/Ent host |
| VNC | TCP 5900 | None by default | Cross-platform desktop | Any |
| SSH | TCP 22 | Strong (built-in) | Command-line, file transfer (SCP/SFTP) | Linux native, Windows via OpenSSH |
| SPICE | TCP 5900–5930 range | TLS optional | VM consoles on KVM/QEMU | Linux virtualization |
| WinRM | 5985 (HTTP) / 5986 (HTTPS) | TLS on 5986 | PowerShell remoting, scripting | Windows |
| Telnet | TCP 23 | **None** | Legacy — don't use | Any |
| VPN (IPsec) | UDP 500/4500 | IPsec | Network tunnel | Any |
| VPN (SSL/TLS) | TCP 443 typically | TLS | Network tunnel, firewall-friendly | Any |

### RDP specifics

- Built into Windows. Server is Pro/Enterprise/Server SKUs only — Windows Home cannot host.
- **NLA (Network Level Authentication)** should always be on. Authenticates the user before allocating session resources — kills pre-auth exploits.
- Supports clipboard, drive, and printer redirection. Useful and also a data-exfil vector — disable redirection in high-security environments.
- **Remote Desktop Gateway (RD Gateway)** wraps RDP inside HTTPS so you can publish it through a firewall without exposing 3389.

### SSH specifics

- Password auth → fine for labs. **Key-based auth → the right answer** for anything that matters.
- Private key stays on your machine (or in a hardware token). Public key goes in `~/.ssh/authorized_keys` on the server.
- SCP and SFTP ride on the same SSH session — encrypted file transfer for free.
- Windows: install via `Settings → Optional Features → OpenSSH Server`. Then `ssh user@host` from any terminal.

### VPN — site-to-site vs client-to-site

- **Client-to-site (remote access VPN):** your laptop connects to the corporate gateway. Cisco AnyConnect, GlobalProtect, Windows built-in client. This is what most remote employees use.
- **Site-to-site:** two networks (e.g., HQ and a branch office) connected permanently via a VPN tunnel between their firewalls. Users don't initiate anything — it's just there.

### CompTIA exam traps

> **CompTIA exam trap: RDP vs VNC.** RDP is **Windows-native, encrypted, port 3389.** VNC is **cross-platform, NOT encrypted by default, port 5900.** If the scenario says "Linux desktop" or "cross-platform," it's VNC. If it says "internal Windows network" with no mention of encryption concerns, it's RDP.

> **CompTIA exam trap: SSH vs Telnet.** Both give you a remote command line on port-adjacent services (22 vs 23). SSH is encrypted, Telnet sends everything — including your password — in cleartext. Telnet's only correct exam answer is "what should we replace?"

> **CompTIA exam trap: VPN is not remote desktop.** A VPN tunnels your traffic onto another network. It doesn't show you a desktop. The exam loves answers like "VPN to connect, then RDP to control" — those two together, not either alone.

> **CompTIA exam trap: WinRM is not RDP.** WinRM is for **scripts and PowerShell remoting**, no GUI. If the scenario says "I need to run a PowerShell command on 50 machines," that's WinRM. If it says "I need to see the user's desktop," that's RDP.

### Security considerations (every method)

- **Never expose RDP, VNC, SSH, or WinRM directly to the public internet** without a layer in front (VPN, gateway, jump host, ZTNA).
- **MFA on every remote access path.** The VPN, the RDP gateway, the RMM console. All of it.
- **Logging and session recording** for privileged remote sessions — especially in regulated environments (HIPAA, PCI, SOX).
- **Patch the remote access stack first** when CVEs drop. BlueKeep, EternalBlue, the Citrix Bleed — they all targeted remote access surfaces.
- **Third-party tools introduce supply-chain risk.** The Kaseya VSA compromise in 2021 turned an RMM platform into a ransomware delivery system across hundreds of MSPs. Vet your vendors, patch their agents, monitor their consoles.
- **Screen-share tools (Teams, Zoom) need user consent** — they're attended-access tools. Good for helping. Bad for unattended administration.

## Helpdesk reality

- **User says:** "Can you just log in and look at it?" → **Right answer:** open the RMM session, request control, document the change. Don't shadow without consent if your policy requires the user to approve.
- **User says:** "I'm working from home and can't reach the file share." → **Right answer:** check that the VPN is connected first. Ninety percent of "I can't reach internal X" tickets from remote users are dropped VPN tunnels. Never promise the file share is up before you've confirmed the tunnel.
- **User says:** "TeamViewer told me to install it to fix my computer." → **Right answer:** that's a tech-support scam. Walk them through uninstalling it, then escalate to security if they entered credentials or banking info.
- **User says:** "Can you set up RDP on my home PC so I can get into work?" → **Right answer:** no. Use the corporate VPN and the approved remote-work path. Personal RDP forwarding violates policy in every shop you'll ever work at, and it's how breaches start.
- **AI assist:** When a user sends a screenshot of an unfamiliar remote-access error, paste it into your company-approved AI (Copilot, Now Assist) and ask what the error means. Tool, not crutch — you make the troubleshooting decision.

## Related concepts

[[VPN]] · [[RDP]] · [[SSH]] · [[Windows Firewall]] · [[Multi-Factor Authentication]] · [[Remote Monitoring and Management]] · [[Group Policy]] · [[Windows Editions]]

*Source: VIRGIL knowledge base — 2026-05-10*