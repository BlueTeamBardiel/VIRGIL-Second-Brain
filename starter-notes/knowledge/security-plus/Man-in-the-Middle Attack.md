---
domain: "offensive-security"
tags: [attack, network, cryptography, interception, spoofing, active-attack]
---
# Man-in-the-Middle Attack

A **Man-in-the-Middle (MitM) attack** — now formally called an **on-path attack** in NIST and CompTIA SY0-701 terminology — is an active interception technique in which an adversary secretly relays, and potentially alters, communications between two parties who each believe they are talking directly to the other. MitM attacks simultaneously undermine the **confidentiality** and **integrity** pillars of the CIA triad and serve as the enabling prerequisite for higher-order exploits including [[Session Hijacking]], [[Credential Harvesting]], and [[TLS Downgrade Attack]]s. Because the attacker sits between both endpoints in real time, detection is far harder than with passive [[Eavesdropping]].

---

## Overview

The Man-in-the-Middle attack is one of the oldest and most conceptually fundamental threats in computer security. Its lineage predates modern networking: military cryptographers have long described a "bucket brigade" adversary who sits between the sender and receiver of a cipher, reading and re-sealing messages before forwarding them. In modern IP networks, the attack manifests whenever an adversary can insert themselves into the path of traffic — at Layer 2 through [[ARP Spoofing]], at Layer 3 via rogue routers or [[BGP Hijacking]], at Layer 7 through malicious proxies, or even at the radio layer with rogue [[Evil Twin Attack|Wi-Fi access points]] and [[IMSI Catcher]]s. The unifying theme is not the mechanism but the position: the attacker becomes an invisible third party to what both victims believe is a private two-party channel.

MitM attacks exist because most foundational Internet protocols were designed in an era that assumed a trustworthy, cooperative transport. Classic protocols — **Telnet**, **FTP**, **HTTP**, **SMTP**, **POP3**, and **IMAP** — transmit credentials and payloads in cleartext, giving any on-path attacker full, immediate visibility. Even modern encrypted protocols can be subverted when authentication is weak or misconfigured: a server certificate that is never validated, a wireless network that accepts any peer, or a DNS resolver that is not cryptographically authenticated can all permit an attacker to impersonate a legitimate endpoint before encryption even begins.

The impact of a successful MitM attack ranges from purely passive eavesdropping — capturing session cookies, API tokens, or cleartext passwords — to fully active manipulation: injecting malware into software update streams, rewriting banking wire-transfer destinations, or tricking a victim into submitting credentials to a perfectly replicated phishing proxy. Because the attacker controls the channel, they can selectively drop, delay, replay, or modify individual packets, making detection extremely difficult without end-to-end cryptographic assurance that neither peer is an impostor.

Real-world incidents illustrate the full breadth of the problem. The 2011 compromise of Dutch certificate authority **DigiNotar** allowed attackers to issue fraudulent wildcard certificates for `*.google.com`, which were used in large-scale MitM attacks against Iranian Gmail users — the fraudulent certificate was trusted by all major browsers because it chained to a valid root CA. The **Superfish** adware preinstalled on Lenovo laptops in 2014–2015 installed a root CA certificate whose private key was shared across all affected devices and was easily extracted; any attacker on the same Wi-Fi network could use it to decrypt HTTPS traffic to any site. The **KRACK** (Key Reinstallation Attack, 2017) and **FragAttacks** (2021) vulnerabilities in WPA2 allowed attackers within wireless range to coerce nonce reuse and inject or decrypt frames in encrypted Wi-Fi sessions.

MitM is classified as an *active* attack because the adversary must participate in the communication flow — forwarding, relaying, and optionally modifying packets. This distinguishes it from purely passive interception such as fiber tapping, although many real campaigns blend both phases: passive sniffing to map the target topology, followed by active insertion to exploit the positioned channel.

---

## How It Works

A MitM attack generally follows three phases: **positioning**, **interception**, and **manipulation or exfiltration**. The techniques used in each phase are determined by the OSI layer at which the attacker operates and the trust model of the protocol being attacked.

### Phase 1 — Positioning

**ARP Spoofing (Layer 2).** On a switched LAN, hosts use the Address Resolution Protocol (ARP) to map IPv4 addresses to MAC addresses. ARP carries no authentication and accepts unsolicited replies. An attacker on the same broadcast domain sends forged ARP replies to the victim claiming the gateway's IP maps to the attacker's MAC address, and simultaneously tells the gateway that the victim's IP maps to the attacker's MAC. Traffic now flows `victim → attacker → gateway` in both directions — a classic Layer 2 MitM position. The attacker enables IP forwarding so neither party notices a disruption.

