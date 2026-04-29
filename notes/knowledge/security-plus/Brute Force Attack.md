---
domain: "offensive-security"
tags: [attack, authentication, passwords, cryptography, credential-attacks, brute-force]
---
# Brute Force Attack

A **brute force attack** is a cryptanalytic or authentication attack in which an adversary systematically tries every possible value from a **keyspace** until the correct secret is found. It is the most fundamental form of [[Password Attack]] and represents the theoretical baseline against which all [[Authentication]] and [[Cryptography]] schemes must be measured. Brute forcing may target login prompts, encrypted archives, session tokens, captured hash digests, or any secret protected only by its own entropy.

---

## Overview

Brute force is conceptually the simplest attack in existence: if a secret has `N` possible values, the attacker tries all `N` until one succeeds. Because it requires no mathematical cleverness, no protocol weakness, and no insider knowledge, it functions as a universal fallback when more efficient attacks — cryptanalysis, credential theft, [[Phishing]] — are unavailable. The attack's feasibility is governed entirely by the **keyspace size**, the **guess rate**, and the **time available**. A 4-digit PIN (10,000 values) falls in milliseconds; a properly generated 256-bit AES key would take longer than the age of the universe on every computer ever built combined.

Historically, brute force preceded computing. Codebreakers during World War II exhausted Enigma rotor settings through mechanical enumeration, and the principle was formalized in Claude Shannon's 1949 work on cipher security, where **work factor** became the measure of a cipher's resistance to exhaustive search. The arrival of cheap computation turned brute forcing from a specialist activity into a commodity: password-cracking rigs built from consumer GPUs can now compute tens of billions of hash guesses per second, and cloud providers rent comparable capacity by the hour.

In modern practice, brute force rarely means blindly trying every 20-character string. Attackers combine brute force with heuristics — **dictionary attacks**, **rule-based mangling**, **mask attacks**, and **hybrid attacks** — that prioritize statistically likely candidates. This is still brute force in the formal sense (systematic enumeration over a defined space), but it targets human predictability of chosen passwords rather than the raw keyspace. Tools like [[Hashcat]] and [[John the Ripper]] expose dozens of strategies along this spectrum, dramatically reducing the practical time to crack.

Brute force also exists in two operationally distinct contexts: **online attacks**, targeting a live service such as SSH, RDP, or a web login form where defenders can observe and throttle traffic; and **offline attacks**, targeting captured material — a password hash, an encrypted archive, a WPA2 handshake — where the attacker is limited only by their own hardware. Offline attacks are typically orders of magnitude faster and are the main reason strong, adaptive hashing algorithms (bcrypt, scrypt, Argon2) deliberately slow computation: they inflate the per-guess cost without changing the keyspace, making hardware speed far less decisive.

The attack persists because humans choose weak and reused secrets, systems leak hashes through SQL injection and breaches, and legacy protocols omit rate limiting. The 2012 LinkedIn breach, continuous RDP brute-force campaigns tracked by Microsoft since 2019, and virtually every ransomware intrusion that begins with "Valid Account / Brute Force" in MITRE ATT&CK telemetry all confirm that brute force remains a top initial-access technique — not because it is elegant, but because it still works.

---

## How It Works

A brute force attack follows a consistent pipeline regardless of target system or protocol:

1. **Identify the oracle** — the function that tells the attacker whether a guess is correct. For online attacks, this is the application's login response (success/failure). For offline attacks, it is the result of hashing or decrypting a candidate and comparing it against a known value, magic bytes, or padding structure.
2. **Define the keyspace** — the complete set of candidates. A 6-digit numeric PIN has `10⁶` = 1,000,000 candidates; an 8-character lowercase-alpha password has `26⁸ ≈ 2.1 × 10¹¹`; a 128-bit AES key has `2¹²⁸`.
3. **Enumerate candidates** — iterate through the keyspace in an optimized order, submitting each to the oracle.
4. **Detect success** — extract and use the recovered secret.

### Online Brute Force — SSH (TCP/22)

SSH password authentication can be attacked directly with tools like **Hydra**, **Medusa**, **Ncrack**, or **Patator**:

```bash
# Hydra: try every username/password combination from two wordlists
hydra -L users.txt -P rockyou.txt -t 4 -f ssh://192.0.2.10:22

# Flags:
#   -L users.txt      list of usernames to try
#   -P rockyou.txt    password wordlist (14 million real passwords)
#   -t 4              4 parallel threads (SSH throttles aggressively; keep low)
#   -f                stop on the first valid credential pair found
```

Online attack speed is bounded by server connection-handling limits, TCP handshake overhead, and any rate-limiting or lockout policy in place. Realistic online rates range from a few attempts per second on hardened targets to several hundred on misconfigured services.

