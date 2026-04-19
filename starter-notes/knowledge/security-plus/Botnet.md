---
domain: "threats-and-attacks"
tags: [botnet, malware, ddos, command-and-control, iot-security, cybercrime]
---
# Botnet

A **botnet** (a portmanteau of "robot" and "network") is a collection of internet-connected devices infected with malware that allows a remote operator—called a **botmaster** or **bot herder**—to issue commands simultaneously to all enrolled members through a **command-and-control (C2)** channel. Individual compromised machines, known as **bots** or **zombies**, are typically unaware of their participation and can be directed to perform [[DDoS]] attacks, send spam, mine cryptocurrency, steal credentials, or act as anonymizing proxies. Botnets are among the most economically significant forms of [[Malware]] infrastructure and power a large portion of the underground market in cybercrime-as-a-service.

---

## Overview

Botnets evolved from benign IRC "eggdrop" bots of the early 1990s—scripts that performed automated channel administration—into malicious tools once attackers realized the same command-fan-out model could coordinate thousands of compromised hosts. Early criminal botnets such as **GTbot** (2000) and **Agobot/Phatbot** (2002) used [[IRC]] channels as rendezvous points, with the botmaster issuing plain-text commands that every connected zombie parsed and executed. As defenders learned to block IRC traffic and seize C2 servers, botnet architecture evolved toward HTTP/HTTPS-based beaconing, **peer-to-peer (P2P)** overlays, and **domain generation algorithms (DGAs)** that produce thousands of potential rendezvous hostnames per day so that blocking any single one is futile.

The scale of modern botnets is staggering. **Conficker** (2008) infected an estimated 9–15 million Windows hosts by exploiting [[CVE-2008-4250]] (MS08-067, an anonymous SMB stack overflow) combined with weak credentials and USB autorun. **GameOver Zeus** (2011–2014) used a Kademlia-style P2P overlay with a DGA fallback, stealing hundreds of millions of dollars in banking fraud before the multinational **Operation Tovar** sinkholed it in 2014. **Mirai** (2016) demonstrated the acute threat posed by insecure IoT devices: roughly 600,000 CCTV cameras, DVRs, and home routers were compromised via default Telnet credentials, enabling a 620 Gbps attack on journalist Brian Krebs's website and the landmark 1.2 Tbps attack against Dyn DNS, which disrupted Twitter, Reddit, Netflix, and Spotify for hours across the US East Coast. **Emotet**, dismantled in January 2021 by a Europol-coordinated operation, had operated as "malware-as-a-service," acting as a loader and initial-access broker for banking trojans (TrickBot) and ransomware affiliates (Ryuk, Conti).

Economically, botnets underpin a criminal service economy. **Booter/stresser** sites rent DDoS capacity for as little as US$10 per attack; **pay-per-install (PPI)** services charge other criminals a fee for each new bot infection they deliver; residential proxy networks (e.g., the notorious 911.re, seized in 2022) monetize bot hosts by routing third-party traffic through them to launder the source IP. Spam botnets including Cutwail, Grum, and Necurs have at their respective peaks collectively produced tens of billions of spam messages per day, accounting for the majority of global email volume.

Law enforcement has increasingly turned to **sinkholing**—registering DGA-generated domains before the attacker—and coordinated **infrastructure seizures**. Notable takedowns include Microsoft's Digital Crimes Unit actions against Waledac (2010) and Rustock (2011), Operation Tovar targeting GameOver Zeus and CryptoLocker (2014), the Avalanche platform takedown (2016), and the 2021 Emotet action that pushed a remote uninstaller to all active infected hosts worldwide, cleansing the botnet from the inside.

---

## How It Works

A botnet's lifecycle unfolds across four overlapping phases: **infection → rallying → command and control → execution**.

### Phase 1 — Infection

The method of initial compromise varies by target class:

- **Desktop/server botnets**: phishing emails with weaponized Office macros or ISO attachments, exploit kits (RIG, Magnitude) targeting browser/plugin vulnerabilities, watering-hole drive-by downloads, or worm propagation via SMB (EternalBlue, [[CVE-2017-0144]]).
- **IoT botnets (Mirai model)**: internet-wide port scans (masscan/zmap at millions of packets/second) identify hosts with Telnet (TCP/23) or SSH (TCP/22) open. A credential-spray module tries a hardcoded dictionary of default factory passwords:

```
root:xc3511      root:vizxv       root:admin
admin:admin      root:888888      root:xmhdipc
root:default     root:juantech    root:123456
admin:password   root:root        root:1234
```

Once in, the bot binary is downloaded via `busybox wget` or `busybox tftp` and executed directly from memory (`/proc/self/exe` tricks) to avoid leaving files on flash storage.

### Phase 2 — Rallying (Finding the C2)

