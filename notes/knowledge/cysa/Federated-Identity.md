# Federated Identity

## What it is

In **Tears of the Kingdom**, the Sages give Link their vows. Tulin, Sidon, Yunobo, Riju, Mineru — each one hands you an avatar you can summon, and that avatar acts with the Sage's full authority. Tulin's gust works because the Rito recognize Tulin, not because they've ever met Link. Link doesn't need Rito citizenship — he carries the vow, and every Rito-aligned mechanic in the world honors it. The vow is the trust. The avatar is the token. Link is the user. The world is the service provider doing what the token says.

That's exactly what federated identity does — one organization vouches for a user, and other organizations accept that vouch without re-verifying the human.

Technically: **federation** is a trust relationship between an **Identity Provider (IdP)** and one or more **Service Providers (SPs)** in which the IdP authenticates the user and issues a signed assertion (a token), and the SP consumes that assertion to make access decisions. The SP never sees the password. The IdP never sees the SP's data. Trust is established out-of-band — usually via exchanged certificates or metadata — and every runtime decision is enforced by validating the signature on the token.

Federation is the backbone of [[Single Sign-On]] across organizational boundaries, the engine behind "Sign in with Google," and the reason your corporate laptop logs into Salesforce, Workday, and AWS without re-prompting for credentials.

## Why it matters

Federation is everywhere in the enterprise, which means it's everywhere in the SOC. When it works, users stop reusing passwords across thirty SaaS apps. When it breaks — misconfigured trust, stolen tokens, compromised IdP — one breach becomes thirty breaches at once. SolarWinds, Midnight Blizzard's attack on Microsoft, the Okta support-system compromise: all federation-adjacent incidents where the IdP or its tokens became the crown jewel.

**Exam relevance:** CS0-003 Objective 1.1 lists Federation, SSO, IAM, MFA, and Zero Trust together — CompTIA treats them as one architectural family. Expect questions that test whether you can distinguish SAML from OIDC from OAuth, and whether you can name the risks of a federated trust without immediately reaching for "MFA fixes it."

## Key facts

### The three players

| Role | What it does | TotK analogy |
|---|---|---|
| **User (Principal)** | The human or service trying to access something | Link |
| **Identity Provider (IdP)** | Authenticates the user, issues a signed token | The Sage giving the vow |
| **Service Provider (SP) / Relying Party (RP)** | Consumes the token, makes the access decision | The Rito village honoring Tulin's mark |

The IdP and SP **never directly talk to each other during login** in browser-based flows. The user's browser is the courier — it carries the token via redirects. That's why redirect manipulation is a serious attack class.

### Core protocols — know this cold

| Protocol | AuthN | AuthZ | Token format | Where you'll see it |
|---|---|---|---|---|
| **SAML 2.0** | Yes | Yes (via attributes) | XML assertion, signed | Enterprise SSO — Okta, Ping, ADFS to SaaS |
| **OpenID Connect (OIDC)** | Yes | No | JWT (ID token) | Modern web/mobile, "Sign in with…" |
| **OAuth 2.0** | No | Yes | JWT or opaque (access token) | API authorization, delegated access |
| **AD FS** | Yes | Yes | SAML or WS-Fed | Windows-centric on-prem federation |
| **WS-Federation** | Yes | Yes | SAML | Legacy Microsoft stacks |

The mnemonic that survives the exam: **OAuth is for authorization, OIDC is OAuth plus authentication, SAML is the enterprise XML grandfather of both.**

### What's in a token

A federation token (SAML assertion or JWT) typically carries:

- **Issuer** — which IdP signed this
- **Subject** — who the user is (email, UPN, sub claim)
- **Audience** — which SP this token is for
- **Issued-at / Not-before / Expiration** — time bounds
- **Attributes / Claims** — group memberships, roles, MFA status, device posture
- **Signature** — proves the IdP issued it and nobody tampered

The SP validates the signature using the IdP's public key, checks the audience matches itself, checks the timestamps, and only then trusts the claims. Skip any of those checks and you've built a vulnerability.

### Trust establishment

