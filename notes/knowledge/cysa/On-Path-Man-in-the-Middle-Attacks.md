# On-Path (Man-in-the-Middle) Attacks

## What it is

In **Final Fantasy**, the bridge to Cornelia is held by Garland — he's kidnapped Princess Sara and he's sitting between the kingdom and the Chaos Shrine. Every message, every rescue party, every supply caravan has to cross his bridge or go around. He doesn't have to break the kingdom's walls. He just has to be in the middle, reading what passes, deciding what gets through, and rewriting the rest. That's exactly what an on-path attacker does — they don't compromise the client, they don't compromise the server, they just sit between them and own the conversation.

Plain English: somebody wedges themselves into the network path between two parties who think they're talking directly. They can read the traffic, modify it, drop it, or replay it. Both endpoints stay convinced the conversation is private.

Technical CS0-003 definition: an **on-path attack** (CompTIA's preferred term — "man-in-the-middle" is the legacy phrasing) is an active interception attack where an adversary positions themselves between two communicating endpoints and relays, observes, or alters traffic. Common positioning techniques: **ARP poisoning** on a LAN, **DNS spoofing**, **rogue Wi-Fi access points** ("evil twin"), **BGP hijacking** at the routing layer, **DHCP spoofing**, and **SSL/TLS stripping** to force a downgrade from HTTPS to HTTP. The attack defeats confidentiality and integrity simultaneously, and the endpoints have no native way to know it's happening unless cryptographic identity verification (certificates, certificate pinning, mutual TLS) catches it.

## Why it matters

The CySA+ angle: this is one of the attack patterns vulnerability assessment tools are specifically built to surface. **Burp Suite** and **ZAP** are themselves intercepting proxies — same mechanics as the attack, used legitimately for web app testing under CS0-003 Objective 2.2. If you understand how the tool sits in the path, you understand the threat.

Career relevance: on-path attacks are how attackers harvest credentials at scale on guest Wi-Fi, how state actors collect from undersea cables (BGP hijack flavor), and how internal pivots work after initial access — the attacker poisons ARP inside the VLAN and starts grabbing service account hashes off SMB. As a SOC analyst, you'll see the symptoms before you see the attacker: duplicate ARP entries, certificate warnings nobody clicked through to report, DNS responses that don't match the cache, sudden TLS downgrades on monitored flows.

Exam relevance: CompTIA tests on-path in Objectives 1.x (threats), 2.2 (tools that detect it — and tools that *perform* it during testing), and 3.x (incident response when one is confirmed).

## Key facts

### How the attacker gets in the middle

| Technique | Layer | What it abuses | Where you see it |
|---|---|---|---|
| **ARP poisoning** | L2 | ARP has no authentication | LAN, same broadcast domain |
| **DNS spoofing / cache poisoning** | L7 | Recursive resolver trust | Open resolvers, weak DNSSEC |
| **Rogue AP / Evil Twin** | L1/L2 | Clients auto-join known SSIDs | Coffee shops, conferences, lobby Wi-Fi |
| **DHCP spoofing** | L2/L3 | First DHCP response wins | Flat networks, no DHCP snooping |
| **BGP hijacking** | L3 | BGP trusts peer announcements | ISP/transit level |
| **SSL stripping** | L7 | User typed `http://` not `https://` | Anywhere TLS isn't enforced |
| **Malicious browser extension** | L7 | Sits inside the browser process | Endpoint-side, bypasses TLS entirely |

The pattern: every one of these abuses a protocol that was designed before authentication was a default expectation. ARP, DNS, DHCP, BGP — all trusted by design. That trust is the attack surface.

### The TLS / certificate angle (this is the exam meat)

Encryption protects **data in transit, not endpoints**. An on-path attacker can't read properly validated TLS traffic — but they have several ways around that:

- **TLS downgrade / SSL stripping** — proxy the connection, present plaintext HTTP to the victim, talk HTTPS to the real server. Defeated by **HSTS** (HTTP Strict Transport Security) and HSTS preload lists.
- **Forged certificate** — present a certificate the victim's browser will accept. Defeated by proper **CA validation** and **certificate pinning**.
- **Compromised CA** — DigiNotar in 2011, the textbook example. A trusted CA issued forged certs for Google. Defeated by **Certificate Transparency** logs and pinning.
- **User clicks through the warning** — the most common path. No technical control fixes a user who hits "Proceed anyway."
- **Endpoint compromise** — if the attacker owns the endpoint, they own the keys. TLS is irrelevant. *This is the case that catches analysts off-guard.*

> **CompTIA exam trap:** TLS does not protect against on-path attacks if the endpoint is compromised, the user accepts an invalid certificate, or the attacker controls a trusted CA. CompTIA will give you a scenario where TLS is "in use" and ask if on-path is still viable. Answer: yes, if any of the above conditions are met. TLS protects the channel, not the parties.

### Tools — both sides of the fence (Objective 2.2)

The CySA+ exam mixes defensive and offensive tooling under "vulnerability assessment." On-path-adjacent tools you must know:

**Intercepting proxies (you run these on yourself, legitimately):**
- **[[Burp Suite]]** — the standard for web app testing. Sits between browser and server, decrypts TLS using a CA cert you install in your test browser. Same mechanics as the attack.
- **[[Zed Attack Proxy]] (ZAP)** — OWASP's free Burp equivalent. Same intercepting-proxy model.

**Network scanning and mapping (you use these to find on-path opportunities, or to map your own attack surface):**
- **[[Nmap]]** — port and service discovery. Identifies what's listening, what versions, what's encrypted.
- **[[Angry IP Scanner]]** — lighter-weight host discovery. Good for quick LAN sweeps.
- **[[Maltego]]** — OSINT relationship mapping. Maps the external attack surface — domains, IPs, people, infrastructure.
- **[[Recon-ng]]** — modular OSINT framework. Same lane as Maltego, CLI-driven.

**Exploitation frameworks:**
- **[[Metasploit Framework]] (MSF)** — includes auxiliary modules for ARP poisoning, DNS spoofing, and TLS stripping. Read the module source to learn the attack.

**Web app scanners (find the conditions that enable on-path):**
- **[[Nikto]]** — flags missing HSTS, weak TLS configs, mixed content.
- **[[Arachni]]** — deeper crawling, similar findings.

**Vulnerability scanners (find weak crypto across the fleet):**
- **[[Nessus]]**, **[[OpenVAS]]** — both will flag weak TLS ciphers, expired certs, SSLv3/TLS 1.0/1.1 support, self-signed certs in production. All on-path enablers.

**Cloud infrastructure assessment:**
- **[[Scout Suite]]**, **[[Prowler]]**, **[[Pacu]]** — find misconfigured load balancers, S3 buckets serving HTTP, API gateways without TLS enforcement. Cloud on-path is real; an unencrypted internal service mesh is a feast.

**Debuggers (when you're analyzing a sample that performs on-path locally):**
- **[[Immunity Debugger]]** — Windows user-mode debugger for malware reversing.
- **[[GNU Debugger]] (GDB)** — Linux equivalent. Useful when you've grabbed a Linux implant that's doing TLS interception on the endpoint.

### Detection — what the analyst actually sees

| Signal | Where it shows up |
|---|---|
| Duplicate ARP entries / gratuitous ARP storms | Switch logs, IDS (Suricata, Snort, Zeek rules) |
| Unexpected certificate CN or issuer | Browser warnings, EDR cert telemetry, Zeek `ssl.log` |
| DNS responses not matching authoritative records | DNS monitoring, Passive DNS comparison |
| Sudden TLS downgrade (TLS 1.3 → 1.0, or HTTPS → HTTP) | Web proxy logs, NetFlow with deep inspection |
| New default gateway MAC on a host | DHCP logs, endpoint network telemetry |
| Beaconing to a known-good domain that resolves to a new IP | Threat intel correlation in SIEM |

### Defenses — what stops it

- **802.1X** + **port security** — authenticate devices before they get a switch port.
- **Dynamic ARP Inspection (DAI)** + **DHCP snooping** — the L2 defenses. Together they kill ARP poisoning on a managed switch.
- **HSTS + HSTS preload** — kills SSL stripping for sites that are in the preload list from the first request.
- **Certificate pinning** — app refuses to talk to anything but the specific cert/CA it expects. Heavy operational cost (cert rotation), but it's how mobile banking apps survive.
- **DNSSEC** + **DNS over HTTPS (DoH)** / **DNS over TLS (DoT)** — authenticated DNS, encrypted DNS.
- **VPN with mutual authentication** — both ends prove identity. Removes the "any Wi-Fi is safe" assumption.
- **WPA3** — replaces WPA2's PSK with SAE, killing the evil-twin offline attack.

### CompTIA exam traps

> **Trap 1:** Burp Suite and ZAP are *intercepting proxies* — they perform the same technical operation as an on-path attack. The exam may describe a tester running Burp and ask what attack class it models. Answer: on-path / MitM.

> **Trap 2:** "TLS is in use" does not mean "on-path is impossible." See above — endpoint compromise, downgrade, forged cert, user click-through. Don't pick the answer that says TLS alone is sufficient.

> **Trap 3:** ARP poisoning is **layer 2** — it does not cross routed boundaries. If the question describes an attacker on a different VLAN/subnet, ARP poisoning is not the answer. Look at DNS spoofing or BGP hijack instead.

> **Trap 4:** **HSTS protects against SSL stripping**, but only after the first successful HTTPS connection (unless the domain is in the preload list). CompTIA loves the "first visit" edge case.

## SOC reality

- The first signal is rarely "on-path attack detected." It's a user ticket: *"My browser keeps saying the certificate isn't trusted on the corporate Wi-Fi."* Three users, same SSID, same hour — now you're investigating an evil twin in the parking lot.
- L1's first move: confirm the SSID is yours, check the BSSID (MAC) against the known APs list, look for new DHCP leases that came from an unexpected MAC. Don't tell the user it's "probably nothing."
- The IR lead will ask: *"What got transmitted in cleartext during the window? Any service accounts? Any session tokens?"* If you don't have the proxy logs to answer, you're guessing about the blast radius — and guessing wrong about credentials means a fleet-wide password reset.
- Never tell leadership "TLS protected us" until you've confirmed (a) every client validated the cert chain, (b) no one clicked through a warning, (c) no endpoint had a rogue CA installed. *EDR cert-store telemetry is the only way to know that last one cold.*
- Escalation: L1 confirms the indicator → L2 pulls Zeek `ssl.log` and DHCP/ARP tables → IR isolates the VLAN and pulls the rogue AP → legal gets notified if any regulated data was in flight. The handoff is fast because on-path is, by definition, ongoing until you cut the wire.

## Related concepts

[[ARP Poisoning]] · [[DNS Spoofing]] · [[Evil Twin Attack]] · [[SSL Stripping]] · [[TLS Downgrade]] · [[Certificate Pinning]] · [[HSTS]] · [[DNSSEC]] · [[Burp Suite]] · [[ZAP]] · [[Nmap]] · [[Nessus]] · [[OpenVAS]] · [[Scout Suite]] · [[Prowler]] · [[Pacu]] · [[Maltego]] · [[Recon-ng]] · [[Metasploit Framework]] · [[Network Forensics]] · [[Zeek]]

*Source: VIRGIL knowledge base — 2026-05-11*