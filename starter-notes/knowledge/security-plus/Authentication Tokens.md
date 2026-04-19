---
domain: "Identity and Access Management"
tags: [authentication, tokens, iam, cryptography, session-management, access-control]
---
# Authentication Tokens

**Authentication tokens** are cryptographically generated data objects used to verify a user's or system's identity without repeatedly transmitting raw credentials like passwords. They serve as a time-limited, tamper-evident proof of prior successful [[Authentication]], enabling stateless or session-based access to protected resources. Tokens are foundational to modern [[Identity and Access Management (IAM)]], [[Single Sign-On (SSO)]], and [[API Security]] architectures.

---

## Overview

Authentication tokens exist because repeatedly sending passwords over a network — even over encrypted channels — increases the attack surface. A password, once captured, grants unlimited access indefinitely. A token, by contrast, can be scoped to specific resources, constrained by expiration time, and revoked without changing the underlying credential. This design principle, sometimes called *credential separation*, is central to zero-trust architectures and modern identity systems.

Tokens originate from a successful authentication event. A user presents their credentials (username/password, certificate, biometric) to an **authentication server** or **identity provider (IdP)**. Upon verification, the IdP issues a token — a structured, often signed data object — that the client presents on subsequent requests. The receiving server validates the token's signature and claims rather than querying the IdP on every request, making the exchange far more scalable.

There are several token paradigms in use. **Session tokens** (or cookies) are opaque random strings stored server-side, where the server maps the token to a session record. **Stateless tokens** like [[JSON Web Tokens (JWT)]] embed all necessary claims within the token itself, signed so the verifier needs only the public key or shared secret to validate — no server-side storage required. **Hardware tokens** and **software tokens** (OTP generators) produce time- or event-based codes as a second factor. Each paradigm trades off storage overhead, revocability, and scalability differently.

In enterprise environments, token-based authentication underpins protocols like [[OAuth 2.0]], [[OpenID Connect (OIDC)]], and [[SAML 2.0]]. OAuth 2.0 uses **access tokens** to authorize API calls and **refresh tokens** to obtain new access tokens. SAML exchanges **assertions** (XML-based tokens) between an IdP and a service provider. OIDC extends OAuth 2.0 with **ID tokens** (JWT-formatted) that carry user identity claims. Understanding the distinctions between these token types is critical for both exam preparation and real-world architecture decisions.

Tokens have become prime targets for attackers. Stealing a valid token bypasses the need to know a password and, depending on token lifetime and scope, can grant extensive access. High-profile breaches such as the 2023 Microsoft Exchange Online compromise (Storm-0558) involved forged authentication tokens, demonstrating that even token infrastructure itself can be subverted. This reality drives the need for short expiration windows, rigorous signature validation, and robust token storage practices.

---

## How It Works

### General Token Issuance and Validation Flow

```
Client                    Auth Server (IdP)              Resource Server
  |                              |                              |
  |-- POST /login (user:pass) -->|                              |
  |                              |-- [verify credentials] ---  |
  |<-- 200 OK + Token ----------|                              |
  |                              |                              |
  |-- GET /api/resource ---------------------------------------->|
  |   Authorization: Bearer <token>                             |
  |                              |<-- [validate token sig] -----|
  |<-- 200 OK + Resource ----------------------------------------|
```

### JSON Web Token (JWT) Deep Dive

JWT is the most widely encountered stateless token format. A JWT consists of three Base64URL-encoded parts separated by dots:

```
<Header>.<Payload>.<Signature>
```

**Header** specifies the algorithm:
```json
{
  "alg": "RS256",
  "typ": "JWT"
}
```

**Payload** carries claims:
```json
{
  "sub": "user-12345",
  "iss": "https://auth.example.com",
  "aud": "https://api.example.com",
  "exp": 1717200000,
  "iat": 1717196400,
  "roles": ["read", "write"]
}
```

**Signature** for RS256:
```
RSASHA256(
  base64url(header) + "." + base64url(payload),
  privateKey
)
```

To decode a JWT locally (never decode untrusted tokens in production without verification):
```bash
# Decode without verification (inspection only)
echo "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c2VyLTEyMzQ1IiwiaXNzIjoiaHR0cHM6Ly9hdXRoLmV4YW1wbGUuY29tIn0.SIGNATURE" \
  | cut -d'.' -f2 \
  | base64 -d 2>/dev/null | python3 -m json.tool
```

Verify a JWT signature using `jwt-cli`:
```bash
jwt decode --secret @public_key.pem <token>
```

### OAuth 2.0 Token Flow (Authorization Code)

