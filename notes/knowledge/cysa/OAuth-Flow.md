# OAuth Flow

## What it is

In **Tetris**, you don't get to pick which piece falls next — the game hands you one. You see the "Next" preview, you place what you're given, and the queue advances. You never reach into the bag yourself. The bag is the authority; you're just the operator with permission to place the piece that drops.

That's exactly what OAuth does — the user never hands their password to the third-party app, they let the authorization server hand the app a single piece (token) to play with, scoped and time-limited.

**Technical definition:** OAuth 2.0 is a **delegated authorization framework** (RFC 6749) that lets a client application obtain limited access to a resource on behalf of a user, without the user surrendering their credentials to the client. The user authenticates *to the authorization server*, which issues an **access token** that the client presents to the resource server. The token carries scope, lifetime, and audience — it is not the user's password and it is not proof of identity.

Repeat that last part because CompTIA tests it: **OAuth is authorization, not authentication.** If you need identity, you layer **OpenID Connect (OIDC)** on top — which adds an `id_token` (a signed JWT containing user claims) to the OAuth response.

## Why it matters

Every "Log in with Google" / "Connect your GitHub" / "Allow this app to read your calendar" button on the modern internet is OAuth. It's also the backbone of cloud federation, API-to-API auth between microservices, and most SSO implementations in front of SaaS.

For the SOC, OAuth is where **identity, [[IAM]], and application security collide.** Phishing campaigns now skip the password entirely and target the **consent prompt** — get the user to click "Allow" on a malicious OAuth app and the attacker walks away with a long-lived token that bypasses [[MFA]]. Token theft, refresh-token abuse, and **illicit consent grants** are some of the most-investigated incidents in cloud-heavy environments.

**Exam relevance:** Objective **CS0-003 1.1** — system and network architecture. OAuth shows up under [[Identity and Access Management]], [[Single Sign-On]], [[Federation]], and [[Zero Trust]] architecture. You need to know the flow, the four roles, the token types, and why OAuth alone doesn't authenticate.

## Key facts

### The four roles

| Role | What it does | Tetris analog |
|---|---|---|
| **Resource Owner** | The user. Owns the data. Grants consent. | The player |
| **Client** | The third-party app requesting access | The placement cursor |
| **Authorization Server** | Authenticates the user, issues tokens | The piece-bag / game engine |
| **Resource Server** | The API holding the protected data | The board itself |

The authorization server and resource server can be the same system (Google does both) or separate (common in enterprise — Okta issues tokens, Salesforce holds the data).

### The Authorization Code flow (the one CompTIA cares about)

This is the standard server-side flow. Memorize the order:

1. **Client redirects user** to the authorization server with `client_id`, `redirect_uri`, `scope`, and `state`.
2. **User authenticates** to the authorization server — this is where the password, [[MFA]], or [[Passwordless]] auth happens. The client never sees credentials.
3. **User consents** to the requested scopes ("This app wants to read your email").
4. **Auth server redirects back** to the client's `redirect_uri` with an **authorization code** (short-lived, one-time-use, ~10 min).
5. **Client exchanges code for token** by calling the auth server's token endpoint directly with its `client_secret`. This back-channel call is what makes the flow secure.
6. **Auth server returns** an `access_token` (and usually a `refresh_token`).
7. **Client calls the resource server** with `Authorization: Bearer <access_token>`.
8. **Resource server validates the token** and returns the data.

The reason the code-then-token two-step exists: the code travels through the browser (visible in URLs, logs, history). The token doesn't. Only the client's backend, holding the `client_secret`, can redeem the code.

### Token types

- **Access token** — short-lived (minutes to ~1 hour), presented to the resource server. Usually a [[JWT]] or an opaque string.
- **Refresh token** — long-lived (days to indefinite), used to get a new access token without re-prompting the user. **Highest-value target for attackers** — steal one and you have persistent access.
- **ID token** (OIDC only) — signed JWT carrying user identity claims (`sub`, `email`, `name`). This is what makes OIDC "authentication on top of OAuth."

### OAuth flow variants

| Flow | Use case | Notes |
|---|---|---|
| **Authorization Code + PKCE** | SPAs, mobile apps, anything public | PKCE (Proof Key for Code Exchange) replaces `client_secret` for clients that can't store one securely. **Current best practice for almost everything.** |
| **Authorization Code** (classic) | Server-side web apps with a backend | Has `client_secret` |
| **Client Credentials** | Service-to-service, no user involved | Two-legged. The client *is* the resource owner. |
| **Device Code** | Smart TVs, CLI tools, anything without a browser | User authenticates on a phone, device polls for the token |
| **Implicit** | Legacy SPAs | **Deprecated.** Tokens went straight to the browser URL fragment. Don't use it. Don't recommend it. |
| **Resource Owner Password Credentials** | Legacy migration only | **Deprecated.** User gives their password to the client — defeats the entire point of OAuth. |

