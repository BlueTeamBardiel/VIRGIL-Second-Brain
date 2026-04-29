---
domain: "attacks"
tags: [offline-attack, password-cracking, hashcat, authentication, cryptanalysis, security-plus]
---
# Offline Attack

An **offline attack** is a class of [[Password Cracking]] attack in which an adversary, having already obtained a copy of hashed or encrypted credentials, attempts to recover the plaintext secrets on **hardware they control** — without ever interacting with the victim's authentication system. Because there is no live service to rate-limit, lock out, or log the attempt, the attacker can try **billions of candidate passwords per second** against the captured [[Cryptographic Hash|hashes]], bounded only by the strength of the hash algorithm, the password's entropy, and the attacker's compute budget. Offline attacks are the mirror image of [[Online Attack|online attacks]] and represent the dominant real-world threat model for stolen credential databases.

---

## Overview

Offline attacks presuppose **credential theft**: the attacker must first acquire hash material through some earlier compromise. Common sources include the Windows **SAM** and **NTDS.dit** databases extracted from domain controllers, the Linux `/etc/shadow` file, cached domain credentials, Kerberos service tickets obtained via [[Kerberoasting]], WPA2 **4-way handshake** captures from Wi-Fi, and database dumps from breached web applications. High-profile examples include LinkedIn (2012, 117 million hashes), Adobe (2013, 153 million records), and Yahoo (2013–2016, 3 billion accounts). Once the hashes leave the victim environment, the defender loses almost all control: no password policy, account-lockout timer, or intrusion detection system can influence what happens on the attacker's GPU cluster.

The existence of offline attacks is a direct consequence of how authentication systems are designed. Because a server must verify a password without storing it in plaintext, it stores a **one-way transformation** — a hash. That same hash, once exfiltrated, becomes the target of cryptanalysis. If the hash function is fast — MD5, NTLM, SHA-1, unsalted SHA-256 — modern GPUs can exhaust the entire 8-character printable ASCII keyspace in hours. If the hash is slow and salted ([[bcrypt]], [[scrypt]], [[Argon2]], PBKDF2 with high iteration counts), the attacker is forced into dictionary and rule-based attacks against realistic human password distributions, where the weakest passwords still fall quickly and the strongest may never fall.

Historically, offline attacks go back to the 1970s `crypt(3)` work-factor debates and became mainstream with **L0phtCrack** (1997) targeting Windows LANMAN hashes. The modern era is defined by **Hashcat** and **John the Ripper**, CUDA/OpenCL GPU acceleration, and affordable cloud GPU rental, which have collectively collapsed the cost of cracking by several orders of magnitude. The **RockYou** breach (2009, 32 million plaintext passwords) produced the canonical wordlist still used in most cracking campaigns today.

Offline attacks are distinct from but frequently chained with **credential stuffing**, **pass-the-hash**, and **lateral movement**. A single domain controller dump can reveal every user password in an organization. The attacker then pivots using valid, plaintext credentials — bypassing many detection controls that would flag anomalous hashed-credential reuse. From a defender's perspective, offline attacks reframe the password-hygiene question entirely: the threat is not "can someone guess my password at a login screen," but "**when** my hash is stolen, how long does it survive on an attacker's rig?"

The asymmetry between offense and defense is stark. An attacker renting ten A100 GPUs on a cloud provider for a weekend can attempt trillions of MD5 guesses for under a hundred dollars. Defenders counter this not through network controls but through algorithm selection — a design decision made at the time the application is built, often years before any breach occurs.

---

## How It Works

An offline attack proceeds in four phases: **acquisition**, **identification**, **cracking**, and **exploitation**.

---

### Phase 1 — Acquisition

The attacker extracts credential material through a preceding compromise:

```bash
# Windows: dump SAM + SYSTEM hive from a live host (local admin required)
reg save HKLM\SAM    C:\temp\sam.save
reg save HKLM\SYSTEM C:\temp\system.save

# Parse offline with Impacket's secretsdump (no network call to target needed)
impacket-secretsdump -sam sam.save -system system.save LOCAL

# Domain Controller: exfiltrate NTDS.dit via Volume Shadow Copy
vssadmin create shadow /for=C:
copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\NTDS\NTDS.dit C:\temp\
copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SYSTEM C:\temp\
impacket-secretsdump -ntds ntds.dit -system SYSTEM LOCAL

# Linux: read /etc/shadow (root required)
sudo cat /etc/shadow | grep -v '[!*]'

# Wi-Fi WPA2: capture the 4-way handshake
airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture wlan0mon
# Force a client to re-authenticate (deauth attack)
aireplay-ng --deauth 5 -a AA:BB:CC:DD:EE:FF wlan0mon

# Kerberoasting: request TGS tickets for SPN-bearing service accounts
impacket-GetUserSPNs -request -dc-ip 10.0.0.1 corp.local/jdoe:Password1 \
  -outputfile tgs_hashes.txt
```