1. Client redirects user to IdP: `GET https://auth.example.com/authorize?response_type=code&client_id=CLIENT_ID&redirect_uri=https://app.example.com/callback&scope=openid profile&state=RANDOM_STATE`
2. User authenticates at IdP; IdP redirects back with authorization code: `GET https://app.example.com/callback?code=AUTH_CODE&state=RANDOM_STATE`
3. Backend exchanges code for tokens:
```bash
curl -X POST https://auth.example.com/token \
  -d "grant_type=authorization_code" \
  -d "code=AUTH_CODE" \
  -d "client_id=CLIENT_ID" \
  -d "client_secret=CLIENT_SECRET" \
  -d "redirect_uri=https://app.example.com/callback"
```
4. IdP returns:
```json
{
  "access_token": "eyJhbGci...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "dGhpcyBpcyBhIHJlZnJlc2ggdG9rZW4...",
  "id_token": "eyJhbGci..."
}
```
5. Client uses `Authorization: Bearer <access_token>` header for API calls.

### TOTP (Time-Based One-Time Password) — RFC 6238

Hardware/software OTP tokens generate codes using:
```
TOTP = HOTP(secret, floor(current_time / time_step))
HOTP = truncate(HMAC-SHA1(secret, counter))
```
- **Time step**: typically 30 seconds
- **Secret**: shared between authenticator app and server
- **Ports**: No dedicated port; used within RADIUS (UDP/1812), LDAP, or web authentication flows

Generate a TOTP manually in Python:
```python
import hmac, hashlib, struct, time, base64

def totp(secret_b32, step=30):
    secret = base64.b32decode(secret_b32.upper())
    counter = struct.pack('>Q', int(time.time()) // step)
    mac = hmac.new(secret, counter, hashlib.sha1).digest()
    offset = mac[-1] & 0x0F
    code = struct.unpack('>I', mac[offset:offset+4])[0] & 0x7FFFFFFF
    return str(code % 10**6).zfill(6)

print(totp("JBSWY3DPEHPK3PXP"))
```

### Kerberos Ticket-Based Tokens

In Active Directory environments, [[Kerberos]] uses **tickets** as tokens:
- **TGT (Ticket Granting Ticket)**: Issued by the KDC Authentication Service after initial login. Valid typically 10 hours.
- **Service Ticket (TGS)**: Issued by the Ticket Granting Service; grants access to a specific service.

```bash
# List Kerberos tickets on Linux
klist

# Request a TGT
kinit username@DOMAIN.LOCAL

# Inspect ticket cache
klist -e
```

---

## Key Concepts

- **Bearer Token**: A token where possession alone grants access — "whoever bears this token is authorized." Requires transport-layer security (TLS) to prevent interception. Used ubiquitously in OAuth 2.0 API calls.
- **Access Token**: A short-lived token (typically 15 minutes to 1 hour) that grants permission to access specific resources. In OAuth 2.0, it is presented to the resource server, not the IdP.
- **Refresh Token**: A longer-lived token (days to weeks) used exclusively to obtain new access tokens without re-authentication. Must be stored securely; its compromise allows indefinite session extension.
- **ID Token**: A JWT issued by an OIDC-compliant IdP that contains claims *about the authenticated user* (identity assertion), not authorization grants. Intended for the client application, not the resource server.
- **Token Claims**: Key-value pairs embedded in a token's payload. Standard JWT claims include `iss` (issuer), `sub` (subject), `aud` (audience), `exp` (expiration), `iat` (issued at), and `nbf` (not before). Custom claims carry application-specific data like roles or tenant IDs.
- **Token Introspection**: An OAuth 2.0 mechanism (RFC 7662) where a resource server queries the authorization server to validate an opaque token: `POST /introspect` with the token value. Returns active/inactive status and metadata.
- **Token Revocation**: The process of invalidating a token before its natural expiration (RFC 7009 for OAuth). More complex for stateless JWTs; requires a revocation list or short expiry windows.
- **Opaque Token**: A token with no intrinsic structure readable by the client (e.g., a random string mapped to server-side session data). Requires server-side storage; easier to revoke than JWTs.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Tokens appear primarily in Domain 1.0 (General Security Concepts), Domain 2.0 (Threats, Vulnerabilities, and Mitigations), and Domain 4.0 (Security Operations).

**High-Frequency Question Patterns**:

