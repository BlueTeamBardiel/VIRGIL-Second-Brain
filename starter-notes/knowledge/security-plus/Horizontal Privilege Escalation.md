---
domain: "offensive-security"
tags: [privilege-escalation, access-control, idor, web-security, authorization, owasp]
---
# Horizontal Privilege Escalation

**Horizontal privilege escalation** is an attack in which a user gains access to resources, data, or functionality belonging to *another user at the same privilege level*. Unlike [[Vertical Privilege Escalation]], which climbs a hierarchy (user → admin), horizontal escalation moves *sideways* — for example, customer A reading customer B's invoices or messages. It is almost always a symptom of [[Broken Access Control]], the #1 item on the **OWASP Top 10 (A01:2021)**, and most commonly manifests through **Insecure Direct Object References ([[IDOR]])**, session theft, or parameter tampering.

---

## Overview

Horizontal privilege escalation exploits the gap between **authentication** (proving who you are) and **authorization** (proving you are *allowed* to do something). A well-designed application authenticates a user at login and then checks, on every request, that the authenticated identity owns or has rights to the resource being requested. When the second check is missing, weak, or performed only on the client side, any authenticated user can often impersonate any other by simply editing a URL, cookie, hidden form field, or API body.

The attack class is distinct from vertical escalation because **no privilege boundary is formally crossed** — the attacker remains a "regular user" from the application's point of view. This makes detection significantly harder: logs show a valid session performing legitimate-looking actions on valid endpoints. The damage, however, can exceed vertical escalation because horizontal flaws typically scale to *every* user in the system. A single unauthenticated IDOR on a user-profile endpoint can leak the entire customer database one ID at a time, making it both a high-severity and high-frequency class of vulnerability.

Horizontal escalation exists because enforcing per-object authorization is genuinely hard in multi-tenant systems. Developers tend to implement role-based checks ("is this user an admin?") long before they implement object-level checks ("does this user own record #4712?"). Frameworks historically provided strong authentication primitives — sessions, JWTs, OAuth tokens — but left object-level authorization entirely to the developer, creating systemic blind spots. Microservices architectures compound the problem: an internal API trusting the gateway's `X-User-ID` header rarely re-validates ownership against the backing database.

Real-world incidents are frequent and high-impact. The **2021 Peloton API leak** allowed any authenticated user to pull any other user's age, gender, weight, workout history, and birthday via an endpoint that did not verify the requester's identity against the target user ID. The **2022 Optus breach** in Australia leveraged an API endpoint that incremented customer IDs, exposing 9.8 million records. Facebook, Instagram, Twitter, Uber, and Shopify have all paid six- and seven-figure bug bounties for horizontal escalation flaws. Regulators under the U.S. **FTC** and EU **GDPR** treat these bugs as reportable data breaches, adding regulatory liability on top of reputational damage.

Because the attack primitive is so simple — often a single HTTP request with a changed integer — horizontal escalation is a staple of web-application penetration testing, bug-bounty hunting, and red-team exercises. It is also one of the first bug classes most automated DAST scanners miss, because identifying "whose data is this?" requires semantic context about the application's ownership model that a generic scanner cannot infer.

---

## How It Works

At its core, horizontal escalation abuses an endpoint that accepts a **resource identifier** from the client but fails to verify that the current session *owns* that resource. The attack flow generally proceeds in four stages.

**Stage 1 — Observe and enumerate IDs.** The attacker creates a valid account and uses the application normally to observe how resources are referenced. They look for:

- Integer keys in URLs: `/account/profile?id=1337`
- UUIDs in JSON bodies: `"orderId": "7a1f3c…"`
- Filenames: `/reports/user_1337_2024.pdf`
- Hidden form fields: `<input type="hidden" name="accountId" value="1337">`
- JWT claims: `{"sub":"1337","role":"user"}`
- Cookie values: `Cookie: user=1337; role=customer`

**Stage 2 — Manipulate the identifier.** Using an intercepting proxy such as **Burp Suite** or **OWASP ZAP**, the attacker replays the request with a different ID. A vulnerable endpoint responds with the victim's data rather than a 403:

```http
GET /api/v1/users/1338/messages HTTP/1.1
Host: target.example
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...   ← attacker's valid token

HTTP/1.1 200 OK
Content-Type: application/json

{ "messages": [{ "to": "victim@example.com", "body": "My SSN is…" }] }
```

**Stage 3 — Automate bulk enumeration.** Once one ID swap succeeds, the attacker scripts mass harvesting:

```bash
# Enumerate all user profiles via IDOR
for id in $(seq 1 100000); do
  curl -s \
       -H "Authorization: Bearer $TOKEN" \
       "https://target.example/api/v1/users/$id" \
       -o "dump/$id.json"
done
```

Alternatively, in Burp Suite Intruder, set the `id` parameter as the payload position and supply a numeric range of 1–100000. Filter for HTTP 200 responses.

