---
domain: "offensive-security"
tags: [brute-force, password-attacks, authentication, credential-access, cryptanalysis, attack]
---
# Brute-force attack

A **brute-force attack** is an [[authentication]] or [[cryptanalysis]] technique that systematically enumerates every candidate value in a **keyspace**—passwords, encryption keys, session tokens, or PINs—until the correct value is discovered. Because it relies on raw computation rather than logical flaws, its feasibility is bounded only by [[entropy]], [[rate limiting]], and the attacker's compute budget, making it both the simplest and most universal attack against secret-based security. It is the baseline against which every [[key derivation function]] and [[password policy]] must be justified.

---

## Overview

Brute-force attacks are conceptually ancient: the Allied *bombes* at Bletchley Park mechanized the enumeration of Enigma rotor settings during WWII, and the term itself predates modern computing. In contemporary systems the principle is unchanged—try every possibility—but the targets have multiplied to include password hashes, TLS private keys, WPA2 4-way handshakes, JWT signing secrets, API tokens, BIOS passwords, encrypted archives, and cryptocurrency wallet seeds. What has changed dramatically is cost: commodity GPUs and cloud compute have collapsed the time and dollar price of enumeration. A single NVIDIA RTX 4090 computes roughly 164 GH/s against MD5 and 288 GH/s against NTLM in [[Hashcat]] benchmarks, and rental clusters on AWS or vast.ai can sustain tera-hash rates for pennies per hour.

The attack divides into two fundamentally different regimes. **Online brute force** interacts with a live service—SSH, RDP, a web login form, a REST API—and is limited by network latency and server-side throttling. It is noisy in logs and visible to defenders. **Offline brute force** operates on captured material—a stolen `/etc/shadow`, an NTDS.dit dump, a sniffed WPA2 handshake, or a leaked password database—and is limited only by the attacker's hardware. Offline attacks are entirely invisible to the victim until the cracked credentials are weaponized.

The theoretical foundation is [[keyspace]] [[entropy]]. A password drawn uniformly from the 94 printable ASCII characters has `log₂(94) ≈ 6.55` bits per character. An 8-character password therefore carries roughly 52 bits of entropy, representing about 6.1 × 10¹⁵ combinations. A mid-range GPU cluster sustaining 10¹² NTLM hashes per second exhausts that space in approximately 1.7 hours. Add four more characters (12 total) and the same hardware needs roughly 4,700 years. This exponential relationship—each additional character multiplies the cost by 94—is the single most important intuition in [[password security]] and the core reason modern [[NIST SP 800-63B]] guidance prioritizes length over composition complexity.

Pure, exhaustive enumeration is rarely optimal in practice. Attackers combine it with corpora and probabilistic heuristics: **dictionary attacks** use leaked password lists such as `rockyou.txt` or HaveIBeenPwned's Pwned Passwords corpus; **rule-based attacks** mutate dictionary entries (e.g., hashcat's `best64.rule` or `dive.rule`); **mask attacks** exploit known structural patterns (e.g., `?u?l?l?l?l?l?d?d` for one uppercase letter, six lowercase, two digits); and **hybrid attacks** combine a dictionary with a mask. **Credential stuffing** and **password spraying** are derivative techniques that exploit password reuse and weak lockout policies at population scale rather than exhausting a single account's keyspace.

Notable real-world incidents anchor this topic in genuine consequence. The 2012 LinkedIn breach exposed 6.5 million unsalted SHA-1 hashes that were cracked almost entirely within days. The 2014 iCloud "Celebgate" incident involved the *iBrute* tool exploiting a missing rate limit on Apple's Find My iPhone API endpoint. Persistent SSH brute-force botnets—FritzFrog, Outlaw, and Mirai variants—generate the majority of noise in public-internet honeypots. RDP brute force appears as the most common initial-access vector in ransomware incident reports from Sophos, CISA, and Microsoft. Unauthorized brute-force attempts against systems you do not own constitute criminal offenses under the [[Computer Fraud and Abuse Act]] (US), the Computer Misuse Act 1990 (UK), and equivalent statutes internationally.

---

## How It Works

A brute-force attack proceeds through four logical phases regardless of the target: **target selection**, **material acquisition**, **candidate generation**, and **verification**. The mechanics diverge sharply between online and offline variants.

### Phase 1 — Online Brute Force (Example: SSH)

The attacker identifies a service exposed on a well-known port: SSH on TCP/22, RDP on TCP/3389, SMB on TCP/445, HTTPS login forms on TCP/443, FTP on TCP/21, VNC on TCP/5900, or MySQL on TCP/3306. Credentials are submitted sequentially or in parallel; the server's success or failure response is observed for each attempt.