### OAuth vs OIDC vs SAML

| Protocol | Purpose | Token format | Where you see it |
|---|---|---|---|
| **OAuth 2.0** | Authorization (delegated access) | Access token (often JWT) | "Allow this app to access your data" |
| **OpenID Connect** | Authentication (identity) + OAuth | ID token (JWT) + access token | "Log in with Google" |
| **SAML 2.0** | Authentication + authorization | XML assertion | Enterprise [[SSO]], older federation |

SAML is the XML-based predecessor still common in enterprise. OIDC is the modern JSON/JWT replacement. CompTIA may ask you to distinguish them — SAML uses XML and is browser-redirect heavy; OIDC uses JSON tokens and is API-friendly.

### CompTIA exam traps

> **CompTIA exam trap:** OAuth alone does NOT authenticate the user. It authorizes a client to act on the user's behalf. If the question describes "logging in with a third-party identity provider" and lists OAuth as an answer, the *more correct* answer is usually **OpenID Connect** or **SAML**. OAuth + OIDC = authentication; OAuth alone = authorization.

> **CompTIA exam trap:** OAuth is not [[SSO]] by itself — but it's commonly the *transport* for SSO. SSO is the user experience (one login, many apps); OAuth/OIDC/SAML are protocols that can implement it. Don't conflate them.

> **CompTIA exam trap:** The `state` parameter prevents **CSRF on the redirect**. The `client_secret` (or PKCE code verifier) prevents **code interception attacks**. They are different mitigations for different threats. Expect a question that swaps them.

## OAuth attacks the SOC actually sees

### Illicit consent grant ("OAuth phishing")

Attacker registers a malicious app — often with a benign-sounding name like "Office 365 Reporting" — and sends a link that triggers a legitimate consent prompt. The user clicks Allow. The attacker now has a refresh token to the user's mailbox or files. **No password was stolen. [[MFA]] was never bypassed because it wasn't challenged a second time.** This is the Microsoft 365 attack pattern that defined 2020–2024.

*I learned this the hard way: an MFA-enforced tenant is not a consent-locked tenant. If your users can grant arbitrary OAuth apps, your MFA is decoration.*

### Token theft

Refresh tokens stolen from browser storage, mobile keychains, or memory dumps. Because they're bearer tokens, possession = access. No second factor on replay. **Token binding and short refresh lifetimes are the only real defenses** beyond not getting compromised in the first place.

### Redirect URI manipulation

Attacker registers a client and tricks the auth server into redirecting the code to a domain they control. Mitigated by **exact-match `redirect_uri` whitelisting** on the auth server.

### Scope creep / over-permissioned apps

Dev team registers an OAuth app and asks for `Mail.ReadWrite.All` because it was easier than scoping. Two years later, the app's credentials leak. The blast radius is the entire tenant's mail.

## SOC reality

- **The alert at 3am:** "New OAuth app consented by user X, scopes include `Mail.Read`, `offline_access`." Your L1 looks at the publisher (unverified), the consent count (1 — just this user), and the scopes (read mail + persistent refresh). That's a consent-grant phishing IOC. Open a case.
- **L1 first action:** Pull the app's `client_id` from the audit log (Microsoft calls it the AAD sign-in / consent log; Google calls it the OAuth token audit). Check how many other users in the tenant consented. Check the publisher domain age — newly registered = bad.
- **The IR lead asks:** "What's the scope, what's the token lifetime, and have we revoked the refresh token yet?" Revoking the user's session does NOT revoke OAuth tokens. You revoke the **app consent** (which kills the refresh token's ability to mint new access tokens) and, ideally, the access token if your IdP supports it.
- **Never promise leadership:** "MFA protected us." MFA fires on the *initial* user auth to the authorization server. The attacker never re-auths — they ride the refresh token. Saying "MFA blocked it" when an OAuth consent grant succeeded will get you corrected in the post-mortem.
- **Handoff:** L1 confirms the consent grant and revokes → L2 hunts for other consented apps and pulls mailbox audit logs to see what the token actually read → IR determines exfil scope → legal determines breach notification obligation if PII was in those mailboxes ([[Personally Identifiable Information]]).
- **Hardening that prevents this entire class:** disable user consent for unverified publishers (Azure AD has an admin-consent workflow), enforce scope policies via [[CASB]], log all OAuth consent events into the [[SIEM]], and alert on `offline_access` scope grants to high-value accounts.

## Related concepts

[[Identity and Access Management]] · [[Single Sign-On]] · [[Federation]] · [[Multifactor Authentication]] · [[Passwordless]] · [[OpenID Connect]] · [[SAML]] · [[JWT]] · [[Zero Trust]] · [[CASB]] · [[Cloud Architecture]] · [[Token Theft]] · [[Consent Grant Attack]] · [[PKI]]

*Source: VIRGIL knowledge base — 2026-05-11*