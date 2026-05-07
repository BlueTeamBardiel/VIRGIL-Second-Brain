# Wireless LAN Security

## What it is

Wi-Fi is basically shouting your secrets in a crowded food court. Wired networks are like passing notes under the table — someone has to physically tap the cable. Wireless? Every frame your laptop sends is a radio broadcast that any device in RF range can grab out of the air, whether it's the AP you meant to talk to or some random sitting in the parking lot with a directional antenna.

Wireless LAN security is the stack of standards (WEP, WPA, WPA2, WPA3) and authentication frameworks (PSK, 802.1X, SAE) that make sure those broadcasts are scrambled, the people sending them are who they claim to be, and tampered frames get rejected.

A quick vocabulary check before going deeper:
- **Cleartext** — data that will never be encrypted (like a warning banner).
- **Plaintext** — data waiting to be encrypted (your DM before it's scrambled).
- **Ciphertext** — the scrambled output (what an attacker captures off the air).
- **Checksum** — detects tampering but doesn't prevent it. Like a tamper-evident sticker on a pizza box: you'll know if someone opened it, but the sticker didn't stop them.

## Why it matters

A wired switch has implicit physical security — to sniff traffic you have to be in the building. Wi-Fi deletes that boundary. Run an unencrypted SSID and you're handing every passerby a pcap of your network. Worse, attackers don't even need to crack live traffic — they can sit, capture the four-way handshake once, and brute-force the password offline at their leisure on a GPU rig (think of it like recording a Souls boss fight and practicing the parry timing forever, instead of having to fight it live).

Choosing the wrong WPA version or sticking with TKIP is the wireless equivalent of running a Counter-Strike server with no anticheat. It works, but anyone who shows up knows.

## Key facts

### Threats unique to wireless
- **RF Jamming**: flood the 802.11 frequency bands with noise. The Wi-Fi version of someone yelling into a megaphone next to you in Discord voice chat — nobody can hear anything useful.
- **Passive sniffing**: any unencrypted frame within RF range is fair game. No exploit needed, just a NIC in monitor mode.
- **Dictionary attacks**: weak PSKs get brute-forced offline once the handshake is captured.

### WEP (the original sin)
- **24-bit IV** — way too small. The keyspace recycles fast, like a roguelike with only 16 room layouts; you'll see repeats quickly.
- **Static keys** that never rotate.
- **Open System auth**: approves *every* request without checking credentials. The bouncer waving everyone in.
- **Shared Key auth**: uses a static key that also never rotates.
- Uses a basic checksum — detects accidental corruption, useless against intentional tampering.

### WPA (2003) — the bandage
- Uses **TKIP** encryption.
- TKIP still rides on the **RC4** stream cipher (same as WEP) but adds:
  - **48-bit IV** (way bigger keyspace).
  - **Per-packet key derivation** — every frame gets a unique key.
  - **Message Integrity Check (MIC)** — much stronger than WEP's checksum.
- **TKIP is deprecated.** Don't use it. It exists for backwards compatibility and that's it.

### WPA2 (2004) — the standard for ~14 years
- Uses **AES-CCMP** with **128-bit keys**.
- **CCMP** = Counter Mode encryption + CBC-MAC authentication. Counter Mode handles the scrambling, CBC-MAC handles "did anyone tamper with this frame." One algorithm, two jobs, like a Helldivers stratagem that both kills enemies and marks the area.
- Each frame gets a unique encryption key derived from the master key and the frame number.
- Vulnerable to **KRACK** (key reinstallation attacks against the four-way handshake).

### WPA3 (2018) — the modern standard
- Uses **AES-CCMP-192** (192-bit keys).
- Replaces the PSK handshake with **SAE** (Simultaneous Authentication of Equals).
- SAE uses **elliptic-curve cryptography** and prevents offline precomputation attacks even when the password is weak. The handshake itself refuses to leak crackable material.
- **Individualized Data Encryption** for open networks — even on a no-password coffee-shop SSID, your traffic is encrypted uniquely from everyone else's. Open Wi-Fi isn't automatic free-for-all sniffing anymore.
- **KRACK is mitigated** by WPA3's more robust key derivation.

### Pre-Shared Key (PSK) mode
- The PSK derives a **Pairwise Master Key (PMK)**.
- The PMK is used to derive a **Pairwise Transient Key (PTK)** for each session.
- The **PTK encrypts all unicast traffic** between client and AP.
- The **Four-Way Handshake** exchanges four EAPOL frames between AP and client to prove both sides know the PMK and to install the PTK.
  - **ANonce** — random nonce sent by the AP.
  - **SNonce** — random nonce sent by the client.
  - The nonces + MAC addresses + PMK get mixed into the PTK. Like a fighting game RNG seed — both players contribute entropy so nobody can predict the round.
- **No forward secrecy** in PSK mode: if someone records traffic today and gets the PSK next year, they decrypt every old session. SAE in WPA3 fixes this.
- **If the PSK leaks, everyone's traffic — past and future — is exposed.** One key, one apocalypse.

### 802.1X / Enterprise mode
Three roles:
- **Supplicant** — the client device asking for access.
- **Authenticator** — the AP/switch standing at the door.
- **Authentication Server** — usually a **RADIUS** server, the actual brain that says yes/no.

Per-user credentials. Like every player on a Minecraft realm having their own login instead of sharing one master password. **If one user's account is compromised, only that user's traffic is at risk** — not the whole network.

### Wi-Fi Alliance
- Certification requires compliance with WPA standards.
- That sticker on a router box isn't decorative — it's the gate that keeps WEP-era gear from claiming compatibility.

### Quick decision rule
- WPA3-Personal (SAE) at home if your gear supports it.
- WPA2-AES at minimum. Never WPA/TKIP. Never WEP.
- WPA2/WPA3-Enterprise (802.1X + RADIUS) for any environment with more than a handful of users.

## Related concepts
[[802.1X Authentication]]
[[RADIUS]]
[[EAP and EAPOL]]
[[Four-Way Handshake]]
[[AES-CCMP]]
[[SAE and Dragonfly Key Exchange]]
[[KRACK Attack]]
[[Forward Secrecy]]
[[RF Jamming and Deauth Attacks]]
[[Evil Twin and Rogue AP]]
[[802.11 Frame Structure]]