---

### Phase 2 — Identification

Hashes are fingerprinted by format before selecting the correct cracking mode:

| Format | Identifying pattern | Hashcat `-m` |
|---|---|---|
| NTLM | 32-char hex, no prefix | `1000` |
| NetNTLMv2 | `username::domain:challenge:...` | `5600` |
| Kerberos 5 TGS-REP (RC4) | `$krb5tgs$23$*...*` | `13100` |
| bcrypt | `$2b$12$...` | `3200` |
| sha512crypt (Linux) | `$6$salt$...` | `1800` |
| WPA2-EAPOL-PBKDF2 | `WPA*02*...` | `22000` |
| MD5 (raw) | 32-char hex | `0` |
| PBKDF2-HMAC-SHA256 | `$pbkdf2-sha256$...` | `10900` |

```bash
# Auto-identify hash type
hashid '$6$rounds=5000$salt$hashvalue...'
hash-identifier   # interactive menu
```

---

### Phase 3 — Cracking

The attacker iterates candidate passwords, hashes each candidate under the target algorithm, and compares the output to the captured hash. Five primary strategies exist:

**A. Dictionary Attack** — iterate a curated wordlist:
```bash
hashcat -m 1000 -a 0 ntlm_hashes.txt /usr/share/wordlists/rockyou.txt
```

**B. Rule-based Attack** — apply mutation rules to dictionary words (`p@ssword`, `Password1!`):
```bash
hashcat -m 1000 -a 0 ntlm_hashes.txt rockyou.txt \
  -r /usr/share/hashcat/rules/best64.rule \
  -r /usr/share/hashcat/rules/toggles1.rule -O -w 3
```

**C. Brute Force / Mask Attack** — exhaustive keyspace search with known structure:
```bash
# All 8-char lowercase+digit combinations
hashcat -m 1000 -a 3 ntlm_hashes.txt ?l?l?l?l?l?d?d?d

# WPA2: all 8-digit PINs (common ISP router default)
hashcat -m 22000 -a 3 capture.hc22000 ?d?d?d?d?d?d?d?d
```

**D. Hybrid Attack** — wordlist with appended/prepended mask:
```bash
# Dictionary word + 2-digit year
hashcat -m 1000 -a 6 ntlm_hashes.txt rockyou.txt ?d?d
```

**E. Rainbow Table Lookup** — precomputed hash→plaintext tables, defeated by salting:
```bash
# RainbowCrack lookup (only effective against unsalted hashes)
rcrack rainbow_tables/ -h aad3b435b51404eeaad3b435b51404ee
```

**Speed comparison on a single RTX 4090:**

| Algorithm | Speed | Time to exhaust 8-char ?a keyspace |
|---|---|---|
| MD5 | ~68 GH/s | ~13 minutes |
| NTLM | ~200 GH/s | ~4 minutes |
| SHA-256 | ~22 GH/s | ~41 minutes |
| sha512crypt ($6$) | ~2.1 MH/s | ~centuries |
| bcrypt (cost 12) | ~8 H/s | thermodynamically infeasible |
| Argon2id | ~400 H/s | infeasible |

This ~25-billion-fold speed difference between MD5 and bcrypt is the single most consequential fact in password storage security.

---

### Phase 4 — Exploitation

Recovered plaintexts are used for direct login, lateral movement with valid credentials, credential stuffing across other services (email, VPNs, cloud portals), privilege escalation, or sale on criminal markets.

---

## Key Concepts

- **Hash function**: A deterministic, one-way transformation mapping arbitrary input to a fixed-length digest. The cracker's problem is finding a preimage — any input that produces the captured digest — which for a well-designed hash requires guessing the original password.
- **Salt**: A unique, per-credential random value (minimum 16 bytes) mixed into the hash input before storage. Salts invalidate precomputed rainbow tables and force the attacker to crack every hash individually, even if two users share the same password.
- **Pepper**: A secret value stored separately from the database — in an HSM, KMS, or application environment variable — and mixed into every hash. If the database leaks without the pepper, offline cracking is cryptographically blocked regardless of hash speed.
- **Key stretching / work factor**: Deliberate computational slowdown applied during hashing via iteration (PBKDF2), memory-hardness ([[scrypt]], [[Argon2]]), or an adaptive cost parameter ([[bcrypt]]). The tunable cost allows defenders to raise attacker effort as hardware improves while adding only tens of milliseconds to legitimate login flows.
- **Rainbow table**: A space-time tradeoff data structure storing chains of precomputed hashes for rapid inversion. Effective only against **unsalted** hashes; salting makes all precomputed tables useless.
- **Keyspace**: The complete set of candidate passwords the attacker must search. Size grows exponentially with password length and character-set diversity. A 15-character passphrase drawn from full printable ASCII is ~96¹⁵ ≈ 4×10²⁹ candidates — infeasible against even fast hashes.
- **Pass-the-hash (PtH)**: A lateral movement technique unique to NTLM in which the **raw hash** is used directly for authentication, bypassing the need to recover plaintext. Highlights that even a "well-protected" fast hash can still be weaponized if the protocol accepts the hash itself as a credential.
- **AS-REP Roasting**: An offline attack variant targeting Active Directory accounts with pre-authentication disabled. The KDC returns an AS-REP encrypted with the user's password hash, which the attacker cracks offline without ever needing a valid credential to begin.

