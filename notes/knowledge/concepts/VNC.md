# VNC

## What it is
Think of VNC like a two-way mirror where you see and control someone else's desktop as if you were sitting right in front of it — but over a network. Virtual Network Computing (VNC) is a graphical desktop-sharing protocol that transmits keyboard and mouse events from a client to a remote machine and returns screen updates using the RFB (Remote Frame Buffer) protocol. Unlike RDP, VNC is platform-agnostic and works across Windows, Linux, and macOS systems.

## Why it matters
Attackers who gain initial access to a network frequently scan for open VNC ports (5900–5902) and attempt authentication using default or weak passwords, since many administrators deploy VNC without proper hardening. In the 2021 healthcare sector attacks, exposed VNC instances with no authentication were used as direct pivot points into clinical networks, enabling ransomware deployment. Defenders should scan internally for these services and ensure VNC is never exposed directly to the internet.

## Key facts
- VNC operates on **TCP port 5900** by default; each additional display increments by 1 (5901, 5902, etc.)
- The RFB protocol transmits raw pixel data, making unencrypted VNC sessions trivially captured via packet sniffing
- VNC has **no built-in encryption** in its base form — secure deployment requires tunneling through SSH or a VPN
- Many VNC implementations (TightVNC, RealVNC, UltraVNC) have had **authentication bypass CVEs** due to flawed challenge-response handling
- On Security+/CySA+ exams, VNC appears under **remote access services** and **lateral movement** techniques in threat hunting scenarios

## Related concepts
[[Remote Desktop Protocol (RDP)]] [[SSH Tunneling]] [[Lateral Movement]] [[Port Scanning]] [[Credential Stuffing]]