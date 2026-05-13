# Authentication and Access

## What it is

You join a corporate Wi-Fi and a box pops up asking for your username and password — not a shared "guest123" passphrase taped to the wall. That's enterprise authentication: the network doesn't trust the SSID alone, it asks *who are you, and can someone vouch for you.*

In plain English: authentication is how a system proves you are who you claim to be. Access control is what happens after — what you're allowed to touch. The network stack is the voice and ears of the machine; authentication is the bouncer who decides whether the voice gets to speak to anything important.

Technically: this domain covers the wireless encryption protocols (WPA2, WPA3, the dead body of WEP), the authentication servers that back enterprise networks (RADIUS, TACACS+), the ticket-granting protocol that runs every Windows domain on Earth (Kerberos), and the layered identity model that keeps a stolen password from being game over (MFA).

## Why it matters

Objective 220-1202 2.3 hammers this because the helpdesk lives at the authentication failure boundary. "I can't log in" is the #1 ticket, every shift, forever. You need to know which protocol owns the failure — is it the wireless association, the RADIUS handshake, the Kerberos ticket, the MFA push that got swallowed by a dead phone battery? Each has a different fix path.

Career-wise: every job above tier-1 helpdesk assumes you understand the difference between WPA2-Personal and WPA2-Enterprise, between Kerberos and NTLM, between a RADIUS timeout and a bad password.

## At home, in the enterprise

**Beat 1 — Technical depth.** Wireless encryption has gone through four generations. WEP (dead, 2004) used RC4 and broke in minutes. WPA (transitional) added TKIP, also broken. WPA2 (2004–present) uses AES-CCMP and is still acceptable. WPA3 (2018+) uses AES-GCMP-256 and SAE (Simultaneous Authentication of Equals) to replace the pre-shared key handshake that made WPA2 crackable offline. Both WPA2 and WPA3 come in two flavors: **Personal** (one shared passphrase for the whole network) and **Enterprise** (per-user credentials via 802.1X and a RADIUS server on the back end).

**Beat 2 — Feynman via the home network.**

**Your home Wi-Fi:** One SSID, one passphrase, WPA2-Personal or WPA3-Personal. Everyone in the house uses the same key. *If the key leaks, you change it on the router and every device re-joins.*

**Your kid's friend connects:** They got the password once at a sleepover. They can connect forever until you rotate the key. *Personal mode has no concept of "this individual no longer has access."*

**Now scale to a 5,000-person company:** Rotating a shared passphrase across 5,000 laptops every time someone quits is insane. So enterprise networks don't. They use WPA2/WPA3-**Enterprise**, where each user authenticates with their own AD credentials. *HR offboards the user, IT disables the account, the laptop stops associating.*

**The handshake under the hood:** Your laptop talks 802.1X to the access point. The AP forwards credentials to a RADIUS server. RADIUS checks them against Active Directory. AD says yes/no. RADIUS tells the AP. *The access point doesn't know who you are — it just relays.*

**Beat 3 — Bridge.** Same question — "how does the network know who you are?" — different right answers:

- **Home:** WPA3-Personal. One key, change it occasionally.
- **Coffee shop:** Open SSID + captive portal. Assume hostile, VPN everything.
- **Enterprise:** WPA2/WPA3-Enterprise with RADIUS backed by AD. Certificate-based EAP-TLS for the security-conscious shops.
- **Server administration:** TACACS+ for network device login (routers, switches, firewalls). Per-command authorization, every command logged.

**Beat 4 — The point.** Authentication scales by separating *who you are* from *how the network checks*. Personal mode collapses both into a shared secret. Enterprise mode splits them — credentials live in a directory, the network just asks. Get this distinction into your bones; everything else in this objective is a variation on it.

## Key facts

### Wireless protocol cheat sheet

| Protocol | Year | Encryption | Auth method | Status |
|---|---|---|---|---|
| WEP | 1997 | RC4 (broken) | Shared key | Dead. Never use. |
| WPA | 2003 | TKIP (broken) | PSK or 802.1X | Dead. Transitional only. |
| WPA2-Personal | 2004 | AES-CCMP | Pre-shared key (PSK) | Acceptable. Vulnerable to offline crack if PSK is weak. |
| WPA2-Enterprise | 2004 | AES-CCMP | 802.1X + RADIUS | Standard for business. |
| WPA3-Personal | 2018 | AES-GCMP-128 | SAE (replaces PSK handshake) | Current best for home/small business. |
| WPA3-Enterprise | 2018 | AES-GCMP-256 | 802.1X + RADIUS | Current best for business. |

**TKIP** was the bandage on WEP — rotated keys per packet but kept RC4 underneath. Broken. If you see TKIP in 2026, the AP is a museum piece. **AES** replaced it and is the actual cipher doing the work in WPA2 and WPA3.

### Enterprise authentication servers

