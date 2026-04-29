---
domain: "identity-access-management"
tags: [credential-stuffing, authentication, account-takeover, password-attacks, owasp, bot-attacks]
---
# Credential Stuffing

**Credential stuffing** is an automated [[Account Takeover|account takeover]] attack in which adversaries replay large lists of breached **username/password pairs** against unrelated services, exploiting widespread [[Password Reuse|password reuse]]. Unlike [[Brute Force Attack|brute-force]] attacks, it relies on *known-valid* credentials rather than guessing, giving it dramatically higher success rates and far lower noise. It is catalogued by [[OWASP]] as **OAT-008** in the *Automated Threats to Web Applications* taxonomy and is one of the most common precursors to [[Fraud|fraud]], [[Data Breach|data breaches]], and [[Ransomware|ransomware]] intrusions.

---

## Overview

Credential stuffing emerged as a dominant attack class in the mid-2010s after large dumps such as the **2012 LinkedIn breach** (167 million hashes), **Adobe (2013, 153M)**, **Yahoo (2013–2016, 3B)**, and the **Collection #1–#5 compilations (2019, ~2.2B unique pairs)** flooded underground markets. Once attackers possess billions of `email:password` tuples, the marginal cost of testing them against another site approaches zero. Because users reuse passwords across an estimated 60–70% of their accounts — per [[NIST SP 800-63B]] research and Verizon DBIR reporting — even a 0.1–2% hit rate yields millions of compromised accounts per campaign.

The attack is fundamentally an **economic phenomenon**, not a technical novelty. A botnet operator can rent residential proxy networks for pennies per gigabyte, run open-source tools like **OpenBullet 2** or **Sentry MBA**, and monetize hits via account marketplaces (Genesis Market, RussianMarket), gift-card cash-out, loyalty-point theft, or resale of streaming and gaming accounts. A single compromised retail loyalty account can fetch $5–$30 on underground markets; banking and cryptocurrency credentials sell for hundreds. The entire operation scales linearly with compute and proxy spend, making it accessible to low-skilled threat actors.

Credential stuffing is distinct from related password attacks. [[Password Spraying|Password spraying]] tries *one* common password against *many* usernames to evade lockout thresholds; [[Brute Force Attack|brute force]] exhaustively iterates a password space; **credential cracking** attempts to reverse captured hashes offline; and [[Dictionary Attack|dictionary attacks]] guess from wordlists. Credential stuffing already has the cleartext password — it only needs a valid login endpoint and infrastructure to evade detection.

The **2022 Verizon DBIR** found that over 80% of basic web application breaches involved the use of stolen credentials, with credential stuffing as the most prevalent vector. Notable incidents include **Disney+ (2019)** — accounts hijacked within hours of launch — **Nintendo (2020, ~300,000 accounts)**, **Zoom (2020, ~500,000 credentials)**, **PayPal (2022, 34,942 accounts)**, **Roku (2024, 591,000 accounts across two waves)**, and **23andMe (2023)**, where an initial 14,000 stuffed accounts cascaded via the *DNA Relatives* feature into the exposure of ~6.9 million users' genetic and ancestry data.

Regulators have responded with explicit guidance: the **NY DFS Cybersecurity Regulation (23 NYCRR 500)** cites credential stuffing in its 2021 advisory, and the **FTC** reached a **$410,000 settlement with Dunkin' Donuts (2021)** for failing to implement reasonable defenses after repeated stuffing campaigns compromised customer rewards accounts.

---

## How It Works

A credential stuffing campaign follows a repeatable operational pipeline. The attacker needs four components: a **combo list**, a **target configuration**, **proxy infrastructure**, and a **monetization strategy**.

### Step 1 — Combo List Acquisition

Attackers download breach dumps from forums such as BreachForums (the successor to RaidForums), Telegram leak channels, or multi-breach compilations like Collection #1. Lists are formatted as `email:password` or `username:password` pairs:

```
user@example.com:Summer2023!
jdoe@gmail.com:dogname1
admin@corp.io:P@ssw0rd
```

Lists are deduplicated, validated for format, and often "combo-cleaned" — filtered by target site's known email domain patterns or previously confirmed accounts. Specialized sublists are sold per vertical: "Netflix combos," "banking combos," "gaming combos."

### Step 2 — Target Configuration

The attacker reverse-engineers the target's login flow using browser DevTools or a proxy like **Burp Suite** or **mitmproxy**, identifying:

- The login endpoint (`POST /api/v1/auth/login` over **TCP/443, HTTPS**)
- Required headers (`User-Agent`, `Origin`, `X-CSRF-Token`, `Cookie`)
- Anti-bot tokens (reCAPTCHA, hCaptcha, Cloudflare Turnstile, Akamai `_abck`, PerimeterX `_px`)
- Success/failure indicators (HTTP 200 with `{"access_token":"..."}`, HTTP 401, redirect `Location` header)