---

## Exam Relevance

On the **Security+ SY0-701** exam, offline attacks appear primarily in **Domain 2.0 — Threats, Vulnerabilities, and Mitigations** and intersect with **Domain 4.0 — Security Operations** (detection/response) and **Domain 5.0 — Security Program Management** (identity controls).

**Common question patterns:**

- *"An attacker exfiltrates a database of password hashes and runs Hashcat on a personal workstation. This is BEST described as a __________ attack."* → **Offline attack** (the key indicator is no interaction with the victim system post-theft).
- *"Which password storage mechanism BEST mitigates an offline brute-force attack?"* → **bcrypt / Argon2 / key stretching** — NOT account lockout, which is an online-only control.
- *"An attacker uses a precomputed table to crack passwords rapidly. Which control would have prevented this?"* → **Salting** — specifically prevents rainbow table attacks.
- *"Which attack requests Kerberos TGS tickets to crack service account passwords offline?"* → **Kerberoasting**.

**Critical gotchas:**

- **Account lockout and rate limiting are online-only defenses.** They are completely irrelevant once hashes are exfiltrated. Never select these as mitigations for an offline attack scenario.
- **Salting defeats rainbow tables, not brute force.** The attacker can still crack a salted hash by brute force — the salt just forces per-hash computation. Only a *slow* hash stops brute force.
- **Pass-the-hash is not an offline attack** in the cracking sense — no plaintext recovery occurs — but it originates from the same hash-dump acquisition phase.
- Know the full attack taxonomy: **brute force** (exhaustive), **dictionary** (wordlist), **rainbow table** (precomputed, unsalted only), **hybrid** (wordlist+mask), **spraying** (online, low-and-slow), **credential stuffing** (online, stolen plaintexts).

---

## Security Implications

Offline cracking has driven some of the largest and most damaging credential breaches in history:

- **LinkedIn (2012/2016)**: 117 million accounts stored as unsalted SHA-1. Over 90% were cracked within days of the 2016 dark-web publication. The absence of a salt meant one hash lookup recovered every instance of a common password simultaneously.
- **Adobe (2013)**: 153 million records encrypted with 3DES-ECB — a symmetric cipher rather than a one-way hash. The same password produced identical ciphertext across users, and publicly-available password hints made mass recovery trivial within days.
- **Ashley Madison (2015)**: The application used bcrypt(cost=12) for most passwords — a sound choice — but a legacy MD5 token field with lowercased passwords exposed ~11 million accounts rapidly, illustrating the **weakest-hash-wins** principle: one poor implementation nullifies the stronger one.
- **NotPetya / APT lateral movement (2017+)**: Attackers leveraging Mimikatz to dump LSASS on compromised workstations, combined with DCSync against domain controllers, extracted entire enterprise credential stores. Offline cracking of NTLM hashes then yielded plaintext passwords for all domain users.
- **CVE-2022-33679** and related Kerberos RC4 weaknesses: Legacy RC4 encryption support in Active Directory continues to make AS-REP and TGS-REP tickets vulnerable to offline cracking via Hashcat mode 18200/13100.

**Detection challenges:** The cracking itself generates **zero network telemetry** on the victim's infrastructure — it happens entirely on attacker hardware. Defenders must detect the *preceding acquisition* events: anomalous LSASS handle access (**Sysmon Event ID 10**, Windows **Event ID 4656**), `vssadmin`/`ntdsutil` execution on domain controllers, unusual volume of Kerberos TGS-REQ for multiple service accounts, and large-file egress of `.dit`, `.save`, or `/etc/shadow` equivalents.

---

## Defensive Measures

**Algorithm selection (most impactful control):**
- Deploy **Argon2id** (OWASP first recommendation) with a minimum of 19 MiB memory, 2 iterations, 1 parallelism factor — adjust upward until login takes 200–500