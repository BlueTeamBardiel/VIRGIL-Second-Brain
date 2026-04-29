# T1021: Remote Services

Adversaries use valid accounts to log into remote services (SSH, RDP, VNC, telnet) to perform lateral movement. Enterprise domains allow attackers with valid credentials to access multiple machines; legitimate tools like Apple Remote Desktop can be abused for code execution and lateral movement.

## Technique Details

**ID:** T1021  
**Tactic:** Lateral Movement  
**Platforms:** ESXi, IaaS, Linux, Windows, macOS  
**Created:** 31 May 2017  
**Last Modified:** 24 October 2025

## Sub-techniques

- [[T1021.001]] – Remote Desktop Protocol  
- [[T1021.002]] – SMB/Windows Admin Shares  
- [[T1021.003]] – Distributed Component Object Model  
- [[T1021.004]] – SSH  
- [[T1021.005]] – VNC  
- [[T1021.006]] – Windows Remote Management  
- [[T1021.007]] – Cloud Services  
- [[T1021.008]] – Direct Cloud VM Connections  

## Attack Flow

Adversaries obtain valid domain credentials and use remote access protocols to authenticate across the network. In domain environments, a single credential set grants access to multiple machines. Attackers can also target SaaS/IaaS services with federated identity or internal virtualization management platforms like [[VMware vCenter]].

Malicious abuse of legitimate remote management tools (e.g., [[Apple Remote Desktop]] on macOS) enables remote code execution. In macOS versions prior to 10.14, SSH sessions can escape to ARD sessions, allowing attackers to bypass TCC (Transparency, Consent, and Control) prompts.

## Notable Threat Actors & Malware

- **[[Aquatic Panda]]** – Used remote scheduled tasks for lateral movement  
- **[[Brute Ratel C4]]** – RPC-based lateral movement  
- **[[Ember Bear]]** – Credential harvesting + [[Impacket]] framework for network traversal  
- **[[Wizard Spider]]** – WebDAV protocol exploitation for payload execution  
- **[[Stuxnet]]** – Peer‑to‑peer propagation via RPC  

## Mitigations

- **M1047 – Audit:** Scan systems for permissions, insecure software, and weak configurations  
- **M1042 – Disable or Remove Feature:** Disable unnecessary remote services if not required  

## Tags

#attack #lateral-movement #t1021 #remote-services #valid-accounts #rdp #ssh #smb #vnc  

---

## What Is It? (Feynman Version)

Think of a remote service as a keyhole on a door that lets you pull the latch from the other side. It lets a user open a computer’s console without standing beside it.  

In plain English, **T1021** is the use of legitimate remote‑access protocols—like RDP, SSH, or VNC—to log into another machine and move around the network.

## Why Does It Exist?

Before remote services, an attacker needed to break into a workstation, then physically or through local exploits reach another host. Remote services dissolve that boundary by letting credentials carry a “passport” that the network trusts. This solves the problem of restricted lateral movement: once inside a domain, the same account can hop to any node that accepts the protocol, regardless of physical location.  

A real‑world trigger is the shift to “remote‑first” workforces: many users now rely on VPN‑less, cloud‑hosted desktops. If an attacker steals a user’s credentials, they can walk straight into the data center and beyond.

## How It Works (Under The Hood)

1. **Credential acquisition** – Password, pass‑phrase, key, or token is stolen or guessed.  
2. **Authentication** – The attacker initiates a protocol handshake (e.g., RDP’s TLS‑protected key exchange).  
3. **Session establishment** – The target host validates the credential against its domain controller (or local account store).  
4. **Remote execution** – Once authenticated, the attacker runs commands or launches a shell, often through the protocol’s built‑in features (e.g., SMB’s “command execution” or SSH’s “remote shell”).  
5. **Pivoting** – The attacker uses the established session to spawn new connections from the compromised host to additional machines, repeating steps 2–4.  

Each sub‑technique follows this pattern but uses a different protocol‑specific channel: RDP streams a desktop, SMB shares a filesystem, SSH forwards ports, etc. In cloud environments, federated identities replace domain passwords, yet the same hop‑through logic applies.

## What Breaks When It Goes Wrong?

When an unauthorized remote session slips through, the first symptom is usually an *anomaly in network telemetry*: an unexpected RDP connection from a corporate IP to an unpaired server. IT teams then discover that the account has accessed resources it shouldn’t have.  

The blast radius can be huge:

- **Data exfiltration**: The attacker can pull files from any node in the domain.  
- **Ransomware spread**: Many ransomware families use RDP or SMB to move laterally.  
- **Credential stuffing**: Compromised accounts are reused in other attacks.  
- **Regulatory fines**: Breaches of personal data can trigger costly penalties.  

Because the attack uses *valid* credentials, it often bypasses traditional intrusion detection, leaving the human cost to be realized only when a critical service is down or a customer’s data is exposed.

---

_Ingested: 2026-04-15 20:21 | Source: https://attack.mitre.org/techniques/T1021/_