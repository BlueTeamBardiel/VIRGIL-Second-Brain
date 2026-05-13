# SSO — Single Sign-on

## What it is

In **Counter-Strike**, you buy into a round once. M4A4, kevlar+helmet, defuse kit, two flashes, a smoke, an HE — one trip to the buy menu and you're kitted for every angle on the map. You don't re-buy when you push B site. You don't re-buy when you rotate to A. The economy gave you one authentication moment at round start, and that loadout follows you everywhere until you die or the round ends.

That's exactly what SSO does. **One authentication, one session, every app you're entitled to.**

Plain English: the user logs in once to an identity provider, and that provider hands out tokens to every downstream app the user touches for the rest of the session. Email, HR portal, Salesforce, Jira, the AWS console — all of them trust the same login.

**Technical definition (CS0-003):** Single Sign-on is an authentication scheme where an Identity Provider (IdP) authenticates a principal once and issues signed assertions or tokens (SAML, OIDC, Kerberos) to Service Providers (SPs) that consume those assertions to grant access without re-prompting for credentials. SSO is the user-facing mechanism; **federation** is the trust relationship between the IdP and SPs that makes it possible.

## Why it matters

SSO is the single most important authentication control in modern enterprises *and* the single juiciest target for an attacker. Compromise one set of IdP credentials, you compromise the kingdom. That's the trade — convenience and centralized policy enforcement vs. blast radius.

For the CySA+ exam, SSO sits inside **Objective 1.1** as a core [[Identity and Access Management]] concept. CompTIA wants you to understand the relationship between SSO, [[MFA]], [[Federation]], [[Zero Trust]], [[PAM]], and [[CASB]] — because in a modern enterprise, SSO is the seam where all of them meet.

For the SOC, the IdP is your number-one log source after EDR. Every authentication, every token issuance, every impossible-travel event, every MFA push fatigue attempt — flows through the IdP and into your [[SIEM]]. If you're not ingesting Okta/Entra ID/Ping logs, you're flying blind on the part of the kill chain attackers actually use.

## Key facts

### The three protocols you must know

| Protocol | Use case | Token format | Transport |
|---|---|---|---|
| **SAML 2.0** | Enterprise web SSO (B2B, B2E) | XML assertion, signed | HTTP POST / Redirect |
| **OAuth 2.0** | Delegated authorization (not authn) | Access token (often JWT) | HTTPS REST |
| **OIDC** (OpenID Connect) | Modern web/mobile authn on top of OAuth | ID token (JWT) | HTTPS REST |
| **Kerberos** | On-prem AD SSO | Ticket (TGT + service ticket) | TCP/UDP 88 |

> **CompTIA exam trap:** OAuth 2.0 is **authorization**, not authentication. It tells a service "this user said you can read their calendar." OIDC layers identity *on top of* OAuth and adds the ID token — that's the authentication part. CompTIA loves to ask "which protocol authenticates the user?" with OAuth as the wrong-but-tempting answer. Pick **OIDC** or **SAML**.

### The SAML flow (memorize this)

1. User hits the **Service Provider** (e.g., Salesforce).
2. SP redirects user to the **Identity Provider** (e.g., Okta) with a SAML AuthnRequest.
3. IdP authenticates the user — password + MFA, or passwordless via FIDO2/WebAuthn.
4. IdP issues a **signed SAML assertion** containing the user's identity and attributes.
5. Browser POSTs the assertion back to the SP.
6. SP validates the signature against the IdP's public key (this is where [[PKI]] lives in the flow) and grants the session.

The signature is the whole game. If an attacker can forge or replay an assertion — Golden SAML, the post-SolarWinds nightmare — they bypass every downstream control.

### Federation vs SSO vs Directory

- **Directory** ([[Active Directory]], LDAP, Entra ID) — the database of identities.
- **SSO** — the user experience of logging in once.
- **Federation** — the trust relationship that lets one organization's IdP vouch for users at another organization's SP. *SSO inside your company is just SSO. SSO that lets your contractor at Acme log into your SharePoint without an account in your directory — that's federation.*

### On-prem vs cloud vs hybrid

| Deployment | Typical IdP | SSO mechanism |
|---|---|---|
| **On-prem** | Active Directory + ADFS | Kerberos (intranet), SAML (extranet) |
| **Cloud** | Entra ID, Okta, Ping, Google | OIDC, SAML |
| **Hybrid** | AD synced to Entra ID via Entra Connect | Pass-through auth, password hash sync, or federation |

Hybrid is where breaches live. The sync agent is a high-value target — own it, own both sides. Audit the service account it runs as; it should be in tier 0 [[PAM]] vaulting with no interactive logon rights.

### SSO + MFA + Passwordless

SSO without [[MFA]] is a loaded gun pointed at the SOC. The whole point of centralizing auth is so you can centralize **strong** auth. Modern stack:

- **Passwordless** via FIDO2/WebAuthn (YubiKey, platform authenticators like Windows Hello, Touch ID) — phishing-resistant, no shared secret to steal.
- **Conditional access policies** — require MFA when login is from a new device, new country, or risky IP. This is where Entra ID Conditional Access and Okta's risk engine earn their license cost.
- **Number matching** — kills MFA push fatigue / push bombing attacks where attackers spam prompts until the user taps Approve to stop the buzzing.

