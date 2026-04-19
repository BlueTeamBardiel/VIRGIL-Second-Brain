---
domain: "wireless-security"
tags: [wireless, 802.11, wifi, dos, attack, deauth]
---
# Deauthentication Attack

A **deauthentication attack** (commonly called a **deauth attack**) is a wireless [[Denial of Service]] technique that exploits unprotected IEEE [[802.11]] management frames to forcibly disconnect clients from an access point. The attacker spoofs the AP's MAC address and injects crafted **deauthentication frames** into the air at one or more stations, causing them to tear down their session state and renegotiate. Prior to [[802.11w|Protected Management Frames]] (PMF), deauth frames required no authentication or integrity protection to be accepted, making this one of the most reliable and widely abused attacks in wireless security.

---

## Overview

The deauthentication frame is a legitimate component of the 802.11 MAC standard. It is treated as a *notification* rather than a *request*: when a station receives one, it must immediately drop its session state and reset to the unauthenticated, unassociated condition. A forced reconnect triggers a fresh [[WPA Handshake Capture|4-way handshake]], which an attacker can capture and subject to offline cracking. Because these frames are sent in the clear with no integrity check on pre-2009 hardware, any adversary within radio range who can observe a BSSID and a client's MAC — both trivially visible in passive monitor mode — can forge a convincing deauth in a single command.

The attack was publicly documented in the early 2000s and became ubiquitous after the release of **aireplay-ng** (part of the [[Aircrack-ng]] suite), **MDK3/MDK4**, **wifite**, and **bettercap**. Its operational simplicity — a single terminal command and a sub-US$30 USB Wi-Fi adapter capable of monitor and injection mode — places it within reach of any hobbyist. The deauth is rarely an end in itself; it is most powerful as a *trigger* that forces clients to reconnect, which enables [[WPA Handshake Capture|WPA/WPA2 4-way handshake capture]] for offline PSK cracking, [[Evil Twin Attack|evil-twin]] funneling, or [[Karma Attack|KARMA]]-style probe manipulation.

Real-world misuse is well-documented. The U.S. Federal Communications Commission fined **Marriott International US$600,000 in 2014** for deauthing guest-owned mobile hotspots at the Gaylord Opryland to force guests onto paid hotel Wi-Fi; Hilton was fined US$25,000 in 2015 for obstructing a parallel investigation. Deauth has also been documented in physical-security attacks: adversaries have used it to disable wireless IP cameras and alarm systems during burglaries, making this a concern beyond pure network security. Intentional radio-frequency jamming through spoofed deauth is illegal in the United States under 47 U.S.C. § 333 and under comparable statutes in most jurisdictions.

IEEE addressed the root design flaw in **802.11w-2009**, which introduced **Management Frame Protection (MFP)**. MFP adds a keyed Message Integrity Check (MIC) to class-3 management frames — including deauth, disassociation, and action frames — cryptographically authenticating them and causing clients to reject forgeries. 802.11w is **mandatory for [[WPA3]]**-certified devices and optional-but-recommended under WPA2. Despite its age, deployment remains uneven across consumer and IoT devices, so the attack continues to be viable against a long tail of legacy equipment.

The closely related **disassociation attack** uses the disassociation frame (subtype `0x0A`) instead of the deauth frame (subtype `0x0C`). From the client's perspective the effect is identical — both terminate the association — and both are neutralized by the same 802.11w mitigation.

---

## How It Works

The 802.11 MAC defines three frame classes: management, control, and data. The deauthentication frame is a **management frame with subtype `0x0C`** in the Frame Control field. It carries a mandatory 16-bit **Reason Code** field (IEEE 802.11-2020 Table 9-49) such as `1` ("Unspecified"), `4` ("Disassociated due to inactivity"), or `7` ("Class 3 frame received from nonassociated station"). The on-air frame structure is:

```
+---------------+-------------+-----------+-----------+-----------+--------+-----+
| Frame Control | Duration/ID | DA(addr1) | SA(addr2) | BSSID(a3) | SeqCtl | Rsn |
|    2 bytes    |   2 bytes   |  6 bytes  |  6 bytes  |  6 bytes  | 2 bytes|  2  |
+---------------+-------------+-----------+-----------+-----------+--------+-----+
```

### Attack Phases

**Phase 1 — Monitor-Mode Setup**

An 802.11 adapter must be placed into monitor mode and have packet injection capability. Common chipsets that support both include the Atheros AR9271, Ralink RT3070, Realtek RTL8812AU, and MediaTek MT7612U. Drivers must expose the `nl80211` injection interface.

