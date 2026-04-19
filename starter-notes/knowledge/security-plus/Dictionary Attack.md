```markdown
---
domain: "offensive-security"
tags: [password-attack, authentication, credentials, wordlists, hashcracking, brute-force]
---
# Dictionary Attack

A **dictionary attack** is a [[Password Attack]] technique in which an adversary attempts to authenticate or crack a [[Password Hash]] by trying entries from a precompiled list of likely candidates — a *wordlist* or *dictionary* — instead of exhaustively enumerating every possible combination. It exploits the predictable, human-generated nature of real-world passwords and sits on the spectrum of guessing attacks between naive [[Brute Force Attack]]s and targeted [[Credential Stuffing]]. Because most users choose passwords from a limited pool of culturally familiar words, phrases, and patterns, a well-curated wordlist will recover a substantial fraction of any unprotected credential store far faster than exhaustive enumeration ever could.

---

## Overview

Dictionary attacks predate modern computing in concept. The term originates from the literal use of English-language dictionaries as candidate password sources in early UNIX password-cracking research; Robert Morris and Ken Thompson documented the technique in their 1979 paper *"Password Security: A Case History,"* which motivated the introduction of the `crypt(3)` per-user salt. By the 1990s, tools such as **Crack** by Alec Muffett and later **John the Ripper** formalized the approach into usable software. The 2009 **RockYou breach** — which leaked 14.3 million plaintext passwords from a social-game platform — transformed dictionary attacks from academic curiosities into the default starting point for every modern password audit. That single list, `rockyou.txt`, now ships with Kali Linux and is the most widely used cracking wordlist in existence.

The attack exists because users do not choose passwords uniformly at random. Analysis of large breach corpora — Adobe (2013, 153 million accounts), LinkedIn (2012, 167 million accounts), Yahoo (2013, 3 billion accounts), Collection #1 (2019, 773 million unique addresses) — consistently show that a small number of passwords (`123456`, `password`, `qwerty`, `iloveyou`) account for a disproportionate share of all accounts. Even passwords that appear "complex" by surface-area rules frequently follow predictable templates: `Summer2024!`, `CompanyName1`, `P@ssw0rd`. A wordlist of a few million entries will therefore recover a significant fraction of hashes from any non-hardened corpus in minutes, whereas a true brute-force enumeration of the same keyspace would take years.

Dictionary attacks operate in two fundamental modes. **Online attacks** submit guesses directly to a live authentication service — SSH, RDP, SMB, HTTP login forms, SMTP AUTH — and are constrained by network round-trip time, service-imposed rate limits, and account lockout thresholds. A typical SSH service might tolerate only a few attempts per second per connection without defensive controls. **Offline attacks** operate against a stolen hash database and are bounded only by the attacker's compute budget. Modern GPUs compute billions of NTLM or MD5 candidates per second, collapsing days of online effort into seconds; here the quality of the wordlist, not CPU power, is the gating factor.

Modern dictionary attacks rarely use a raw wordlist unchanged. Practitioners apply **mangling rules** — deterministic per-word transformations such as `password` → `P@ssw0rd!`, `Password123`, `drowssap` — and **hybrid techniques** (wordlist combined with a brute-force mask, or two wordlists concatenated) to expand the realistic search space by orders of magnitude. Frameworks such as [[Hashcat]] and [[John the Ripper]] ship with carefully tuned rule sets — `best64.rule`, `OneRuleToRuleThemAll.rule`, `d3ad0ne.rule` — distilled from analysis of previously cracked breach corpora, making the attacker's starting position progressively better with each new leak.

Dictionary attacks remain a first-line technique in 2024 despite decades of awareness because the underlying human behavior that enables them has not fundamentally changed. Password managers, [[Multi-Factor Authentication]], and server-side [[Key Derivation Function]]s all raise the cost of exploitation significantly, but incomplete adoption means that every major breach continues to produce fresh wordlist material that feeds the next wave of attacks.

---

## How It Works

A dictionary attack proceeds in three phases: **wordlist selection**, **candidate transformation**, and **verification**.

### Phase 1 — Wordlist Selection

The attacker chooses one or more wordlists appropriate to the target environment. `rockyou.txt` is the canonical general-purpose list. The **SecLists** repository (`github.com/danielmiessler/SecLists`) bundles hundreds of specialized lists covering default credentials, application-specific passwords, usernames, and subdomains. Targeted engagements enrich the base list with company-specific material: **CeWL** scrapes the target's public website to extract likely terms, while **CUPP** (Common User Password Profiler) builds a candidate list from personal OSINT data such as names, birthdates, pet names, and notable dates.

```bash
# Generate a custom wordlist by spidering a target website (depth 2, min length 5)
cewl -d 2 -m 5 -w custom_cewl.txt https://example.com

# Merge and deduplicate multiple wordlists
cat rockyou.txt custom_cewl.txt | awk '!seen[$0]++' > combined.txt

