# request smuggling

## What it is
Imagine two border agents — one reads "STOP after the red line," another reads "STOP after the blue line" — so a smuggler hides contraband in the gap between their interpretations. HTTP request smuggling exploits disagreements between a front-end proxy (like a load balancer) and a back-end server about where one HTTP request ends and the next begins. Attackers craft ambiguous `Content-Length` and `Transfer-Encoding` headers to inject a partial request that gets prepended to the *next legitimate user's* request.

## Why it matters
In 2019, researcher James Kettle demonstrated request smuggling against major platforms like Netflix and Akamai, achieving cache poisoning, credential hijacking, and full request capture of other users' traffic — all without any credentials. A single malformed request could steal session tokens from subsequent users hitting the same back-end server, making it a high-impact vulnerability in modern multi-tier architectures.

## Key facts
- The two attack variants are **CL.TE** (front-end uses `Content-Length`, back-end uses `Transfer-Encoding`) and **TE.CL** (reversed roles)
- Smuggled requests exploit the HTTP/1.1 `Transfer-Encoding: chunked` directive, which some servers silently ignore or misparse
- Can lead to **cache poisoning**, **bypass of WAF/access controls**, **session hijacking**, and **reflected XSS** against other users
- Mitigations include: normalizing ambiguous requests at the reverse proxy, disabling `Transfer-Encoding` on back-end connections, or upgrading to **HTTP/2** end-to-end (which eliminates the ambiguity)
- Listed in **OWASP Top 10 (A10 – Server-Side Request Forgery / Security Misconfiguration** adjacent) and a key topic in web application penetration testing

## Related concepts
[[HTTP header injection]] [[cache poisoning]] [[proxy misconfigurations]] [[SSRF]] [[desync attacks]]