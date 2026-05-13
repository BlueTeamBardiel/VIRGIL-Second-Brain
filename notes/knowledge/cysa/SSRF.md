# SSRF — Server-side Request Forgery

## What it is

In **Among Us**, the Impostor can't vent into Electrical from the cafeteria — but if they convince a Crewmate to swipe their card at Admin, that swipe goes through with full Crewmate trust. The card reader doesn't ask *why* the task is being done. It just executes because someone with permission asked. That's exactly what SSRF does — the attacker can't reach the internal network directly, but they trick a public-facing server into making requests on their behalf, and those requests carry the server's trust.

**Server-side Request Forgery (SSRF)** is a web application vulnerability where the attacker manipulates a server into issuing HTTP (or other protocol) requests to destinations the attacker chose. The server becomes a confused deputy: it has network access the attacker doesn't, and the application doesn't validate where it's being told to fetch from. Result: the attacker pivots from the internet edge into internal services, cloud metadata APIs, and management interfaces that should never have been reachable from outside.

SSRF lives in OWASP Top 10 as its own category (A10:2021) because it's the cleanest pivot from "external web bug" to "full cloud account takeover" anyone has ever found.

## Why it matters

SSRF is the bug that turned Capital One into a textbook case. A misconfigured WAF with SSRF reached the AWS Instance Metadata Service (IMDS) at `169.254.169.254`, pulled IAM credentials, and exfiltrated 100M+ customer records. The vuln wasn't exotic. The blast radius was the whole bank.

For the CySA+ exam, SSRF maps to **Objective 2.4** (recommend controls to mitigate attacks and software vulnerabilities) and shows up under **Objective 1.x** as an attack technique. CompTIA likes SSRF because it touches network segmentation, cloud security, input validation, and trust boundaries all at once — a single question can test four concepts.

For your career: cloud-native apps with URL-fetching features (webhook handlers, PDF generators, image proxies, link previews, SSO callbacks) are SSRF magnets. If you do AppSec or cloud SOC work, you will see this.

## Key facts

### The mechanic

The vulnerable pattern looks like this:

```
GET /fetch?url=https://api.partner.com/data HTTP/1.1
```

The application takes `url` and does a backend HTTP GET. Attacker changes the value:

```
GET /fetch?url=http://169.254.169.254/latest/meta-data/iam/security-credentials/
GET /fetch?url=http://localhost:8080/admin
GET /fetch?url=file:///etc/passwd
GET /fetch?url=http://10.0.0.5:6379/  (internal Redis)
```

The server fetches, the response comes back through the application, and now the attacker is reading internal resources using the server's network identity.

### SSRF variants

| Variant | What happens | How you spot it |
|---|---|---|
| **In-band (basic) SSRF** | Server fetches URL and returns response body to the attacker | Easy — diff response sizes, look for internal content in HTTP responses |
| **Blind SSRF** | Server fetches but doesn't return the body | Hard — measure timing, use DNS exfil (`attacker.com` collaborator), check side channels |
| **Semi-blind** | Status code or headers leak back, body doesn't | Look for HTTP status diffs (200 vs 500 vs timeout) telling you what exists |

### Common targets

- **Cloud metadata endpoints.** AWS IMDSv1 at `169.254.169.254`, GCP at `metadata.google.internal`, Azure at `169.254.169.254/metadata/instance`. Pre-IMDSv2, a single GET returns IAM credentials. This is the prize.
- **Internal services.** Databases, message queues, admin panels, internal APIs sitting on RFC1918 space (`10/8`, `172.16/12`, `192.168/16`) that trust internal callers implicitly.
- **Management interfaces.** Kubernetes API server, Docker socket, Consul, etcd, Jenkins — anything bound to localhost or internal network with weak auth because "only internal traffic reaches it."
- **Loopback services.** `127.0.0.1:<port>` scanning to map what's running on the server itself.
- **Non-HTTP protocols.** `file://`, `gopher://`, `dict://`, `ftp://` — gopher is the nasty one because it lets you craft arbitrary TCP payloads (Redis, memcached, SMTP relay).

### What an attacker chains SSRF into

- **Credential theft** → cloud account takeover (the Capital One play)
- **Internal port scanning** → asset discovery from outside the firewall
- **[[Remote code execution]]** via internal services that trust the network (unauthenticated Redis, Jenkins script console)
- **[[Local file inclusion]] (LFI)** via `file://` to read `/etc/passwd`, `.env`, private keys
- **Bypassing IP allowlists** because the request now originates from a trusted server
- **[[Cross-site request forgery]]** against internal admin panels that only check origin IP

### Defenses (this is what 2.4 wants you to recommend)

