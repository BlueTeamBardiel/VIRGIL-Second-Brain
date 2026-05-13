# Authentication Methods

## What it is

You walk up to a corporate Wi-Fi network. Your laptop asks you for a username and password, not a pre-shared key. Behind the scenes, the access point hands your credentials off to a separate server, which checks them against the company's user directory, decides yes or no, and tells the AP to let you on. You never typed a Wi-Fi password — you typed your *identity*.

That's enterprise authentication. The Wi-Fi password model you use at home (one shared secret, everybody types the same thing) doesn't scale and doesn't track individuals. Enterprises authenticate *people*, not networks.

**Authentication** is proving you are who you claim to be. **Authorization** is what you're allowed to do once proven. **Accounting** is the log of what you did. Together: AAA. The protocols in this note are the machinery that runs AAA — RADIUS and TACACS+ for network access, Kerberos for domain logon, MFA for everything that matters.

If the kernel is the soul of a machine, authentication is the immune system of the network — deciding what gets in, what gets stopped at the door, and what gets logged for the autopsy later.

## Why it matters

Every breach post-mortem you'll ever read starts with the same sentence: *the attacker obtained valid credentials.* Phishing, password reuse, a sticky note under a keyboard — the front door is always weaker than the walls. Authentication is the control that decides whether a stolen password becomes a breach or a logged failed-login event.

For the exam, 220-1202 Objective 2.3 expects you to compare wireless security protocols (WPA2 vs WPA3, TKIP vs AES) and authentication services (RADIUS vs TACACS+, Kerberos, MFA factors). CompTIA loves the distinctions between these — they look similar at a glance and test very differently.

For the job, you will configure RADIUS on day one of a real IT role. You will reset Kerberos tickets when a user's logon breaks mysteriously after a password change. You will enroll users in MFA and field the calls when they get a new phone and lose their authenticator app.

## At home, at work

**Beat 1 — the technical landscape.** Wireless authentication splits into two modes: **Personal (PSK)** where everyone shares one passphrase, and **Enterprise (802.1X)** where each user authenticates individually against a backend server. WPA2 and WPA3 both support both modes. The encryption underneath (TKIP, AES-CCMP, AES-GCMP) is separate from the authentication method on top. RADIUS and TACACS+ are the backend protocols that carry credentials from the network device to the directory. Kerberos is what Windows domains use internally for logon. MFA is a layer that sits on top of any of these.

**Beat 2 — the home network you've configured a hundred times.**

**WPA2-Personal at home:** One password, everyone uses it. Roommate moves out → you should change it but you don't. Smart bulb manufacturer leaks the password in plaintext through their app → you don't know. *PSK means one compromise compromises everyone.*

**WPA3-Personal:** Same UX, but the handshake (SAE — Simultaneous Authentication of Equals) resists offline cracking. Capture the handshake, you still can't brute-force it offline. Also forward secrecy: yesterday's traffic stays safe even if today's password leaks. *Same convenience, dramatically better cryptography.*

**Your phone on corporate Wi-Fi:** No password prompt. It just asks for your username and company password, then connects. That's 802.1X with RADIUS in the background. Your phone authenticated to a server you'll never see. *Enterprise mode doesn't share secrets — it verifies identities.*

**The MFA pop-up at 8:47 AM:** You typed your password into Outlook, now your phone is buzzing. That's the second factor. The password is "something you know" — the phone tap is "something you have." *Two independent factors means a stolen password alone is worthless.*

**Beat 3 — the bridge to enterprise.** Same fundamental question — *how do we trust this user is who they say they are?* — answered four different ways depending on the environment:

- **Home network:** WPA2/WPA3-Personal. One PSK. Good enough for a household.
- **Small business (10 users):** WPA2-Personal with a quarterly password rotation, plus MFA on email and cloud services. Pragmatic.
- **Mid-size enterprise (500 users):** WPA2/WPA3-Enterprise with RADIUS pointing at Active Directory. Every user authenticates individually. Termination of an employee instantly cuts their Wi-Fi access.
- **Regulated industry (healthcare, finance, defense):** WPA3-Enterprise + RADIUS + certificate-based 802.1X (EAP-TLS, no passwords on the wire) + hardware MFA tokens. Kerberos for internal domain access. TACACS+ for network device admin with per-command authorization logged.

**Beat 4 — the point.** Authentication is a tiered investment. You pay in complexity for the level of assurance you actually need. The home user doesn't need certificates. The hospital doesn't get to skip them. Learn the question — *who is this user, how confident am I, and what gets logged?* — and the right protocol falls out of the answer.

## Key facts

### Wireless security protocols

| Protocol | Encryption | Status | Notes |
|---|---|---|---|
| **WEP** | RC4 | Broken, deprecated | Crackable in minutes. Never deploy. |
| **WPA** | TKIP | Deprecated | Bridge protocol from WEP. |
| **WPA2** | AES-CCMP (TKIP optional) | Current baseline | KRACK vulnerability patched in clients. |
| **WPA3** | AES-GCMP-256, SAE handshake | Current best | Forward secrecy, resists offline cracking. |

