# PPTP

## What it is
Think of PPTP like a paper envelope slid inside a second envelope — it wraps PPP traffic inside GRE packets to tunnel it across a network, but the outer envelope is embarrassingly thin. Point-to-Point Tunneling Protocol (PPTP) is a legacy VPN protocol developed by Microsoft in 1996 that encapsulates PPP frames using GRE and authenticates via MS-CHAPv2 over TCP port 1723.

## Why it matters
In 2012, security researcher Moxie Marlinspike released CloudCracker, demonstrating that MS-CHAPv2 — the backbone of PPTP authentication — could be broken with 100% certainty using a single DES key brute-force attack. Organizations still running PPTP VPNs for remote access were exposing employee credentials and internal network traffic to any attacker capable of capturing the handshake, which is trivially done on public Wi-Fi.

## Key facts
- Uses **TCP port 1723** for control and **GRE (protocol 47)** for data encapsulation — GRE is not TCP/UDP, which causes problems with many NAT devices
- Authentication relies on **MS-CHAPv2**, which has been cryptographically broken and should never be trusted for sensitive communications
- Encryption uses **MPPE (Microsoft Point-to-Point Encryption)** with RC4 — RC4 itself is deprecated and considered weak
- The NSA is widely reported to have been able to decrypt PPTP traffic in bulk, making it unsuitable for any threat model involving nation-state actors
- **No Perfect Forward Secrecy (PFS)** — compromising the session key exposes all past traffic encrypted under it
- Officially deprecated; Security+ and CySA+ flag it as an example of a **weak or legacy VPN protocol** that should be replaced by L2TP/IPSec, IKEv2, or OpenVPN

## Related concepts
[[MS-CHAPv2]] [[L2TP]] [[GRE Tunneling]] [[RC4]] [[VPN Protocols]]