# Connect

## What it is
Like a tenant knocking on an apartment door to request entry, the TCP `connect()` system call is a client-side operation that initiates a full three-way handshake with a target port. It is the standard POSIX socket call that completes SYN → SYN-ACK → ACK before the OS reports the port as open.

## Why it matters
During reconnaissance, attackers use full `connect()` scans (Nmap's `-sT` flag) when they lack raw socket privileges — such as on a non-root Linux account or a restricted Windows host. This technique is louder than a SYN scan because the completed handshake is logged by most application-layer services, making it highly detectable by a SOC analyst reviewing auth or access logs.

## Key facts
- **Full-open scan**: `connect()` completes the entire TCP handshake, making it the most reliably accurate port scan method but the easiest to detect and log.
- **No raw socket required**: Unlike SYN (half-open) scans, `connect()` uses the OS network stack, so it works without administrator/root privileges.
- **Port state logic**: An open port responds SYN-ACK; a closed port responds RST; a filtered port drops the packet, causing a timeout.
- **Log footprint**: Because the connection is fully established, target services (SSH, HTTP, FTP) typically record the source IP in their own access logs — not just firewall logs.
- **Nmap flag**: `-sT` invokes connect scan; it is the default when the user lacks raw socket privileges.

## Related concepts
[[TCP Three-Way Handshake]] [[SYN Scan]] [[Port Scanning]] [[Nmap]] [[Network Reconnaissance]]