```bash
# Enable IP forwarding so traffic still reaches its destination
echo 1 > /proc/sys/net/ipv4/ip_forward

# Poison victim (192.168.1.50) into thinking attacker = gateway (192.168.1.1)
arpspoof -i eth0 -t 192.168.1.50 192.168.1.1

# Simultaneously poison gateway into thinking attacker = victim
arpspoof -i eth0 -t 192.168.1.1 192.168.1.50

# Passively capture all intercepted traffic
tcpdump -i eth0 -w capture.pcap host 192.168.1.50
```

**Rogue DHCP / DHCPv6 (Layer 3).** A rogue DHCP server wins the race against the legitimate server by responding faster, advertising itself as both the default gateway and DNS resolver. The victim's entire traffic path is redirected at the moment of network join. Tools such as **Responder** and **mitm6** (which exploits Windows clients' default preference for IPv6 router advertisements) automate this attack against Windows-heavy enterprise environments.

**DNS Spoofing (Layer 7).** [[DNS Spoofing|DNS cache poisoning]] or a compromised resolver returns attacker-controlled IP addresses for target domains. The victim successfully resolves `bank.com` but reaches the attacker's server, which then proxies the real site. This is effective even against geographically distant victims not on the same LAN.

**Rogue Wireless AP / Evil Twin (Layer 1–2).** An Evil Twin access point broadcasts the same SSID (and optionally the same BSSID) as a legitimate network but with a stronger signal. Victims' devices auto-associate, especially against open networks or PSK networks whose passphrase the attacker knows. Tools: **hostapd-mana**, **airgeddon**, **Wifiphisher**.

---

### Phase 2 — Interception and TLS Bypass

Once positioned on-path, TLS is the primary technical barrier. The attacker operates a transparent SSL/TLS proxy such as **mitmproxy**, **Burp Suite Pro**, or **sslsplit**. The proxy terminates TLS on the victim-facing side using a forged certificate and opens a new TLS connection to the real server, acting as a legitimate client. The victim receives a certificate signed by the attacker's CA — this succeeds only when:

- The victim's trust store includes the attacker's CA (e.g., corporate inspection proxy, Superfish-style preload, or malware-installed root), **or**
- The application fails to validate certificates (endemic in IoT firmware, legacy SOAP clients, and poorly written mobile apps), **or**
- The victim is socially engineered into clicking through a browser certificate warning.

```bash
# Run mitmproxy in transparent interception mode
sudo mitmproxy --mode transparent --showhost

# Redirect victim HTTPS traffic to the proxy port via iptables
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp \
    --dport 443 -j REDIRECT --to-port 8080
```

**TLS Stripping.** Moxie Marlinspike's `sslstrip` technique exploits the HTTP → HTTPS redirect flow: when a victim types `bank.com` in a browser (without explicitly prefixing `https://`), the first request is HTTP. The attacker intercepts this HTTP response, rewrites all `https://` links and `Location:` redirect headers to `http://`, and the victim never upgrades. The attacker then maintains the real HTTPS session with the server. This attack is fully defeated by [[HTTP Strict Transport Security|HSTS preload lists]], where the browser refuses to issue the initial HTTP request at all.

```bash
# bettercap sslstrip + ARP spoof in one session
sudo bettercap -iface eth0
net.probe on
set arp.spoof.targets 192.168.1.50
arp.spoof on
set http.proxy.sslstrip true
http.proxy on
```

---

### Phase 3 — Manipulation and Exfiltration

With cleartext content in hand, an attacker can:

- **Credential harvest**: extract usernames, passwords, and session tokens from HTTP forms and cookies.
- **Content injection**: insert JavaScript payloads (e.g., [[BeEF]] hooks) into HTTP responses to execute code in the victim's browser.
- **Binary patching**: replace downloaded executables with trojaned versions mid-stream (the **Flame** malware executed this via forged Microsoft Update certificates).
- **Transaction manipulation**: rewrite wire-transfer account numbers or IBAN fields in real-time banking sessions.
- **Certificate downgrade**: strip HPKP or certificate-pinning headers from HTTPS responses before relaying them.

---

## Key Concepts