This analysis produces a **config file** — in OpenBullet 2 syntax, an `.opk` archive — that encodes the full request chain, response parsing rules, and success conditions. These configs are actively bought, sold, and traded on tooling marketplaces.

### Step 3 — Execution at Scale

The attacker loads the config and combo list into a runner, distributing requests across a **residential proxy pool** to defeat IP-based rate limiting and geo-blocking. Residential proxies carry real consumer ISP IP addresses (often harvested via SDK-embedded mobile apps), making them nearly indistinguishable from legitimate user traffic.

A simplified Python equivalent demonstrates the core logic:

```python
import requests, itertools
from concurrent.futures import ThreadPoolExecutor

combos = [line.strip().split(":", 1) for line in open("combo.txt")]
proxies_list = open("proxies.txt").read().splitlines()
proxy_pool = itertools.cycle(proxies_list)

def attempt(user_pass):
    user, pw = user_pass
    proxy = next(proxy_pool)
    try:
        r = requests.post(
            "https://target.example.com/api/v1/auth/login",
            json={"email": user, "password": pw},
            headers={
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) ...",
                "Origin": "https://target.example.com"
            },
            proxies={"https": f"http://{proxy}"},
            timeout=8
        )
        if r.status_code == 200 and "access_token" in r.text:
            with open("hits.txt", "a") as f:
                f.write(f"{user}:{pw}\n")
    except Exception:
        pass

with ThreadPoolExecutor(max_workers=200) as ex:
    ex.map(attempt, combos)
```

Real toolchains add **TLS fingerprint spoofing** (via `curl-impersonate` or `tls-client`, defeating JA3/JA4 detection), **headless browser emulation** (Puppeteer-extra with the stealth plugin, simulating full browser behavior), and **CAPTCHA-solving services** (2Captcha, CapMonster — approximately $2 per 1,000 reCAPTCHA v2 solves).

### Step 4 — Validation and Account Enrichment

Confirmed hits are fed into **account checkers** — secondary config sets that log into the verified account, parse subscription tier, account balance, stored payment methods, and PII, then assign a market price. A single compromised email address may unlock accounts on 10+ services, each sold separately.

### Step 5 — Evasion and Persistence

Sophisticated actors throttle to approximately 1 request per IP per hour, rotate `User-Agent` strings sourced from real telemetry corpora, and avoid known honeypot endpoints. For a major platform receiving 50 million legitimate logins per day, even 5 million malicious attempts are difficult to isolate without behavioral analytics — the traffic is volumetrically camouflaged.

---

## Key Concepts

- **Combo list** — A dataset of `username:password` pairs derived from prior breaches, used as the direct input to a stuffing campaign. Quality is measured by recency, vertical targeting (e.g., "gaming combos"), and deduplication integrity.
- **Validity rate** — The percentage of tested credential pairs that result in a successful authentication. Typical campaign rates are 0.1%–2%; well-targeted or fresh lists can exceed 5%.
- **Residential proxy** — A SOCKS5 or HTTP proxy egressing through a real consumer ISP IP address, used to defeat IP reputation scoring and geofencing. Fundamentally different from *data-center proxies*, which are trivially blocklisted.
- **OAT-008** — OWASP's formal Automated Threat classification for credential stuffing, within the *Automated Threats to Web Applications* framework. Adjacent threats include OAT-007 (credential cracking) and OAT-001 (carding).
- **TLS / JA3 fingerprinting** — A defensive technique that hashes the TLS `ClientHello` handshake parameters to identify non-browser HTTP clients. Defeated by tools like `curl-impersonate` that replicate a browser's exact TLS profile.
- **Account checker** — A post-validation tool that authenticates into a confirmed hit and parses account value (subscription level, stored funds, loyalty points) to price it for resale.
- **CAPTCHA farm** — A human-operated or ML-based service that accepts CAPTCHA challenge images or tokens via API and returns valid solutions, undermining challenge-response defenses at commodity pricing.
- **Password reuse** — The root-cause enabler of credential stuffing; a user who employs the same password across multiple services transforms every breach of any one service into a potential compromise of all others.

---

## Exam Relevance

For **Security+ SY0-701**, credential stuffing appears under **Domain 2 (Threats, Vulnerabilities, and Mitigations)**, specifically objectives **2.4 (password attacks)** and **2.2 (common threat vectors)**. The exam will present scenarios and ask you to identify the *specific* attack type — precision matters here.

| Attack | Input | Target | Exploits |
|---|---|---|---|
| **Credential Stuffing** | Known email:password pairs | Many services | Password reuse |
| **[[Password Spraying]]** | One common password | Many accounts | Weak lockout policy |
| **[[Brute Force Attack\|Brute Force]]** | All possible combinations | One account | No complexity enforcement |
| **[[Dictionary Attack]]** | Password wordlist | One account | Predictable passwords |
| **[[Rainbow Table Attack\|Rainbow Tables]]** | Precomputed hash chains | Offline hashes | Unsalted storage |

