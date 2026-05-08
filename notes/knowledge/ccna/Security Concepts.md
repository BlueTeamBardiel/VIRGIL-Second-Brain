# Security Concepts

## What it is

In Far Cry, an outpost has weak points (the alarm box you can disable, the sniper in the tower, the unpatrolled rear fence), you have tools that exploit them (silenced sniper, wingsuit infiltration, a grenade through the window), and *you* — the player choosing to liberate it — are the threat. Remove the weak points, the tools, or the player, and the outpost stands untouched.

The whole field rests on three guarantees, often called the **CIA triad**:

- **Confidentiality** — only authorized eyes see the data. Like the radio chatter between Pagan Min's lieutenants: meant for them, not for you crouched in the grass with a directional mic.
- **Integrity** — data isn't tampered with in transit or at rest. The intel marker on your map should say "convoy at 0600," not coordinates that lead you into an ambush.
- **Availability** — the system is up when you need it. The fast-travel network being knocked offline mid-mission is an availability failure, and the walk back is suffering.

Around that core, four more terms define the threat model:

- **Vulnerability** — a weakness sitting in the code or config (the alarm box nobody welded shut).
- **Exploit** — the actual tool or technique that abuses the vulnerability (the wire cutters in your hand).
- **Threat** — the person or group with both *intent* and *capability* to use the exploit (you, the liberator — not the goat wandering past the fence).
- **Mitigation** — the control that reduces the risk (extra guards, floodlights, attack dogs on patrol).

And the formula tying it all together: **Risk = Threat × Vulnerability × Impact**. Zero out any factor and risk goes to zero — which is why you patch (kill vulnerability), block attackers (kill threat exposure), or segment networks (limit impact).

## Why it matters

Every defensive control you'll ever configure — ACLs, port security, DHCP snooping, MFA, rate limits — is just a specific answer to "which leg of CIA am I protecting, and from which attack class?" Without this mental model, security work feels like a pile of disconnected checkboxes. With it, every config line has a purpose.

It also matters because attackers don't kick down the front door first. They case the building. Recognizing reconnaissance early — the Ping Sweeps, the Port Scans — is often the difference between catching an intruder in the lobby and finding out about them on the news.

## Key facts

### Denial-of-Service (Availability attacks)

The whole family is about making something unusable by drowning it. Think of a Twitch chat during a major drop event — so much noise nothing useful gets through.

- **DoS / DDoS** — overwhelm a system, service, or network with traffic until legitimate users can't get in.
- **SYN Flood** — fires thousands of TCP SYN packets with spoofed source IPs. The server allocates a half-open connection for each one and waits for an ACK that never comes. Like sending 10,000 Uber Eats orders to a restaurant from fake addresses — the kitchen fills up before any real customer can order. The TCP connection table fills, real users get refused.
- **UDP Flood** — high volume of UDP packets at random ports. The target burns CPU answering "no service here" until it falls over.
- **ICMP Flood** — same idea with ICMP Echo Requests.
- **Smurf Attack** — sends ICMP Echo to a network's *broadcast address*, but spoofs the source as the victim. Every host on that network replies *to the victim*. One packet in, hundreds out. Reflection and amplification in one move.

**Mitigations:** SYN cookies (the server stops allocating state for half-opens), connection limits, rate limiting, disabling directed broadcasts (kills Smurf), filtering ICMP, scrubbing centers (cloud-scale traffic washing machines), and firewalls.

### Spoofing & Man-in-the-Middle (Integrity + Confidentiality attacks)

Spoofing is Among Us in network form — wear someone else's identity and act normally until you stab.

- **Spoofing** — fake source IP or MAC to impersonate a device.
- **DHCP Exhaustion** — flood the DHCP server with DISCOVER messages from spoofed MACs until the address pool is empty. Now nobody gets an IP, and an attacker can stand up a rogue DHCP server to hand out poisoned configs.
- **MitM** — attacker sits between two parties, reading or rewriting traffic. Like a fake delivery driver intercepting your DoorDash, peeking in the bag, and handing it over.
- **ARP Spoofing** — fake ARP replies tell the LAN "that legit IP belongs to *my* MAC." Layer 2 trust is implicit, so it just works.
- **DNS Spoofing** — answer DNS queries with a malicious IP. You typed the right URL; you landed in the wrong place.
- **SSL/TLS Stripping** — downgrades the connection from HTTPS to HTTP so traffic is readable.
- **Rogue Access Point** — fake Wi-Fi with the same SSID as the real one. The Watch Dogs 2 starter move.

**Mitigations:** DHCP snooping (Layer 2 sanity check on DHCP traffic), Dynamic ARP Inspection, port security (cap MACs per port), certificate pinning (the app refuses any cert that isn't *the* cert).

### Reconnaissance

The casing-the-joint phase. Cyberpunk 2077's scanner mode applied to networks.

- **Ping Sweep** — ICMP Echo across an IP range to find live hosts.
- **Port Scanning** — probe common ports to map running services.
- **Banner Grabbing** — connect to a service and read its response to learn software name, version, and OS. Like inspecting a player's loadout in Tarkov before deciding to engage.
- **DNS Enumeration** — pull DNS records to map subdomains, mail servers, and infrastructure.
- **Packet Sniffing** — passively capture traffic for credentials, tokens, patterns.

**Mitigations:** disable ICMP responses to kill ping sweeps, restrict service banners, limit external DNS exposure, encrypt everything so sniffing yields ciphertext.

### Malware

- **Virus** — attaches to a legit file; spreads when the file is executed. Needs a host.
- **Worm** — self-propagating, no user action required. The reason network segmentation exists.
- **Trojan** — looks legit, hides malicious code inside. The free "totally not a cheat" download.
- **Ransomware** — encrypts files, demands payment. The modern hostage situation.
- **Spyware** — silently monitors user activity.
- **Botnet** — your device gets conscripted into someone else's army for coordinated attacks (usually DDoS).
- **Rootkit** — hides other malware from detection. The cloak, not the dagger.
- **Keylogger** — captures keystrokes, including passwords.

### Password & Credential attacks

- **Brute Force** — try every combination. Slow, loud, eventually wins if there's no lockout.
- **Dictionary Attack** — try common words and known passwords. Faster than brute force because humans are predictable.
- **Credential Stuffing** — replay username/password pairs leaked from other breaches. The reason password reuse is the original sin.
- **Password Spraying** — try one weak password (`Summer2024!`) across thousands of accounts. Stays under per-account lockout thresholds.
- **Rainbow Tables** — pre-computed hash lookups; turn cracking into a search problem. Defeated by salting hashes.
- **Phishing** — social engineering instead of computation. Easier than cracking when the user will just hand it over.

**Authentication vs Authorization:** authentication asks "who are you?" (showing ID at the door), authorization asks "what are you allowed to do?" (do you have backstage access). Different problems, different controls.

**Password hygiene baseline:**
- Minimum **12 characters**, 14+ preferred.
- Mix uppercase, lowercase, numbers, symbols.
- Expire sensitive account passwords every **60–90 days**.
- Lock accounts after **3–5 failed attempts** for **15–30 minutes** — kills brute force and spraying without locking out forgetful humans forever.

## Related concepts

[[CIA Triad]]
[[TCP Three-Way Handshake]]
[[ARP and DHCP Snooping]]
[[Port Security]]
[[Firewalls and ACLs]]
[[AAA - Authentication Authorization Accounting]]
[[Multi-Factor Authentication]]
[[Network Segmentation and VLANs]]
[[TLS and Certificate Pinning]]
[[IDS and IPS]]
[[Social Engineering]]