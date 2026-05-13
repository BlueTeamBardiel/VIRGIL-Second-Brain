# Password Attacks

## What it is

Every account you've ever made — your Steam login, your bank, your work email, the domain admin account that runs the whole company — sits behind a string of characters. Password attacks are the methods adversaries use to guess, steal, or crack that string. Sometimes they grind through guesses. Sometimes they steal a hash file and crack it offline. Sometimes they just watch you type it at a coffee shop.

In plain English: it's the lock-picking section of the attacker's toolkit. The lock is your password. The picks come in two flavors — guessing the password directly (online), or stealing the encrypted form and breaking it on their own hardware (offline). Every modern breach you've read about either started with a stolen password or escalated through one.

Technically: a password attack is any technique used to defeat authentication that depends on a knowledge factor. The attacks divide cleanly into **online attacks** (against a live login prompt — rate-limited, noisy, slow) and **offline attacks** (against a stolen hash — unlimited attempts, silent, fast). The defender's job is to make both painful: lockouts and MFA for online, strong hashing and long passwords for offline.

## Why it matters

Objective **220-1202 2.5** lists **brute-force attack** and **dictionary attack** as vulnerabilities you must recognize. Objective **2.4** also pulls in password attacks as part of the malware/threat landscape. On the job, this is the single most common attack class you'll see logged. SIEM dashboards at every SOC light up with failed login storms daily. Your helpdesk will field "I'm locked out" tickets caused by both legitimate forgetfulness and active attacks — telling the two apart is part of the job.

Career stakes: weak password hygiene is how junior admins get fired. Reusing your domain admin password on a forum that gets breached is a career-ending move. The reader needs to know not just how the attacks work, but why every senior tech reflexively reaches for a password manager and MFA.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Password attacks split by where the work happens. **Online attacks** hammer a live authentication endpoint — RDP, SSH, web login, SMB. They're throttled by the target: account lockouts, CAPTCHAs, rate limits, MFA. Loud in logs. **Offline attacks** require the attacker to first steal a hash file (`/etc/shadow`, the SAM database, NTDS.dit, a leaked database dump). Once they have the hash, they crack it on their own GPU rig at billions of guesses per second with no network noise.

Within those two buckets: **brute force** tries every possible combination — `aaaa`, `aaab`, `aaac`. Slow but mathematically guaranteed if you have infinite time. **Dictionary attacks** try a wordlist — `rockyou.txt` (14 million real passwords from a 2009 breach), common variations, leetspeak substitutions. Fast and effective because humans pick predictable passwords. **Hybrid attacks** combine the two — dictionary word plus appended numbers and symbols (`Password123!`). **Rainbow tables** are precomputed hash lookups — defeated by salting, which is why every modern system salts. **Credential stuffing** takes username/password pairs from one breach and tries them against other sites — works because reuse is universal. **Password spraying** flips the model: one common password (`Winter2026!`) tried against thousands of accounts to stay under per-account lockout thresholds.

**Beat 2 — Feynman via your gaming rig.** You build a cracking lab in your homelab on a rainy weekend. Not to attack anyone — to understand what defenders are up against.

**The rig:** Your gaming PC with a single RTX 4090. You install Hashcat, grab the leaked `rockyou.txt`, and feed it some test hashes you generated yourself.

**MD5, unsalted:** Your 4090 chews through about 100 billion hashes per second. An 8-character password from the standard keyboard? Cracked in under an hour. *MD5 for password storage is a war crime.*

**NTLM (Windows local hashes):** Around 80 billion per second on the same card. The reason every pentester drools over a dumped SAM file. *Windows local passwords below 12 characters are functionally plaintext to a motivated attacker.*

**bcrypt, cost factor 12:** Same hardware drops to roughly 20,000 hashes per second. Five orders of magnitude slower than MD5. A 10-character password that fell in an hour against MD5 now takes years. *The hashing algorithm matters more than the password length, up to a point.*

**The kicker:** Then you point the same setup at a long passphrase — `correct horse battery staple plus a number` style, 25+ characters. Heat death of the universe territory, even against MD5. *Length defeats cracking. Complexity rules are a 1990s relic that taught users to write passwords on sticky notes.*

**Beat 3 — Bridge from gaming to enterprise.** Same lab logic, different stakes. On your gaming PC, the worst case from a weak password is somebody hijacking your Steam account. In a small business, the worst case is the bookkeeper's `Spring2026!` getting sprayed across the company's Microsoft 365 tenant — attacker reads invoices for two weeks, then sends a fake wire transfer instruction to accounting. That's **business email compromise**, and it starts with one cracked password.

At enterprise scale: the attacker doesn't crack one password at a time. They breach a database, walk out with a million hashes, and crack offline on a 16-GPU cluster for weeks. Then they replay the working credentials against every cloud service your company uses. Your home defense is "use a password manager." The enterprise defense is layered — strong hashing on storage, password complexity *and length* policies, account lockouts, MFA on everything that touches the internet, conditional access policies that block logins from countries you don't operate in, and a SIEM watching for spray patterns.

**Beat 4 — The point.** Same fundamental question across every build: *how fast can someone who steals my hashes turn them back into passwords, and what's between them and my front door if they don't have the hash yet?* On your home rig: a password manager, MFA on critical accounts, and not reusing passwords. In the enterprise: the same answers, plus hash storage hardening, lockout policies, MFA everywhere, and active monitoring. Get this question into your bones — you'll ask it for every account you create for the rest of your career.

## Key facts

