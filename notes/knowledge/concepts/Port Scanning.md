# port scanning

## What it is
Like a burglar walking down a street trying every door and window to see which ones are unlocked, port scanning systematically probes a host's TCP/UDP ports to discover which services are open, closed, or filtered. It maps the attack surface of a target system before exploitation begins.

## Why it matters
During a penetration test — or a real intrusion — an attacker runs `nmap -sS 192.168.1.1` to perform a TCP SYN scan, discovering an exposed port 3389 (RDP). That single open port becomes the entry point for a brute-force or credential-stuffing attack that leads to full domain compromise. Defenders use the same technique proactively to find unintended exposures before attackers do.

## Key facts
- **TCP SYN scan (half-open scan)** sends a SYN packet and reads the response — SYN-ACK means open, RST means closed — without completing the handshake, making it stealthier than a full connect scan
- **Port states**: open (service listening), closed (host responds, no service), filtered (firewall drops packet, no response), and unfiltered (accessible but state unknown)
- **Well-known ports** run 0–1023 (e.g., 22=SSH, 80=HTTP, 443=HTTPS, 445=SMB), registered ports 1024–49151, dynamic/ephemeral 49152–65535
- **Nmap** is the de facto standard tool; `-sU` performs UDP scanning, which is slower because UDP has no handshake to confirm open ports
- Port scanning is often the **reconnaissance phase** in the Cyber Kill Chain and triggers IDS/IPS alerts when done rapidly (e.g., >1000 ports/second)

## Related concepts
[[network reconnaissance]] [[firewall]] [[intrusion detection system]] [[TCP/IP three-way handshake]] [[vulnerability scanning]]