```bash
# Kill interfering processes (NetworkManager, wpa_supplicant)
sudo airmon-ng check kill

# Place adapter into monitor mode
sudo airmon-ng start wlan0            # produces wlan0mon

# Verify injection is functional
sudo aireplay-ng --test wlan0mon      # expect "Injection is working!"
```

**Phase 2 — Target Enumeration**

`airodump-ng` passively surveys nearby APs and their associated clients, revealing BSSIDs, SSIDs, channels, client MACs, and signal strengths.

```bash
sudo airodump-ng wlan0mon
# Note: BSSID (AP MAC), CH (channel), STATION (connected client MACs)
```

**Phase 3 — Handshake Capture Setup**

Before injecting, begin recording traffic on the target channel to catch the handshake when the victim reconnects.

```bash
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture wlan0mon
```

**Phase 4 — Frame Injection**

Open a second terminal and inject deauth frames. Aireplay-ng sends *two* spoofed frames per iteration — one from the AP addressed to the client, and one from the client addressed to the AP — ensuring either side tears down state regardless of which direction is validated first.

```bash
# Targeted deauth: 64 frames at a specific client
sudo aireplay-ng --deauth 64 \
    -a AA:BB:CC:DD:EE:FF \          # AP BSSID
    -c 11:22:33:44:55:66 \          # Victim client MAC
    wlan0mon

# Broadcast deauth: affects every client on the BSSID (noisier)
sudo aireplay-ng --deauth 0 -a AA:BB:CC:DD:EE:FF wlan0mon
# --deauth 0 = continuous; omit -c for broadcast
```

When the victim reconnects, the EAPOL 4-way handshake appears in the capture file (`capture-01.cap`), confirmed by the header line `WPA handshake: AA:BB:CC:DD:EE:FF` in airodump-ng's output.

**Phase 5 — Offline PSK Cracking (Post-Capture)**

```bash
# Convert pcap to hashcat format
hcxpcapngtool -o capture.22000 capture-01.cap

# Dictionary attack (WPA2 hash mode 22000)
hashcat -m 22000 capture.22000 /usr/share/wordlists/rockyou.txt

# Or use aircrack-ng directly
aircrack-ng -w /usr/share/wordlists/rockyou.txt capture-01.cap
```

### Alternative Tooling

```bash
# mdk4 — high-rate flood mode targeting one BSSID
mdk4 wlan0mon d -c 6 -B AA:BB:CC:DD:EE:FF

# bettercap — interactive, scriptable
sudo bettercap -iface wlan0mon
> wifi.recon on
> wifi.deauth AA:BB:CC:DD:EE:FF

# hcxdumptool — modern PMKID/handshake capture with optional active provocation
sudo hcxdumptool -i wlan0mon -o dump.pcapng \
    --active_beacon --enable_status=15
```

Hardware alternatives include the **ESP8266 Deauther** — open-source firmware for a US$5 microcontroller that executes deauth floods from a phone-sized device, requiring no laptop or Kali distribution.

Against **WPA3-SAE** networks, the captured handshake yields no offline cracking benefit because SAE (Dragonfly) is designed to be forward-secret and resistant to dictionary attack, effectively removing the primary motive for deauthing modern networks.

---

## Key Concepts

- **Management Frame**: A class of 802.11 frame used for association, authentication, and network housekeeping (beacons, probes, auth, assoc, deauth, disassoc). Historically transmitted in plaintext with no integrity protection, making them trivially forgeable.
- **Reason Code**: A mandatory 16-bit field inside every deauth or disassociation frame specifying the stated reason for session termination. Attackers typically use reason `1` ("Unspecified") or `7` ("Class 3 frame from nonassociated STA") to appear plausible.
- **Monitor Mode**: An adapter operating state that passes every received 802.11 frame — including management frames from other networks — to userspace and permits raw frame injection. A non-negotiable prerequisite for mounting this attack.
- **BSSID Spoofing**: The attacker sets `addr2` (Source Address) and `addr3` (BSSID) in the forged frame to match the legitimate AP's MAC address, causing the client to treat the malicious frame as authoritative.
- **Protected Management Frames (PMF) / 802.11w**: A 2009 IEEE amendment that applies a keyed Message Integrity Check (BIP-CMAC-128 or BIP-GMAC-256) to class-3 management frames. Clients that have negotiated PMF silently drop deauth and disassoc frames that fail validation. **Mandatory under [[WPA3]]; optional under WPA2.**
- **EAPOL 4-Way Handshake**: The WPA/WPA2 pairwise transient key (PTK) derivation exchange between client and AP. Its capture is the real operational goal of most deauth attacks; the frames are sufficient to mount an offline brute-force attack on the network's PSK.
- **Disassociation Attack**: Functionally identical technique using the disassociation management frame (subtype `0x0A`) instead of deauthentication (`0x0C`). Both are mitigated identically by 802.11w.

