# Internal Servers

## What it is
Like the back-of-house kitchen in a restaurant — customers never see it, but everything depends on it running correctly. Internal servers are hosts that operate exclusively within a private network (LAN/intranet), providing services such as file sharing, authentication, databases, or email relay to internal users only, without direct exposure to the public internet.

## Why it matters
During a 2020 SolarWinds-style lateral movement attack, threat actors compromised an internal file server after pivoting from an internet-facing endpoint — exfiltrating terabytes of sensitive data that was never meant to leave the building. This illustrates why internal servers can't be treated as "safe by default" simply because they lack a public IP; once an attacker establishes a foothold, the internal network becomes the primary hunting ground.

## Key facts
- Internal servers typically sit behind a firewall on RFC 1918 address space (10.x.x.x, 172.16–31.x.x, 192.168.x.x), making them unreachable from the public internet without explicit routing or VPN
- A **jump server (bastion host)** is the controlled gateway used to administer internal servers, reducing direct attack surface
- Misconfigured internal servers are a primary target for **privilege escalation** and **lateral movement** post-initial compromise
- Internal DNS servers can be weaponized via **DNS poisoning** to redirect internal traffic — attackers don't need internet access for this
- **Network segmentation** (VLANs, micro-segmentation) is the primary defense to limit blast radius if one internal server is compromised; Security+ exam frequently tests this control

## Related concepts
[[Network Segmentation]] [[Jump Server]] [[Lateral Movement]] [[RFC 1918 Addressing]] [[DMZ]]