# URL filter

## What it is
Think of it as a bouncer at a club working from a list — some URLs are on the VIP list (allowed), some are on the banned list (blocked), and everything else gets checked against the policy. A URL filter is a security control that inspects and restricts web traffic based on the destination address, blocking access to URLs that match categories, blocklists, or policy rules. It operates at the application layer, typically within a proxy, next-gen firewall, or secure web gateway.

## Why it matters
During a phishing campaign, an attacker sends employees a link to `secure-login.totallynotmalicious.com` hosting a credential harvesting page. A URL filter with category-based blocking would flag the newly registered domain under "suspicious/uncategorized" and block the request before the browser ever loads the page — stopping credential theft without requiring the user to recognize the threat themselves.

## Key facts
- URL filters can operate via **blocklists** (deny known-bad), **allowlists** (permit only approved), or **category-based filtering** (block gambling, malware, adult content, etc.)
- They differ from IP blocking — a single domain can resolve to many IPs, while a single IP can host thousands of domains; URL filtering targets the application-layer identifier
- **DNS-based filtering** (e.g., Cisco Umbrella) blocks at resolution time; **proxy-based filtering** inspects full URLs including paths and query strings
- Bypasses include using IP addresses directly, DNS-over-HTTPS (DoH) tunneling, or URL shorteners — all relevant threat vectors on CySA+ exams
- URL filtering is a control mapped to **NIST SP 800-53 SC-7 (Boundary Protection)** and commonly appears in Zero Trust architectures as part of secure web gateway (SWG) solutions

## Related concepts
[[Proxy Server]] [[DNS Filtering]] [[Web Application Firewall]] [[Content Filtering]] [[Secure Web Gateway]]