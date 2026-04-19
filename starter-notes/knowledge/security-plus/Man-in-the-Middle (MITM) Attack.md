```markdown
---
domain: "network-security"
tags: [mitm, on-path-attack, network-attack, interception, cryptography, security-plus]
---
# Man-in-the-Middle (MITM) Attack

A **Man-in-the-Middle (MITM) attack** — officially renamed **on-path attack** by NIST and CompTIA in recent guidance — is a class of interception attack in which an adversary covertly inserts themselves into a communication channel between two parties, relaying and optionally modifying traffic while both endpoints believe they are speaking directly. MITM is a foundational attack pattern underlying many real-world compromises, from [[ARP Spoofing]] on a LAN to [[BGP Hijacking]] across the internet backbone, and it is one of the primary threats that drives adoption of strong [[TLS]] and [[Mutual TLS (mTLS)]].

---

## Overview

A MITM attack exploits the trust model of a communications channel. In the canonical model, Alice intends to speak to Bob, but Mallory sits between them: Alice's packets reach Mallory first, Mallory forwards them to Bob (possibly altered), and Bob's replies return through Mallory. If no authenticated, integrity-protected channel exists — or if one exists but can be stripped, downgraded, or impersonated — neither endpoint can detect the interposition.

The attack is as old as telecommunications itself. Telegraph operators tapped wires, radio operators intercepted transmissions, and early computer networks inherited the vulnerability when plaintext protocols like **Telnet**, **HTTP**, **FTP**, **SMTP**, and **POP3** became widespread. As encryption moved into mainstream use during the 1990s and 2000s, attackers evolved from raw eavesdropping to active manipulation: tricking clients into accepting fraudulent certificates, downgrading cipher suites, or stripping encryption entirely before it could be negotiated.

MITM attacks fall into several broad categories based on network layer:

- **Layer 2 (LAN)**: [[ARP Spoofing]], [[MAC Flooding]], [[STP Manipulation]], rogue [[DHCP]] servers, [[IPv6]] Router Advertisement attacks.
- **Layer 3 (Routing/DNS)**: [[DNS Poisoning]], [[BGP Hijacking]], ICMP redirect abuse.
- **Layer 7 (Application)**: [[SSL Stripping]], TLS downgrade (POODLE, FREAK, Logjam), [[Session Hijacking]], malicious proxies, rogue browser extensions.
- **Wireless**: [[Evil Twin Attack]], [[KRACK Attack]], Karma attacks against probing clients.

Real-world incidents illustrate the impact. In 2011, the **DigiNotar** CA compromise allowed attackers to issue valid certificates for `*.google.com`, enabling nation-state MITM against Iranian Gmail users. In 2015, Lenovo shipped laptops with the **Superfish/Komodia** adware, which installed a universal root CA and MITM'd every HTTPS connection to inject ads. The NSA's **QUANTUM INSERT** program, revealed by Snowden disclosures, used upstream taps to race legitimate servers and inject malicious responses. **Public Wi-Fi** remains the most common real-world MITM vector against ordinary users.

---

## How It Works

The mechanics depend on the layer being attacked, but every MITM requires two capabilities: **traffic redirection** (getting packets to flow through the attacker) and **channel impersonation** (presenting as the legitimate peer at the chosen layer).

### Layer-2 ARP Spoofing Walkthrough

On a switched Ethernet LAN, hosts discover each other's MAC addresses via ARP. ARP is stateless and unauthenticated — any host can claim any IP.

1. Attacker joins the LAN (physically, via Wi-Fi, or via compromised host).
2. Attacker enables IP forwarding so traffic is transparently relayed:
   ```bash
   sudo sysctl -w net.ipv4.ip_forward=1
   sudo sysctl -w net.ipv6.conf.all.forwarding=1
   ```
3. Attacker sends **gratuitous ARP replies** to the victim claiming the gateway's IP resolves to the attacker's MAC, and to the gateway claiming the victim's IP resolves to the attacker's MAC:
   ```bash
   # Bidirectional poisoning with arpspoof (dsniff suite)
   sudo arpspoof -i eth0 -t 192.168.1.50 -r 192.168.1.1
   ```
4. Victim's ARP cache is poisoned; all traffic bound for the gateway flows through the attacker.
5. Attacker now inspects, logs, or modifies traffic using **Wireshark**, **tcpdump**, or scripted proxies.

### Using bettercap (Modern Tooling)

```bash
sudo bettercap -iface eth0
# Inside the bettercap REPL:
» net.probe on
» net.show
» set arp.spoof.fullduplex true
» set arp.spoof.targets 192.168.1.50
» arp.spoof on
» net.sniff on
» set http.proxy.sslstrip true
» http.proxy on
```

### SSL Stripping

Introduced by Moxie Marlinspike in 2009, **sslstrip** watches for HTTP→HTTPS redirects and rewrites them, keeping the victim on plaintext HTTP while the attacker maintains an HTTPS session upstream. The victim sees `http://bank.example.com` with no lock icon; credentials transit in cleartext. Modern browsers resist this via **HSTS preload lists** and `upgrade-insecure-requests`, but legacy sites and first-connection scenarios remain vulnerable.