# Profile an interactive target with CUPP
python3 cupp.py -i
```

### Phase 2 — Candidate Transformation

Raw wordlists are expanded with rules before submission. Hashcat's rule language describes per-word mutations applied at runtime: `c` capitalizes the first letter, `$1` appends the digit `1`, `sa@` substitutes every `a` with `@`, `r` reverses the string. A 10-million-word base list combined with `best64.rule` (77 rules) yields approximately 770 million unique candidates without requiring 770 million lines of storage.

```bash
# Hashcat attack mode 0 (straight dictionary) with rules against NTLM hashes
hashcat -m 1000 -a 0 ntlm_hashes.txt rockyou.txt -r rules/best64.rule

# Attack mode 6 (hybrid wordlist + mask): catches Summer2024-style passwords
hashcat -m 1000 -a 6 ntlm_hashes.txt rockyou.txt ?d?d?d?d

# Attack mode 1 (combination): two wordlists concatenated per candidate
hashcat -m 1000 -a 1 ntlm_hashes.txt words1.txt words2.txt
```

### Phase 3 — Verification

**Offline verification:** Each candidate is hashed through the same algorithm as the stored digest (MD5, SHA-1, NTLM, bcrypt, sha512crypt, etc.) and compared. Salted hashes require per-user computation and defeat precomputed [[Rainbow Table]]s but do not stop dictionary attacks — they only prevent the attacker from cracking all accounts simultaneously with a single precomputed table.

```bash
# John the Ripper against a Linux shadow file
unshadow /etc/passwd /etc/shadow > combined_shadow.txt
john --wordlist=/usr/share/wordlists/rockyou.txt --rules=Jumbo combined_shadow.txt
john --show combined_shadow.txt

# Hashcat against sha512crypt (mode 1800)
hashcat -m 1800 -a 0 combined_shadow.txt rockyou.txt -r rules/best64.rule --status
```

**Online verification:** The attacker submits each candidate to the live authentication endpoint. **Hydra** is the most widely used tool; **Medusa** and **Ncrack** are alternatives with different concurrency and protocol support.

```bash
# SSH dictionary attack, 4 parallel connections, stop on first success
hydra -l admin -P rockyou.txt -t 4 -f ssh://192.168.56.101

# HTTP POST form against DVWA (login failure string used for detection)
hydra -l admin -P rockyou.txt 192.168.56.101 http-post-form \
  "/dvwa/login.php:username=^USER^&password=^PASS^:Login failed"

# SMB / Windows share
hydra -L users.txt -P rockyou.txt smb://192.168.56.102

# RDP (port 3389)
hydra -l administrator -P rockyou.txt rdp://192.168.56.103
```

**Common target ports:** 22 (SSH), 23 (Telnet), 21 (FTP), 3389 (RDP), 445 (SMB), 1433 (MSSQL), 3306 (MySQL), 5432 (PostgreSQL), 110/143/993/995 (mail protocols), 80/443 (HTTP/S login forms).

**Throughput realities:** An RTX 4090 computes roughly **164 GH/s** against raw MD5, **96 GH/s** against NTLM, and only **~200 kH/s** against bcrypt at cost factor 5. That six-order-of-magnitude gap — not wordlist size — is why algorithm selection dominates defensive strategy for stored credentials.

---

## Key Concepts

- **Wordlist / Dictionary:** A flat file of candidate passwords, one per line. Quality and relevance to the target matter more than raw size; `rockyou-75.txt` (the top 75% most common entries) often out-cracks the full `rockyou.txt` on time-bounded jobs by concentrating compute on the highest-probability candidates first.
- **Mangling Rules:** Deterministic transformation scripts applied to each wordlist entry at runtime (capitalization, leet-substitution, affixes, reversal). A 64-rule file applied to a 10 M-word list produces ~640 M effective candidates without proportionally increasing storage requirements.
- **Hybrid Attack:** Combines a wordlist with a brute-force positional mask — for example, every word in the list followed by four digits — to capture the extremely common `Word####` password pattern without an exhaustive character-space search.
- **Online vs. Offline Attack:** Online attacks target a live service and are constrained by network, latency, and lockout policy; offline attacks operate on stolen hash files and are constrained only by compute. Offline attack throughput is typically billions of times greater, making hash algorithm strength the primary control.
- **Salt:** A per-user random value prepended or appended to the plaintext before hashing. Salts defeat [[Rainbow Table]] lookups by making each hash unique to its user, but they do not prevent dictionary attacks — they simply force the attacker to compute each candidate once per user rather than once globally.
- **Key Derivation Function (KDF):** A deliberately slow, resource-intensive hash algorithm — **Argon2id**, **bcrypt**, **scrypt**, **PBKDF2** — whose work factor can be tuned to collapse attacker throughput to thousands of guesses per second rather than billions, rendering even large wordlists computationally impractical.
- **Credential Stuffing:** A closely related attack that replays known `(username, password)` pairs from prior breach data rather than guessing passwords from a wordlist. Distinguished from dictionary attacks by the use of confirmed credential pairs and typically automated against many target sites simultaneously.
- **Password Spraying:** The inverse of a per-account dictionary attack: one (or a small set of) common passwords tried across many accounts, specifically to remain below per-account lockout thresholds. Organizationally devastating because it can compromise accounts without triggering standard lockout alerts.

