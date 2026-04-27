# Security Concepts
**Why this matters:** Security is the foundation of network design—without understanding threats, authentication, and access control, you'll design networks vulnerable to attacks that compromise confidentiality, integrity, and availability.

---

## 11.1 Key Security Concepts

### The CIA Triad: The Three Pillars of Security

Think of the CIA triad like a bank vault. A vault needs three things to work:
- **Confidentiality**: Only the right people can open it (locked)
- **Integrity**: The contents can't be secretly altered while locked
- **Availability**: Authorized people can actually access it when needed

Now expand that: every system and piece of data in a network needs these three properties.

| CIA Component | Definition | Real-World Impact | Example |
|---|---|---|---|
| **Confidentiality** | Only authorized entities access systems/data | Prevents unauthorized viewing of sensitive information | Encrypted passwords, access control lists |
| **Integrity** | Data remains trustworthy; only authorized modification | Prevents tampering during storage or transmission | Digital signatures, checksums, hashing |
| **Availability** | Systems and data accessible to authorized users when needed | Ensures legitimate users aren't blocked from resources | Redundancy, DDoS mitigation, failover systems |

**Key principle**: When evaluating any security control or attack, ask: "Which part of the CIA triad does this affect?"

---

### Vulnerabilities, Exploits, Threats, and Mitigation

These four terms are related but distinct—exam questions test whether you can differentiate them.

**Vulnerability** = A potential weakness in a system
- Like an unlocked window in a house
- Exists even if no one tries to exploit it
- Examples: unpatched software, weak password policies, open ports

**Exploit** = A tool or technique that takes advantage of a vulnerability
- Like a crowbar used to pry open that window
- Can be code, a process, or a method
- Examples: [[SQL injection]] tools, [[buffer overflow]] techniques, password-cracking software

**Threat** = An actual person or group with intent and capability to exploit a vulnerability
- Like a burglar who intends to use a crowbar on your window
- Combines three elements: capability, intent, and opportunity
- Examples: malicious insiders, organized cybercriminals, hostile nation-states

**Mitigation Technique** = A control that reduces or eliminates risk
- Like installing bars over the window or motion-sensor lights
- Preventive (stops attack), detective (finds attack), or corrective (responds to attack)
- Examples: [[DHCP Snooping]], [[port security]], [[access control lists]], encryption

**Formula for risk**: Risk = Threat × Vulnerability × Impact (If no threat exists, or vulnerability is patched, or impact is mitigated, risk drops significantly)

---

## 11.2 Common Threats

### Technical Threats Overview

Attackers target the CIA triad from multiple angles. Understanding each threat type helps you implement appropriate defenses.

---

### Denial-of-Service (DoS) and Distributed DoS (DDoS)

**What it is**: A malicious attempt to make a system, service, or network unusable by overwhelming it with traffic.

**CIA impact**: **Availability** (primary target)

**How it works**:
1. Attacker floods target with requests faster than it can handle
2. Legitimate traffic cannot reach the service
3. System resources (CPU, memory, bandwidth) are exhausted

**Common DoS attack types**:

| Attack Type | Mechanism | Target | Mitigation |
|---|---|---|---|
| **SYN Flood** | Send thousands of [[TCP]] SYN packets with spoofed IPs | TCP three-way handshake | SYN cookies, connection limits, rate limiting |
| **UDP Flood** | Bombard target with high-volume [[UDP]] packets | Bandwidth and CPU | Rate limiting, traffic filtering, UDP rate-based detection |
| **ICMP Flood** (Ping Flood) | Flood target with ICMP Echo Requests | Bandwidth | Disable ICMP responses, rate limiting |
| **Smurf Attack** | Send ICMP to broadcast address (spoofed source = victim) | Bandwidth amplification | Disable directed broadcasts, filter ICMP |
| **Botnet/DDoS** | Thousands of compromised devices attack simultaneously | Any resource | Scrubbing centers, mitigation services, firewalls |

**Why SYN floods work**: The target's TCP connection table fills with half-open connections waiting for the final [[ACK]], preventing legitimate connections from being established.

---

### Spoofing Attacks

**What it is**: Falsifying a device's identity by using a fake source IP address or MAC address.

**CIA impact**: **Confidentiality** and **Integrity** (enables other attacks)

**Spoofing is not the attack itself—it's a technique used in other attacks:**

| Attack | How Spoofing is Used |
|---|---|
| SYN Flood | Attacker spoofs source IP so return traffic doesn't reach them |
| DHCP Exhaustion | Attacker sends DISCOVER messages with fake MAC addresses |
| [[ARP]] Spoofing | Attacker claims ownership of another device's IP (creates man-in-the-middle) |
| Email Spoofing | Attacker forges sender address |

**DHCP Exhaustion (DHCP Starvation)**:
- Attacker floods DHCP server with DISCOVER messages using spoofed MAC addresses
- DHCP server's address pool is exhausted
- Legitimate clients cannot receive IP addresses
- Network becomes unusable for new connections

---

### Man-in-the-Middle (MitM) Attacks

**What it is**: Attacker positions themselves between two communicating parties and intercepts/modifies traffic.

**CIA impact**: **Confidentiality** (eavesdropping) and **Integrity** (message modification)

**How it works**:
1. Attacker intercepts communication channel
2. Attacker reads or modifies messages
3. Both parties believe they're communicating securely
4. Parties are unaware of the attacker's presence

**Common MitM scenarios**:
- **[[ARP]] Spoofing**: Attacker sends fake ARP replies to associate their MAC with a legitimate IP
- **DNS Spoofing**: Attacker responds to DNS queries with a fake IP address
- **SSL/TLS Stripping**: Attacker downgrades HTTPS to HTTP to read unencrypted traffic
- **Rogue Access Point**: Attacker creates fake wireless network with legitimate SSID