**Network layer — the load-bearing control:**
- **Egress filtering.** The vulnerable server should not be able to reach `169.254.169.254`, RFC1918 ranges it doesn't need, or arbitrary internet hosts. Default-deny outbound, allowlist what's required.
- **Network segmentation.** The web tier doesn't need a route to the database management port. Separate VPCs/subnets, security groups that enforce least-privilege at the network layer.
- **IMDSv2 (AWS).** Session-token-based, requires `PUT` first to get a token. SSRF that only does `GET` can't reach it. Mandate IMDSv2; disable IMDSv1.

**Application layer:**
- **URL allowlist, not denylist.** Validate the destination against a known list of allowed hosts. Denylists (`block 169.254.x.x`) lose to DNS rebinding, decimal IP encoding (`http://2852039166/`), IPv6 mapping (`[::ffff:169.254.169.254]`), redirects, and `0.0.0.0`.
- **Resolve DNS once, then validate, then connect to the resolved IP.** Prevents DNS rebinding where the hostname resolves to a safe IP during validation and a malicious IP on the actual fetch.
- **Disable unused URL schemes.** If you only need HTTPS, block `file://`, `gopher://`, `dict://`, `ftp://`.
- **Don't return raw responses.** If the feature only needs metadata (e.g., link preview pulling a title), parse and return only what's needed. Don't proxy the whole body.

**Identity layer:**
- **Least-privilege IAM roles.** If SSRF does steal credentials, the credentials should be useless. The web server's role shouldn't have `s3:*` on the customer-data bucket.

### CompTIA exam traps

> **CompTIA exam trap:** SSRF vs [[Cross-site request forgery]] (CSRF). Both have "request forgery" in the name. CSRF is **client-side** — the victim's browser is tricked into making a request to a site they're authenticated to. SSRF is **server-side** — the victim is the server itself, tricked into making a request on the attacker's behalf. Different attack, different defense (CSRF tokens won't stop SSRF; egress filtering won't stop CSRF).

> **CompTIA exam trap:** The mitigation question almost always has "input validation" as a tempting answer. Input validation alone is not the strongest SSRF control — **network segmentation and egress filtering** are. CompTIA wants defense in depth, but if forced to pick one, the network control survives the bypass. Denylists get bypassed by encoding tricks; segmentation doesn't.

> **CompTIA exam trap:** SSRF is sometimes confused with [[Directory traversal]] when the payload uses `file://`. Traversal is `../../../etc/passwd` against a file-handling parameter on the server's own filesystem. SSRF with `file://` is the server making a URL request that happens to dereference a local file. The distinction matters because the controls differ — traversal wants path canonicalization, SSRF wants scheme restriction.

### CVSS shape

SSRF rarely scores low. Typical base vector for an internet-facing SSRF reaching cloud metadata: **AV:N / AC:L / PR:N / UI:N / S:C / C:H / I:H / A:N → CVSS 9.3-ish**. Scope change (S:C) is the kicker — the impact crosses a trust boundary, from the web app into the cloud control plane. Argue scope change at the change board when prioritizing the fix.

## SOC reality

- The alert that catches SSRF in production is rarely labeled "SSRF." It's a **WAF rule firing on `169.254.169.254` in a URL parameter**, or a **netflow anomaly showing the web tier suddenly talking to an internal subnet it's never talked to before**, or **IAM CloudTrail logs showing the web server's role being assumed from an unfamiliar IP**. You back into the SSRF diagnosis from the network or identity side.
- L1 triage: confirm the source (was the request crafted externally or by a legitimate feature?), pull the full request, check whether the response left the perimeter. If credentials are involved, the playbook escalates immediately — this is a credential-theft incident, not a web-app incident.
- What the IR lead asks at 3am: *"Did the server actually fetch the metadata URL, or did the WAF block it before the request went out? Show me the egress log."* The WAF inbound log isn't enough — you need proof the server didn't make the outbound call. If it did, rotate every credential that role had.
- Never promise "we patched it" until you've also rotated the IAM credentials. The patch closes the door; the credentials are already walking around outside.
- Handoff: L1 confirms scope and pulls evidence → L2/AppSec validates the vulnerable parameter and writes the WAF rule → IR rotates credentials and reviews CloudTrail for misuse → engineering ships the code fix → post-incident reviews IMDS version and egress policy across the fleet, not just the one app.

## Related concepts

[[Cross-site request forgery]] · [[Cross-site scripting]] · [[Injection flaws]] · [[Remote code execution]] · [[Directory traversal]] · [[Local file inclusion]] · [[Security misconfiguration]] · [[Insecure design]] · [[Broken access control]] · [[Cloud metadata service]] · [[IAM least privilege]] · [[Network segmentation]] · [[Egress filtering]] · [[OWASP Top 10]] · [[WAF]] · [[CVSS]]

*Source: VIRGIL knowledge base — 2026-05-11*