Newly infected hosts must locate the controller. Modern malware uses layered mechanisms rather than a single hardcoded IP:

| Mechanism | How It Works |
|---|---|
| Hardcoded domain/IP | Simple fallback; easily blocked |
| **DGA (Domain Generation Algorithm)** | Algorithm derives N pseudo-random domains per day from a time-based seed; attacker registers only a handful |
| **Fast-flux DNS** | A records rotate through bot proxies every 60–300 s, hiding the real backend |
| **P2P overlay** | Bots maintain a distributed peer list; no single C2 to seize |
| **Dead-drop resolvers** | C2 IP encoded in a tweet, Pastebin post, or GitHub Gist |
| **Tor hidden services** | `.onion` rendezvous, anonymizing the operator |

**DGA example** (simplified, date-seeded):

```python
import hashlib
import datetime

def dga(seed_date: str, count: int = 64, tld: str = ".net") -> list[str]:
    domains = []
    for i in range(count):
        h = hashlib.md5(f"{seed_date}-{i}".encode()).hexdigest()
        domains.append(h[:16] + tld)
    return domains

today = datetime.date.today().isoformat()
for d in dga(today)[:5]:
    print(d)
# e.g.: 3e4a1f8bc9027d65.net
```

The attacker runs this same algorithm and pre-registers just a few of the generated names. Defenders must compute the entire daily set and sinkhole all of them to be effective.

### Phase 3 — Command and Control

The most common C2 transport today is **HTTPS (TCP/443)** because it blends with legitimate web traffic, encrypts tasking, and passes most firewalls:

```http
GET /api/v2/stats?id=7f3a9b&seq=142 HTTP/1.1
Host: cdn-analytics-delivery.example.com
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)
Accept: */*
```

The `id` field is the bot's unique identifier; the response body contains base64- or RC4-encrypted tasking. The bot **beacons** at a regular interval (e.g., every 60 seconds) with a random jitter of ±20–30% to avoid triggering heartbeat-detection signatures.

| Transport | Typical Port(s) | Notes |
|---|---|---|
| IRC | TCP 6667, 6697 (TLS) | Legacy; easily flagged by NIDS |
| HTTP/HTTPS | TCP 80, 443 | Dominant; hides in web noise |
| DNS TXT tunneling | UDP/TCP 53 | Bypasses web proxies |
| Custom TCP/UDP | varies | ZeroAccess, Kelihos |
| Tor | TCP 9050 (SOCKS) | Operator anonymity |
| Slack/Discord/Telegram API | TCP 443 | Abuse of legitimate platforms |

### Phase 4 — Execution (Tasking)

Common bot commands issued by operators:

```
# DDoS
ddos syn <target_ip> <port> <duration_seconds>
ddos udpflood <target_ip> <duration_seconds>
ddos dns_amp <target_ip> <resolver_list> <duration_seconds>

# Spam
spam <template_id> <recipient_list_url>

# Persistence / lateral movement
install <payload_url>
update <binary_url>

# Intelligence gathering
keylog start
grab cookies chrome firefox
grab pwds

# Proxy
socks5 listen 1080
```

Mirai's DDoS arsenal specifically included SYN floods, ACK floods, UDP floods, GRE IP floods, GRE ETH floods, DNS water-torture (NXDOMAIN floods), HTTP floods, and the novel **Valve Source Engine Query flood** designed to target gaming infrastructure.

---

## Key Concepts

