# Wireless Encryption

## What it is

Your home Wi-Fi password isn't a password. It's the seed for a cryptographic handshake that derives the actual encryption keys protecting every packet that leaves your laptop. When you type the Wi-Fi password into your phone, you're not unlocking a door — you're proving you know the shared secret, and that proof becomes the basis for keys that encrypt traffic between your phone and the access point.

Wireless encryption is the **immune system of the air gap**. Wired networks have physical security — to sniff traffic, attackers need to touch the cable. Wi-Fi sprays your packets across a hundred-meter radius, through walls, into the parking lot, where anyone with a $30 USB radio can listen. Encryption is what makes that broadcast intelligible only to authorized parties.

Technically: wireless encryption protocols (WEP → WPA → WPA2 → WPA3) define how a wireless client authenticates to an access point, how session keys are derived, and how each frame is encrypted before it hits the air.

## Why it matters

This is exam objective **220-1202 2.3** and it's tested heavily. CompTIA loves wireless security questions because the protocols form a clean historical ladder — each one was broken, replaced, broken again. Know which uses which cipher, which is deprecated, and which authentication mode fits which environment (home vs enterprise).

On the job, you'll configure SOHO routers for small businesses, set up enterprise SSIDs that authenticate against Active Directory via RADIUS, and explain to a confused user why the new conference room Wi-Fi asks for their username and password instead of one shared key. You'll also be the person who notices a coffee shop's "Free Wi-Fi" is running WEP and quietly switches to the LTE hotspot.

## At home, at work

**Beat 1 — Technical depth.** The protocol ladder, in order of historical appearance and current trust:

- **WEP (Wired Equivalent Privacy)** — RC4 cipher, 64/128-bit keys, broken since 2001. If you find it deployed, you found a finding.
- **WPA (Wi-Fi Protected Access)** — interim fix, used **TKIP** (Temporal Key Integrity Protocol) to wrap RC4 with per-packet key mixing. Also broken. Deprecated.
- **WPA2** — released 2004, mandatory since 2006. Replaced TKIP with **AES-CCMP** (Advanced Encryption Standard, Counter Mode CBC-MAC). Still acceptable for current networks but vulnerable to **KRACK** (2017) and offline dictionary attacks against weak passphrases.
- **WPA3** — released 2018, mandatory on Wi-Fi 6 certified gear. Replaces the PSK handshake with **SAE** (Simultaneous Authentication of Equals, aka Dragonfly), which is dictionary-attack resistant. Also adds forward secrecy — capturing the handshake today doesn't decrypt yesterday's traffic.

Two authentication modes exist for WPA2 and WPA3:

- **Personal (PSK)** — one shared passphrase, all clients use it. SOHO default.
- **Enterprise (802.1X)** — each user authenticates with their own credentials against a backend **RADIUS** server. No shared passphrase to leak.

**Beat 2 — Feynman example via the home network.**

**Setting up your gaming rig:** You plug in a new router, open the admin page, see four options: WPA3-Personal, WPA2/WPA3 Transition, WPA2-Personal, WPA2/WPA-Mixed. *Pick WPA3-Personal if every device supports it. Pick WPA2/WPA3 Transition if your smart bulbs are from 2019.*

**The passphrase matters more than you think:** WPA2-Personal's weakness isn't the AES encryption — AES is fine. It's that an attacker can capture the 4-way handshake when any device connects, then crack the passphrase offline at billions of guesses per second. `password123` dies in milliseconds. *A 16-character random passphrase or a four-word diceware string is what stands between your network and the kid down the street with a Pwnagotchi.*

**WPA3 fixes this:** SAE makes offline cracking infeasible because each guess requires a fresh interaction with the AP. The attacker can't grind locally on captured data. *This is the single biggest security improvement in 20 years of consumer Wi-Fi.*

**The IoT trap:** Your fridge, your robot vacuum, your printer from 2018 — half of them don't speak WPA3. Transition mode lets them connect using WPA2 while modern devices negotiate WPA3. *Convenience tax: your network is only as strong as its weakest client.*

**Beat 3 — Bridge from home to enterprise.** Same fundamental question — "how do clients prove they belong on this network?" — different right answers:

- **Home/SOHO:** WPA3-Personal, one passphrase, written on the fridge. Acceptable because the threat model is the neighbor, not a nation-state.
- **Coffee shop:** Open network or captive portal. No encryption between you and the AP — assume every packet is read. *Use a VPN or don't touch banking.*
- **Small business (under 50 employees):** WPA2-Personal with a rotated passphrase, or WPA3-Personal. Acceptable but every former employee still knows the password.
- **Enterprise:** WPA2/WPA3-Enterprise with 802.1X authenticating against RADIUS, which queries Active Directory or LDAP. Every user has their own credentials. Terminate a user, disable their AD account, they're off the Wi-Fi instantly. No shared secret to rotate.