### DNS-Based MITM

```bash
# Inside bettercap
» set dns.spoof.domains *.bank.com,*.google.com
» set dns.spoof.address 10.0.0.99
» dns.spoof on
```
The victim resolves a banking domain to the attacker's IP. The attacker either serves a phishing clone or transparently proxies the real site to harvest session cookies without the victim noticing any disruption.

### TLS MITM

Breaking TLS without detection generally requires one of:
- A **rogue or compromised CA** trusted by the victim's OS (DigiNotar, Superfish).
- A **pre-installed attacker root certificate** — corporate inspection proxies like **Zscaler** and **Blue Coat** operate this way legitimately; malware does so covertly.
- **User acceptance of a certificate warning** — clicking through an untrusted-cert prompt hands the session to the attacker.
- A **cryptographic weakness** — SSL 3.0 (POODLE), EXPORT ciphers (FREAK), weak Diffie-Hellman (Logjam), RC4 statistical biases.

Without one of these prerequisites, a modern TLS 1.3 connection with proper certificate validation is cryptographically robust against passive and active MITM.

---

## Key Concepts

- **On-path attacker**: The current NIST SP 800-series and CompTIA SY0-701 term for MITM; inclusive of both passive eavesdropping and active modification, and preferred because it describes position rather than gender.
- **ARP poisoning**: Forging unsolicited ARP replies to associate the attacker's MAC with a legitimate host's IP, redirecting Layer-2 traffic through the attacker without modifying routing tables.
- **DNS spoofing**: Returning forged DNS answers — either on-path or via cache poisoning — to direct victims to attacker-controlled IP addresses before any TCP session is established.
- **SSL/TLS stripping**: A downgrade attack that intercepts HTTP→HTTPS redirects and rewrites links so the client communicates in cleartext while the attacker maintains an encrypted upstream session.
- **Evil twin**: A rogue Wi-Fi AP broadcasting the same SSID (and optionally BSSID) as a legitimate AP at higher power, causing nearby clients to associate with the attacker's hardware.
- **Session hijacking**: Theft of authenticated session tokens or cookies observed or inferred during interception, enabling impersonation of an already-authenticated user without knowing their password.
- **Certificate pinning**: A client-side control that hardcodes an expected certificate fingerprint or public key, causing connection failure if the presented certificate does not match even if signed by a CA in the trust store.
- **HSTS (HTTP Strict Transport Security)**: A server-sent response header (`Strict-Transport-Security: max-age=31536000; includeSubDomains; preload`) instructing the browser to refuse all future plaintext HTTP connections to that domain, defeating SSL stripping on return visits.
- **Mutual TLS (mTLS)**: A TLS configuration in which both client and server present certificates; prevents impersonation of either peer and is the standard for [[Zero Trust Architecture]] east-west traffic.
- **Downgrade attack**: Any technique that forces negotiation of a weaker protocol version or cipher suite; TLS 1.3 addresses this by removing all negotiable weak primitives, and `TLS_FALLBACK_SCSV` signals intentional downgrades to prevent interception-forced fallback.

---

## Exam Relevance

SY0-701 prefers the term **on-path attack** over "man-in-the-middle." Expect terminology-swap questions where the scenario describes classic MITM behavior but the correct answer is labeled "on-path."

**Common question patterns:**
- *"A user at a coffee shop had credentials stolen after using the free Wi-Fi."* → On-path attack. Mitigations: VPN, HTTPS/HSTS, [[WPA3]].
- *"An attacker redirected LAN traffic without changing routing tables."* → ARP poisoning. Countermeasure: Dynamic ARP Inspection (DAI).
- *"Which attack allows real-time interception AND modification?"* → On-path (MITM). Distractor: replay attacks only re-send captured traffic *later*, they do not modify it in transit.
- *"Which control prevents SSL stripping?"* → HSTS / HSTS preload. Not simply HTTPS — stripping attacks bypass the redirect before HTTPS is established.

**Gotchas:**
- **Rogue AP ≠ Evil Twin**: A rogue AP is any unauthorized access point on the network. An evil twin *specifically clones a known, trusted SSID* to attract clients.
- **HTTPS alone is not sufficient** if the CA is compromised, if the user accepts a warning, or if the site is not on the HSTS preload list for first-visit scenarios.
- **DAI requires DHCP snooping** to be enabled first — exam questions test knowledge of this dependency.
- **802.1X authenticates ports, not just devices** — it prevents rogue devices from participating on the segment at all, which is the upstream prevention for many LAN MITM scenarios.

---

## Security Implications

MITM underpins credential theft, financial fraud, session takeover, malware injection, and targeted surveillance. Notable CVEs and incidents include:

