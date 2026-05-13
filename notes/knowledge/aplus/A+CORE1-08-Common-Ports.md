# Common Ports

## What it is

Every networked service answers the door at a specific number. SSH at 22. HTTPS at 443. RDP at 3389. The IP address gets you to the building; the port number gets you to the right office inside it.

Plain English: a port is a 16-bit number (0–65535) that tells the OS which running service should handle an incoming packet. Your laptop has one IP address but dozens of services listening — the port is how the kernel routes the traffic to the right one. Web browser traffic goes to port 443, your remote desktop session goes to 3389, your DNS lookup goes to 53. Same wire, same IP, different doors.

Technical: ports live in the TCP and UDP headers. The first 1024 are **well-known ports** assigned by IANA — that's the list CompTIA wants you to memorize. Ports 1024–49151 are **registered** (vendor-claimed). 49152–65535 are **dynamic/ephemeral** — the OS assigns these to your outbound connections. When your browser hits a website, your end of the conversation is some random port like 52341; the server's end is 443. The combination of source IP + source port + destination IP + destination port + protocol is called the **socket** — that's what uniquely identifies a single conversation.

In the body metaphor: if the IP address is the building's street address and the network stack is the voice, ports are the room numbers. The receptionist (the kernel) routes the visitor to the right office.

## Why it matters

Every A+ exam has port-number questions. CompTIA loves them because they're unambiguous — either you know SMB is 445 or you don't. Objective 220-1201 2.1 lists roughly fifteen ports you must know cold.

Beyond the exam: ports are the language of firewall rules, troubleshooting, and security. A user says "I can't reach the server." You ask: which service? RDP? Then we're checking 3389. Email broken? 25, 110, 143, 587, 993, 995 — which protocol, which direction? Every helpdesk ticket involving network reachability ends in a port number eventually.

Security side: open ports are attack surface. Telnet on 23 in 2026 is a resume-generating event. SMB on 445 exposed to the internet is how WannaCry happened. The ports you close matter as much as the ones you open.

## In your build, in the enterprise

**Beat 1 — Technical depth.** TCP and UDP both use ports but behave differently. TCP is connection-oriented: three-way handshake (SYN, SYN-ACK, ACK), guaranteed delivery, ordered packets, retransmission on loss. UDP is fire-and-forget: no handshake, no guarantee, no ordering. Use TCP when correctness matters (web pages, file transfers, SSH sessions). Use UDP when speed matters more than perfection (DNS lookups, VoIP, game traffic, video streaming). Some protocols use both: DNS uses UDP for normal lookups but switches to TCP for zone transfers and large responses.

A few ports use both TCP and UDP officially. DNS (53) does. Most don't — HTTPS is TCP only, SSH is TCP only.

**Beat 2 — Feynman example via gaming/personal build.** You're hosting a Minecraft server on your gaming PC for friends. Three ports become real fast.

**Port 25565 (Minecraft default, TCP):** You forward this on your router to your PC's LAN IP. Friends connect to your public IP on 25565, your router NATs it to your PC, the Minecraft server process is listening on that port and accepts the connection. *Port forwarding is just teaching the router which inside door to open when an outside knock arrives.*

**Port 22 (SSH, TCP):** You also have a Linux box running a Pi-hole. You SSH in from your laptop on port 22 to tweak the config. If you expose 22 to the internet, every botnet on Earth will hammer it within an hour. *Move it to a non-standard port, use key auth, and the noise drops 99%.*

**Port 53 (DNS, UDP):** Your Pi-hole listens on 53 to answer DNS for your whole house. When your phone asks "where is twitch.tv?", the query is a UDP packet to your Pi-hole on 53. Pi-hole answers (or blocks). *DNS is UDP because the query is tiny, the answer is tiny, and if it drops you just ask again — handshake overhead would be wasted.*

**The kicker:** Open `netstat -an` on your gaming PC mid-session. You'll see dozens of connections — Steam, Discord, Spotify, the game, Windows Update — each with its own port pair. The OS has been juggling all of them at once, and you never noticed. *That's what the port number is doing every second your machine is on.*

**Beat 3 — Bridge from gaming to enterprise.** Same fundamental question — which service, which port, which direction — scales straight into enterprise work. At home you forward 25565 to your Minecraft box. At work, the firewall team opens 443 to a load balancer that fronts a web app. At home you SSH to your Pi-hole. At work, jump boxes accept SSH only from a management VLAN, and your session is logged. At home your Pi-hole is the DNS server; at work, Active Directory domain controllers serve DNS on 53 plus LDAP on 389 (or LDAPS on 636) plus Kerberos on 88. Same ports, vastly more rules around them.

The home environment trusts everything inside the LAN. The enterprise trusts nothing — every port between zones is a deliberate firewall rule with a ticket attached.

**Beat 4 — The point.** Same question — *what service, what port, what direction, who's allowed* — different scale, different stakes. Get this question into your bones. You'll ask it for the rest of your career, every time something doesn't connect.

## Key facts

### The port table — memorize this cold

