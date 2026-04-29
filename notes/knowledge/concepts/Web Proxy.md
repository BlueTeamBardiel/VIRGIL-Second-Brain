# Web Proxy

## What it is
Like a translator standing between two diplomats who can't speak directly, a web proxy is a server that sits between a client and the internet — intercepting, forwarding, and optionally modifying HTTP/HTTPS traffic on behalf of the client. Requests go to the proxy first; the proxy fetches the content and returns it, masking the client's true IP from the destination.

## Why it matters
Security teams deploy **forward proxies** (like Squid or Zscaler) to inspect outbound employee traffic and block malicious URLs — stopping a phishing victim from actually reaching the attacker's C2 server even after clicking the link. Conversely, attackers use **intercepting proxies** like Burp Suite to capture and manipulate HTTP requests in transit, enabling them to discover hidden API parameters, bypass client-side validation, and exploit IDOR vulnerabilities by modifying order IDs in request bodies.

## Key facts
- A **forward proxy** acts on behalf of clients (hides client identity); a **reverse proxy** acts on behalf of servers (hides server identity and load-balances traffic)
- **Transparent proxies** intercept traffic without client configuration — users may not know they exist; **non-transparent proxies** require explicit client-side settings
- Burp Suite operates as an intercepting (man-in-the-middle) proxy by installing a custom CA certificate to decrypt HTTPS traffic — this is why certificate pinning defeats it
- **SSL/TLS inspection** (SSL bumping) on corporate proxies breaks end-to-end encryption; clients must trust the proxy's certificate for this to work silently
- Web proxies are a common method of **egress filtering bypass** — attackers tunnel malicious traffic over port 443 knowing most proxies allow outbound HTTPS

## Related concepts
[[Man-in-the-Middle Attack]] [[TLS Inspection]] [[Burp Suite]] [[Reverse Proxy]] [[URL Filtering]]