**Beat 4 — The point.** *The shared-key model doesn't scale past the people you'd invite to dinner.* The moment you have employees, contractors, or guests, you need per-user authentication. RADIUS exists to solve exactly this problem. Get this question into your bones — "how do we authenticate users at scale?" — because you'll ask it about Wi-Fi, VPN, switch port access, and remote desktop for the rest of your career.

## Key facts

### Protocol comparison

| Protocol | Cipher | Year | Status | Notes |
|---|---|---|---|---|
| WEP | RC4 | 1997 | **Deprecated, do not use** | Crackable in minutes |
| WPA | TKIP (RC4) | 2003 | **Deprecated** | Interim fix, broken |
| WPA2 | AES-CCMP | 2004 | Acceptable | Vulnerable to KRACK, offline dictionary |
| WPA3 | AES-GCMP-256 (Enterprise) / AES-CCMP-128 (Personal) | 2018 | **Current standard** | SAE handshake, forward secrecy |

### Authentication modes

- **WPA2/WPA3-Personal (PSK / SAE)** — pre-shared key or SAE-derived key. One secret per network.
- **WPA2/WPA3-Enterprise (802.1X / EAP)** — per-user authentication via RADIUS backend. EAP variants: EAP-TLS (certificate-based, most secure), PEAP (username/password tunneled in TLS), EAP-TTLS.

### Backend authentication protocols (220-1202 2.3 sub-bullets)

- **RADIUS (Remote Authentication Dial-In User Service)** — UDP-based AAA protocol. The standard for 802.1X Wi-Fi and VPN authentication. Encrypts only the password field, not the full payload — usually run on a trusted management network.
- **TACACS+ (Terminal Access Controller Access-Control System Plus)** — Cisco-developed, TCP-based, encrypts the entire payload. Used primarily for network device administration (logging into routers/switches), not Wi-Fi.
- **Kerberos** — ticket-based authentication, the heart of Active Directory. Not directly used for Wi-Fi handshakes, but the RADIUS server often validates credentials against AD, which runs Kerberos under the hood.
- **Multifactor authentication (MFA)** — layered on top of 802.1X in high-security environments. Something you know (password) + something you have (certificate, smart card, TOTP). Increasingly common for corporate Wi-Fi.

### TKIP vs AES — the one CompTIA loves

- **TKIP** — Temporal Key Integrity Protocol. Used by WPA. Wraps RC4 with per-packet rekeying. **Deprecated.**
- **AES** — Advanced Encryption Standard. Block cipher used by WPA2 (CCMP mode) and WPA3 (GCMP-256 in Enterprise). Hardware-accelerated on every modern radio.

> **CompTIA exam trap:** "WPA uses TKIP, WPA2 uses AES" is the answer they want. Real-world WPA2 can fall back to TKIP for legacy clients (WPA2-Mixed mode), but on the exam, **WPA = TKIP, WPA2 = AES, WPA3 = AES with SAE**.

### CompTIA exam traps

> **Trap 1:** WPA3 does not use TKIP. TKIP died with WPA. If you see "WPA3 + TKIP" on the exam, it's wrong.

> **Trap 2:** RADIUS uses UDP (ports 1812 authentication, 1813 accounting). TACACS+ uses TCP (port 49). CompTIA will swap them.

> **Trap 3:** "Enterprise" mode does not mean "more encryption." It means **per-user authentication via RADIUS**. The encryption cipher (AES-CCMP) is the same as Personal mode. The difference is who holds the key material.

> **Trap 4:** Kerberos is not a Wi-Fi protocol. It's the domain authentication backbone. RADIUS may validate against a Kerberos realm, but Kerberos itself doesn't encrypt your wireless frames.

## Helpdesk reality

- **"My laptop won't connect to the new office Wi-Fi."** — Likely 802.1X with EAP-TLS and the user's machine certificate didn't deploy. Check Intune/SCCM, push the cert, reboot. Don't give them the "guest" password as a shortcut — that's how shadow IT starts.
- **"It worked at home but not at work."** — Home is WPA2/3-Personal, work is WPA2/3-Enterprise. Same SSID name doesn't matter; the auth model is different.
- **"Can you tell me the Wi-Fi password?"** — If you're on enterprise Wi-Fi, there isn't one. Explain that they log in with their normal AD credentials. This conversation happens weekly.
- **"My old printer won't join the Wi-Fi."** — It probably only speaks WPA2-Personal. Either put it on a segregated IoT SSID running WPA2, or wire it. Don't downgrade your whole network for one printer.
- **Never** promise that WPA2 is "secure enough" for a regulated environment (PCI, HIPAA). The auditor wants WPA3-Enterprise with 802.1X and they're not negotiating.

## Related concepts

[[SOHO Router Configuration]] · [[802.1X and RADIUS]] · [[Active Directory and Kerberos]] · [[MFA and Authentication Factors]] · [[VPN Encryption]] · [[Wireless Standards (Wi-Fi 6/6E/7)]] · [[Network Segmentation and VLANs]]

*Source: VIRGIL knowledge base — 2026-05-10*