### SSO and Zero Trust

[[Zero Trust]] doesn't kill SSO — it changes what the session means. Old model: authenticate once, trust the session for 8 hours. Zero Trust: authenticate once, but re-evaluate trust on every request based on device posture, location, behavior, and resource sensitivity. SSO is the entry point; **continuous access evaluation** is the leash.

This is why SSO logs matter for the SOC. A single sign-on event isn't a single log — it's a stream of token refreshes, conditional access evaluations, and session revocations that paint the user's day.

### SSO and the broader stack

- **[[CASB]]** (Cloud Access Security Broker) — sits between users and SaaS, often gets identity context *from* the IdP. SSO tells CASB who the user is so CASB can apply DLP and shadow-IT controls.
- **[[SASE]]** (Secure Access Service Edge) — SSO is the identity layer; SASE bundles it with SD-WAN, ZTNA, SWG, and CASB into one cloud-delivered fabric.
- **[[PAM]]** (Privileged Access Management) — admins should NEVER use plain SSO into tier 0. PAM (CyberArk, BeyondTrust, Delinea) brokers privileged sessions with checkout, recording, and just-in-time elevation. SSO into PAM, PAM into the box.

## Attacker tradecraft against SSO

The IdP is the keys to the kingdom. Known attacks the CySA+ analyst must recognize:

- **Phishing for the IdP password + MFA prompt** — adversary-in-the-middle kits (Evilginx, Modlishka) proxy the real login page and capture the session cookie *after* MFA. The cookie is the prize.
- **Token theft from the endpoint** — once the user has authenticated, the SSO session cookie or refresh token lives on disk or in browser storage. Malware like LummaC2, RedLine, and Atomic Stealer grabs them. Replay the cookie from anywhere and you ARE the user.
- **Golden SAML** — attacker steals the IdP's token-signing certificate, forges assertions as any user with any role. Survives password resets and MFA. Detection requires correlation between IdP logs and SP logs because the IdP never sees the forged login.
- **OAuth consent phishing** — trick the user into approving a malicious app that gets persistent OAuth tokens to their mailbox. No password needed after the grant.
- **MFA fatigue / push bombing** — spam Approve prompts until the user taps yes. Number matching kills this.

> **CompTIA exam trap:** A successful SSO login from a trusted device with valid MFA is **not** proof of legitimacy. If the session cookie was stolen post-MFA, every downstream log shows clean auth. The IoCs live in user-agent strings, IP reputation, geo-velocity, and behavioral anomalies — not the auth event itself.

### CompTIA exam traps

> **Trap:** "SSO improves security" — only partially true. SSO improves **policy consistency** (one MFA policy, one password policy, one offboarding pull) and **user experience**. It concentrates risk. CompTIA wants both halves of that answer.

> **Trap:** SSO ≠ same password everywhere. Users with the same password across ten apps are doing **password reuse**, not SSO. SSO means one authentication event produces tokens for many apps — the apps never see a password.

> **Trap:** [[Time synchronization]] matters. Kerberos tickets and SAML assertions have tight time windows (Kerberos default ±5 minutes). If domain controllers drift, auth breaks and the helpdesk floods. NTP is an SSO dependency, not a footnote.

## SOC reality

- The 3am alert you'll see most: **"Impossible travel"** — same user authenticated from Dallas at 02:41 and Bucharest at 02:47. 80% of the time it's a VPN or a corporate proxy egress. 20% of the time it's a stolen session cookie. Triage: pull the user-agent, the IP ASN, and whether MFA was satisfied on the foreign login or whether it was a refresh token replay.
- **First action for L1:** confirm the user, check device compliance, look for a parallel session, and if anything smells wrong — revoke all sessions and force re-authentication. Don't disable the account first; that tips off an attacker who's already inside. **Revoke tokens, then investigate.**
- **The CISO will ask:** "Did MFA fire? What's the scope of apps the token gave access to? Is the user's mailbox forwarded externally? Did they consent to any OAuth apps in the last 30 days?" Have answers ready.
- **Never promise containment after revoking the IdP session.** If the attacker pivoted to a refresh token, an app-specific password, or an OAuth grant, the IdP revocation doesn't kill those. You contain by revoking *all* tokens, *all* OAuth grants, *all* app passwords, and resetting MFA factors. Then you watch for 72 hours.
- **Handoff:** L1 confirms the auth anomaly → L2 pulls IdP raw logs, correlates with EDR on the endpoint, checks for stealer malware → IR if Golden SAML or IdP admin compromise is suspected → legal if PII/CHD exposure is confirmed.

*The IdP is the seam. Every modern intrusion you triage will pass through it. If you don't have IdP logs in your SIEM with full token-issuance detail, you are not running a SOC — you're running a dashboard.*

## Related concepts

[[Identity and Access Management]] · [[MFA]] · [[Federation]] · [[Zero Trust]] · [[PAM]] · [[CASB]] · [[SASE]] · [[PKI]] · [[Active Directory]] · [[Kerberos]] · [[SAML]] · [[OIDC]] · [[Conditional Access]] · [[Passwordless Authentication]] · [[Token Theft]] · [[Golden SAML]] · [[SIEM]] · [[Log Ingestion]]

*Source: VIRGIL knowledge base — 2026-05-11*