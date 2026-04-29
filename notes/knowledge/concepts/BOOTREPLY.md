# BOOTREPLY

## What it is
Like a hotel front desk sliding a room key and breakfast voucher under your door after you knocked asking for directions — BOOTREPLY is the server-side response in the BOOTP protocol, delivering IP address, subnet mask, gateway, and boot file information back to a client that sent a BOOTREQUEST. It operates at the application layer over UDP port 67 (server) to port 68 (client), and is the direct ancestor of DHCP's OFFER and ACK messages.

## Why it matters
Rogue DHCP/BOOTP server attacks exploit the BOOTREPLY mechanism: an attacker on the local network races to respond to client BOOTREQUEST messages before the legitimate server, injecting a malicious gateway IP to perform man-in-the-middle attacks. Because clients accept the *first* valid BOOTREPLY they receive, there is no authentication — making network segmentation and DHCP snooping critical defensive controls.

## Key facts
- BOOTREPLY uses **UDP source port 67, destination port 68** — the same port pairing inherited by DHCP
- The BOOTREPLY packet contains a **"op" field set to value 2** (BOOTREQUEST uses value 1), making it trivially identifiable in packet captures
- BOOTP (and BOOTREPLY) is **stateless and lacks any authentication mechanism**, meaning spoofed replies are trivially crafted
- DHCP is a direct extension of BOOTP; a DHCP OFFER/ACK is technically a BOOTREPLY with added **option 53** specifying message type
- **DHCP snooping** on managed switches mitigates rogue BOOTREPLY attacks by whitelisting trusted ports that can send server-side BOOTP/DHCP responses

## Related concepts
[[DHCP Spoofing]] [[Rogue DHCP Server]] [[DHCP Snooping]] [[Man-in-the-Middle Attack]] [[UDP]]