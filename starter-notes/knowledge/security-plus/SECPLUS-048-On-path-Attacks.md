---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 048
source: rewritten
---

# On-path Attacks
**An attacker intercepts and relays communications between two devices while remaining invisible to both parties.**

---

## Overview
An on-path attack positions an attacker in the communication pathway between two networked devices, allowing them to observe, and potentially alter, all traffic flowing between those systems. The victims remain unaware the attack is occurring, making this one of the most dangerous network-layer threats. Understanding these attacks is critical for Security+ as they represent real-world vulnerabilities in unencrypted network protocols.

---

## Key Concepts

### On-Path Attack (Man-in-the-Middle)
**Analogy**: Imagine a postal worker who intercepts every letter between two pen pals, reads the contents, and decides whether to deliver, modify, or delete each message—all while both pen pals think they're communicating directly.

**Definition**: A network attack where an attacker positions themselves in the direct communication path between two devices, passively eavesdropping or actively modifying data as it traverses the network. The attack is invisible to the communicating parties.

**Related concepts**: [[Network Layer Attacks]], [[Man-in-the-Middle]], [[Eavesdropping]], [[Data Integrity Threats]]

---

### ARP Poisoning (ARP Spoofing)
**Analogy**: Think of ARP poisoning like secretly changing contact information in a phone book—when someone tries to call their friend by looking up their number, they reach the attacker's phone instead.

**Definition**: A Layer 2 [[Address Resolution Protocol]] attack where an attacker floods a local subnet with malicious ARP replies, mapping their own [[MAC address]] to the IP address of legitimate devices (typically the default gateway). Because [[ARP]] contains no built-in authentication or encryption mechanisms, devices accept these unsolicited replies without verification.

**Key Constraints**:
- Operates only on the **local subnet** (Layer 2)
- Attacker must be on the same physical or virtual network segment as victims
- No inherent security mechanisms in [[ARP]] protocol itself
- Requires minimal technical sophistication to execute

**Attack Flow Example**:
1. Laptop (192.168.1.100, MAC: xx:xx:xx:38:D5) needs to communicate with router (192.168.1.1, MAC: xx:xx:BB:FE)
2. Laptop performs [[ARP]] lookup: "Who has 192.168.1.1?"
3. Attacker responds: "I have 192.168.1.1, my MAC is xx:xx:xx:AA:BB"
4. Laptop updates [[ARP cache]] with attacker's MAC address
5. All traffic intended for the router now flows through attacker's device

| Aspect | Details |
|--------|---------|
| **Layer** | Layer 2 (Data Link) |
| **Scope** | Local subnet only |
| **Protocol** | [[ARP]] (Address Resolution Protocol) |
| **Authentication Required** | None |
| **Encryption Available** | None |
| **Detection Difficulty** | High (no inherent alerts) |
| **Attacker Position** | Must be on same network segment |

---

## Exam Tips

### Question Type 1: Identifying On-Path Attack Scenarios
- *"A user's credentials are intercepted while authenticating to a server on the same subnet. The user notices no unusual network behavior. Which attack is occurring?"* → ARP Poisoning / On-path attack
- **Trick**: Candidates often confuse on-path attacks with [[Man-in-the-Middle DNS attacks]] or [[SSL Stripping]]—remember ARP poisoning specifically requires local subnet access.

### Question Type 2: Mitigation Recognition
- *"Which of the following prevents ARP poisoning? A) Firewall rules, B) Static ARP entries, C) Encryption, D) MAC filtering alone"* → B (Static [[ARP]] entries eliminate the need for dynamic resolution)
- **Trick**: [[MAC filtering]] alone doesn't prevent ARP poisoning—the attacker simply spoofs a valid MAC address.

### Question Type 3: Attack Characteristics
- *"An on-path attacker can modify encrypted HTTPS traffic in transit."* → **FALSE** (encryption prevents modification; attacker can only observe)
- **Trick**: Know the difference between [[Passive Attacks]] (eavesdropping only) and [[Active Attacks]] (modification)—ARP poisoning enables both, but encryption blocks modification.

---

## Common Mistakes

### Mistake 1: Assuming ARP Poisoning Works Across Subnets
**Wrong**: "An attacker in a different subnet can poison ARP tables to intercept traffic."
**Right**: [[ARP]] operates at Layer 2 and is subnet-local; cross-subnet attacks require different methods like [[DNS Spoofing]] or [[BGP Hijacking]].
**Impact on Exam**: You may see questions designed to test whether you understand ARP's layer scope. Multi-subnet attacks use different protocols.

### Mistake 2: Confusing Passive Observation with Active Modification
**Wrong**: "With ARP poisoning, all traffic is automatically encrypted, so attackers can't modify it."
**Right**: [[ARP poisoning]] allows the attacker to intercept traffic, but whether they can modify it depends on the application layer—unencrypted protocols (HTTP, Telnet) are modifiable; encrypted ones ([[HTTPS]], [[SSH]]) are only observed.
**Impact on Exam**: Questions may ask what protections exist against on-path modification; encryption is the key answer.

### Mistake 3: Underestimating Detection Difficulty
**Wrong**: "Users will always notice ARP poisoning because network performance degrades."
**Right**: Well-executed on-path attacks are invisible—the attacker properly relays traffic, maintaining normal performance while eavesdropping.
**Impact on Exam**: Expect questions about why on-path attacks are dangerous *because* they're invisible, and why standard monitoring may miss them.

### Mistake 4: Thinking Static IP Addressing Alone Prevents ARP Attacks
**Wrong**: "If I use static IP addresses, ARP poisoning won't work."
**Right**: Static IPs prevent DHCP-based attacks but not [[ARP poisoning]]—the protocol still processes spoofed ARP replies regardless of whether IPs are static or dynamic.
**Impact on Exam**: Know that static [[ARP]] table entries (not static IPs) prevent poisoning by eliminating dynamic resolution.

---

## Mitigation Strategies

| Defense Method | How It Works | Effectiveness |
|---|---|---|
| **Static ARP Entries** | Pre-populate [[ARP]] tables so dynamic replies are ignored | Very High (for critical devices) |
| **ARP Monitoring Tools** | Detect unusual [[ARP]] activity or duplicate MAC-to-IP mappings | High (requires active monitoring) |
| **Network Encryption** ([[HTTPS]], [[SSH]]) | Prevents modification even if traffic is intercepted | High (blocks active attacks only) |
| **VPN Usage** | Isolates traffic from local subnet threats | Very High (for remote users) |
| **Port Security** ([[802.1X]]) | Restricts unauthorized devices from connecting | Medium (layer enforcement) |
| **DHCP Snooping** | Validates DHCP responses, indirectly protects against some ARP attacks | Medium (layer-dependent) |

---

## Related Topics
- [[Man-in-the-Middle (MITM) Attacks]]
- [[Address Resolution Protocol (ARP)]]
- [[MAC Address Spoofing]]
- [[Network Eavesdropping]]
- [[DNS Spoofing]]
- [[SSL Stripping]]
- [[Passive vs. Active Attacks]]
- [[Layer 2 Attacks]]
- [[Network Encryption Protocols]]
- [[802.1X Port-Based Authentication]]

---

*Source: CompTIA Security+ SY0-701 Study Companion (VIRGIL) | [[Security+]]*