---
domain: "offensive-security"
tags: [brute-force, password-attack, authentication, credential-access, mitre-t1110, cryptanalysis]
---
# Brute Force

A **brute force attack** is an [[authentication]]-bypass and [[cryptanalysis]] technique that systematically enumerates every candidate value—password, encryption key, session token, or PIN—until the correct one is found. It trades cleverness for raw compute, exploiting the fact that any finite keyspace can in principle be exhausted. Brute force is catalogued by [[MITRE ATT&CK]] as technique **T1110** and remains one of the oldest and most persistent classes of attack against [[passwords]], [[hash functions]], and weak [[symmetric encryption]].

---

## Overview

Brute force attacks exploit a fundamental property of finite keyspaces: any secret drawn from a bounded set of values can be discovered by trying each value in turn. Viability depends entirely on the size of the keyspace, the rate at which guesses can be evaluated, and whether the system imposes rate-limiting or lockout. A four-digit numeric PIN has only 10,000 possibilities and can be exhausted in milliseconds; a 256-bit AES key has 2²⁵⁶ possibilities and is computationally infeasible to exhaust with any conceivable hardware.

Historically, brute force against live services was throttled by network latency and account lockouts, forcing attackers to be selective. The 2012 LinkedIn breach—6.5 million SHA-1 password hashes leaked—changed the landscape entirely: once an attacker possesses a stolen hash database, the attack moves entirely offline, where modern GPUs compute billions of hashes per second. A single Nvidia RTX 4090 can attempt more than 200 billion MD5 hashes per second; rented cloud clusters multiply this further. That single incident catalyzed widespread industry adoption of slow, memory-hard hashing.

Brute force exists because designers often choose secrets that are too short, hashing algorithms that are too fast, or systems that fail to detect repeated failures. It is the baseline attack against which all credential-based defenses must be measured: a system vulnerable to brute force is vulnerable in the most general way possible. Common variants include **dictionary attacks** (trying a curated wordlist of likely passwords), **hybrid attacks** (dictionary entries combined with mutation rules), **credential stuffing** (replaying credentials from prior breaches), and **password spraying** (one common password tried against many accounts to evade per-account lockout).

In practice, modern brute force is rarely "pure." Attackers prioritize candidates by frequency, language, and breach corpus data. Tools like [[Hashcat]] and [[John the Ripper]] support mask attacks, rule-based mutations, and Markov-chain candidate ordering, all of which dramatically reduce the effective keyspace by focusing on high-probability guesses first.

The economic impact is significant. Verizon's annual *Data Breach Investigations Report* consistently identifies stolen and brute-forced credentials as the top initial-access vector, accounting for roughly 80% of web-application breaches in recent reporting years. Password-based authentication remains ubiquitous, ensuring that brute force will remain a primary threat for the foreseeable future.

---

## How It Works

A brute force attack consists of three components: a **candidate generator**, an **oracle** that evaluates each guess, and optionally **parallelization** infrastructure. The candidate generator produces values to test—iterating sequentially through a keyspace, reading from a wordlist, or applying mutation rules. The oracle returns "correct" or "incorrect" for each candidate: a login form, an SSH daemon, a hash-comparison routine, or a decryption attempt that yields plausible plaintext.

### Online vs. Offline

**Online brute force** targets live services—SSH (port 22), RDP (3389), SMB (445), HTTP/HTTPS forms (80/443), FTP (21), VNC (5900), MySQL (3306), MSSQL (1433), PostgreSQL (5432), LDAP (389), Kerberos (88), IMAP (143), SMTP (25), and SNMP (161) community strings. Each guess incurs network round-trip latency and any server-side processing delay. Defensive controls (lockout, captcha, rate limiting) operate here and are the primary obstacle.

**Offline brute force** operates against captured material: hash dumps from a database breach, WPA2 four-way handshakes captured with `airodump-ng`, encrypted ZIP or KeePass files, or Kerberos service tickets extracted via [[Kerberoasting]] or AS-REP roasting. Offline attacks are typically millions of times faster because they bypass network and server-side limits entirely—the only throttle is local hardware.

### Mathematical Foundation

For a keyspace of size *N* and a guess rate of *r* per second, the expected time to find a uniformly random secret is *N / (2r)* seconds. An 8-character lowercase-alphanumeric password (62⁸ ≈ 2.18 × 10¹⁴) against MD5 at 2 × 10¹¹ H/s takes approximately 9 minutes. The same keyspace against bcrypt at cost factor 12 (~30 hashes/sec on that same GPU) requires roughly 115,000 years. The defender's lever is not raw key length alone—it is **cost per guess**.

### Step-by-Step: Online Attack with Hydra