### Web Form Brute Force (HTTP POST)

```bash
hydra -l admin -P passwords.txt 10.10.10.5 http-post-form \
  "/login:username=^USER^&password=^PASS^:F=Invalid credentials"

# ^USER^ and ^PASS^ are substitution markers Hydra replaces per attempt.
# F= defines the failure string; success is detected by its absence.
```

Tools like `ffuf` and `wfuzz` perform the same role and support custom headers, cookies, and CSRF token injection workflows.

### Offline Hash Cracking

Once a hash dump is obtained (from `/etc/shadow`, a SQL injection, or an NTLM responder capture), the attacker runs entirely locally — no target interaction required:

```bash
# Hashcat mode 1800 = sha512crypt ($6$), the Linux shadow default
hashcat -m 1800 -a 0 hashes.txt rockyou.txt

# Mode 1000 = NTLM (Windows); mask attack over all 8-char upper+lower+digit combos
hashcat -m 1000 -a 3 ntlm.txt ?u?l?l?l?l?l?d?d

# Hybrid: dictionary + rule-based mangling (appends digits, capitalizes, leetspeak)
hashcat -m 1000 -a 0 ntlm.txt rockyou.txt -r rules/best64.rule
```

**Hashcat attack modes:**

| Flag | Mode | Description |
|------|------|-------------|
| `-a 0` | Straight | Dictionary wordlist, one candidate per line |
| `-a 1` | Combinator | Cartesian product of two wordlists |
| `-a 3` | Mask | Position-by-position character-class enumeration |
| `-a 6` | Hybrid | Wordlist + mask appended |
| `-a 7` | Hybrid | Mask prepended + wordlist |

A single RTX 4090 achieves approximately **160 GH/s** against MD5, **22 GH/s** against NTLM — but only around **200 kH/s** against bcrypt (cost=10). That 100,000x gap is the entire argument for adaptive hashing.

### WPA2 Handshake Capture and Crack

```bash
# 1. Capture the 4-way handshake triggered by a deauth frame
airodump-ng wlan0mon -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture
aireplay-ng --deauth 5 -a AA:BB:CC:DD:EE:FF wlan0mon

# 2. Convert and crack offline at full GPU speed
hashcat -m 22000 capture.hc22000 rockyou.txt
```

The handshake contains enough cryptographic material to verify PSK guesses entirely offline — no AP interaction after capture.

### Mathematics of Feasibility

```
Time to exhaustion = |Keyspace| / Guess Rate
```

For an 8-character password over 94 printable ASCII characters:
- `|K| = 94⁸ ≈ 6.1 × 10¹⁵`
- At 100 GH/s (MD5): ~17 hours to exhaust
- At 200 kH/s (bcrypt): ~970 years to exhaust

This is why the choice of **hashing function** — not merely password length — frequently determines real-world crackability.

---

## Key Concepts

- **Keyspace** — the total set of possible secret values. Grows exponentially with length and character-set size; `log₂(|K|)` expresses the entropy in bits. An 8-character alphanumeric password has ~48 bits of entropy — far less than it appears.
- **Work factor** — the expected number of operations an attacker must perform to succeed. Adaptive key derivation functions (KDFs) deliberately inflate per-guess cost by running thousands of iterations, raising the work factor without shrinking the keyspace.
- **Online vs. Offline Attack** — online attacks interact with a live authentication service and are subject to network latency, lockout policies, and IDS detection; offline attacks operate against captured material (hashes, handshakes) at hardware-limited speed with no external visibility.
- **Dictionary Attack** — a brute force variant that enumerates a curated wordlist of probable passwords (e.g., `rockyou.txt` with 14 million entries) rather than the full character space. Exploits the statistical reality that most human-chosen passwords appear in breach corpora.
- **Mask Attack** — a position-by-position brute force using character-class wildcards (e.g., `?u?l?l?l?d?d` for one uppercase, four lowercase, two digits). More targeted than pure brute force, it covers predictable patterns like `Summer23`.
- **[[Password Spraying]]** — the inverse of classic brute force: one common password (e.g., `Welcome1`) tried against many accounts simultaneously. Designed to evade per-account lockout thresholds.
- **[[Credential Stuffing]]** — automated replay of username/password pairs leaked from one breach against unrelated services. Exploits password reuse rather than unknown secrets; often miscategorized as brute force in incident reports.
- **[[Rainbow Table]]** — a precomputed time-memory tradeoff table mapping hashes back to plaintexts. Defeated by per-password **salting**, which forces per-hash computation and eliminates lookup efficiency.
- **Reverse Brute Force** — the attacker fixes a known or guessed password and enumerates usernames. Useful when a common default password (e.g., `admin`) is likely in use across many accounts.
- **Throttling vs. Lockout** — NIST SP 800-63B recommends rate-limiting (slowing attempts) over hard lockout (disabling accounts), which can itself be weaponized as a denial-of-service vector against legitimate users.

