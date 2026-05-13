# SAML — Security Assertion Markup Language

## What it is

In **NBA 2K**, when you take your MyPlayer from MyCareer into the Neighborhood, the Park, the Rec, and the Pro-Am — you don't re-create your build at each one. The game holds your identity (overalls, badges, animations, gear) and hands a signed token to each mode that says *"this is DemiGod_23, 6'9 point forward, here are his attributes, let him in."* The Park doesn't verify your attributes from scratch — it trusts the signed handoff from the identity layer. That's exactly what SAML does — one identity provider vouches for you, every application trusts the vouch.

**Plain English:** SAML is the XML-based language that lets you log in once and access a dozen apps without re-entering credentials. The identity provider (IdP) signs a digital "yes, this is them" message and the service provider (SP) reads it.

**Technical:** **Security Assertion Markup Language** is an XML-based open standard (OASIS, current version 2.0) for exchanging authentication and authorization data between an **identity provider** and a **service provider**. The core artifact is the **SAML assertion** — a signed XML document containing statements about the subject (who they are, what they're authorized to do, when the assertion was issued and expires). It's the backbone of enterprise SSO and federation.

## Why it matters

Every modern enterprise runs SAML or OIDC for single sign-on. Okta, Azure AD/Entra, Ping, ADFS, Google Workspace — they're all speaking SAML to Salesforce, Workday, ServiceNow, AWS, and a thousand SaaS apps. When SAML breaks or gets abused, the blast radius is the entire SaaS estate.

For CySA+ this lives in **Domain 1.3** (determining malicious activity) — specifically in the cluster of **abnormal account activity**, **impersonation**, **impossible travel**, and **XML-based attacks**. SAML assertions are XML, and attackers know it. The **Golden SAML** technique was central to SolarWinds/SUNBURST — once Nobelium owned the ADFS signing key, they could mint assertions for any user against any federated app and nothing downstream could tell the difference. No password reset fixes that. You have to rotate the key.

If you can't read a SAML flow in Wireshark or a SAML response in Burp, you can't triage federation incidents. And federation incidents are the ones that take down the C-suite's email and the engineering team's AWS in the same hour.

## Key facts

### The three actors

| Actor | Role | Example |
|---|---|---|
| **Principal** | The user trying to log in | Employee at their laptop |
| **Identity Provider (IdP)** | Authenticates the principal, issues the assertion | Okta, Azure AD, ADFS |
| **Service Provider (SP)** | The app that consumes the assertion and grants access | Salesforce, AWS, ServiceNow |

### The SAML flow (SP-initiated, the common one)

1. User hits the **SP** (e.g., `salesforce.com`).
2. SP redirects browser to the **IdP** with a **SAML AuthnRequest**.
3. IdP authenticates the user (password, MFA, cert, whatever).
4. IdP generates a **SAML Response** containing a signed **assertion**.
5. Browser POSTs the response back to the SP's **ACS** (Assertion Consumer Service) URL.
6. SP validates the signature, checks the assertion, and creates a session.

The browser is the middleman carrying signed XML. The IdP and SP never talk directly during login — they only share a trust relationship established once via certificate exchange.

### Assertion anatomy

A SAML assertion contains three statement types:

- **Authentication statement** — when and how the user authenticated (password, MFA, smartcard — `AuthnContextClassRef`)
- **Attribute statement** — user attributes (email, group memberships, role)
- **Authorization decision statement** — rarely used in practice

Critical XML elements you'll see in a capture:

- `<saml:Issuer>` — who minted the assertion (must match IdP entity ID)
- `<saml:Subject>` / `<saml:NameID>` — who the assertion is about
- `<saml:Conditions NotBefore="..." NotOnOrAfter="...">` — validity window
- `<saml:AudienceRestriction>` — which SP this assertion is for
- `<ds:Signature>` — the XMLDSig over the assertion or response

### SAML attacks the CySA+ analyst must know

**Golden SAML.** Attacker compromises the IdP's token-signing private key (often the ADFS service account or its underlying key material). They can now forge assertions for any user, with any attributes, with any validity period, against any federated SP. The SP can't tell the forgery from a real assertion — the signature validates. *Detection lives in the SP's logs, not the IdP's, because the IdP was never involved.* Look for logins to federated apps with no corresponding IdP authentication event.

**XML Signature Wrapping (XSW).** Attacker intercepts a legitimate assertion, wraps malicious content around it, and exploits parser/validator desync — the signature validates against the original chunk but the parser reads the attacker's injected chunk. Mitigation: strict schema validation, signing the entire response, and using libraries that aren't vulnerable.

**Replay attacks.** Stolen assertion reused before `NotOnOrAfter`. Mitigation: SP enforces `OneTimeUse`, tracks assertion IDs, and respects the validity window strictly.

**Open redirect / RelayState abuse.** The `RelayState` parameter tells the SP where to send the user post-auth. If unvalidated, attackers use it as a phishing landing redirect.

**Recipient confusion / audience bypass.** Assertion meant for SP-A is replayed against SP-B. Mitigation: SP must enforce that `AudienceRestriction` matches its own entity ID.

### CompTIA exam traps

> **CompTIA exam trap:** SAML vs OAuth vs OIDC. SAML is **authentication + authorization** via signed XML, designed for enterprise SSO. **OAuth 2.0** is **authorization only** (delegated access via tokens — "let this app read your Google Drive"). **OIDC** is an authentication layer built on top of OAuth 2.0 using JSON Web Tokens (JWT), not XML. If the question says "XML-based federation," it's SAML. If it says "JWT" or "Bearer token for API access," it's OAuth/OIDC.

> **CompTIA exam trap:** "Impossible travel" detection and SAML. A user authenticating to the IdP from Denver at 09:00 and the SP showing a session from Moscow at 09:03 doesn't mean the user teleported — it can mean the assertion was stolen or forged (Golden SAML). The trap: CompTIA may ask which log source confirms impersonation. Answer: correlate **IdP authentication logs** with **SP session logs**. A session at the SP with no matching IdP event = forged assertion.

### Tools for triaging SAML

| Tool | Use |
|---|---|
| **Wireshark** | Capture the SAML POST. Decode the base64 `SAMLResponse` form field to read the XML. |
| **SAML-tracer** (browser ext) | See assertions inline during a login flow. |
| **Burp Suite** | Intercept, decode, and replay SAML responses during testing. |
| **Python (`signxml`, `python3-saml`)** | Parse and validate signatures programmatically. |
| **PowerShell + ADFS cmdlets** | Pull `Get-AdfsRelyingPartyTrust`, audit token-signing certs, check claim rules. |
| **SIEM correlation** | Join `Okta.user.authentication.sso` with `Salesforce.login` events by session ID. |

### Logs the SOC actually pulls

**IdP side:**
- AuthN event (success/failure, MFA satisfied, source IP, user agent)
- Assertion issued (timestamp, SP audience, assertion ID, validity window)
- Certificate rotation events — *if you see one you didn't authorize, drop everything*

**SP side:**
- Session creation event (assertion ID consumed, source IP)
- Failed assertion validation (signature mismatch, audience mismatch, expired) — these are gold for hunt

The hunt query you'll write a hundred times: *find SP sessions where there is no corresponding IdP AuthN event in the prior 5 minutes.* That gap is where Golden SAML lives.

## SOC reality

- At 3am the alert is "Okta admin role assigned to a service account that never logs in interactively" or "ADFS token-signing certificate exported via PowerShell on the ADFS host." The first one is a misconfig 70% of the time. The second one is your bad day.
- L1's first move on a suspected federation incident: **do not** disable the user. Pull the IdP and SP logs side-by-side, get the assertion ID, get the source IP, get the user agent. If the assertion was forged, disabling the user does nothing — the attacker isn't authenticating as them anymore, they're minting assertions as them. *I once watched a team reset every password in the company and the attacker kept logging in for another six hours because the signing key was still owned.*
- The CISO will ask three questions: "Did the attacker get the signing key? Which apps are federated to that IdP? Can we prove it with logs?" Have the federation inventory ready — you should know which SPs trust which IdPs before you ever need to.
- Never promise "we revoked the session" until you've **rotated the IdP token-signing certificate** and confirmed all SPs picked up the new metadata. Session revocation at the SP doesn't matter if the attacker can mint a new assertion in 30 seconds.
- Escalation path: L1 confirms anomaly → L2 pulls IdP/SP correlation → IR lead decides on key rotation (this is a coordinated, high-impact change — every federated app needs the new metadata) → identity team executes rotation → legal/comms get looped in if a breach is confirmed because federation incidents almost always trigger regulatory timelines.

## Related concepts

[[SSO]] · [[OAuth 2.0]] · [[OIDC]] · [[JWT]] · [[ADFS]] · [[Okta]] · [[Azure AD / Entra ID]] · [[Golden SAML]] · [[XML Signature Wrapping]] · [[Impossible travel]] · [[Abnormal account activity]] · [[Impersonation]] · [[Identity Provider]] · [[Federation]] · [[MFA bypass]] · [[Log correlation]] · [[SIEM]] · [[XMLDSig]] · [[Kill chain — Initial Access via federated identity]]

*Source: VIRGIL knowledge base — 2026-05-11*