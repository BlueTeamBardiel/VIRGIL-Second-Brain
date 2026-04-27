---
domain: "wireless networking"
tags: [wireless, 802.11, authentication, wifi-security, frames, layer2]
---
# Authentication Frame

An **Authentication Frame** is a specific type of [[IEEE 802.11]] management frame used during the initial handshake process that allows a wireless client ([[Station (STA)]]) to prove its identity to an [[Access Point (AP)]] before association can occur. It is part of the fundamental [[802.11 Management Frame]] architecture and operates at Layer 2 of the [[OSI Model]]. Understanding Authentication Frames is critical for both wireless network design and for analyzing attacks such as [[Deauthentication Attack]] and [[Evil Twin Attack]].

---

## Overview

In the original IEEE 802.11 specification (1997), Authentication Frames were designed as the first formal handshake step in the two-phase process of joining a wireless network: authentication followed by association. Without a successful authentication exchange, the access point will not allow a station to send an [[Association Request Frame]], meaning the client cannot obtain network access regardless of any higher-layer credentials it may possess.

The 802.11 standard originally defined two authentication methods carried within Authentication Frames: **Open System Authentication** and **Shared Key Authentication**. Open System Authentication is essentially a null authentication — the AP accepts any client that presents a valid frame. Shared Key Authentication used [[WEP (Wired Equivalent Privacy)]] in a challenge-response scheme that was later demonstrated to be cryptographically broken. Modern Wi-Fi security has replaced these primitive mechanisms with [[WPA2]] and [[WPA3]], which layer [[EAP (Extensible Authentication Protocol)]] or [[SAE (Simultaneous Authentication of Equals)]] on top of the basic frame exchange, but the underlying Authentication Frame structure persists.

Authentication Frames are **management frames**, meaning they are not encrypted by default in most legacy deployments. This is a critical security characteristic: because management frames traditionally lacked cryptographic protection, attackers could forge Authentication Frames to confuse stations and access points. The introduction of [[802.11w (Management Frame Protection)]] in 2009, later made mandatory in Wi-Fi 6 ([[802.11ax]]), addressed this vulnerability by cryptographically signing certain management frames, including deauthentication and disassociation frames, though Authentication Frames used during the initial open exchange remain publicly observable.

In enterprise environments using [[WPA2-Enterprise]] or [[WPA3-Enterprise]], the Authentication Frame exchange is only the gateway to a deeper [[RADIUS]]-backed authentication process. The station and AP complete the 802.11 authentication frame exchange quickly (often a two-frame Open System exchange), and then the real credential verification happens through the [[EAPOL (EAP over LAN)]] handshake during the association phase. This architectural split means that the Authentication Frame itself carries little security weight in modern enterprise Wi-Fi — the security burden has been shifted to the 4-Way Handshake and EAP methods.

The practical relevance of Authentication Frames for security professionals lies in their role in attack tooling. Tools such as `airbase-ng`, `hostapd`, and `mdk4` manipulate Authentication Frame exchanges to perform network attacks, rogue AP creation, and denial-of-service. Conversely, [[Wireless Intrusion Detection System (WIDS)]] solutions monitor Authentication Frame rates and sequences to detect flooding attacks and rogue stations.

---

## How It Works

### Frame Structure

An Authentication Frame is an 802.11 management frame with a **Frame Control** field type set to `00` (Management) and a subtype value of `1011` (binary) = `0x0B`. Its body contains three key fixed fields and one optional information element:

```
802.11 Authentication Frame Body Layout:
+-----------------------------+----------+
| Authentication Algorithm    | 2 bytes  |  0 = Open System, 1 = Shared Key, 3 = SAE
| Authentication Transaction  | 2 bytes  |  Sequence number: 1, 2, 3, or 4
| Status Code                 | 2 bytes  |  0x0000 = Success
+-----------------------------+----------+
| Challenge Text (optional)   | Variable |  Used in Shared Key only
+-----------------------------+----------+
```

### Open System Authentication (Two-Frame Exchange)

This is the dominant mode in virtually all modern Wi-Fi deployments (WPA2-Personal, WPA3-Personal, WPA2-Enterprise). Despite its name, it provides no real identity verification.

**Step 1 — Authentication Request (STA → AP):**
- The client sends an Authentication Frame with:
  - **Authentication Algorithm Number:** `0x0000` (Open System)
  - **Authentication Transaction Sequence:** `0x0001`
  - **Status Code:** `0x0000` (reserved in requests)

**Step 2 — Authentication Response (AP → STA):**
- The AP replies with:
  - **Authentication Algorithm Number:** `0x0000`
  - **Authentication Transaction Sequence:** `0x0002`
  - **Status Code:** `0x0000` (Success) or an error code (e.g., `0x0001` = Unspecified failure)

After a successful response, the client proceeds to send an [[Association Request Frame]].

### Shared Key Authentication (Four-Frame Exchange — Legacy/Deprecated)