---

## Exam Relevance

SY0-701 places dictionary attacks in **Domain 2.4** (indicators of malicious activity) and **Domain 5.3** (identity and access management hardening / account policies). The exam tests the ability to distinguish between the four related guessing techniques with precision:

| Attack Type | Candidate Source | Typical Target Count | Lockout Evasion |
|---|---|---|---|
| **Brute Force** | Every character combination | Single account | No |
| **Dictionary** | Wordlist of likely passwords | Single account | No |
| **Password Spraying** | One or a few common passwords | Many accounts | Yes — by design |
| **Credential Stuffing** | Breached `user:pass` pairs | Many accounts, matched | Yes — uses valid pairs |

**Common question patterns and gotchas:**

- *"An attacker is trying one password against all accounts to avoid triggering lockout"* → **Password Spraying**, not dictionary.
- *"An attacker uses a list of common passwords against a single account"* → **Dictionary attack**, not brute force.
- *"Which control specifically defeats rainbow table attacks but not dictionary attacks?"* → **Salting**. Salting is a frequent distractor; exams expect candidates to know it helps one thing and not the other.
- *"Which is the best single control against online dictionary attacks?"* → **Multi-Factor Authentication** is the highest-value answer. Account lockout is correct but secondary. Lockout alone still enables spraying.
- *"Which password storage algorithm best resists offline dictionary attacks?"* → **bcrypt / Argon2** (slow KDFs), not SHA-256/SHA-512 (fast hashes, even if salted).
- **NIST SP 800-63B** is testable: NIST recommends checking passwords against breach corpora at creation, recommends length over forced complexity, and does *not* recommend mandatory periodic rotation unless compromise is suspected — all of these are counterintuitive to older exam prep materials.

---

## Security Implications

Dictionary attacks have been the proximate cause of some of the most damaging breaches on record. In 2012, **LinkedIn** lost 167 million unsalted SHA-1 hashes; within days, over 90% had been cracked via dictionary and rule-based attacks, producing a credential corpus that fueled phishing and credential-stuffing campaigns for a decade. The 2013 **Adobe** breach leaked 153 million records encrypted with 3DES in ECB mode with password hints stored in plaintext — a design so poor that distributional dictionary attacks could succeed without cracking the cipher at all. The **Ashley Madison** breach (2015) demonstrated split security: bcrypt-hashed passwords (cost 12) resisted cracking, but a parallel legacy MD5 implementation for older accounts allowed ~11 million dictionary recoveries within weeks of the leak.

**Active attack vectors in the current threat landscape:**

- **Exposed SSH (port 22) with password authentication:** Internet-facing SSH is under continuous automated dictionary attack. Botnets including **FritzFrog** (peer-to-peer, targets Linux servers) and **Outlaw** maintain persistent distributed campaigns against public IP ranges. Shodan indexes millions of password-auth SSH endpoints.
- **RDP (port 3389):** A primary ransomware initial-access vector. Dharma, Phobos, and Conti ransomware affiliates routinely purchase or brute-force RDP credentials as their entry point; CISA advisory **AA20-245A** documents this pattern extensively.
- **Cloud identity providers (Entra ID / Azure AD, Okta, Google Workspace):** Password spraying attributed to **APT29 / Midnight Blizzard** compromised Microsoft corporate email in early 2024 by targeting legacy OAuth2 authentication flows with low-and-slow spraying that evaded conditional access policies.
- **IoT default credentials:** The **Mirai** botnet (2016) used a compiled dictionary of 62 factory-default `user:pass` pairs (e.g., `admin:admin`, `root:1234`, `ubnt:ubnt`) to recruit ~600,000 devices and generate 620 Gbps DDoS traffic. The attack required no exploitation — just dictionary lookup.

**Detection indicators:** Large volumes of authentication failures from a single source IP (brute-force/dictionary) or low-volume failures spread across many accounts from one IP (spraying); logons from anomalous geographies or user-agents consistent with Hydra or Medusa; Windows Event IDs **4625** (failed logon), **4740** (account locked out), **4771** (Kerberos pre-auth failure); Linux `/var/log/auth.log` or `/var/log/secure`. SIEM rules commonly alert on `>10 failures per account per 5 minutes` or `>50 unique-account failures from one source per minute`.

---

## Defensive Measures

Defense is layered. No single control is sufficient; the following stack addresses online attacks, offline attacks, and the human-behavior root cause simultaneously.

1. **Enforce [[Multi-Factor Authentication]] everywhere externally reachable.