# AF_PACKET

## What it is
Think of AF_PACKET as a raw fire hose directly tapping into your network interface card, bypassing the kernel's normal packet processing. It's a Linux socket family that lets userspace programs capture and send raw network frames at Layer 2, giving you direct access to packets before the kernel's network stack touches them.

## Why it matters
Packet sniffers like tcpdump and Wireshark depend entirely on AF_PACKET to capture traffic for network forensics and intrusion detection. Attackers also use it to craft malicious frames and spoof Ethernet headers in ways that bypass higher-layer filtering—critical in ARP spoofing and MAC-layer attacks on local networks.

## Key facts
- Uses `socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL))` to capture all frames regardless of destination MAC
- Operates at Layer 2 (data link), capturing full Ethernet frames including headers kernel usually strips
- Requires `CAP_NET_RAW` capability—restricting this prevents unprivileged users from sniffing traffic
- Two modes: `SOCK_RAW` (full frame) and `SOCK_DGRAM` (frame stripped of link layer header)
- Enables both passive packet capture and active frame injection for network manipulation

## Related concepts
[[Raw Sockets]] [[libpcap]] [[Packet Injection]] [[Network Capabilities]] [[ARP Spoofing]]