Used only with WEP. This process is now considered broken and disabled in all modern hardware.

**Step 1 — Request (STA → AP):** Algorithm `0x0001`, Sequence `0x0001`
**Step 2 — Challenge (AP → STA):** AP sends a 128-byte plaintext challenge in the frame body, Sequence `0x0002`
**Step 3 — Response (STA → AP):** Client encrypts the challenge with the WEP key and returns it, Sequence `0x0003`
**Step 4 — Result (AP → STA):** AP verifies the encrypted challenge, Sequence `0x0004`, Status = Success/Fail

The flaw: an attacker can observe frames 2 and 3 to recover the WEP [[keystream]], making Shared Key Authentication *less secure* than Open System.

### SAE Authentication (WPA3)

[[SAE (Simultaneous Authentication of Equals)]] uses the Authentication Frame transport but with Algorithm Number `0x0003`. It is a multi-round Diffie-Hellman-based [[Dragonfly Handshake]]:

**Commit Exchange:** Both STA and AP send Authentication Frames with SAE Commit elements (scalar and element values).
**Confirm Exchange:** Both sides send Confirm elements to verify knowledge of the same password without revealing it.

```
Frame 1: STA → AP  | Algo=SAE(3), Seq=1, SAE Commit
Frame 2: AP → STA  | Algo=SAE(3), Seq=1, SAE Commit
Frame 3: STA → AP  | Algo=SAE(3), Seq=2, SAE Confirm
Frame 4: AP → STA  | Algo=SAE(3), Seq=2, SAE Confirm (Status=Success)
```

### Capturing Authentication Frames with Wireshark / Aircrack-ng

```bash
# Put interface into monitor mode
sudo airmon-ng start wlan0

# Capture all management frames on channel 6
sudo airodump-ng wlan0mon --channel 6 -w capture_output

# In Wireshark, filter for authentication frames only
wlan.fc.type_subtype == 0x000b

# Filter for a specific BSSID's auth frames
wlan.fc.type_subtype == 0x000b && wlan.bssid == aa:bb:cc:dd:ee:ff
```

```bash
# Send a crafted authentication frame (Open System) with scapy
from scapy.all import *
from scapy.layers.dot11 import Dot11, Dot11Auth, RadioTap

iface = "wlan0mon"
client_mac = "de:ad:be:ef:00:01"
ap_bssid   = "aa:bb:cc:dd:ee:ff"

auth_frame = (
    RadioTap() /
    Dot11(type=0, subtype=11, addr1=ap_bssid, addr2=client_mac, addr3=ap_bssid) /
    Dot11Auth(algo=0, seqnum=1, status=0)
)
sendp(auth_frame, iface=iface, count=1, verbose=True)
```

---

## Key Concepts

- **Authentication Algorithm Number:** A 2-byte field inside the Authentication Frame body that specifies which authentication method is being used. `0` = Open System, `1` = Shared Key (WEP), `3` = SAE (WPA3). Hardware or drivers that do not support an algorithm will respond with Status Code `0x000D` (Unsupported Auth Algorithm).

- **Authentication Transaction Sequence Number:** Tracks the current step in the multi-frame authentication handshake. Open System uses sequences 1 and 2; Shared Key uses 1–4; SAE uses a more complex commit/confirm structure. An out-of-sequence frame should be treated as malformed or an attack indicator.

- **Status Code:** A 2-byte field in the AP's response Authentication Frame indicating success (`0x0000`) or the specific reason for failure. Common codes include `0x0001` (Unspecified failure), `0x000D` (Responding STA does not support the specified auth algorithm), and `0x0051` (Rejected with suggested BSS transition).

- **Management Frame Protection (802.11w):** An IEEE amendment that adds cryptographic integrity to specific management frames. Critically, it does *not* protect Authentication Frames in the initial exchange (since keys do not yet exist), but it does protect later deauthentication and disassociation frames using a [[Message Integrity Code (MIC)]]. WPA3 mandates 802.11w.

- **Pre-Shared Key (PSK) vs. Authentication Frame:** It is a common misconception that the PSK is verified during the Authentication Frame exchange. In WPA2-Personal, the Authentication Frame exchange is Open System (effectively blank); PSK verification occurs entirely within the [[4-Way Handshake]] during association. The Authentication Frame is merely a gate, not a credential check.

- **PMKID Attack Surface:** Because the Authentication Frame exchange in WPA2 is trivially completed (Open System), an attacker can complete auth and association purely to capture a [[PMKID]] from the first EAPOL frame — enabling offline dictionary attacks without monitoring for a legitimate client's handshake.

- **Authentication Flood (DoS):** Sending thousands of spoofed Authentication Frames from random MAC addresses can overwhelm an AP's association table, a variant of the [[Deauthentication Attack]] / management frame flood class of attacks.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Primarily falls under **Domain 2.0 — Threats, Vulnerabilities, and Mitigations** (wireless attacks) and **Domain 3.0 — Security Architecture** (wireless protocols).