---

## Exam Relevance

Security+ SY0-701 explicitly covers brute force under **Domain 2.0 — Threats, Vulnerabilities, and Mitigations**, specifically objectives **2.3** (application and password attacks) and **2.4** (indicator analysis). Common question patterns and gotchas:

- **Distinguish brute force, spraying, and stuffing.** Brute force = many guesses against one account. Spraying = one guess across many accounts (evades per-account lockout). Stuffing = replaying leaked pairs. Exam scenarios will describe the pattern and ask you to name it — read carefully for "many passwords, one account" vs. "one password, many accounts."
- **Online vs. offline changes the effective countermeasure.** If a scenario involves a captured hash file, shadow dump, or wireless handshake, the attack is offline. In this case, **account lockout policies are irrelevant** — only hashing algorithm strength and password entropy matter.
- **Salting defeats rainbow tables, not brute force itself.** A per-password salt forces per-hash computation, eliminating precomputed lookup tables. It does not slow down the hash function — bcrypt's cost factor does that. Know which control solves which problem.
- **MFA mitigates brute force of the password factor** but does not eliminate all risk; AitM phishing and MFA fatigue attacks are separate exam topics. The exam expects you to know MFA as the highest-value mitigation for online brute force.
- **Lockout, CAPTCHA, and rate limiting** are controls for online brute force. The exam often lists these as distractors alongside MFA — when asked for the *most effective* single control, MFA wins.
- **"Exhaustive key search"** is the academic term for brute force applied to a cipher key. If you see this phrase in a cryptography question, recognize it as brute force.
- The term **"birthday attack"** is *not* brute force; it is a probabilistic attack on hash collision resistance. Do not conflate.

---

## Security Implications

Brute force and its variants underlie a significant fraction of real-world initial access:

- **2012 LinkedIn Breach** — 6.5 million unsalted SHA-1 password hashes leaked; more than 90% were cracked within days by commodity GPU rigs. This incident became the canonical public demonstration that unsalted fast hashes are operationally equivalent to plaintext storage.
- **2016 Mirai Botnet** — compromised approximately 600,000 IoT devices by brute-forcing Telnet (TCP/23) and SSH using a hardcoded list of 62 default credential pairs. Demonstrated that brute force combined with default credentials operates at internet scale.
- **RDP Brute Force (Ongoing, TCP/3389)** — Microsoft's Digital Defense Reports have consistently flagged RDP brute forcing as the leading ransomware initial access vector since 2019. Windows Event ID **4625** (failed logon) followed by **4624** (success) from the same source IP is the archetypal SIEM detection pattern.
- **CVE-2023-20269 (Cisco ASA / FTD)** — a vulnerability in the Cisco Adaptive Security Appliance VPN authentication endpoint permitted unauthenticated brute force with no rate limiting or lockout. Actively exploited by Akira and LockBit ransomware groups for initial access.
- **CVE-2020-1472 "Zerologon"** — exploited a cryptographic flaw in the Netlogon protocol reducible to brute-forcing an 8-byte IV with a 1-in-256 success rate per attempt. A working exploit required an average of ~256 connection attempts in under 3 seconds, illustrating how algorithmic weakness can catastrophically collapse work factor.
- **Colonial Pipeline (2021)** — initial access achieved via a single compromised VPN credential with no MFA enforced. While the credential was likely obtained through prior credential stuffing or purchase, the absence of MFA meant a single password was the only barrier to the operational technology network.

**Detection indicators:**
- Burst of failed authentication events: Windows Event ID 4625, Linux `auth.log` PAM failures, `/var/log/secure` (RHEL/CentOS)
- Multiple failures followed by a single success from the same source IP (brute force success pattern)
- Single source IP failing against many accounts in a short window (spraying pattern)
- TLS/SSH handshake volumes inconsistent with normal client behavior
- Authentication attempts from geographically anomalous ASNs outside normal business hours
- NTLM authentication attempts from hosts that should use Kerberos

---

## Defensive Measures

Layered controls, ordered by impact:

1. **Enforce [[Multi-Factor Authentication]]** — the single highest-impact control. Deploy FIDO2/WebAuthn (phishing-resistant, eliminates credential brute force entirely for that factor), TOTP (e.g., Google Authenticator, Authy), or push with number-matching. Disable SMS-based MFA where alternatives exist. This control makes a correct password guess alone insufficient.

2. **Use adaptive password hashing** — store passwords with **Argon2id** (OWASP recommended, winner of the 2015 Password Hashing Competition), **scrypt**, or **bcrypt** (cost ≥ 12). Never use MD5, SHA-1, or