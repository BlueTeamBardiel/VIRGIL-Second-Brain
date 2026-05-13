# Wireless Encryption

## What it is

In **Silent Hill**, the radio in Harry's pocket hisses static whenever a monster is nearby. The signal is in the air whether you want it or not — anyone walking through that fog with the right receiver picks up the same noise. The radio doesn't choose who hears it. The fog doesn't have walls. That's exactly what Wi-Fi is — a broadcast medium where every frame leaves the antenna and travels through space that anyone with a card in monitor mode can listen to. Wireless encryption is the cipher you wrap around those frames so that when the wrong receiver picks them up, all they get is static.

Technically: **wireless encryption** is the suite of cryptographic protocols (WPA2, WPA3) that authenticate clients to an [[Access Point]] and encrypt the 802.11 data frames between them. It does not hide that traffic exists — beacons, probes, and frame headers are still visible in the air. It hides what the traffic *says*.

## Why it matters

Wi-Fi without encryption is a public address system. Anyone within RF range — the car in the parking lot, the apartment one floor up, the guy with a Pringles can antenna two blocks over — can capture every frame. Open Wi-Fi at the coffee shop is the textbook example: HTTPS protects the web sessions, but DNS queries, SNI fields, and any plaintext protocol are wide open.

For Network+, this is **Objective 2.3**. The exam tests whether you can pick the right encryption standard for a scenario, tell PSK from Enterprise, and know what WPA3 actually fixed that WPA2 didn't. Wrong answers on this section are how techs end up deploying WEP-equivalent garbage in 2026.

In the real world: the auditor failing your network on a PCI scan, the GDPR fine when guest Wi-Fi leaks customer email, the breach post-mortem where the attacker pivoted from the parking lot — all of these start with wireless encryption decisions made by someone who didn't know the difference between WPA2-Personal and WPA2-Enterprise.

## Key facts

### The encryption standards (and the dead ones)

| Standard | Cipher | Status | Use it? |
|---|---|---|---|
| **WEP** | RC4 | Broken since 2001 | Never. Crackable in minutes. |
| **WPA** | TKIP | Deprecated | Never. TKIP is a band-aid on RC4. |
| **WPA2** | AES-CCMP | Current minimum acceptable | Yes, with caveats |
| **WPA3** | AES-GCMP-256 + SAE | Current best | Yes, when clients support it |

**WEP** and **WPA (TKIP)** are exam distractors. If a question offers them as the "secure" option, it's wrong. They exist on the exam so you can recognize and reject them.

### WPA2 — the workhorse

**[[WPA2]]** uses **AES** in **CCMP** mode for encryption and a **4-way handshake** to derive session keys from a shared secret. It's been the deployable standard since 2006. It works. It's also got known weaknesses:

- **KRACK attack** (2017) — replays handshake messages to force nonce reuse. Patched on all maintained clients, but unpatched IoT devices are still vulnerable.
- **Offline dictionary attack on the PSK** — capture the 4-way handshake, take it home, run hashcat against it. If your PSK is `Welcome123`, you have minutes, not years.

### WPA3 — what actually changed

**[[WPA3]]** is not just "WPA2 but bigger numbers." It fixed real problems:

- **SAE (Simultaneous Authentication of Equals)** replaces the PSK handshake. SAE is a Dragonfly key exchange — even if an attacker captures the handshake, they can't run an offline dictionary attack. They have to attack live, which the AP rate-limits.
- **Forward secrecy** — compromising the PSK doesn't decrypt previously captured sessions. WPA2 doesn't have this.
- **GCMP-256** instead of CCMP-128 in WPA3-Enterprise 192-bit mode.
- **Protected Management Frames (PMF)** mandatory — kills the deauth-flood attack that's been the bread and butter of every wireless pentester for a decade.
- **Wi-Fi Easy Connect (DPP)** — QR-code onboarding for IoT, so the smart bulb doesn't need a keyboard.

> **CompTIA exam trap:** WPA3 does NOT make weak passwords safe. SAE prevents *offline* dictionary attacks, but an attacker can still try passwords against the live AP. A 4-character PSK is still trivial. SAE buys you time, not invincibility.

### PSK vs Enterprise — the one diagram you must memorize

| Feature | **WPA2/3-Personal (PSK)** | **WPA2/3-Enterprise** |
|---|---|---|
| Authentication | One shared password | Per-user credentials via [[RADIUS]] |
| Key source | PSK + SSID | EAP method (PEAP, EAP-TLS, etc.) |
| Revoke one user | Change PSK, reconfigure everyone | Disable account in AD/IdP |
| Per-user encryption keys | No — derived from same PSK | Yes — unique per session |
| Backend needed | None | RADIUS server (NPS, FreeRADIUS, Cloud) |
| Use case | Home, SOHO, small office | Anything with employees |

**EAP methods you'll see on the exam:**
- **EAP-TLS** — certificates on both client and server. Gold standard. Painful to deploy.
- **PEAP** — server cert + user/pass inside a TLS tunnel. Most common in AD environments.
- **EAP-TTLS** — similar to PEAP, more flexible inner auth.
- **EAP-FAST** — Cisco's, uses PACs instead of certs.

> **CompTIA exam trap:** WPA2-Enterprise is NOT inherently stronger encryption than WPA2-Personal — both use AES-CCMP. What Enterprise gives you is *better authentication and key management*, not a different cipher. The frames are encrypted the same way; the keys just come from somewhere smarter.