**Stage 4 — Pivot or exfiltrate.** With access to other users' objects the attacker may:
- Read PII (name, email, phone, payment info)
- Trigger password resets via the victim's account-recovery token
- Place orders charged to the victim's saved card
- In *chained* attacks, locate an administrator's user record and pivot vertically

**Common technical variants:**

- **IDOR (Insecure Direct Object Reference):** Direct manipulation of a primary key in a URL parameter, query string, or JSON body. The archetypal horizontal escalation mechanism.
- **Mass assignment:** Sending `{"userId":"1338"}` in a PATCH to `/api/me` overwrites the server-side session binding and operates on the victim's record.
- **JWT / cookie tampering:** Decoding a JWT, editing `"sub":"1337"` → `"sub":"1338"`, and re-signing — exploitable when HS256 secrets are weak, or via the `alg:none` vulnerability.
- **Forceful browsing:** Accessing URLs not linked from the UI by guessing path segments — e.g., `/invoices/1338/download`.
- **Race conditions (TOCTOU):** Submitting concurrent requests so an authorization check passes before ownership is enforced, particularly during resource-transfer operations.
- **GraphQL resolver abuse:** Querying `user(id: 1338) { email ssn }` against a resolver that lacks ownership validation.
- **Cross-tenant SaaS leakage:** Supplying another organization's `tenantId` in a header when the service trusts client-supplied tenancy rather than re-deriving it from the session.

On the backend, the root cause is almost always a single missing constraint in a database query:

```python
# VULNERABLE — fetches any record by PK
invoice = Invoice.objects.get(pk=request_id)

# SAFE — scopes to the authenticated user
invoice = Invoice.objects.get(pk=request_id, customer=request.user)
```

The first form is what developers write when building features quickly. The second form is what a threat-modelled access-control review demands. The gap between them is where horizontal escalation lives.

---

## Key Concepts

- **Authorization vs. Authentication:** Authentication verifies *who you are*; authorization verifies *what you are allowed to do*. Horizontal escalation is a pure authorization failure — the attacker is successfully authenticated throughout the attack.
- **IDOR (Insecure Direct Object Reference):** A web vulnerability where object identifiers are exposed to and controlled by clients, and the server fails to enforce ownership before returning or modifying the referenced object. The most common mechanical cause of horizontal escalation.
- **Broken Access Control:** The umbrella OWASP Top 10 category (A01:2021) covering IDOR, forced browsing, JWT tampering, and mass assignment. Ranked #1 since 2021, present in 94% of tested applications.
- **Object-Level Authorization:** The specific enforcement check — *"does subject S own or have permission to act on object O?"* — that must be performed server-side on every request. Also called row-level, instance-level, or resource-level authorization.
- **Multi-tenancy:** An architectural pattern where one application instance serves many customers. Cross-tenant horizontal escalation is the worst-case outcome: one paying customer reading another's confidential data.
- **Forceful Browsing:** Accessing endpoints not surfaced through the normal UI by guessing, scanning, or modifying URL paths and parameters. A common enumeration technique that precedes or accompanies IDOR exploitation.
- **Session Hijacking:** Stealing another user's session token via [[XSS]], network sniffing on unencrypted HTTP, or malware, then using it to inherit that user's access. A horizontal escalation primitive that bypasses the need to guess object IDs entirely.
- **Parameter Tampering:** Client-side modification of hidden form fields, query strings, headers, or API bodies to alter the server's behavior in ways the developer did not intend to expose.

---

## Exam Relevance

**SY0-701 — what to know:**

- Know the *direction* distinction cold. **Horizontal = same privilege level (user → user)**. **Vertical = higher privilege level (user → admin, guest → root)**. Exam scenarios often describe a specific situation — a customer service rep accessing another rep's performance review is *horizontal*; that same rep granting themselves administrator access is *vertical*.
- Horizontal escalation is the textbook example of **Broken Access Control** and **IDOR**. When a question states "the attacker changed the user ID in the URL and accessed another user's data," the correct answer is almost always IDOR or horizontal privilege escalation.
- **Common distractor:** "Session replay" describes re-transmitting captured packets or tokens. It is a *mechanism* that can enable horizontal escalation but is not a synonym. Read question stems carefully.
- **Mitigation questions:** CompTIA maps the correct controls to [[Least Privilege]], input validation, server-side access control enforcement, and logging/monitoring. If asked what prevents this attack, the answer is **authorization / access controls**, not stronger authentication or MFA alone — a valid authenticated user is performing the attack.
- **Cross-reference domains:** Web application attacks (Domain 1.4), identity and access management (Domain 4.6), and security architecture (Domain 3.2) all touch this concept.
- **Gotcha:** A question may describe an attacker who is fully authenticated with valid MFA. The correct answer for prevention is still *access control enforcement*, because authentication did not fail — authorization did.
- Watch for OWASP Top 10 questions pairing A01:2021 (Broken Access Control) with IDOR and horizontal escalation scenarios.