**TKIP (Temporal Key Integrity Protocol)** — older encryption from the WPA era, rotates keys per packet but uses the broken RC4 cipher. Deprecated. If you see TKIP in a config, it's there for legacy compatibility — turn it off when you can.

**AES (Advanced Encryption Standard)** — the modern symmetric cipher used by WPA2 (as CCMP) and WPA3 (as GCMP). Hardware-accelerated on every modern CPU. This is what you want.

### Personal vs Enterprise mode

| Mode | How it works | Use case |
|---|---|---|
| **Personal (PSK)** | One shared passphrase for all users | Home, small office |
| **Enterprise (802.1X)** | Each user authenticates to a RADIUS server with their own credentials or certificate | Any environment with employee turnover |

802.1X uses **EAP (Extensible Authentication Protocol)** as the framework. Common variants: EAP-TLS (certificates, strongest), PEAP (password inside a TLS tunnel), EAP-TTLS.

### RADIUS vs TACACS+

| Feature | RADIUS | TACACS+ |
|---|---|---|
| **Port** | UDP 1812 (auth), 1813 (accounting) | TCP 49 |
| **Encryption** | Encrypts password only | Encrypts entire payload |
| **AAA** | Combines authentication + authorization | Separates authentication, authorization, accounting |
| **Vendor** | Open standard (IETF) | Cisco proprietary (de facto open) |
| **Typical use** | Wi-Fi, VPN, network access | Network device administration (per-command authz) |

*Memorize the ports and the encryption difference. CompTIA tests both.*

### Kerberos

The authentication protocol Windows Active Directory uses internally. Ticket-based, runs on **TCP/UDP 88**.

Flow, briefly:
1. User logs in → client requests a **TGT (Ticket Granting Ticket)** from the **KDC (Key Distribution Center)**
2. KDC verifies credentials, issues TGT
3. When the user accesses a service (file share, Exchange), client presents TGT to KDC and gets a **service ticket**
4. Service ticket is presented to the service, which trusts it because it's signed by the KDC

Kerberos requires **tight clock synchronization** (default tolerance: 5 minutes). Time skew is the #1 cause of mysterious Kerberos failures.

*If a domain user suddenly can't access anything but their password is correct — check the system clock.*

### Multifactor Authentication (MFA)

Three classic factors:

| Factor | Examples |
|---|---|
| **Something you know** | Password, PIN, security question |
| **Something you have** | Phone (TOTP app, push), hardware token (YubiKey), smart card |
| **Something you are** | Fingerprint, face, iris |

Sometimes extended with **somewhere you are** (geolocation) and **something you do** (typing rhythm, behavioral).

**MFA requires factors from different categories.** Password + security question = still single-factor (both "something you know"). Password + phone tap = real MFA.

### CompTIA exam traps

> **CompTIA exam trap:** RADIUS encrypts only the password field. TACACS+ encrypts the entire packet. If the question asks "which is more secure for network device administration?" — TACACS+.

> **CompTIA exam trap:** WPA2 vs WPA3 — WPA3 introduces **SAE (Simultaneous Authentication of Equals)**, replacing the WPA2 4-way handshake for personal mode. SAE is what gives WPA3 its resistance to offline dictionary attacks.

> **CompTIA exam trap:** TKIP is *authentication-era encryption*, not an authentication protocol. AES is the cipher. WPA2 *can* use TKIP for backward compatibility, but you want AES-CCMP.

> **CompTIA exam trap:** Two passwords is not MFA. Password + PIN is not MFA. Both are "something you know." MFA requires factors from *different categories*.

> **CompTIA exam trap:** Kerberos port is **88**. RADIUS auth is **1812** (not 1645 — that's legacy). TACACS+ is **49**.

## Helpdesk reality

- **"I can't connect to Wi-Fi but my password is right."** On enterprise Wi-Fi (802.1X), the "password" is their domain password — if it expired or was reset, Wi-Fi breaks until they update the saved credentials on the device. Forget the network, reconnect, retype.
- **"My MFA isn't working, I got a new phone."** You'll do this call weekly. You will need to verify their identity through a backup channel (manager confirmation, security questions, in-person ID) before re-enrolling. Never reset MFA based on a phone call alone — that's the exact attack vector that bypasses MFA.
- **"I keep getting locked out of everything after I changed my password."** Likely cached credentials on a mapped drive, Outlook profile, or a service running under their account. Sometimes it's Kerberos clock skew on their laptop after a long sleep. Restart, sync time, retry.
- **"Why do I need MFA for email, it's just email?"** Email is the password-reset endpoint for every other service they own. Compromise the inbox, own everything. Don't argue — enroll them.
- **Never disable MFA "temporarily" because a VIP is annoyed.** Document the request, escalate to the security team, let policy decide. "The CEO asked me to" is in every breach report ever written.

## Related concepts

[[Wireless Security Protocols]] · [[Active Directory]] · [[Single Sign-On (SSO)]] · [[Certificates and PKI]] · [[Social Engineering]] · [[Password Best Practices]] · [[VPN Authentication]] · [[Group Policy]]

*Source: VIRGIL knowledge base — 2026-05-10*