```bash
# -l  : single username
# -P  : password wordlist
# -t 4: four parallel threads (low to evade fail2ban)
# -f  : stop on first valid credential pair
# -V  : verbose, print each attempt
hydra -l admin -P /usr/share/wordlists/rockyou.txt \
      -t 4 -f -V ssh://192.0.2.10
```

Hydra opens four parallel TCP connections on port 22, sends an SSH authentication request for each candidate, and reads the server's accept/reject response. A success response halts the attack.

### Step-by-Step: Offline Hash Cracking with Hashcat

```bash
# Dictionary attack against sha512crypt hashes (/etc/shadow format)
# -m 1800 : hash type (sha512crypt)
# -a 0    : attack mode straight/dictionary
# -O      : enable optimized kernels
# -w 3    : workload profile (high)
hashcat -m 1800 -a 0 hashes.txt rockyou.txt -O -w 3

# Mask attack: 4 lowercase letters + 3 digits (e.g. "july123")
hashcat -m 1800 -a 3 hashes.txt ?l?l?l?l?d?d?d

# Rule-based hybrid: apply best64.rule mutations to a wordlist
hashcat -m 1800 -a 0 hashes.txt rockyou.txt \
        -r /usr/share/hashcat/rules/best64.rule
```

### Detection Signatures

Brute force produces recognizable telemetry. **Windows**: Event ID **4625** (failed logon), **4648** (explicit credential logon), **4771** (Kerberos pre-authentication failure), **4776** (NTLM validation failure). **Linux**: `/var/log/auth.log` or `journalctl -u ssh` showing repeated `Failed password` entries. SIEM rules typically flag thresholds such as "≥10 failed logins from a single source IP in 60 seconds" or, for spraying, "≥1 failure per account across ≥50 accounts in 5 minutes."

```bash
# Tally failed SSH attempts by source IP
sudo journalctl _SYSTEMD_UNIT=ssh.service --since "1 hour ago" \
  | grep "Failed password" \
  | awk '{print $(NF-3)}' | sort | uniq -c | sort -rn
```

---

## Key Concepts

- **Keyspace** — The complete set of possible secret values. An 8-character lowercase-only password has 26⁸ ≈ 2 × 10¹¹ possibilities; the same length using full printable ASCII (95 chars) has 95⁸ ≈ 6.6 × 10¹⁵—a 30,000× larger space that takes proportionally longer to exhaust.
- **Dictionary attack** — Iterates a curated wordlist (e.g., `rockyou.txt`, ~14 million entries from a real breach) instead of the full keyspace, exploiting the non-uniform distribution of human-chosen passwords. Far faster than pure brute force against realistic targets.
- **Hybrid attack** — Combines dictionary entries with rule-based mutations—capitalization, leetspeak substitutions, appended digits or years—to cover high-probability patterns like `Summer2024!`. Implemented via Hashcat rule files or John the Ripper mangling rules.
- **Password spraying** — Holds the password constant (e.g., `Winter2024!`) and iterates across many usernames. Designed to stay below per-account lockout thresholds. Generates breadth-based signals rather than depth signals, requiring different detection logic.
- **Credential stuffing** — Replays username/password pairs extracted from prior data breaches, exploiting the widespread habit of reusing credentials across multiple services. Defeated by unique passwords per service and [[MFA]].
- **Rainbow table** — A precomputed space-time tradeoff storing hash chains to accelerate lookup from hash to plaintext. Completely defeated by per-user cryptographic [[salt (cryptography)|salting]]; salting does not protect against live brute force, only precomputation.
- **Work factor / cost factor** — A tunable integer parameter (in [[bcrypt]], [[scrypt]], [[Argon2]]) that deliberately scales hashing computation time and/or memory, raising brute-force cost exponentially as the factor increases while verification remains fast enough for legitimate users.
- **Account lockout** — A policy that disables or delays an account or source IP after *N* consecutive failures. Effective against online attacks but can itself enable denial-of-service if attackers deliberately lock legitimate users by targeting their accounts.

---

## Exam Relevance

The SY0-701 exam tests brute force primarily within **Domain 2.0 (Threats, Vulnerabilities, and Mitigations)**, specifically objective **2.4** (analyze indicators of malicious activity) and **Domain 4.0**, objective **4.6** (implement and manage identity and access management).

**Common question patterns and gotchas:**

