# login page

## What it is
Like the front door of a bank vault — it looks simple, but it's the single choke point where every identity claim gets verified before access is granted. A login page is a web interface that collects credentials (typically username and password) and submits them to an authentication system to establish a session. It is the primary attack surface for credential-based attacks against web applications.

## Why it matters
In the 2012 LinkedIn breach, attackers who obtained hashed passwords used them in credential stuffing attacks against login pages across multiple sites — exploiting password reuse to compromise millions of accounts without ever "hacking" the application itself. A properly hardened login page with account lockout, MFA, and rate limiting would have dramatically reduced the blast radius. This illustrates why login pages are both a critical defense layer and a high-value target.

## Key facts
- **Brute force and credential stuffing** are the primary attacks; mitigated by account lockout policies, CAPTCHA, and rate limiting
- **Username enumeration** occurs when different error messages are returned for invalid username vs. invalid password — always return a generic message like "Invalid credentials"
- **Multi-factor authentication (MFA)** at the login page is one of the highest-impact single security controls an organization can implement
- **HTTPS is mandatory** — submitting credentials over HTTP exposes them to network-level interception (man-in-the-middle attacks)
- **Login page anomalies** (unusual geolocations, impossible travel, high failure rates) are key indicators monitored in SIEM/UBA tools for insider threat and account compromise detection

## Related concepts
[[credential stuffing]] [[brute force attack]] [[multi-factor authentication]] [[session management]] [[account lockout policy]]