**Common gotcha:** A scenario describes "thousands of failed logins arriving from hundreds of different IP addresses, using credentials found in a recently published breach database" — the answer is **credential stuffing**, **not brute force**. If the scenario emphasizes *one password tried against many usernames with minimal failures*, choose **password spraying**. The IP diversity clue is critical — stuffing uses proxy pools expressly to distribute source addresses.

**Best mitigations to memorize for the exam, in order of effectiveness:**
1. [[Multi-Factor Authentication|MFA]] — the single strongest control; explicitly the expected answer when the exam asks "what would have *prevented* this?"
2. **Breached-password screening** (mandated by [[NIST SP 800-63B]] §5.1.1.2)
3. **Account lockout** (with caveats — hard lockouts enable DoS; prefer adaptive backoff)
4. **CAPTCHA** and **WAF/bot management**

Know that **NIST SP 800-63B explicitly requires** identity providers to check new and reset passwords against known-breach corpora. This is a direct exam-relevant policy reference.

---

## Security Implications

Credential stuffing's blast radius extends well beyond the directly targeted application, making it a systemic risk rather than a site-specific one.

**Lateral compromise into enterprise environments** is the most severe downstream consequence. A password reused from a consumer shopping account may unlock a corporate VPN, Microsoft 365 tenant, or Okta dashboard. The **2022 Uber breach** involved attackers using credentials obtained from external sources to authenticate against Uber's internal systems before pivoting deeper via social engineering of MFA.

**Financial fraud** is the most common immediate monetization path. Compromised loyalty accounts (Dunkin', Marriott Bonvoy, Hilton Honors, airline miles programs) yield fungible value; banking credentials enable ACH and wire fraud; cryptocurrency exchange accounts are drained directly.

**Cascading PII exfiltration** was devastatingly demonstrated by the **23andMe incident (October 2023)**. Attackers stuffed approximately 14,000 accounts with valid credentials, then exploited the *DNA Relatives* feature — which shares data between opted-in users — to scrape genetic ancestry data on approximately **6.9 million users** who never had their own accounts compromised. This cascading exposure led to a **$30 million class-action settlement in 2024** and illustrates how application-layer trust features amplify the damage of account takeovers.

**Infrastructure impact** is measurable at industry scale. **Akamai's 2023 *State of the Internet* report** documented peaks exceeding **1 billion credential stuffing attempts per day** against media and commerce verticals. This volume imposes direct infrastructure cost — compute, bandwidth, logging storage — on defenders who didn't ask for the traffic.

Key incident timeline:
- **Disney+ (Nov 2019)** — Accounts listed for sale within 24 hours of platform launch.
- **Nintendo NNID (Apr 2020)** — ~300,000 accounts; Nintendo deprecated the legacy NNID login system as a direct response.
- **Zoom (Apr 2020)** — ~500,000 credentials sold for $0.002 each on the dark web.
- **PayPal (Dec 2022)** — 34,942 accounts confirmed compromised; forced password resets issued.
- **Okta Auth0 (Apr 2024)** — Cross-Origin Authentication endpoints abused for large-scale credential stuffing campaigns against Okta customers.
- **Roku (Jan & Mar 2024)** — Two-wave campaign: 15,000 then 576,000 accounts; Roku enrolled all 80+ million users in mandatory 2FA in response.

There is no single CVE covering credential stuffing because it is an **abuse of legitimate, correctly-functioning authentication endpoints** — a reality that places it outside the scope of traditional [[Vulnerability Management|vulnerability management]] programs and requires dedicated application and identity security controls.

---

## Defensive Measures

Effective defense requires layering controls at the identity, network, and application layers. No single control is sufficient.

**1. Multi-Factor Authentication ([[MFA]])** — The decisive control. Phishing-resistant factors ([[FIDO2]] / [[WebAuthn]] / [[Passkeys]]) defeat credential stuffing categorically because a valid password alone cannot complete authentication. TOTP and SMS-based OTP still block over 99% of automated attempts even when the password is known (per Microsoft Identity Security research, 2019). Enforce MFA at the [[Identity Provider|IdP]] level, not application-by-application.

**2. Breached-Password Screening** — Block the use of known-leaked passwords at registration, login, and password change. Integrate the **Have I Been Pwned Pwned Passwords API** (k-anonymity model — only the first 5 hex characters of the SHA-1 hash are transmitted) or commercial equivalents (Enzoic, SpyCloud, Recorded Future). This is a normative requirement under [[NIST SP 800-63B]] §5.1.1.2.

**3. Rate Limiting and Adaptive Throttling** — Apply per-IP, per-account, and per-ASN request limits on authentication endpoints. Tools and syntax:

```nginx
# nginx — 5 login attempts per minute per IP
limit_req_zone $binary_remote_addr zone=login:10m rate=5