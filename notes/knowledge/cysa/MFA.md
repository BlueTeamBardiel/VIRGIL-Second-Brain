# MFA — Multifactor Authentication

## What it is

In **Final Fantasy**, you don't open the sealed door with one key. You need the Earth Crystal, the Fire Crystal, the Water Crystal, and the Wind Crystal — four distinct artifacts, each held by a different power, each lost in a different dungeon. The Warriors of Light can't bluff their way past the seal by waving one crystal twice. You bring all four or you don't get in.

That's exactly what MFA does — it makes the door require evidence from multiple independent categories before it opens.

**Technical definition:** Multifactor authentication is an access control mechanism that requires the user to present credentials from **two or more distinct authentication factor categories** before access is granted. The categories are:

1. **Something you know** — password, PIN, security question
2. **Something you have** — hardware token, smartcard, phone with authenticator app, FIDO2 key
3. **Something you are** — fingerprint, face, iris, voiceprint (biometric)
4. **Somewhere you are** — geolocation, network location (GPS, IP geofence)
5. **Something you do** — behavioral biometric (typing cadence, mouse movement)

Two passwords stacked is *not* MFA. Two factors from the same category is single-factor authentication wearing a costume. CompTIA tests this distinction directly.

## Why it matters

Verizon's DBIR has run the same headline for years: **stolen or weak credentials are the top initial access vector** for breaches. MFA is the single highest-ROI control a SOC can push on. CISA calls it "the most important security practice an organization can implement," and they don't usually talk like that.

For CySA+ Objective 1.1, MFA sits inside **[[Identity and Access Management]]** alongside [[Single Sign-On]], [[Federation]], [[Privileged Access Management]], and [[Zero Trust]]. The exam expects you to know the factor categories, the failure modes, and how MFA composes with SSO and PAM to harden the identity plane.

In the war room, MFA enforcement (or the lack of it) is the first question after a credential-theft incident. *"Did the compromised account have MFA?"* is the single most predictive question for blast radius. No MFA: assume full account takeover. MFA enforced: now you're hunting for MFA fatigue, SIM swap, or session token theft — different playbook entirely.

## Key facts

### Factor categories — the CompTIA five

| Category | Examples | Failure modes |
|---|---|---|
| Know | Password, PIN, KBA | Phishing, brute force, dump reuse |
| Have | TOTP app, hardware key, smartcard, push | Phone theft, SIM swap, push fatigue |
| Are | Fingerprint, face, iris | Spoofing, presentation attack, no revocation |
| Where | GPS, IP geofence | VPN/proxy bypass, GPS spoof |
| Do | Keystroke dynamics, mouse profile | Drift, accessibility conflicts |

Biometrics get tested on a specific weakness: **you can't revoke a fingerprint.** Once the template leaks, it leaks forever. That's why biometric is rarely the only factor — it's stacked with something you have (the phone holding the secure enclave).

### MFA implementation types, ranked by phishing resistance

1. **FIDO2 / WebAuthn / hardware security key (YubiKey, Titan)** — phishing-resistant. The key cryptographically binds to the origin domain. A lookalike domain can't replay the challenge. This is what CISA recommends for high-value accounts.
2. **Smartcard + PIN (PIV, CAC)** — phishing-resistant. Uses [[PKI]] certificates on the card; the private key never leaves the chip.
3. **Push notification with number matching** — better than vanilla push. User types a number shown on the login screen into the app — defeats blind push approval (MFA fatigue).
4. **TOTP (Time-based One-Time Password, RFC 6238)** — 6-digit code rotating every 30s. Requires [[Time Synchronization]] between server and token (NTP drift kills TOTP). Phishable via real-time relay.
5. **SMS / voice OTP** — *NIST SP 800-63B deprecated SMS as a restricted authenticator.* Vulnerable to SIM swap, SS7 interception, and SMS phishing. Still better than no MFA, but don't put your domain admins behind it.

### Passwordless — where this is going

Passwordless authentication eliminates the "something you know" factor entirely, replacing the password with a phishing-resistant possession factor (FIDO2 key, platform authenticator like Windows Hello / Touch ID) typically gated by a biometric or PIN held *locally* on the device.

The trick: the local PIN/biometric unlocks the private key inside the device's secure enclave. The server never sees the PIN. So even though the user "knows" something, the **know factor never crosses the wire** — it just unlocks the have factor locally.

Passwordless ≠ single factor. A FIDO2 key with required user verification (touch + PIN/biometric) is genuinely multi-factor: you have the key, and you verified to it.

### Adaptive / risk-based MFA

Modern IdPs (Entra ID, Okta, Ping) don't prompt for MFA every login. They score the session: device known? Location typical? Impossible travel? Behavioral baseline match? Low risk → no prompt. Anomaly → step-up challenge. High risk → block.

Signals fed into the engine come from [[SIEM]], [[EDR]], [[CASB]], device compliance posture, and threat intel feeds — this is where MFA stops being a checkbox and becomes part of the [[Zero Trust]] control plane.

### MFA bypass techniques the SOC will see