- **CVE-2014-3566 (POODLE)** — SSL 3.0 CBC padding oracle forced via downgrade allows byte-by-byte plaintext recovery of session cookies; patched by disabling SSL 3.0 universally.
- **CVE-2015-0204 (FREAK)** — Servers accepting EXPORT-grade 512-bit RSA keys allowed an on-path attacker to factor the key in hours using cloud compute, then impersonate the server.
- **CVE-2015-4000 (Logjam)** — Weak 512-bit Diffie-Hellman parameters in TLS, breakable by a nation-state-level on-path adversary; affected an estimated 8.4% of the top 1M HTTPS sites at disclosure.
- **CVE-2017-13077–13088 (KRACK)** — WPA2 four-way handshake key reinstallation via crafted retransmissions, enabling nonce reuse and full Wi-Fi MITM on unpatched clients.
- **CVE-2020-0601 (CurveBall / ChainOfFools)** — Windows CryptoAPI (`crypt32.dll`) failed to validate ECC curve parameters, allowing forged certificates that Windows reported as valid.
- **DigiNotar (2011)** — Compromised Dutch CA issued 500+ fraudulent certificates including `*.google.com`; used in nation-state interception of ~300,000 Iranian Gmail users before discovery via Chrome's certificate pinning.
- **Superfish / Komodia (2015)** — Lenovo preloaded adware that installed a self-signed root CA *with its private key shipped on every device*. Any attacker who extracted the key (trivially done within 24 hours of disclosure) could MITM every affected laptop in the world.
- **China "Great Cannon" (2015)** — Nation-state on-path injection at BGP scale, racing legitimate CDN responses with malicious JavaScript to weaponize millions of Chinese browser users against GitHub.

**Detection signals to monitor:**
- Unexpected certificate changes on monitored domains (via [[Certificate Transparency]] log monitoring tools such as **certspotter** or **crt.sh** alerting).
- ARP cache showing a duplicate or changed MAC for the default gateway — check with `arp -a` or `ip neigh show`.
- Abnormally high first-hop latency visible in `traceroute`/`mtr` indicating an extra relay.
- Unexpected ICMP redirect messages arriving on a host.
- IDS/NSM rules (Suricata, Zeek/Bro) alerting on ARP anomalies, negotiated weak cipher suites, or signatures of known MITM frameworks.
- Endpoint EDR or OS alerts on newly installed root CA certificates.

---

## Defensive Measures

### Cryptographic Controls

- Enforce **TLS 1.2+ (prefer TLS 1.3)** with strong AEAD cipher suites (AES-GCM, ChaCha20-Poly1305); explicitly disable SSL 3.0, TLS 1.0/1.1, RC4, EXPORT cipher suites, and DH groups under 2048-bit.
- Deploy **HSTS** with `includeSubDomains` and `preload` directives; submit production domains to the [Chromium HSTS preload list](https://hstspreload.org/) so protection applies even on the first visit.
- Implement **certificate pinning** for high-value mobile and desktop applications. HPKP headers are deprecated; use in-app pinning via frameworks like OkHttp's `CertificatePinner` or platform-native APIs.
- Use **mTLS** for all service-to-service traffic inside microservice architectures and [[Zero Trust Architecture]] environments.
- Enable **DNSSEC** on authoritative zones; configure clients to use **DNS over HTTPS (DoH)** or **DNS over TLS (DoT)** (e.g., `systemd-resolved` with `DNSOverTLS=yes`, or configure DoH in Firefox/Chrome).

### Network Infrastructure (LAN)

- Enable **Dynamic ARP Inspection (DAI)** on all managed access-layer switches, binding to **DHCP snooping** tables so only DHCP-assigned IP→MAC mappings are trusted:
  ```
  ip dhcp snooping
  ip dhcp snooping vlan 10
  interface range Gi0/1-48
   ip arp inspection limit rate 100
  ip arp inspection vlan 10
  ```
- Configure **port security** to limit MAC addresses per switchport, preventing MAC flooding that forces switches into hub mode.
- Deploy **802.1X** (port-based NAC) with EAP-TLS so unauthenticated devices cannot participate on any VLAN at all.
- Use **private VLANs** and micro-segmentation to reduce broadcast domain size, limiting the scope of ARP-based attacks.
- Enable **IPv6 RA Guard** and **DHCPv6 Guard** on all access ports to block rogue router advertisements and rogue DHCPv6 servers.

### Wireless

- Mandate **WPA3-Enterprise** (802.1X + EAP-TLS with server certificate validation) for corporate Wi-Fi; use WPA3-SAE for personal/lab networks.
- Enable **Protected Management Frames (PMF / 802.11w)** to prevent deauthentication-flood attacks used to force clients to reconnect to evil twin APs.
- Deploy a **Wireless Intrusion Prevention System (WIPS)** — enterprise solutions include Cisco