| Port | Protocol | TCP/UDP | What it does |
|---|---|---|---|
| **20, 21** | FTP | TCP | File transfer. 21 = control, 20 = data. Plaintext, dead outside legacy systems. |
| **22** | SSH / SFTP / SCP | TCP | Encrypted remote shell and file transfer. The replacement for Telnet and FTP. |
| **23** | Telnet | TCP | Plaintext remote shell. Obsolete. If you see it, kill it. |
| **25** | SMTP | TCP | Email sending (server-to-server). |
| **53** | DNS | UDP + TCP | Name resolution. UDP for queries, TCP for zone transfers and large responses. |
| **67, 68** | DHCP | UDP | 67 = server, 68 = client. How devices get IP addresses automatically. |
| **80** | HTTP | TCP | Plaintext web. Mostly redirects to 443 now. |
| **110** | POP3 | TCP | Email retrieval, downloads-and-deletes model. Largely replaced by IMAP. |
| **137, 138, 139** | NetBIOS / NetBT | UDP (137, 138), TCP (139) | Legacy Windows name service and file sharing. 137 = name, 138 = datagram, 139 = session. |
| **143** | IMAP | TCP | Email retrieval, server-side folder model. |
| **161, 162** | SNMP | UDP | Network device monitoring. 161 = queries, 162 = traps. |
| **389** | LDAP | TCP (also UDP) | Directory service queries. Active Directory uses this. |
| **443** | HTTPS | TCP | Encrypted web. The default for everything in 2026. |
| **445** | SMB / CIFS | TCP | Windows file and printer sharing. The protocol behind every mapped drive. |
| **3389** | RDP | TCP (also UDP) | Remote Desktop. How techs and admins reach Windows boxes graphically. |

### Email port quick reference

Email confuses people because there are six ports across three protocols and two security states.

| Job | Plaintext | Encrypted |
|---|---|---|
| Send (SMTP) | 25 (server-to-server) | 587 (submission, STARTTLS) or 465 (SMTPS) |
| Retrieve (POP3) | 110 | 995 |
| Retrieve (IMAP) | 143 | 993 |

The exam pattern: 25/110/143 are the plaintext defaults. The encrypted versions sit at 587/995/993. Don't confuse 25 (server-relay) with 587 (client submission).

### TCP vs UDP — when each gets used

**TCP** for: HTTP/HTTPS, SSH, FTP, SMTP, IMAP/POP3, RDP, SMB, LDAP. Anything where missing a packet ruins the result.

**UDP** for: DNS queries, DHCP, SNMP, VoIP, video streaming, online gaming, NetBIOS name service. Anything where speed matters more than perfection, or where the application handles its own retry logic.

### CompTIA exam traps

> **CompTIA exam trap:** SMB is **445**, not 139. NetBIOS over TCP (NetBT) uses 137–139, and old SMB rode on top of NetBIOS via 139. Modern SMB (since Windows 2000) talks directly on 445. CompTIA tests this distinction — 445 is the answer for "Windows file sharing" unless the question explicitly says NetBIOS.

> **CompTIA exam trap:** DHCP is **67 and 68**, both UDP. 67 = server, 68 = client. Easy to flip them under exam stress. Mnemonic: server is lower, client is higher.

> **CompTIA exam trap:** DNS on **53 uses both UDP and TCP**. Default queries are UDP (small, fast). TCP kicks in for zone transfers and responses larger than 512 bytes. If a question says "DNS uses only UDP," it's wrong.

> **CompTIA exam trap:** RDP is **3389**. Easy to confuse with 3306 (MySQL, not on the A+ list but adjacent). RDP runs primarily over TCP but Windows added UDP support for performance — TCP is the default A+ answer.

> **CompTIA exam trap:** FTP is **20 and 21**. 21 is control (commands), 20 is active-mode data. Most modern FTP runs in passive mode, which uses 21 for control and a random high port for data — but the textbook A+ answer is 20/21.

## Helpdesk reality

- User says "the website is down." First questions: HTTP or HTTPS? Internal or external? You're checking whether 80 or 443 is reachable from their network, not whether the site exists.
- "I can't get my email." Six ports in play — find out if it's send (25/587) or receive (110/143/993/995). Mail clients silently fail when one port is blocked and the other isn't.
- "RDP doesn't work from home." 3389 is almost never exposed directly to the internet in 2026. They need to be on the VPN first, then RDP across the tunnel. Never tell a user "we'll just open 3389 to your home IP."
- "Can you open this port on the firewall?" Never promise yes on the spot. That's a change-management ticket with security review. The right answer is "let me submit the request — what's the business justification?"
- A screenshot from a SME shows a connection error mentioning a specific port. Drop it into the company-approved AI assistant to identify the protocol fast, then you do the troubleshooting. *Tool for recognition, not for the decision.*

## Related concepts

[[TCP vs UDP]] · [[DNS]] · [[DHCP]] · [[Firewalls]] · [[SSH]] · [[HTTPS and TLS]] · [[SMB and File Sharing]] · [[Email Protocols]] · [[Active Directory and LDAP]] · [[RDP and Remote Access]]

*Source: VIRGIL knowledge base — 2026-05-10*