- **MFA fatigue / push bombing** — attacker has the password, hammers push approvals at 2am hoping the user taps Approve to make it stop. Killed Uber in 2022. Mitigation: number matching, push throttling, fail-after-N policies.
- **Adversary-in-the-middle (AiTM)** — reverse proxy (Evilginx, Modlishka) sits between user and real login page, captures credentials AND the post-MFA session cookie. Replays the cookie, owns the session. Mitigation: FIDO2 (origin-bound), token binding, short session lifetimes, continuous access evaluation.
- **SIM swap** — attacker social-engineers the carrier to port the victim's number to their SIM. SMS OTPs now go to attacker. Mitigation: don't use SMS for privileged accounts.
- **Help desk social engineering** — attacker calls IT pretending to be the user, gets MFA reset. This is how the MGM and Caesars breaches started in 2023. Mitigation: callback verification, manager approval, video verification for high-value resets.
- **Session token theft** — infostealer malware (Redline, Lumma) scrapes the browser cookie jar. MFA already happened; the attacker just replays the valid cookie. Mitigation: token binding, device-bound sessions, short TTLs.

### MFA + SSO + PAM — how they compose

- **[[Single Sign-On]]** authenticates the user once; SSO becomes the chokepoint where MFA gets enforced. One strong MFA event → many downstream app sessions. Compromise the SSO and MFA falls with it — which is why SSO providers themselves must be hardened with phishing-resistant MFA.
- **[[Privileged Access Management]]** layers *additional* MFA on top of normal MFA for sensitive actions. Domain admin login? Reauthenticate with hardware key. Production database access? Just-in-time approval plus second factor. PAM treats privileged sessions as a separate trust boundary.
- **[[Federation]]** (SAML, OIDC) lets the IdP assert MFA happened to downstream Service Providers via the `AuthnContextClassRef` claim. The SP trusts the assertion — which means a misconfigured federation can let "MFA" claims through without MFA actually occurring. Audit the assertions.

### CompTIA exam traps

> **CompTIA exam trap:** Two passwords is not MFA. A password + a security question is not MFA — both are "something you know." MFA requires factors from **different categories**. The exam loves this distinction.

> **CompTIA exam trap:** SMS OTP is still MFA per the strict definition (something you have = the phone line), but NIST SP 800-63B classifies it as a *restricted* authenticator due to SIM swap and SS7 risk. If the question asks for "phishing-resistant MFA," the answer is FIDO2/WebAuthn or smartcard/PIV — never SMS or TOTP.

> **CompTIA exam trap:** MFA is an [[Identity and Access Management]] control, not an encryption or [[Network Segmentation]] control. Don't pick MFA as the answer to "how do you protect data at rest" — that's [[Encryption]]. MFA protects the authentication event, not the data.

> **CompTIA exam trap:** TOTP failure due to **clock drift** is a [[Time Synchronization]] problem. If a user's TOTP suddenly stops working after a server reboot, suspect NTP. The exam may frame this as a troubleshooting question.

### Logging and SOC visibility

Every MFA event should land in the [[SIEM]] via [[Log Ingestion]] from the IdP. The signals that matter:

- **MFA success / failure / fallback** — fallback to weaker factor is a hunting opportunity
- **MFA registration events** — attacker enrolling their own device is a classic persistence move (the "I'll just add my phone" attack)
- **Impossible travel** — auth from NYC at 09:00 and Lagos at 09:15
- **MFA fatigue patterns** — >5 push prompts in 60s
- **Legacy auth attempts** — protocols that bypass MFA (basic auth, IMAP, POP3, SMTP AUTH). Disable these.

Set logging level to capture both success and failure. Most teams only watch failures — but successful auth from a new country at 3am is more interesting than ten failures.

## SOC reality

- The 3am alert isn't "MFA failed" — it's **"MFA succeeded from a country the user has never logged in from on a device never seen before."** That's an AiTM tell. Pull the session, kill the refresh token, force reauth on a known device.
- First L1 action on a credential-theft ticket: check the user's MFA method. If it's SMS, escalate priority — that user is one SIM swap from full takeover. If it's FIDO2, breathe a little, but still hunt for stolen session tokens because the cookie doesn't care how strong your MFA was.
- The CISO's questions after a phishing incident, in order: *Was MFA enforced? What factor type? Did the attacker complete MFA? Are sessions revoked? How many other users have the same factor type configured?* Have these answers ready before they ask.
- Never promise "MFA prevented the breach" in a status update. MFA prevented the *credential replay*. The attacker may still have the session cookie, the OAuth refresh token, or a help-desk-reset path. Say "MFA held on the initial auth; we're verifying no session-layer compromise."
- Escalation: L1 confirms MFA event details and revokes sessions → L2 hunts for AiTM infrastructure and pivots to other accounts hit by the same kit → IR engages if more than a handful of accounts or any privileged user is in scope. Help-desk-reset incidents get legal and HR fast — those are insider-adjacent.

## Related concepts

[[Identity and Access Management]] · [[Single Sign-On]] · [[Federation]] · [[Privileged Access Management]] · [[Zero Trust]] · [[PKI]] · [[Time Synchronization]] · [[SIEM]] · [[Log Ingestion]] · [[CASB]] · [[Passwordless]] · [[Encryption]] · [[System Hardening]]

*Source: VIRGIL knowledge base — 2026-05-11*