**RADIUS** (Remote Authentication Dial-In User Service):
- UDP ports 1812 (auth) and 1813 (accounting)
- Encrypts only the password field, not the whole packet
- Open standard, works with everything
- Used for Wi-Fi (802.1X), VPN, captive portals

**TACACS+** (Terminal Access Controller Access-Control System Plus):
- TCP port 49
- Encrypts the **entire payload**
- Cisco-developed, now widely supported
- Used primarily for **network device administration** (router/switch/firewall logins)
- **Separates** authentication, authorization, and accounting (AAA) into distinct exchanges — per-command authorization is the killer feature

> **CompTIA exam trap:** RADIUS vs TACACS+. RADIUS = UDP, encrypts password only, used for **network access** (Wi-Fi, VPN). TACACS+ = TCP, encrypts everything, used for **device administration** (logging into the switch itself). Users get RADIUS, admins get TACACS+.

### Kerberos

The authentication protocol running underneath every Active Directory domain. You log into a Windows domain, you're using Kerberos whether you know it or not.

How it works:

1. You log in. Your machine sends a request to the **Key Distribution Center (KDC)** — on Windows, a domain controller.
2. KDC issues a **Ticket-Granting Ticket (TGT)**, encrypted with your password hash. Your machine decrypts it to prove you know the password.
3. When you want to access a file share, your machine presents the TGT to the KDC and asks for a **service ticket** for that file server.
4. KDC issues the service ticket. Your machine hands it to the file server. You're in.

Key points:
- **Port 88** (TCP/UDP)
- **Time-sensitive** — clocks must be within 5 minutes. *"Suddenly can't log in" + "laptop was off for a month" often = clock skew.*
- **Ticket-based** — your password never crosses the wire after initial login
- **Mutual authentication** — the server proves itself to you too

> **CompTIA exam trap:** Kerberos requires **time synchronization**. If a domain-joined machine's clock drifts more than 5 minutes from the DC, Kerberos breaks. Classic "user can't log in after vacation" scenario.

### Multifactor authentication (MFA)

Three categories. Need at least two from different categories to call it MFA:

| Factor | Examples |
|---|---|
| **Something you know** | Password, PIN, security question |
| **Something you have** | Phone with authenticator app, hardware token (YubiKey), smart card |
| **Something you are** | Fingerprint, face scan, iris |

Two passwords ≠ MFA. Password + security question ≠ MFA — both are "something you know."

Common implementations:
- **TOTP** — 6-digit code rotating every 30 seconds. The "something you have" is the phone holding the seed.
- **Push notification** — Authenticator pops up "Approve sign-in?" Vulnerable to **MFA fatigue attacks** (attacker spams pushes until you tap approve).
- **Hardware tokens** — YubiKey, smart card. Phishing-resistant because the token verifies the domain it's authenticating to.
- **Biometric** — Windows Hello, Touch ID. Usually combined with a PIN as fallback.

### CompTIA exam traps

> **WPA2 vs WPA3:** WPA2 uses PSK with a 4-way handshake that can be captured and cracked offline. WPA3 uses **SAE** (Simultaneous Authentication of Equals, aka Dragonfly), resistant to offline cracking. If you see "offline dictionary attack," the answer is "upgrade to WPA3."

> **AES vs TKIP:** AES is the modern cipher (WPA2/WPA3). TKIP is the deprecated bandage. On a WPA2 router, "AES" or "CCMP" is correct; "AES+TKIP mixed" weakens the network to TKIP's level.

> **RADIUS encrypts what:** Only the password field. The rest of the packet is in the clear. TACACS+ encrypts the whole payload. Single most-tested distinction.

## Helpdesk reality

- **"I can't connect to the Wi-Fi."** — On enterprise networks, rarely the Wi-Fi. It's the user's AD password expired, account locked from a forgotten phone re-trying old creds, or the laptop's machine certificate expired. Check AD first.
- **"My MFA isn't working."** — New phone, old authenticator app, no seed migrated. Or push disabled. Or the phone's time is wrong (TOTP needs accurate time too). You'll re-enroll MFA roughly once a week.
- **"I keep getting MFA prompts I didn't request."** — This is an active attack. Tell them **do not approve, change password immediately**, and escalate to security. Not a normal ticket.
- **"It worked yesterday."** — Kerberos clock skew is real. Check the laptop's time vs the DC's time. Domain-joined machines should sync automatically; if they're not, the time service is broken.
- **Never promise** that MFA "can't be bypassed." SIM swaps, MFA fatigue, session token theft, and adversary-in-the-middle phishing all defeat MFA. It raises the bar; it doesn't close the door.

## Related concepts

[[Wireless Networking]] · [[Active Directory]] · [[Logical Security]] · [[Common Attacks]] · [[VPN and Remote Access]] · [[Account Management]] · [[Encryption and PKI]]

*Source: VIRGIL knowledge base — 2026-05-10*