```bash
# Hydra: parallel online brute-forcer supporting 50+ protocols
hydra -l root -P /usr/share/wordlists/rockyou.txt \
      -t 4 -f -V ssh://192.0.2.10

# Medusa: alternative with a module-based architecture
medusa -h 192.0.2.10 -u admin -P passwords.txt -M ssh -t 4

# Patator: scriptable, well-suited for rate-limited targets
patator ssh_login host=192.0.2.10 user=root \
        password=FILE0 0=rockyou.txt -x ignore:mesg='Auth fail'
```

Online attacks are bottlenecked by the server itself: TCP handshakes, TLS negotiation, login prompt latency, and any server-side throttle mechanism reduce practical throughput to dozens or hundreds of attempts per second at best. Account lockout policies, [[fail2ban]], [[CAPTCHA]], and MFA effectively neutralize naive online brute force—which is precisely why **password spraying** (submitting one common password across thousands of accounts) has displaced it in modern intrusion campaigns.

### Phase 2 — Offline Brute Force (Example: NTLM Hash)

The attacker first obtains hashed credential material—via [[SQL injection]], a database dump, `secretsdump.py` against a domain controller, AS-REP roasting, or a captured WPA2 handshake. Verification becomes a local computation: hash the candidate, compare the output to the stored hash. No network interaction is required.

```bash
# hashcat: GPU-accelerated, the de-facto offline cracker
# -m 1000 = NTLM, -a 0 = straight dictionary, -r = rule file
hashcat -m 1000 -a 0 hashes.txt rockyou.txt -r best64.rule

# Mask attack: all 8-char lowercase strings + 2 digits
hashcat -m 1000 -a 3 hashes.txt ?l?l?l?l?l?l?l?l?d?d

# Hybrid: dictionary word + 4-digit numeric suffix
hashcat -m 1000 -a 6 hashes.txt rockyou.txt ?d?d?d?d

# John the Ripper: CPU-oriented, powerful format/rules engine
john --format=NT --wordlist=rockyou.txt --rules=Jumbo hashes.txt
```

### Phase 3 — Rate Estimation and Algorithm Selection

Attackers benchmark hardware before launching to budget time and cost (`hashcat -b`). Approximate rates on a single RTX 4090:

| Algorithm | Rate | Notes |
|---|---|---|
| MD5 | ~164 GH/s | Deprecated; still common in legacy apps |
| SHA-1 | ~50 GH/s | Deprecated for credential storage |
| NTLM | ~288 GH/s | Windows local and domain password hashes |
| NetNTLMv2 | ~10 GH/s | Captured via Responder/relay attacks |
| WPA2-PBKDF2 | ~2 MH/s | From 4-way handshake or PMKID |
| bcrypt (cost 5) | ~184 kH/s | ~5–6 orders of magnitude slower than NTLM |
| Argon2id (default params) | ~3 kH/s | Memory-hard; highly GPU-resistant |

The difference between NTLM and bcrypt—roughly six orders of magnitude—is the quantitative justification for adaptive key derivation functions. Cost parameters are deliberately tuned so a legitimate login takes ~100 ms while adversarial enumeration becomes economically infeasible.

### Phase 4 — Specialized Variants

**Reverse brute force / Password spraying:** Fixes a single common password (e.g., `Spring2024!`) and iterates across a list of usernames. Because each account sees only one failure, lockout thresholds are rarely triggered.

**WPS PIN brute force (CVE-2011-5053):** The Wi-Fi Protected Setup PIN is validated in two halves. The first half has 10⁴ possibilities and the second has 10³ (with a checksum digit), reducing a nominal 10⁸ keyspace to approximately 11,000 total guesses. *Reaver* and *Bully* automate this:

```bash
reaver -i wlan0mon -b AA:BB:CC:DD:EE:FF -vv
```

**[[Kerberoasting]] / AS-REP Roasting:** Active Directory issues TGS or AS-REP tickets encrypted with a service account's or user's NTLM hash. These tickets are captured over the network and cracked offline, with no account lockout exposure.

```bash
# AS-REP roasting with Impacket (no pre-auth required)
GetNPUsers.py DOMAIN.LOCAL/ -usersfile users.txt \
              -format hashcat -outputfile asrep.hashes
hashcat -m 18200 asrep.hashes rockyou.txt
```

**Key-search brute force:** DES at 56 bits fell to the EFF's *Deep Crack* hardware in 1998 in under 23 hours, prompting the immediate transition to 3DES and AES. A 128-bit symmetric key remains computationally infeasible at any foreseeable compute scale (~10³⁸ trials required).

---

## Key Concepts