**Key exam facts to memorize:**
- Authentication Frames are **management frames** — they operate at Layer 2 and are traditionally **unencrypted**.
- The two original 802.11 authentication methods are **Open System** and **Shared Key**. For Security+, know that Shared Key is deprecated because it exposed WEP keystream material.
- [[802.11w]] = **Management Frame Protection** — the solution to forged management frame attacks. WPA3 mandates it; WPA2 made it optional.
- **Deauthentication attacks** and **disassociation attacks** exploit the unprotected nature of management frames (same frame class as Authentication Frames).
- WPA3's SAE replaces PSK pre-shared authentication with a cryptographically secure mutual authentication embedded in the Authentication Frame exchange.

**Common question patterns:**
- "A security analyst sees thousands of Authentication Frames from random MAC addresses hitting the AP. What attack is this?" → **Authentication/Association Flood (DoS)**
- "Which 802.11 amendment adds protection against forged deauthentication frames?" → **802.11w**
- "At what point in the 802.11 connection process is a WPA2-Personal pre-shared key verified?" → **During the 4-Way Handshake (EAPOL), NOT during the Authentication Frame exchange**
- "Why is Shared Key Authentication considered less secure than Open System for WEP networks?" → **Because the challenge/response allows an attacker to derive the WEP keystream**

**Gotcha:** Do not confuse 802.11 Authentication Frames with higher-layer authentication protocols ([[RADIUS]], [[LDAP]], [[Kerberos]]). The exam frequently tests the distinction between 802.11 association-layer authentication and network-layer authentication.

---

## Security Implications

### Forged Authentication Frames (Pre-802.11w)

Because Authentication Frames are sent before any encryption keys are established, they cannot be authenticated cryptographically in the initial exchange. An attacker with a monitor-mode capable wireless adapter can forge Authentication Frames from any source MAC address. This enables:

- **Authentication Flood:** Tools like `mdk4` (mode `a`) send authentication frames from thousands of spoofed MAC addresses. Many older APs have fixed-size association tables; when full, legitimate clients are denied service. This is a documented [[Denial of Service (DoS)]] attack vector.
  ```bash
  # mdk4 authentication flood (educational context only)
  sudo mdk4 wlan0mon a -a <BSSID> -m
  ```

- **Rogue AP Authentication Harvesting:** An [[Evil Twin Attack]] completes an Open System Authentication Frame exchange identically to a legitimate AP. Once the client associates with the rogue AP, the attacker can capture credentials at higher layers.

### PMKID Capture (CVE-related — WPA2)

Discovered by Jens Steube (hashcat author) in 2018, the **PMKID attack** exploits the fact that an attacker needs only to complete an Authentication Frame exchange and capture the first EAPOL frame (which contains the PMKID) to attempt offline password cracking — no legitimate client needs to be present. This dramatically lowered the barrier for WPA2-Personal attacks.

The PMKID is derived as:
```
PMKID = HMAC-SHA1-128(PMK, "PMK Name" || AP_MAC || STA_MAC)
```
Because the PMK is derived from the PSK and SSID, this enables dictionary and brute-force attacks offline using tools like `hcxdumptool` and `hashcat` (mode `-m 22000`).

### SAE Side-Channel Vulnerabilities (Dragonblood — CVE-2019-9494, CVE-2019-9496)

The WPA3 SAE Authentication Frame exchange (Dragonfly handshake) was found to be vulnerable to **timing and cache side-channel attacks** (dubbed "Dragonblood" by Vanhoef and Ronen, 2019). Attackers observing timing differences in AP responses to SAE Commit Authentication Frames could recover partial information about the password. Patches were issued by major vendors, and IEEE 802.11-2020 incorporated countermeasures.

### Management Frame Spoofing Without 802.11w

Without 802.11w, deauthentication and disassociation management frames can be forged trivially. An attacker can:
1. Send a forged Deauthentication Frame to kick a client off the network.
2. The client re-initiates the Authentication Frame exchange.
3. The attacker captures the resulting [[4-Way Handshake]] for offline cracking.

---

## Defensive Measures

### Enable WPA3 with SAE
SAE replaces Open System + PSK with a cryptographically sound mutual authentication embedded in the Authentication Frame exchange itself, eliminating PMKID-style offline attacks and providing [[Forward Secrecy]].

```
# hostapd.conf — WPA3-Personal configuration
wpa=2
wpa_key_mgmt=SAE
ieee80211w=2          # Management Frame Protection required (mandatory for WPA3)
sae_password=YourStrongPassphrase
sae_pwe=2             # Hash-to-element method (mitigates Dragonblood)
```

### Enforce 802.11w (Management Frame Protection)

For WPA2 networks that cannot immediately migrate to WPA3, enable MFP in required mode on all enterprise APs:

```
# Cisco IOS-XE WLC — MFP configuration
wireless profile policy CORPORATE
  mfp client required
  security wpa akm 802.1x
  security