- **Distinguish the sub-types precisely.** A scenario describing "an attacker tries `Password1` against 5,000 accounts" is **password spraying**, not brute force—the password is held constant while accounts vary. A scenario with one account and many passwords is brute force or dictionary. A scenario using breach credential pairs is credential stuffing.
- **Salting defeats rainbow tables, not brute force itself.** Students frequently conflate these. Only slow hashing (bcrypt, scrypt, Argon2id) raises the real-time brute-force cost per guess.
- **MFA is the highest-impact single control** cited in exam answers for defeating credential-based attacks.
- **CAPTCHA** is the textbook online brute-force mitigation for web forms; expect it in scenario-based questions about public-facing login pages.
- **Account lockout creates a DoS risk**—the exam may present a question where an attacker deliberately triggers lockouts as a separate attack goal. Progressive backoff is the preferred nuance.
- **Birthday attack ≠ brute force.** A birthday attack is a probabilistic attack exploiting the birthday paradox to find hash collisions (two inputs with the same hash output). Do not confuse it with exhaustive credential search.
- **Offline attacks are feasible even against strong passwords if hashing is weak.** The exam expects you to know that MD5/SHA-1 are unacceptable for password storage and that Argon2id/bcrypt are current recommendations.

---

## Security Implications

Brute force is the empirical baseline for credential strength: any secret that can be cheaply brute-forced is, for security purposes, no secret at all. Real-world incidents illustrate both the scale and the consequences:

- **2012 LinkedIn breach** — 6.5 million unsalted SHA-1 hashes leaked publicly; over 90% were cracked within 72 hours using consumer hardware. A second leak in 2016 revealed 117 million more. The incident demonstrated that password hashing choices made at design time become catastrophic liabilities years later.
- **2021 Colonial Pipeline ransomware (DarkSide)** — Initial access was attributed to a single legacy VPN account with a reused password found in a credential dump, with no MFA enforced. The resulting shutdown disrupted U.S. East Coast fuel supply for six days, triggering a national emergency declaration.
- **CVE-2018-15473 (OpenSSH user enumeration)** — A timing side-channel in OpenSSH 7.7 and earlier allowed attackers to confirm which usernames were valid before brute forcing, focusing effort and dramatically reducing wasted attempts.
- **CVE-2020-1472 (Zerologon)** — Exploited a brute-force shortcut against the Netlogon protocol: one in every 256 random client challenges produces an all-zero AES-CFB8 ciphertext block, allowing an attacker to authenticate as any domain computer—including the domain controller itself—in an average of 256 attempts, taking under three seconds.
- **2018 WPA2 PMKID attack (Jens Steube)** — Demonstrated that Wi-Fi PSKs could be brute-forced offline from a single PMKID value captured without requiring a full four-way handshake, eliminating the need to wait for a client to connect.
- **2019–2022 Nation-state password spray campaigns** — APT33, APT34, and Midnight Blizzard (NOBELIUM) ran sustained password-spray operations against Office 365 and Azure AD tenants worldwide, demonstrating that brute force is not merely a script-kiddie technique but an active APT initial-access method.

Detection telemetry: Windows Security Event Log (IDs 4625, 4648, 4771, 4776), `/var/log/auth.log`, reverse-proxy access logs, IDS signatures (Suricata `et.trojan` and `et.scan` rule sets), and IdP sign-in logs (Azure AD, Okta). A spike of failures followed by a single success from an anomalous source IP is a high-confidence indicator of compromise requiring immediate triage.

---

## Defensive Measures

Effective defense applies multiple independent layers so that failure of any one control does not result in compromise:

1. **[[MFA]] (Multi-Factor Authentication)** — The single highest-impact control. Even a valid cracked password cannot authenticate without the second factor. Prefer phishing-resistant methods: **FIDO2/WebAuthn** hardware keys or platform authenticators over SMS OTP, which is vulnerable to SIM-swapping.

2. **Strong, slow, salted password hashing** — Use **Argon2id** (OWASP first recommendation, memory-hard) or **bcrypt** (cost factor ≥12) for all password storage. Never use MD5, SHA-1, or unsalted SHA-256. Salting ensures two users with the same password produce different hashes, defeating precomputation entirely.

3. **Account lockout and progressive backoff** — Lock or introduce exponential delays after 5–10 consecutive failures. Prefer progressive delay over hard lockout to avoid attacker-induced DoS against legitimate users.

4. **Rate limiting** — Enforce per-IP and per-account request limits at the load balancer, WAF, or application layer:
   ```nginx
   limit_req_zone $binary_remote_addr zone=login:10m rate=5r/m;
   limit_req zone=login burst=10 nodelay;
   ```

5. **fail2ban / CrowdSec** — Parse authentication logs and dynamically insert firewall DROP rules for offending source IPs:
   ```bash
   sudo apt install fail2ban
   # /etc/fail2ban/jail.local
   [sshd]
   enabled  = true
   maxretry = 5
   findtime = 600
   bantime  = 3600
   ```

6. **CAPTCHA / proof-of-work challenges** — Insert friction after repeated failures on web forms to defeat automated tooling without blocking legitimate users.

7. **Disable password authentication for SSH** — Set `PasswordAuthentication no` and `ChallengeResponseAuthentication no` in `/etc/ssh/sshd_config`. Require public-key