Federation trust is set up out-of-band. The two parties exchange metadata (endpoint URLs, claim mappings), signing certificates (the IdP's public key), and optionally encryption certificates. This is a [[PKI]] use case. Certificate expiration is one of the most common causes of "federation broke at 2am" pages. Clock drift beyond the allowed skew (usually 5 minutes) gets tokens rejected as expired or not-yet-valid. [[NTP|Time synchronization]] is load-bearing.

### Federation vs SSO vs IAM

CompTIA loves to blur these:

- **IAM** is the overall discipline — who exists, what they can do, how it's reviewed
- **SSO** is the user experience — log in once, get access to many apps
- **Federation** is the architecture that makes cross-organizational SSO possible

SSO inside one company (20 internal apps with one AD account) doesn't require federation. SSO from your company into a third-party SaaS does. Federation is what crosses the trust boundary.

### Design choices the architect actually makes

- **Bring-your-own-identity vs high-assurance.** Letting users log in with personal Google accounts outsources identity assurance to whoever owns that Google account. High-assurance federation requires the IdP to enforce [[MFA]], device posture, and conditional access before issuing the token.
- **Attribute release — release the minimum.** Dumping every AD group into every SaaS assertion leaks org structure and creates an exfil-ready target.
- **Provisioning model.** JIT provisioning creates the account on first login. SCIM pushes lifecycle events from IdP to SP. JIT plus no deprovisioning is how former employees keep their SaaS access.
- **Token lifetime.** Short-lived tokens reduce replay window but increase IdP load. Refresh tokens extend sessions but introduce their own theft risk.

### CompTIA exam traps

> **CompTIA exam trap:** OAuth is **not** authentication. OAuth 2.0 is an authorization framework — it tells an API that a token-bearer is allowed to do something, not who that bearer is. If you need to know *who* the user is, you need OIDC layered on top of OAuth, or SAML. Treating an OAuth access token as proof of identity is how "Sign in with Facebook" implementations got phished into account takeovers.

> **CompTIA exam trap:** Federation does not equal MFA. The IdP may or may not enforce MFA before issuing the token. If the IdP is weak, every federated SP is weak — the trust is transitive. CompTIA will offer "implement federation" as an answer to "improve authentication strength." Wrong answer. The right answer enforces MFA at the IdP.

> **CompTIA exam trap:** SAML and OIDC both authenticate, but only SAML carries authorization attributes natively in the assertion. OIDC carries identity claims in the ID token; authorization typically happens via a separate OAuth access token. Mixing these up on a question about "which protocol carries role/group claims for SSO into a SaaS app" trips people who memorized definitions but didn't look at a token.

> **CompTIA exam trap:** "Federated identity" and "directory synchronization" are different. Azure AD Connect *syncing* on-prem AD users to Entra ID is directory sync. Setting up a SAML trust between Entra ID and Salesforce is federation. CompTIA uses them as distractors for each other.

### Common attack classes

| Attack | What happens | Defense |
|---|---|---|
| **Token theft / replay** | Attacker steals a valid token from browser, memory, or proxy and reuses it | Short token lifetime, token binding, IP/device fingerprinting, sign-out propagation |
| **Token forgery** | Forged or modified token (weak signing, JWT `alg:none`) | Strict signature validation, reject unsigned tokens, pin algorithms |
| **Golden SAML** | Attacker compromises the IdP's signing key and forges arbitrary SAML assertions — game over | HSM-protected signing keys, IdP hardening, [[PAM]] on AD FS / Entra admins |
| **Phishing the IdP** | User enters credentials into a fake IdP login page | Phishing-resistant MFA (FIDO2, [[passwordless]]), conditional access |
| **Redirect manipulation** | Attacker tricks the SP into redirecting tokens to attacker-controlled URL | Strict redirect URI allowlists at the IdP |
| **Misconfigured trust** | Too-permissive IdP, or claim mappings grant excessive privilege | Federation reviews, attribute-release audits, least privilege |
| **Consent phishing** | User tricked into granting an OAuth app permissions to their account | Admin consent workflows, restrict third-party app registrations |

**Golden SAML** is the one that ends careers. If the attacker owns the IdP's private signing key, they can mint assertions that claim *any user, any group, any MFA status*. SolarWinds attackers used this against ADFS. No SP can detect it — the signature is valid. The only defenses are upstream: protect the IdP, protect the key, monitor IdP admin activity like it's the keys to the kingdom. Because it is.

## SOC reality

- At 3am, the alert that matters reads "Impossible travel: user authenticated from Seattle and Lagos within 8 minutes" or "Anomalous token issuance — assertion issued without MFA claim." First action: pull IdP sign-in logs, check the IP, check the MFA claim, check whether session tokens have already been minted downstream.
- The L1 question is always: "Is this a session hijack, a credential phish, or a legitimate user on a VPN?" Answer by correlating IdP logs with EDR (was a token stealer like Lumma on the endpoint?), [[CASB]] logs (which SaaS apps did the token hit?), and email gateway (phishing email in the last 24 hours?).
- The IR lead asks: "What's the blast radius?" Federation makes that hard. One compromised token can ride into every federated SP. You revoke at the IdP — kill the session, force re-authentication, rotate refresh tokens — *and* at each SP that issued its own session cookie after consuming the token.
- Never promise leadership "the user is contained" after only disabling the AD account. Federated sessions can outlive the account. Until tokens are revoked at the IdP and SPs have invalidated sessions, the attacker may still be inside Salesforce or M365 with a valid cookie.
- Escalation path: L1 confirms the anomaly → L2 pulls IdP and SP logs, scopes affected apps → IR engages identity team to force revocation and reset → if Golden SAML is suspected, immediate escalation to CISO, legal, and the IdP vendor. *A compromised IdP is a top-of-house incident — not a ticket.*

## Related concepts

[[Single Sign-On]] · [[Identity and Access Management]] · [[Multifactor Authentication]] · [[Passwordless Authentication]] · [[Zero Trust]] · [[PKI]] · [[CASB]] · [[Privileged Access Management]] · [[OAuth]] · [[SAML]] · [[OpenID Connect]] · [[Conditional Access]] · [[Time Synchronization]]

*Source: VIRGIL knowledge base — 2026-05-11*