- **Keyspace**: The complete set of all candidate values an attacker must search. Its size is `alphabet_size ^ length` for fixed-length secrets. Any reduction—through known patterns, policy constraints, or leaked partial information—directly accelerates the attack.
- **Entropy (bits)**: Measured as `log₂(keyspace_size)`. A 40-bit secret requires ~10¹² trials; a 128-bit key requires ~10³⁸. Effective entropy collapses dramatically when users choose predictable passwords, often reducing a nominal 52-bit space to 20–30 effective bits.
- **Online vs. offline attack**: Online brute force interacts with a live authenticator and is rate-limitable, lockout-able, and loggable. Offline brute force operates on stolen cryptographic material and is bounded only by attacker hardware—these two regimes demand entirely different defensive postures.
- **Dictionary, rule, mask, and hybrid attacks**: Increasingly intelligent candidate ordering strategies ensuring statistically likely guesses are tested first. A tuned ruleset applied to a representative wordlist typically cracks 60–80% of a real breach corpus in minutes, compared to weeks for pure sequential enumeration.
- **Hash rate (H/s)**: The number of candidates tested per second; reported in kH/s, MH/s, GH/s, or TH/s. Always algorithm-specific—bcrypt and NTLM differ by approximately six orders of magnitude on identical hardware.
- **Work factor / cost parameter**: A tunable slowdown built into adaptive KDFs (bcrypt rounds, scrypt N/r/p, Argon2 t/m/p). Intended to be incremented periodically as hardware improves, keeping legitimate login latency near 100–300 ms.
- **Rainbow tables**: Precomputed hash-chain tables that trade storage for cracking time against unsalted hashes. Defeated entirely by per-user random [[salt (cryptography)|salt]] (≥ 16 bytes); largely obsolete in practice due to cheap real-time GPU computation.
- **Credential stuffing vs. spraying vs. brute force**: *Stuffing* replays credentials from a prior breach against new services; *spraying* submits a small set of common passwords against many accounts; *brute force* exhausts a keyspace against one or a small number of accounts. CompTIA SY0-701 tests all three distinctions.
- **Lockout threshold**: The failure count that disables an account. A fundamental trade-off: too low enables DoS, too high enables brute force. Modern guidance (NIST SP 800-63B) favors throttling with increasing delays over hard lockouts for most implementations.

---

## Exam Relevance

On **SY0-701**, brute-force attacks appear primarily in **Domain 2.4** ("Analyze indicators of malicious activity") and **Domain 1.2** ("Threats, vulnerabilities, and mitigations"). The exam tests both conceptual definitions and the ability to identify the *most specific correct term* in a scenario.

**Critical distinctions to memorize:**

| Term | Defining Characteristic | Key Mitigation |
|---|---|---|
| Brute force | Exhaust keyspace for one account | Account lockout, MFA |
| Dictionary attack | Brute force using a wordlist | Strong passwords + KDF |
| Password spraying | One password, many accounts—avoids lockout | MFA, anomaly detection |
| Credential stuffing | Reused credentials from another breach | MFA, breach monitoring |
| Rainbow table attack | Precomputed table against unsalted hashes | Salting |
| Hybrid attack | Dictionary + rules or mask | Long, complex passwords |

**Common question patterns and gotchas:**

- If the scenario says **many accounts each saw only one or two failed logins**, but many were compromised, the answer is **password spraying**, not brute force.
- If a scenario describes accounts breached with credentials **"from another site,"** the term is **credential stuffing**.
- If asked the best defense against **offline** brute force (hashes were stolen), the answer is **salting plus an adaptive KDF (bcrypt/Argon2)**—not MFA, not lockouts, which only protect online interactions.
- If asked the best defense against **online** brute force on a public service, the answer is **MFA**—it renders a correct password useless without a second factor.
- **CAPTCHA** and **fail2ban** are controls for *online* attacks only; they provide zero protection once hashes are exfiltrated.
- Know that **rainbow tables** are defeated by **salting**, not by password complexity or length alone.
- NIST SP 800-63B recommends checking new passwords against a **banned password list** (known breached passwords); this is tested as a mitigation question.

---

## Security Implications

Brute force and related password attacks are among the most common initial-access and lateral-movement vectors documented in real incidents. Microsoft's 2023 Digital Defense Report attributed the majority of identity attacks observed in Entra ID telemetry to password spraying and brute force. CISA's StopRansomware advisories consistently identify RDP brute force as a top ransomware precursor, and the Sophos *State of Ransomware* annual reports corroborate this across thousands of incident-response engagements.

**Representative CVEs and incidents:**

- **CVE-2011-5053 (WPS PIN):** Wi-Fi Protected Setup's split-PIN validation reduced the effective keyspace from 10⁸ to ~11,000 guesses. *Reaver* and *Bully* exploited this to recover WPA/WPA2 passphrases in hours against any router with WPS enabled—this affected virtually every consumer router sold between 2007 and 2012.
- **CVE-2015-7755 (Juniper ScreenOS):** A hardcoded backdoor password in Juniper's ScreenOS firmware allowed trivial single