- **On-Path Attacker**: The CompTIA SY0-701 and NIST-preferred term for a MitM adversary. Describes the attacker's topological position rather than their gender, and is used interchangeably with MitM in modern exam and vendor documentation.
- **ARP Poisoning**: Injection of forged ARP replies on a Layer 2 broadcast domain to associate the attacker's MAC address with a legitimate host's IP address. Exploits the entirely stateless, unauthenticated design of the ARP protocol. Mitigated on managed switches by **Dynamic ARP Inspection (DAI)**.
- **TLS Interception / SSL Inspection**: Termination of a TLS session by an intermediate proxy, which re-encrypts toward the real destination. Performed legitimately by enterprise DLP/UTM gateways using a managed root CA distributed via Group Policy; malicious when using a rogue or compromised CA.
- **Certificate Pinning**: A defensive technique in which an application hard-codes the expected server certificate, public key, or CA, refusing any other certificate even if signed by a trusted CA. Breaks opportunistic MitM but complicates certificate rotation and must be managed carefully.
- **HSTS (HTTP Strict Transport Security)**: A browser security policy, delivered via the `Strict-Transport-Security` HTTP response header and maintained in browser preload lists, that instructs clients to refuse plaintext HTTP connections to a domain — completely defeating TLS stripping for preloaded domains.
- **Evil Twin**: A rogue wireless access point that impersonates a legitimate SSID to coerce victims into associating with the attacker's controlled network. Distinct from a generic rogue AP, which is any unauthorized AP without necessarily impersonating a known network.
- **Downgrade Attack**: The act of forcing negotiation of a weaker protocol version or cipher suite (e.g., coercing TLS 1.3 → TLS 1.0, or WPA3-SAE → WPA2-PSK) to expose a session to cryptanalytic attacks that the stronger version was designed to prevent. Examples: POODLE (SSL 3.0), FREAK (export RSA), Logjam (export DH).
- **Relay vs. Replay**: A MitM attack *relays* traffic in real time between two parties. A [[Replay Attack]] captures a valid authenticated message and re-transmits it later to impersonate a legitimate sender — they are distinct threats that can be chained.

---

## Exam Relevance

The **SY0-701** exam retires the phrase "Man-in-the-Middle" in favor of **on-path attack** across Objective 2.4 (Indicators of Malicious Activity) and Objective 4.4 (Security Implications of Proper PKI). Candidates must be fluent in both terms and in the specific sub-techniques that the exam tests:

- **Scenario recognition**: A user on a coffee shop Wi-Fi has their banking session intercepted and credentials stolen → **on-path attack**. Do not choose "eavesdropping" (passive, no alteration) or "replay attack" (re-use of a captured token, not real-time interception).
- **ARP poisoning as an enabler**: If a question asks *how* an on-path position is achieved on a local LAN, the answer is ARP poisoning, not MitM itself. ARP poisoning is the mechanism; MitM is the result.
- **Rogue AP vs. Evil Twin**: A rogue AP is any unauthorized AP connected to the network. An evil twin specifically mimics a known SSID/BSSID to lure clients. The exam distinguishes these in answer sets.
- **TLS stripping countermeasure**: The specific answer for defeating TLS downgrade/stripping is **HSTS** (especially HSTS preloading) — not simply "use TLS" or "use HTTPS redirects."
- **Switch-level mitigations**: DAI (Dynamic ARP Inspection), DHCP Snooping, and 802.1X are the Layer 2 controls tested as defenses against on-path positioning on wired networks.
- **PKI and certificates**: Questions about forged certificates, rogue CAs, and certificate validation all tie back to MitM. Understand that a certificate being CA-signed does not mean it is trustworthy if the CA itself is compromised or rogue.
- **Common gotcha**: IPsec and VPNs protect *transit* traffic from on-path interception but do not prevent an attacker from achieving on-path positioning — they just make the intercepted traffic useless ciphertext.

---

## Security Implications

MitM positioning is a force multiplier: once an attacker controls the channel, nearly every subsequent security guarantee depends on cryptographic authentication that the victim may not fully enforce. Key CVEs and incidents:

| Incident / CVE | Year | Mechanism |
|---|---|---|
| **CVE-2014-0224** ("CCS Injection") | 2014 | OpenSSL ChangeCipherSpec flaw; forced use of weak master key, enabling full session decryption by a MitM |
| **CVE-2015-0204** ("FREAK") | 2015 | TLS downgrade forcing export-grade RSA (512-bit), which an attacker could factor and use to MitM |
| **CVE-2015-4000** ("Logjam") | 2015 | Downgrade to 512-bit export Diffie-Hellman; MitM decryption feasible with pre-computed logs |
| **CVE-2017-13077** (KRACK) | 2017 | WPA2 four-way handshake key reinstallation; nonce reuse allows MitM decryption/injection within Wi-Fi range |
| **DigiNotar CA Compromise** | 2011 | Fraudulent `*.google.com` certificates used against ~300,000 Iranian users |
| **Superfish / Komodia** | 2015 | Pre-installed Lenovo adware with shared root CA private key; trivial MitM on any Lenovo laptop on Wi-Fi |
| **Flame Malware** | 2012 | MD5 collision against Microsoft Terminal Services CA forged Windows Update signatures; MitM update injection |

**Detection indicators** include: unexpected changes in ARP tables (`ip neigh show` / `arp -a`), duplicate MAC addresses seen on different switch ports (detectable with `arpwatch`), certificate fingerprint mismatches vs. previously pinned or Certificate Transparency-logged values, elevated network latency suggesting an extra relay hop, and anomalous NetFlow data showing traffic through unexpected Layer 3 paths. Endpoint detection tools such as **XDR agents** may flag TLS handshakes to endpoints whose certificates are not present in enterprise CT logs.

---

## Defensive Measures

**Encryption with mutual authentication.**
Enforce **TLS 1.3** across all services; disable TLS 1.0, TLS 1.1, and weak cipher suites (RC4,