---

## Exam Relevance

On **CompTIA Security+ SY0-701** this topic maps to:

- **Domain 2.4** — Analyze indicators of malicious activity (wireless attacks).
- **Domain 3.1 / 4.1** — Implementing secure baselines and hardening wireless networks.

**Common question patterns:**

- *"Users on the office Wi-Fi are frequently disconnected simultaneously while a car is idling in the parking lot. What is most likely occurring?"* → **Deauthentication attack** (often a precursor to an evil twin or handshake capture).
- *"Which 802.11 feature prevents spoofed management frames from disconnecting clients?"* → **802.11w / Protected Management Frames (PMF)**.
- *"Which Wi-Fi security standard mandates Management Frame Protection?"* → **WPA3**.
- *"An attacker successfully deauthenticates a WPA2-PSK client and captures the subsequent reconnect. What has the attacker gained?"* → The **EAPOL 4-way handshake**, enabling **offline dictionary/brute-force attack** against the PSK — *not* the key itself directly.

**Common gotchas:**

- Deauth is a **wireless Denial of Service** attack. It does **not by itself reveal the PSK** — it creates the conditions for other attacks to do so.
- The attack works equally against **open, WEP, WPA, and WPA2** networks because data-frame encryption is irrelevant; management frames are a separate, historically unprotected class.
- Do **not** conflate deauthentication (subtype `0x0C`) with disassociation (subtype `0x0A`); both are class-3 management frames, both are addressed by 802.11w.
- **WPA3-Personal** uses SAE (Simultaneous Authentication of Equals), which eliminates offline dictionary attack as a viable outcome even if a handshake analog is captured.

---

## Security Implications

A successful deauthentication campaign can produce multiple cascading outcomes:

- **Sustained Denial of Service** against wireless-only devices: IP cameras, VoIP handsets, wireless door locks, industrial sensors, IoT endpoints, and network printers.
- **Handshake capture → offline PSK cracking**: Modern GPUs can test 10⁹–10¹¹ WPA2 candidate passphrases per second; weak, default, or reused PSKs fall within minutes. Tools: `hashcat -m 22000`, `aircrack-ng`, `john`.
- **Evil-twin funneling**: Kicked clients frequently auto-associate with a rogue AP broadcasting the same ESSID at higher signal strength, exposing credentials to captive-portal phishing and enabling HTTPS downgrade or SSL-stripping attacks.
- **Physical-security bypass**: Academic and real-world cases document attackers deauthing wireless alarm sensors and IP cameras to create blind spots during burglaries. SimpliSafe and Ring camera systems have both been subjects of published research demonstrating this feasibility.

**Notable incidents and CVEs:**

- **FCC v. Marriott International (2014)** — US$600,000 fine for systematically deauthing hotel guests' personal hotspots to compel purchase of hotel Wi-Fi.
- **FCC v. Smart City Holdings / Hilton (2015)** — US$25,000 fine; additional penalties followed.
- **CVE-2019-15126 (Kr00k)** — Broadcom and Cypress Wi-Fi chipsets transmit residual buffered frames encrypted with an all-zero PMK after receiving a deauth event. An attacker who triggers the deauth can then passively decrypt those frames. Affected an estimated 1 billion+ devices.
- **FragAttacks (CVE-2020-24586 through CVE-2020-24588)** — A family of 802.11 design and implementation flaws; several attack chains involve injecting or triggering management-frame-adjacent behavior in ways that interact with deauth mechanics.
- **CVE-2022-47522 (MacStealer)** — Research demonstrating that even post-PMF APs can be manipulated via deauth-adjacent queue-management behavior to redirect traffic toward an adversary.

**Detection indicators (WIDS/WIPS signatures):**

- Anomalously high count of deauth or disassoc frames per minute from a single source MAC.
- Deauth frames whose source address matches a known AP but arrives on an unexpected channel or with out-of-sequence sequence numbers.
- Unusual reason-code distribution — bursts of `1` or `7` are a strong indicator of automated tooling.
- Clients repeatedly associating and disassociating in rapid succession on the same BSSID.
- Tools: **Kismet**, **nzyme**, **Aruba AirWave/ClearPass**, **Cisco CleanAir + aWIPS**, **Extreme AirDefense**, **WatchGuard WIPS**.

---

## Defensive Measures

**1. Enable 802.11w (PMF) in Required mode — the primary technical control.**

On `hostapd` (OpenWrt, Linux-based APs):

```ini
wpa=2
wpa_key_mgmt=WPA-PSK-SHA256       # SHA256 variant required with ieee80211w=2
ieee