### The attack taxonomy

| Attack | Online or offline | How it works | Defense |
|---|---|---|---|
| **Brute force** | Either | Try every combination | Length, lockouts, MFA |
| **Dictionary** | Either | Try wordlist of common passwords | Length, ban common passwords |
| **Hybrid** | Either | Dictionary + appended digits/symbols | Length, passphrases |
| **Rainbow table** | Offline | Precomputed hash lookups | Salt your hashes |
| **Credential stuffing** | Online | Replay creds from other breaches | Don't reuse passwords, MFA |
| **Password spraying** | Online | One password, many accounts | MFA, detect spray patterns |
| **Shoulder surfing** | Physical | Watch the user type | Privacy screen, situational awareness |
| **Keylogger** | Endpoint | Capture keystrokes | EDR, don't get malware |

### Online vs offline — the critical distinction

> **CompTIA exam trap:** Brute force is not automatically "offline." A brute-force attack against an RDP login prompt is online and rate-limited. A brute-force attack against a stolen NTDS.dit file is offline and unlimited. The technique is the same; the venue changes the defense entirely. CompTIA loves this distinction.

**Online attacks:**
- Throttled by the authentication system
- Generate noise — failed login events in logs
- Defeated by account lockouts, MFA, CAPTCHAs, conditional access
- Examples: spraying Microsoft 365, hammering an SSH port

**Offline attacks:**
- Require initial compromise to steal hashes
- No rate limit — attacker's hardware is the only ceiling
- Silent — no auth logs generated on the target
- Defeated by strong hashing (bcrypt, Argon2, scrypt), salting, and long passwords
- Examples: cracking a leaked database dump, breaking NTLM hashes from a domain controller

### Consumer vs enterprise defense

| Layer | Home / consumer | Enterprise |
|---|---|---|
| **Password storage** | Trust the service to hash properly | Verify via policy; salted bcrypt/Argon2; protected NTDS.dit |
| **Password policy** | Pick long passphrases | Enforced minimum length (14+), banned word lists, no expiration unless compromise |
| **Reuse prevention** | Password manager (Bitwarden, 1Password) | Enterprise password manager, SSO to reduce password count |
| **Second factor** | Authenticator app, hardware key for important stuff | MFA everywhere, hardware keys for admins, phishing-resistant FIDO2 |
| **Lockout policy** | None on your local PC | 5–10 attempts, then lockout or step-up auth |
| **Monitoring** | Have I Been Pwned email alerts | SIEM correlation, spray detection, impossible-travel alerts |
| **Recovery** | Account recovery email | Helpdesk identity verification procedure, self-service password reset with MFA |

### Password complexity is dead — length wins

The old NIST guidance (uppercase + lowercase + number + symbol, change every 90 days) is officially retired. Current NIST SP 800-63B guidance: minimum 8 characters, allow up to 64+, no mandatory periodic rotation, check against breach lists. **Length is the only thing that scales against modern GPU cracking.** A 20-character passphrase beats an 8-character `P@ssw0rd!` by every meaningful metric.

### CompTIA exam traps

> **Trap:** A **dictionary attack** is a *type* of brute-force attack in casual speech, but on the exam they're listed separately. Dictionary = wordlist. Brute force = every combination. Know the distinction.

> **Trap:** **Rainbow tables** are defeated by **salting**, not by stronger hashing. CompTIA will ask which defense applies — salt for rainbow tables, slow hashing (bcrypt) for general offline cracking.

> **Trap:** **Credential stuffing** and **password spraying** sound similar. Stuffing = many username/password pairs from a breach against one site. Spraying = one common password against many usernames. Different defenses (breach-list checking vs lockout/MFA).

> **Trap:** **Shoulder surfing** is a password attack in CompTIA's taxonomy even though no software is involved. The "attack surface" includes the human typing the password in a public space.

## Helpdesk reality

- **"My account got locked out at 3 AM, I wasn't even on the computer."** This is either a credential-stuffing attempt or a misconfigured service replaying an old cached password. Check the auth logs for source IPs. If it's a foreign IP, that's a spray — escalate to security. If it's an internal IP, hunt the stale service account.
- **"I keep getting MFA prompts I didn't trigger."** This is **MFA fatigue** — attacker has the password and is spamming push notifications hoping the user taps "approve" out of annoyance. Force a password reset, revoke sessions, enable number-matching MFA. Never tell the user "just deny it and ignore it."
- **"Can you just tell me what my password is?"** No. You can reset it. If the system is configured so an admin can read user passwords in plaintext, that system is broken — escalate it. *Real password systems store hashes, not passwords. Anyone who can hand you back your old password is running an insecure system.*
- **"I have to change my password every 90 days and I'm running out of variations."** Sympathize, but follow company policy. Quietly note that modern guidance has moved away from rotation toward length + breach detection — that's a conversation for the security team, not a battle for the helpdesk.
- **"I wrote my passwords in a notebook, is that okay?"** Honest answer: it's better than reusing one password everywhere, worse than a password manager. Recommend the company-approved password manager. Never promise the notebook is "fine" — it's a compensating control, not a solution.

## Related concepts

[[Social Engineering Attacks]] · [[Multi-Factor Authentication]] · [[Hashing and Encryption]] · [[Account Lockout Policies]] · [[Active Directory Security]] · [[Phishing and BEC]] · [[Password Managers]] · [[SIEM and Auth Monitoring]] · [[Conditional Access]]

*Source: VIRGIL knowledge base — 2026-05-11*