**Mitigation**:
- Use [[HTTPS]] / TLS encryption (prevents reading, detects modification)
- Implement [[DHCP Snooping]] (prevents ARP spoofing on Layer 2)
- Use certificate pinning (detects rogue certificates)
- Implement [[port security]] to prevent unauthorized MAC addresses

---

### Reconnaissance Attacks (Information Gathering)

**What it is**: Attacker gathers information about a network or system before launching actual attacks.

**CIA impact**: **Confidentiality** (indirectly—enables future attacks)

**Not technically an attack, but the precursor to attacks.**

**Common reconnaissance techniques**:

| Technique | Method | Information Obtained |
|---|---|---|
| **Ping Sweep** | Send ICMP Echo to range of IPs | Which hosts are alive |
| **Port Scanning** | Send packets to common ports | Which services are running |
| **Banner Grabbing** | Connect to service and read response | Software version, OS type |
| **DNS Enumeration** | Query DNS records | Domain structure, subdomains, mail servers |
| **Social Engineering** | Call/email employees for info | Passwords, physical locations, org structure |
| **Packet Sniffing** | Capture network traffic | Usernames, unencrypted credentials, data patterns |

**Why it matters**: An attacker who knows your network topology, running services, and software versions can craft targeted exploits. Reconnaissance is the first phase of a multi-stage attack.

**Mitigation**:
- Disable [[ICMP]] responses (prevent ping sweeps)
- Use non-standard ports for critical services
- Hide service banners (don't advertise software versions)
- Implement firewalls to limit port access
- Use intrusion detection to alert on scanning activity

---

### Malware

**What it is**: Malicious software designed to damage, disrupt, or gain unauthorized access to systems.

**CIA impact**: All three—confidentiality (stealing data), integrity (modifying files), availability (crashing system)

**Types of malware**:

| Type | Behavior | Damage | Example |
|---|---|---|---|
| **Virus** | Attaches to legitimate files; spreads when file executes | File corruption, system slowdown | Overwrites boot sector |
| **Worm** | Self-propagating; doesn't need user action | Consumes bandwidth, CPU, spreads network-wide | [[WannaCry]], Conficker |
| **Trojan** | Appears legitimate but contains hidden malicious code | Backdoor access, data theft, system compromise | RAT (remote access trojan) |
| **Ransomware** | Encrypts files and demands payment for decryption | Data unavailability, financial loss | Crypto-locker |
| **Spyware** | Secretly monitors user activity | Credential theft, identity theft | Keystroke logger |
| **Botnet** | Compromises device and uses it in coordinated attacks | Turns device into attack platform | Used in DDoS attacks |
| **Rootkit** | Hides malware presence from detection | Persistent access even after OS reinstall | Deep system compromise |

**Mitigation**:
- Keep OS and software patches current
- Use antivirus/anti-malware software
- Implement application whitelisting
- User training on suspicious files/links
- Network segmentation to contain spread

---

### Password-Related Attacks

**What it is**: Attempts to compromise user credentials, the foundation of authentication.

**CIA impact**: **Confidentiality** (unauthorized access) and **Integrity** (unauthorized changes)

**Common password attacks**:

| Attack | Method | Defense |
|---|---|---|
| **Brute Force** | Try every possible password combination | Account lockout, strong passwords, rate limiting |
| **Dictionary Attack** | Try common words/passwords | Password complexity requirements, account lockout |
| **Credential Stuffing** | Use credentials from previous breaches | Enforce unique passwords across services, MFA |
| **Phishing** | Social engineering to trick users into revealing passwords | User training, email filtering, MFA |
| **Password Spraying** | Try one weak password across many accounts | Account lockout, monitoring, user training |
| **Rainbow Tables** | Pre-computed hash values used to crack passwords | Salt hashes, strong hashing algorithms ([[bcrypt]], [[Argon2]]) |
| **Keylogger** | Malware captures keystrokes | Antimalware, MFA, hardware security keys |

**Why passwords are weak**:
- Users reuse passwords across services
- Users choose predictable patterns
- Passwords are often written down or shared
- No verification that the person entering password is the legitimate user

**Mitigation** ([[#11.3 User Authentication|covered below]]): Strong password policies, [[multifactor authentication]], biometrics, certificates.

---

## 11.3 User Authentication

**Authentication** = Verifying identity: "Are you who you claim to be?"

**Authorization** (not the same thing) = Verifying permissions: "Are you allowed to do this?"

---

### Password-Based Authentication

**The standard, but with serious limitations.**

**Password policy best practices**:

| Policy Element | Recommendation | Rationale |
|---|---|---|
| **Minimum Length** | At least 12 characters (14+ preferred) | Exponentially harder to brute force |
| **Complexity** | Mix uppercase, lowercase, numbers, symbols | Reduces dictionary attack effectiveness |
| **Expiration** | 60–90 days for sensitive accounts | Limits window of compromise from stolen passwords |
| **History** | Prevent reuse of last 5–10 passwords | Stops users from rotating back to old passwords |
| **Account Lockout** | Lock after 3–5 failed attempts for 15–30 min | Stops brute force attacks |
| **Minimum Age** | Prevent changing password multiple times/day | Prevents lockout policy bypass via rapid changes |

**Problems with passwords alone**:
- Users forget them (support costs)
- Users reuse them across services
- Weak passwords remain common despite policies
- No proof the person typing password is the actual

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 11 | [[CCNA]]*