- **Token vs. Password**: Expect questions contrasting session-based auth (opaque cookie) with token-based auth (JWT). The key differentiator is *statefulness* — session tokens require server-side state; JWTs are stateless.
- **OAuth 2.0 Roles**: Know the four roles cold: **Resource Owner** (user), **Client** (app), **Authorization Server** (IdP), **Resource Server** (API). Exam questions often test whether candidates confuse the authorization server and resource server.
- **Token Types**: Distinguish access token (short-lived, API access) vs. refresh token (long-lived, token renewal) vs. ID token (identity claims, OIDC only). Common gotcha: the refresh token goes to the *authorization server*, not the resource server.
- **MFA Token Types**: TOTP (time-based), HOTP (counter/event-based), hardware tokens (RSA SecurID, YubiKey). Know that TOTP uses a **shared secret + current time** while HOTP uses a **shared secret + counter**.
- **Kerberos Tickets**: TGT = "passport to get service tickets"; Service Ticket = "visa for a specific service." The KDC has two components: AS (Authentication Service) and TGS (Ticket Granting Service). PAC (Privilege Attribute Certificate) inside Kerberos tickets carries authorization data.

**Common Gotchas**:
- JWT signing does **not** encrypt the payload — Base64URL encoding is trivially reversible. Encryption requires JWE (JSON Web Encryption).
- The `alg: none` attack: some libraries accept JWTs with no signature if the header specifies `"alg": "none"`. This is a well-known vulnerability.
- Refresh tokens are **not** sent to the resource server — they go only to the authorization server.
- SAML assertions are XML, not JSON; they travel via browser redirects/POSTs, not API headers.

---

## Security Implications

### Token Theft and Replay Attacks
Because bearer tokens grant access on possession alone, intercepted tokens can be replayed. The 2023 **Storm-0558** incident involved attackers forging Azure AD authentication tokens using a stolen Microsoft signing key (CVE-2023-21709 related infrastructure). This allowed access to Exchange Online email accounts of ~25 organizations including U.S. government agencies, demonstrating that token infrastructure itself is a high-value target.

### JWT-Specific Vulnerabilities

**Algorithm Confusion (CVE pattern)**:
```
# Attacker changes header from RS256 to HS256
# Signs token with the PUBLIC KEY (now used as HMAC secret)
# Vulnerable libraries accept this as valid
```

**None Algorithm Attack**: Stripping the signature and setting `"alg": "none"` bypasses verification in vulnerable implementations.

**Weak Secrets**: JWTs signed with `HS256` using weak secrets can be brute-forced offline using tools like `hashcat`:
```bash
hashcat -a 0 -m 16500 <jwt_token> /usr/share/wordlists/rockyou.txt
```

### Token Storage Vulnerabilities
- **Browsers**: Access tokens stored in `localStorage` are vulnerable to [[Cross-Site Scripting (XSS)]] — JavaScript can read and exfiltrate them. `httpOnly` cookies resist XSS but are vulnerable to [[Cross-Site Request Forgery (CSRF)]].
- **Mobile Apps**: Tokens stored in insecure locations (plain SharedPreferences on Android, unprotected NSUserDefaults on iOS) can be extracted from rooted/jailbroken devices.

### Session Token Fixation / Hijacking
Attackers may attempt to steal session tokens via network sniffing (non-TLS connections), XSS injection, or by exploiting predictable token generation (weak PRNG).

### Kerberoasting
In Active Directory, any authenticated user can request service tickets for any SPN. The ticket is encrypted with the service account's password hash. Attackers extract tickets offline for cracking:
```bash
# Using Impacket
python3 GetUserSPNs.py DOMAIN/user:password -dc-ip 10.0.0.1 -request
```

### Pass-the-Ticket / Golden Ticket Attacks
Stolen Kerberos tickets (TGTs or service tickets) can be injected into new sessions. **Golden Ticket** attacks forge a TGT using the KRBTGT account hash, granting domain-wide persistence (Mimikatz technique, common post-exploitation pattern).

---

## Defensive Measures

### Token Lifetime and Rotation
- Set **access token expiration to 15–60 minutes** maximum. Resource servers should validate the `exp` claim on every request.
- Implement **refresh token rotation**: issue a new refresh token each time one is used; invalidate the old one. Detect reuse of previously rotated refresh tokens as a compromise indicator.
- Configure in Okta/Azure AD: `accessTokenLifetime: PT1H`, `refreshTokenExpiration: P90D`.

### Signature Validation Hardening
```python
# Always explicitly specify expected algorithm - never trust header's alg claim
import jwt
payload = jwt.decode(
    token,
    public_key,
    algorithms=["RS256"],  # NEVER use algorithms=jwt.get_unverified_header(token)["alg"]
    audience="https://api.example.com"
)
```

### Secure Storage
- **Web applications**: Store access tokens in memory (JavaScript variables); use `httpOnly`, `Secure`, `SameSite=Strict` cookies for refresh tokens.
- **Mobile**: Use Android Keystore / iOS Secure Enclave for token storage.
- **Server-side**: Store tokens in encrypted secrets management systems (HashiCorp Vault, AWS Secrets Manager) rather than environment variables or config files.

### Token Binding (RFC 8471)