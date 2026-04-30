```yaml
---
domain: "2.0 - Threats, Vulnerabilities, and Mitigations"
section: "2.4"
tags: [security-plus, sy0-701, domain-2, wireless-security, denial-of-service, 802-11]
---
```

# 2.4 - Wireless Attacks

Wireless attacks exploit the fundamental vulnerabilities of [[802.11]] wireless protocols, particularly targeting unprotected management frames and the inherent broadcast nature of radio frequency (RF) communication. This section covers two major wireless attack vectors: [[Wireless Deauthentication Attacks]] and [[Radio Frequency Jamming]], both of which can completely deny service to legitimate wireless users. Understanding these attacks is critical for the Security+ exam because wireless networks are pervasive in enterprise and home environments, and the exam expects you to distinguish between attack types, their mechanisms, and mitigation strategies.

---

## Key Concepts

- **[[802.11 Management Frames]]**: Control frames that enable wireless network operation (association, disassociation, authentication, beacon frames). Originally sent unencrypted and unauthenticated, making them vulnerable to spoofing and injection attacks.

- **[[Wireless Deauthentication Attack]]**: A [[Denial of Service (DoS)]] attack that exploits unprotected 802.11 management frames to forcibly disconnect clients from access points. An attacker sends spoofed deauthentication frames to sever the connection between a client and AP.

- **[[Radio Frequency (RF) Jamming]]**: A physical-layer DoS attack that transmits interfering wireless signals on the same frequency band as legitimate wireless communication, degrading the [[Signal-to-Noise Ratio (SNR)]] at the receiving device.

- **[[Signal-to-Noise Ratio (SNR)]]**: The ratio of desired wireless signal strength to background interference. Jamming deliberately decreases SNR, making the receiver unable to decode legitimate traffic.

- **[[802.11w (Wi-Fi Protected Management - WPM)]]**: IEEE standard (ratified July 2014) that encrypts and authenticates critical 802.11 management frames to prevent deauthentication attacks. Required for [[802.11ac]] compliance.

- **Intentional vs. Unintentional Interference**: 
  - **Jamming** = malicious, deliberate RF interference
  - **Interference** = unintentional (microwave ovens, fluorescent lights, cordless phones)

- **Jamming Types**:
  - **Constant Jamming**: Transmit random or legitimate-looking frames continuously
  - **Random Jamming**: Transmit at unpredictable intervals with random data
  - **Reactive Jamming**: Only transmit interfering signals when detecting legitimate communication

- **[[Unprotected Management Frames]]**: Beacons, probe requests/responses, authentication frames, and association frames remain unencrypted even with 802.11w, as they are needed for clients to discover and join networks.

---

## How It Works (Feynman Analogy)

Imagine a coffee shop with a speaker system announcing important information ("Now serving order #47"). A deauthentication attack is like someone shouting "EVERYONE LEAVE NOW!" in the middle of the announcement—it's heard clearly because no one's checking if that announcement is actually legitimate. Customers (devices) immediately get up and leave, even if they were in the middle of ordering.

RF jamming is different: it's like playing loud static over the loudspeaker at the same time the real announcement is being made. The static drowns out the real message, so customers can't hear what's happening and can't place orders.

**Technical reality**: 
- [[802.11 management frames]] operate at the link layer and were designed without authentication, assuming the RF medium itself was "secure" (wrong assumption). Attackers craft and inject spoofed management frames to trick clients and APs.
- [[RF Jamming]] works at the physical layer—it's a raw signal attack that doesn't need to follow wireless protocol rules. An attacker simply floods the frequency band with power, reducing the receiver's ability to distinguish the legitimate signal from noise.

---

## Exam Tips

- **Distinguish deauth attacks from jamming**: 
  - *Deauth attacks* = protocol-level exploit, attack specific devices, can be mitigated with 802.11w
  - *Jamming* = physical-layer attack, affects everything on that frequency, **cannot** be mitigated with encryption alone
  
- **Know 802.11w cold**: The exam will test whether you understand what it protects (management frames) and what it doesn't (beacons, authentication frames still broadcast in clear). It's required for 802.11ac—this is testable.

- **Watch for "interference vs. jamming" scenarios**: If a question mentions a microwave oven or fluorescent lights, it's interference (unintentional). If it's deliberate and adversarial, it's jamming.

- **Mitigation strategies matter**: 
  - Deauth mitigation = enable 802.11w on all devices
  - Jamming mitigation = frequency hopping, directional antennas, site surveys, RF monitoring tools
  
- **Range and detectability**: Jamming requires proximity (RF range) and can be detected with RF analysis tools. Deauth attacks can be performed from a distance (depends on RF range of the attacker's device).

---

## Common Mistakes

- **Assuming encryption solves wireless problems**: Candidates often think [[WPA3]] or strong encryption prevents all wireless attacks. Exam trap: jamming and deauth attacks operate below the encryption layer and are not prevented by stronger cipher suites.

- **Confusing 802.11w coverage**: Test-takers miss that 802.11w doesn't protect beacons or authentication frames—only management frames like disassociate/deauthenticate. An exam question may ask which frames remain vulnerable even with 802.11w enabled.

- **Not recognizing physical-layer attacks**: Candidates focus on protocol-level mitigations (encryption, authentication) and miss that RF jamming is a *physical-layer attack* requiring RF monitoring, spectrum analysis, and directional antenna techniques to detect and locate.

---

## Real-World Application

In your homelab, RF jamming would be a nightmare if an adversary had physical proximity to the [YOUR-LAB] fleet's [[802.11ac]]-enabled access points—it would bypass all encryption and authentication controls. [[Wazuh]] and network monitoring tools can detect sudden wireless client disconnections (deauth attack signatures), but they cannot defend against intentional RF jamming without RF monitoring hardware. In production sysadmin work, enterprise sites conduct RF site surveys and monitor spectrum to detect both accidental interference (facilities issues) and malicious jamming (security incident).

---

## [[Wiki Links]]

- **Protocols & Standards**: [[802.11]], [[802.11w]], [[802.11ac]], [[WPA3]], [[WEP]], [[WPA]], [[WPA2]]
- **Attack Vectors**: [[Denial of Service (DoS)]], [[Wireless Deauthentication Attack]], [[Radio Frequency Jamming]], [[Management Frame Injection]], [[Evil Twin (Rogue AP)]], [[Man-in-the-Middle (MITM)]]
- **Technical Concepts**: [[802.11 Management Frames]], [[Signal-to-Noise Ratio (SNR)]], [[Beacon Frame]], [[Probe Request/Response]], [[Authentication Frame]], [[Association Frame]]
- **Defensive Measures**: [[Network Segmentation]], [[VLAN]], [[Intrusion Detection System (IDS)]], [[Intrusion Prevention System (IPS)]], [[RF Monitoring]], [[Directional Antenna]], [[Frequency Hopping]]
- **Tools & Platforms**: [[Wazuh]], [[Wireshark]], [[Kali Linux]], [[Aircrack-ng]], [[Kismet]], [[Nmap]], [[Tailscale]]
- **Related Concepts**: [[CIA Triad]], [[Confidentiality]], [[Availability]], [[Encryption]], [[Authentication]], [[Zero Trust]], [[Incident Response]], [[MITRE ATT&CK]]

---

## Tags

`domain-2` `security-plus` `sy0-701` `wireless-security` `denial-of-service` `802-11` `management-frames` `rf-jamming` `deauth-attacks` `802-11w` `exam-critical`

---
_Ingested: 2026-04-15 23:44 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
