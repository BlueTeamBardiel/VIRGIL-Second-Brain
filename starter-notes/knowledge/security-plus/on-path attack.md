```yaml
---
domain: "network-security"
tags: [on-path-attack, mitm, network-security, attack, sy0-701, interception]
---
```

# On-Path Attack

An **on-path attack** (the term that replaced **man-in-the-middle (MITM) attack** in CompTIA's SY0-601/701 vocabulary) is a class of network attack in which an adversary secretly **positions themselves between two communicating parties** to intercept, read, modify, or inject traffic without either endpoint detecting the interposition. Because the attacker terminates each side of the conversation independently, they can impersonate both parties simultaneously, manipulating what each believes the other has said. On-path attacks underpin many higher-level threats, including [[session hijacking]], [[credential harvesting]], and [[SSL stripping|TLS downgrade attacks]].

---

## Overview

An on-path attacker sits *logically* between a client and a server such that traffic in one or both directions traverses the attacker's host. The attacker may be **passive** (eavesdropping only, analogous to [[packet sniffing]]) or **active** (modifying, injecting, or replaying packets in real time). The critical distinction from simple eavesdropping is that an active on-path attacker can *alter* the conversation — changing transaction amounts, replacing file downloads, injecting JavaScript, or stripping encryption — while the two legitimate parties believe they are communicating directly with each other.

The attack class predates the modern internet. Early telegraph and radio systems were vulnerable to relay interception, and the term "man-in-the-middle" appeared in cryptographic literature in the 1980s during analyses of the Diffie-Hellman key exchange, which is famously susceptible to on-path interposition without authentication. Diffie and Hellman themselves noted that an unauthenticated key exchange could be defeated by an interposing adversary — the foundational reason that **public key infrastructure ([[PKI]])** and [[certificate authority|certificate authorities]] exist.

In practice, on-path attacks exploit the trust assumptions baked into underlying protocols. **ARP** has no authentication, so any host on a LAN can claim any IP. **DNS** responses (without [[DNSSEC]]) are accepted on the basis of a transaction ID and source port matching. **HTTP** is plaintext by design. **DHCP** clients accept the first offer they receive. Each of these design decisions, made decades ago for performance and simplicity, provides a primitive an attacker can chain into a full interception capability.

Real-world incidents illustrate the breadth of impact. The 2011 **DigiNotar** CA breach let attackers issue rogue certificates for `*.google.com`, enabling state-level on-path interception of Iranian Gmail users. **Superfish** adware pre-installed on Lenovo laptops (2014–2015) planted a root certificate with a globally known private key, allowing any attacker on the same Wi-Fi network to silently MITM HTTPS sessions. The **NSA's QUANTUM INSERT** program, revealed by Edward Snowden, used backbone-level positioning to race legitimate servers and serve malicious payloads to targets. **KRACK** (2017) allowed on-path attacks against WPA2-protected Wi-Fi by manipulating key reinstallation in the four-way handshake.

On-path attacks remain relevant because new protocols and deployments continually re-introduce the same trust problems: misconfigured TLS, captive portals that train users to accept certificate warnings, IoT devices shipping without certificate validation, and developers who disable verification "temporarily." The ongoing defensive arms race around [[HSTS]], [[certificate pinning]], [[Certificate Transparency]], and encrypted DNS ([[DNS over HTTPS|DoH]] / [[DNS over TLS|DoT]]) is a direct and continuing response to on-path threat vectors.

---

## How It Works

An on-path attack proceeds in three logical phases: **positioning**, **interception**, and **manipulation**. Each phase admits multiple technique options depending on the attacker's network location, available tools, and target protocols.

### Phase 1 — Positioning (Becoming the Next Hop)

The attacker must cause victim traffic to flow *through* their host. Common primitives:

**ARP Poisoning / Spoofing** — The attacker broadcasts gratuitous ARP replies on a LAN, telling the victim host that the gateway's IP maps to the attacker's MAC address and vice versa. All Layer 2 frames between victim and gateway now traverse the attacker's NIC first. Tools: `arpspoof` (dsniff), `ettercap`, `bettercap`.

```bash
# Step 1: Enable IP forwarding so the attacker transparently routes traffic
echo 1 > /proc/sys/net/ipv4/ip_forward

# Step 2: Poison both directions (victim 192.168.1.50, gateway 192.168.1.1)
# Using dsniff's arpspoof on Kali Linux
sudo arpspoof -i eth0 -t 192.168.1.50 -r 192.168.1.1
```

**DHCP Spoofing / Starvation** — The attacker exhausts the legitimate DHCP pool by flooding DISCOVER messages with forged MAC addresses (`dhcpstarv`, `yersinia`), then races to answer new DISCOVER requests first, supplying themselves as the default gateway and DNS server. Operates on UDP ports 67 (server) and 68 (client).

**DNS Spoofing / Cache Poisoning** — The attacker forges DNS responses (UDP 53) faster than the legitimate resolver, or poisons an upstream recursive resolver cache (Kaminsky-class birthday attacks). With DNS control, every subsequent connection is steered to an attacker-controlled IP.

**Rogue Access Point / [[evil twin attack|Evil Twin]]** — The attacker operates an SSID identical to a trusted network (same ESSID, often stronger signal). Devices with saved network profiles auto-associate. A deauthentication flood (IEEE 802.11 management frame injection with `aireplay-ng`) can force victims off the legitimate AP.

**BGP Hijacking** — At internet scale, a malicious or compromised AS announces more-specific prefixes for a victim's IP block, attracting global traffic through attacker infrastructure (demonstrated in the 2018 MyEtherWallet incident, which rerouted AWS Route 53 to attacker DNS servers).

**Malicious Proxy / PAC File** — Deployed via group policy, malware, or a compromised captive portal; instructs the browser to route all traffic through the attacker's proxy automatically.

### Phase 2 — Interception

Once positioned, the attacker captures traffic passively using `tcpdump`, Wireshark, or an inline transparent proxy like `mitmproxy`. For encrypted sessions, raw packet capture yields ciphertext; defeating TLS requires additional technique.

```bash
# Passive capture of all traffic through the attacker interface
sudo tcpdump -i eth0 -w /tmp/capture.pcap

# Inline interactive TLS proxy (mitmproxy)
mitmproxy --mode transparent --showhost
# Requires CA cert installed on victim or certificate error bypass
```

### Phase 3 — TLS Defeat and Manipulation

- **SSL Stripping** — `sslstrip` rewrites `https://` links in HTTP responses to `http://`, maintaining an upstream HTTPS connection to the server while presenting the victim with a cleartext session. Defeated by [[HSTS]] preload.
- **Rogue Certificate** — A CA-signed cert for the target domain (DigiNotar-style breach) or a trusted root planted on the victim endpoint (corporate proxy, Superfish) allows the attacker to present a valid-looking TLS handshake.
- **Protocol Downgrade** — Forcing negotiation to weak cipher suites or older protocol versions: POODLE (SSLv3), FREAK (512-bit export-grade RSA), BEAST (CBC in TLS 1.0), LOGJAM (DHE with 512-bit primes).
- **Transparent TLS Proxy** — Using `mitmproxy` or Burp Suite, the attacker terminates TLS toward the server and presents a dynamically generated certificate to the client.

```bash
# bettercap full-stack on-path: ARP poison + HTTPS proxy
sudo bettercap -iface eth0 -eval \
  "set arp.spoof.targets 192.168.1.50; arp.spoof on; net.sniff on; https.proxy on"

# iptables redirect for transparent mitmproxy mode
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80  -j REDIRECT --to-port 8080
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080
```

Once plaintext is recovered, the attacker can harvest session cookies (bypassing MFA), inject malicious JavaScript (BeEF framework), replace binary downloads with trojanized versions, or log credentials for offline cracking.

---

## Key Concepts

- **Positioning primitive** — The specific mechanism (ARP, DHCP, DNS, BGP, rogue AP) by which the attacker inserts themselves into the traffic path. Detection and defense must target the positioning primitive specifically; defeating it prevents the rest of the attack chain.
- **Active vs. passive on-path** — A **passive** attacker only reads traffic (confidentiality breach); an **active** attacker modifies, injects, or replays (integrity and availability breach). Encryption alone defeats passive attackers; *authenticated* encryption is required to defeat active attackers.
- **[[SSL stripping]]** — Downgrading HTTPS links to HTTP in transit so the victim never initiates an encrypted session with the server. The attacker holds an HTTPS connection to the server and an HTTP connection to the victim. Defeated by [[HSTS]] and browser HTTPS-only modes.
- **Certificate validation failure** — The single most common enabler of practical TLS-layer on-path attacks. A client that accepts any certificate, a self-signed cert, or ignores CN/SAN mismatches provides no cryptographic defense. Mitigated by [[certificate pinning]], [[Certificate Transparency]], and enforced browser UX.
- **[[evil twin attack|Evil twin]]** — A rogue Wi-Fi AP broadcasting a trusted SSID to lure victim associations. Commonly paired with a 802.11 deauthentication attack to evict clients from the legitimate AP first. Defeated by WPA3-Enterprise and Protected Management Frames (802.11w / PMF).
- **[[replay attack]]** — A subset of on-path activity where a valid captured authenticator (session cookie, Kerberos TGT, HMAC token) is resent at a later time without modifying it. Defeated by nonces, timestamps, and short token lifetimes.
- **Perfect [[forward secrecy]] (PFS)** — TLS cipher suites using ephemeral Diffie-Hellman (DHE/ECDHE) that generate unique session keys not derivable from the server's long-term private key. Ensures that passive captures cannot be retroactively decrypted even if the long-term key is later compromised.
- **Mutual TLS (mTLS)** — Both client and server present certificates during the TLS handshake. Because the client must authenticate cryptographically, an attacker who cannot produce a valid client certificate is excluded from the session, closing most TLS-layer on-path scenarios.

---

## Exam Relevance

CompTIA Security+ SY0-701 explicitly uses the term **on-path attack** in **Domain 2.0 – Threats, Vulnerabilities, and Mitigations**. Key exam patterns:

- **Terminology mapping** — The exam will say *on-path* where older resources say *man-in-the-middle*. They are identical concepts. Recognize both. Do not be tripped up if a question lists "MITM" as a distractor or synonym.
- **Subtype identification in scenarios** — A scenario describing an attacker forging ARP replies → answer is **ARP poisoning** (the *primitive*). A scenario describing an attacker operating a fake SSID → answer is **evil twin** (the *positioning method*). A scenario describing a victim whose HTTPS becomes HTTP in transit → answer is **SSL stripping** (the *manipulation technique*). All are on-path attack subtypes.
- **Defense matching** — Exam questions pair attack primitives with their specific countermeasures:
  - ARP poisoning → **Dynamic ARP Inspection (DAI)** + **DHCP Snooping**
  - SSL stripping → **HSTS** / **HTTPS-only mode**
  - DNS spoofing → **DNSSEC**
  - Evil twin → **WPA3-Enterprise** / **802.1X** / **PMF**
  - TLS interception → **Certificate pinning** / **Certificate Transparency**
- **Gotcha — encryption ≠ protection** — A common wrong-answer trap: "the session uses HTTPS, so on-path attacks are impossible." HTTPS without proper certificate validation is still exploitable. The correct answer must include *authentication* of the endpoint, not just *confidentiality* of the channel.
- **Distinguish from adjacent attacks** — A **replay attack** resends captured authenticators but does not require live interception. A **DoS/deauth flood** can *enable* an evil twin but is not itself an on-path attack. Knowing where one attack ends and another begins is regularly tested.

---

## Security Implications

On-path attacks enable downstream compromise far beyond simple credential theft. Captured **session cookies** bypass [[multi-factor authentication]] entirely — the cookie is the post-authentication proof of identity, and MFA has already been satisfied. **Modified software downloads** have served as malware delivery vectors: in 2015, ISP-level injection (linked to Hacking Team-developed tools) replaced legitimate software downloads with trojanized versions for targeted users.

**Notable CVEs and incidents:**

| Reference | Year | Description |
|-----------|------|-------------|
| **CVE-2014-3566** (POODLE) | 2014 | SSLv3 CBC padding oracle; on-path attacker can decrypt session cookies in ~256 requests |
| **CVE-2015-0204** (FREAK) | 2015 | Clients could be forced to accept export-grade 512-bit RSA keys, factorable by an on-path attacker within hours |
| **CVE-2017-13077 ff.** (KRACK) | 2017 | WPA2 four-way handshake key reinstallation; on-path attacker decrypts or injects into Wi-Fi traffic |
| **CVE-2020-0601** (CurveBall) | 2020 | Windows CryptoAPI failed to validate ECC certificate chain parameters, allowing forged TLS and code-signing certs |
| **DigiNotar breach** | 2011 | CA compromise yielded ~531 fraudulent certificates; `*.google.com` cert used for state-level interception of Iranian dissidents |
| **Superfish / VisualDiscovery** | 2015 | Lenovo preinstalled a root CA with a single globally shared private key; any network-local attacker could MITM all HTTPS |
| **MyEtherWallet BGP hijack** | 2018 | AWS Route 53 prefixes announced by a rogue AS; DNS redirected users to fake site; ~$150K in ETH stolen |
| **NSA QUANTUM INSERT** | 2013 (revealed) | Backbone-position TCP injection raced legitimate servers to serve malicious content to targeted users |

**Detection signals** useful in a homelab or SOC:

- Duplicate ARP entries or rapid MAC↔IP mapping changes (visible in `arp -a` or IDS ARP logs)
- Certificate fingerprint changes for a known host (Certificate Transparency monitoring via `crt.sh` or Cert Spotter)
- Unexpected TLS issuer chains (e.g., corporate proxy root appearing in browser certificate viewer)
- Latency spikes on local-network routes (extra hop through attacker)
- Suricata/Snort/Zeek alerts for ARP flood, rogue DHCP, and DNS response anomalies

---

## Defensive Measures

### Network Layer (LAN)

- **DHCP Snooping** — Configures switch ports as trusted (uplinks, legitimate DHCP servers) or untrusted (access ports). DHCP OFFER packets from untrusted ports are dropped. Required prerequisite for DAI.
- **Dynamic ARP Inspection (DAI)** — Validates ARP packets against the DHCP snooping binding table. Gratuitous ARPs with IP/