---

## Security Implications

Horizontal escalation vulnerabilities consistently rank among the highest-paid and highest-impact bug-bounty findings because a single flaw typically scales to the entire user base. Notable real-world incidents include:

- **Peloton API (2021):** Unauthenticated endpoint `/usr/{id}` returned full account profiles — age, gender, city, weight, workout history — for any user ID. Disclosed by Pen Test Partners; Peloton took 90+ days to respond before media pressure forced a patch.
- **Optus (2022):** Australian telecommunications provider breached for 9.8 million customer records. The attacker enumerated an API endpoint with sequential customer IDs and no authentication. Estimated remediation cost exceeded AUD 140 million; the breach triggered national legislative reform.
- **USPS Informed Visibility API (2018):** 60 million USPS customer accounts exposed via an API that performed no requester-to-account validation, reported by journalist Brian Krebs after a year of unremediated disclosure.
- **T-Mobile (2023):** 37 million records exfiltrated via an API identifier flaw. T-Mobile filed an SEC disclosure acknowledging the breach cost approximately $350 million in settlements and remediation.
- **Shopify (HackerOne report #969251, 2020):** An IDOR on staff-permission endpoints allowed any merchant to enumerate staff data belonging to other merchants — a $50,000 bounty.
- **CVE-2021-22214 (GitLab):** An SSRF combined with IDOR allowed unauthenticated users to access internal resources by manipulating project identifiers.

**Detection signals to monitor:**

- A single session accessing a large number of distinct object IDs sequentially within a short time window.
- Session-to-object ownership mismatch: a user whose session is bound to account `A` successfully retrieving records owned by accounts `B`, `C`, `D` — detectable by joining access logs with the ownership table.
- Anomalous 200 OK responses on endpoints that should return 403 for most callers; instrument *authorization denials* as a security metric in dashboards.
- High per-session API call rates characteristic of enumeration scripts.
- [[UEBA]] baselines flagging cross-account access deviation from normal behavior patterns.

---

## Defensive Measures

### Engineering Controls (Primary)

**Enforce object-level authorization on every endpoint.** Every query that accepts a user-controlled object identifier must scope results to the authenticated principal:

```python
# Django ORM — safe pattern
invoice = Invoice.objects.get(pk=pk, customer=request.user)

# UNSAFE — classic IDOR
invoice = Invoice.objects.get(pk=pk)
```

**Use a centralized authorization framework.** Centralizing policy prevents the "forgot to check" failure mode that scatters per-handler authorization across thousands of endpoints:
- **[[OPA|Open Policy Agent]]** (cloud-native, Rego policies)
- **Casbin** (multi-language, policy file-based)
- **AWS Cedar** (type-safe policy language)
- **Rails Pundit / CanCanCan** (Ruby)
- **Spring Security** (Java)

**Prefer non-sequential, unguessable identifiers.** UUIDv4 or ULID instead of auto-increment integers *raises the cost of enumeration* without substituting for authorization checks:

```sql
-- PostgreSQL: use gen_random_uuid() as primary key
CREATE TABLE invoices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  customer_id UUID NOT NULL REFERENCES users(id),
  ...
);
```

**Validate entirely server-side.** Never trust hidden form fields, client-side role flags, or disabled UI elements as authorization signals. The server must re-derive ownership from the session on every request.

**Secure JWT implementation.** Enforce `alg: RS256` or `ES256`; reject `alg: none`; use short expiry with rotation; store sensitive claims server-side:

```python
import jwt
# Verify with explicit algorithm whitelist — never allow "none"
payload = jwt.decode(token, public_key, algorithms=["RS256"])
```

**Re-derive tenancy from the session.** Never trust client-supplied `tenantId`, `orgId`, or `X-Customer-ID` headers for authorization. Always re-derive tenancy from the authenticated session server-side.

### Operational Controls

- **Automated authorization regression tests:** Write CI tests asserting that User B receives 403/404 when requesting User A's objects. Use the **Burp Suite Autorize** or **AuthMatrix** plugins during manual pentests to surface cross-account access automatically.
- **Rate limiting and API gateways:** Enumeration requires volume. Per-session, per-IP, and per-endpoint rate limits — enforced at the gateway ([[NGINX]], Kong, AWS API Gateway, Cloudflare) — frustrate bulk exploitation.
- **Log every authorization decision** with subject, object, action, and outcome. Alert via [[SIEM]] when anomalous cross-account access patterns emerge.
- **Penetration testing** with an explicit access-control scope; many general pentests miss IDOR because they do not create multi-user test scenarios.

### Policy and Process

- Use **OWASP [[ASVS]] v4.0 §4 (Access Control)** as an authorization requirements baseline during design.
- Threat model every new API endpoint with **STRIDE**, paying particular attention to *I* (