### Authentication vs Encryption — don't conflate them

These are two different jobs:

- **[[Authentication]]** — proving who you are. PSK, 802.1X/EAP, SAE.
- **Encryption** — scrambling the data. CCMP, GCMP.

WPA2-Personal authenticates with a PSK and encrypts with CCMP. WPA3-Enterprise authenticates with EAP and encrypts with GCMP-256. Two knobs, not one.

### The SSID family — what shows up on the exam

CompTIA loves these three acronyms:

- **[[SSID]] (Service Set Identifier)** — the network name. "Linksys", "CoffeeShop_Guest", "ATT-7H8K".
- **[[BSSID]] (Basic Service Set Identifier)** — the MAC address of the AP radio. Unique per AP per band. How your phone tells two APs with the same SSID apart.
- **[[ESSID]] (Extended SSID)** — the SSID when multiple APs share it to form one logical network (an Extended Service Set). What roaming runs on.

When you walk through a building and your phone hops APs without dropping the connection, you're roaming across BSSIDs within one ESSID. The SSID stays "CorpWiFi" the whole time; the BSSID changes every time you cross a coverage boundary.

### Guest networks and captive portals

**[[Guest network]]** — separate SSID, separate VLAN, no access to internal resources. Usually open or WPA2/3-Personal with a rotating password posted at the front desk. The whole point is to keep visitor laptops off the corporate LAN.

**[[Captive portal]]** — the splash page that intercepts your first HTTP request and demands you click "I agree" or enter a code before forwarding traffic. Hotel Wi-Fi. Airport Wi-Fi. Conference Wi-Fi. Implemented at the gateway, not the radio — it's an authorization layer on top of (usually open) encryption.

> **CompTIA exam trap:** A captive portal is NOT encryption. Open Wi-Fi with a captive portal is still open Wi-Fi — everything you send before AND after clicking "agree" is in the clear unless the application layer (HTTPS) wraps it. The portal authenticates *you to the network*; it does not encrypt *your traffic to the AP*.

### WPA3-Personal Transition Mode

Real deployments rarely flip from WPA2 to WPA3 overnight. **Transition Mode** lets one SSID accept both WPA2-PSK and WPA3-SAE clients. Newer phones get SAE, the 2018 smart thermostat gets PSK, everyone's happy. The downside: an attacker can force-downgrade clients to WPA2 and attack the PSK. Pure WPA3-only mode is more secure; transition mode is the political compromise.

### Open networks aren't fully open anymore

WPA3 added **OWE (Opportunistic Wireless Encryption)** — "Enhanced Open." It encrypts traffic on networks with no password using anonymous Diffie-Hellman. No authentication, but at least the guy in the parking lot can't sniff your traffic in plaintext. If you see "Enhanced Open" on the exam, this is it.

## Helpdesk reality

- User says: *"The Wi-Fi password doesn't work."* Translation: they're trying to join the corporate SSID with the guest password, or they're on WPA2-Enterprise and don't realize their AD account is locked out. Check the auth logs on the RADIUS server before resetting anything.
- User says: *"My old printer can't see the new Wi-Fi."* Translation: you turned on WPA3-only mode. The 2014 printer doesn't speak SAE. Solutions: transition mode, a separate legacy SSID on WPA2, or replace the printer. Never lower the main SSID's encryption to fit the oldest device on the network.
- User says: *"The Wi-Fi is slow."* Encryption is almost never the cause. Check signal strength, channel utilization, and client capabilities first. AES is hardware-accelerated on every chipset made this decade.
- Never promise: *"WPA3 means you don't need a VPN on public Wi-Fi."* Wrong. Encryption to the AP is one hop. The AP's upstream provider, the captive portal operator, and every middlebox along the path still see your traffic unless it's also TLS-wrapped. *Wireless encryption protects the air gap. Nothing else.*
- Escalation: if you've confirmed the client supports the SSID's security mode, the credentials are correct, and the RADIUS server is reachable — it's a network team / identity team ticket. Don't keep retyping the password.

### CompTIA exam traps (consolidated)

> **Trap 1:** WEP and WPA (original) are always wrong answers. If they appear, eliminate them first.
> **Trap 2:** WPA2-Enterprise uses the same cipher as WPA2-Personal. The difference is authentication, not encryption strength.
> **Trap 3:** A captive portal is authorization, not encryption.
> **Trap 4:** WPA3's SAE defeats *offline* PSK dictionary attacks, not weak passwords in general.
> **Trap 5:** BSSID is per-radio, not per-AP. A dual-band AP has two BSSIDs. A tri-band AP has three.
> **Trap 6:** PMF (Protected Management Frames) is mandatory in WPA3 and optional in WPA2. If a question asks how to prevent deauth attacks, the answer involves PMF.

## Related concepts

[[WPA2]] · [[WPA3]] · [[SSID]] · [[BSSID]] · [[Access Point]] · [[RADIUS]] · [[802.1X]] · [[EAP]] · [[Authentication]] · [[Captive portal]] · [[Guest network]] · [[Channels]] · [[Band steering]] · [[Mesh networks]] · [[Wireless standards]] · [[VLAN]]

*Source: VIRGIL knowledge base — 2026-05-11*