- **Bot / Zombie** — An endpoint compromised by bot malware and enrolled in a botnet without the legitimate user's knowledge. The device responds to C2 commands while appearing to function normally.
- **Botmaster / Bot herder** — The human operator who owns, controls, and monetizes the botnet. May rent it to third parties (DDoS, spam, PPI) through criminal marketplaces; rarely operates bots personally.
- **Command and Control (C2 / C&C)** — The infrastructure and protocols used to issue instructions to bots and receive exfiltrated data. The resilience of C2 defines the resilience of the entire botnet. See [[Command and Control]].
- **Domain Generation Algorithm (DGA)** — A deterministic pseudorandom algorithm embedded in malware that produces hundreds or thousands of candidate domain names per time period. The attacker registers only a few; defenders must enumerate and sinkhole all candidates to fully disrupt rallying.
- **Fast-Flux DNS** — A technique where botnet proxies serve as a rotating shield of DNS A records (TTL 60–300 s), making the true back-end server difficult to locate or block. *Double-flux* additionally rotates NS records.
- **Sinkholing** — Defensive or law enforcement technique of registering or seizing C2 domains and redirecting bot traffic to a monitored server. Prevents tasking and can enumerate the victim population.
- **Peer-to-Peer (P2P) Botnet** — Architecture in which bots maintain a decentralized peer list and propagate commands through the mesh rather than connecting to a central server, eliminating single points of failure. Used by GameOver Zeus, ZeroAccess, and Kelihos.
- **Booter / Stresser** — A commercial DDoS-for-hire service marketed as a "server stress testing" tool; typically powered by rented botnet capacity. Using one against a target you do not own is a federal crime (CFAA in the US, Computer Misuse Act in the UK).
- **Reflection / Amplification** — DDoS technique where bots send requests with a spoofed source IP (the victim's) to open servers (DNS resolvers, NTP servers, Memcached on UDP/11211, SSDP on UDP/1900). Amplification factors range from ~10× (DNS) to 50,000× (Memcached).
- **Loader / Dropper** — Malware whose primary purpose is to gain initial access and then install a secondary payload such as a bot module, RAT, or ransomware. Emotet, TrickBot, and Qakbot operated as loaders for the ransomware ecosystem.

---

## Exam Relevance

SY0-701 tests botnets primarily under **Domain 2: Threats, Vulnerabilities, and Mitigations**, specifically objectives **2.4 (indicators of malicious activity)** and **2.1 (threat actors and motivations)**. Key exam guidance:

- **Botnet ≠ worm**: A worm self-propagates; a bot accepts remote commands. Many real-world families (Conficker, Mirai) do both, but the exam distinguishes them conceptually—a botnet question focuses on *coordinated remote control*, not just spreading.
- **DDoS is the most commonly tested botnet use case**, but be prepared for scenario questions involving spam campaigns, credential harvesting, and cryptomining (especially for IoT).
- **Recognize C2 indicators**: Regular-interval beaconing, DNS queries to algorithmically random hostnames, unexpected outbound TCP/6667 (IRC), TLS to newly registered domains, or high-volume UDP to port 123 (NTP amplification setup). The exam may present NetFlow or SIEM data and ask you to identify the anomaly.
- **Gotcha — "zombie"**: On the exam, "zombie" refers to any bot host in the botnet, not specifically to a DDoS reflector. All DDoS participants are zombies, but not all zombies are DDoSing.
- **IoT scenario pattern**: A question describes cameras or routers being used in an attack. Correct answers almost always include **changing default credentials**, **disabling Telnet**, and **network segmentation**—all direct Mirai lessons.
- **DGA and fast-flux** appear as distractor answers in DNS-based questions; memorize that DGA = many random domains per day, fast-flux = rapidly rotating IPs for a domain.
- **Sinkholing** appears in questions about *law enforcement/incident response* actions against botnets—it is a detection and disruption technique, not a prevention one.
- The **botnet-as-a-service model** aligns with CompTIA's **organized crime** threat actor category (financially motivated, sophisticated, persistent).

---

## Security Implications

**Confidentiality breaches**: Banking trojans Zeus, GameOver Zeus, TrickBot, and Qakbot—all operated as or on botnets—stole credentials via browser process injection and HTML form-grabbing, collectively enabling billions of dollars in fraud. Emotet specifically exfiltrated email thread content to seed more convincing spear-phishing lures for downstream campaigns.

**Integrity and ransomware delivery**: Botnets serve as the initial access and persistence layer for ransomware operations. Ryuk, Conti, BlackBasta, and BlackCat affiliates routinely purchased initial access from TrickBot and Qakbot operators. The 2021 Colonial Pipeline ransomware attack (Darkside) traced initial access to a compromised VPN credential—the type of credential routinely traded among botnet operators.

**Availability attacks**:
- **2016 Dyn DNS attack** (Mirai): ~1.2 Tbps; disrupted DNS resolution for major US internet services for hours.
- **2018 GitHub Memcached reflection**: 1.35 Tbps peak; mitigated by Akamai Prolexic scrubbing.
- **2020 AWS mitigation**: 2.3 Tbps UDP reflection attack, the largest publicly disclosed at the time.

**Key CVEs exploited by botnet loaders**:

| CVE | Vulnerability | Botnet(s) |
|---|---|---|
| CVE-2008-4250 | MS08-067 SMB RCE | Conficker |
| CVE-2017-0144 | EternalBlue SMBv1 | WannaCry, multiple loaders |
| CVE-2018-10561/62 | Dasan GPON RCE | Mirai forks (Satori, Masuta) |
| CVE-2021-44228 | Log4Shell RCE | Mirai, Kinsing variants |
| CVE-2022-1388 | F5 BIG-IP RCE | Multiple IoT/Linux botnets |

**Collateral damage**: Bot hosts face ISP null-routing, IP blacklisting, legal liability for outbound attacks, and performance degradation. Entire residential IP ranges from major ISPs have appeared on Spamhaus's PBL (Policy Block List) due to botnet abuse.

---

## Defensive