# HTTP request smuggling

## What it is
Imagine two postal workers sorting the same package using different rulebooks — one counts by weight, the other by label — so they disagree on where one package ends and the next begins. HTTP request smuggling exploits disagreements between a front-end proxy (like a load balancer) and a back-end server over how to parse HTTP/1.1 request boundaries, specifically via conflicting `Content-Length` and `Transfer-Encoding: chunked` headers. An attacker crafts an ambiguous request that the front-end treats as one request but the back-end splits into two, "smuggling" a hidden second request into the pipeline.

## Why it matters
In 2019, researchers demonstrated HTTP request smuggling against major platforms including Netflix and Airbnb, achieving cache poisoning, credential hijacking, and access to other users' requests. A single malformed request could prepend attacker-controlled data to a legitimate victim's subsequent request, effectively stealing their session tokens or redirecting their traffic — all without the victim doing anything wrong.

## Key facts
- **CL.TE attack**: Front-end trusts `Content-Length`, back-end trusts `Transfer-Encoding` — attacker uses both to inject a hidden prefix into the next request.
- **TE.CL attack**: Reverse scenario — front-end trusts `Transfer-Encoding`, back-end trusts `Content-Length`.
- **Root cause**: HTTP/1.1 spec technically forbids both headers simultaneously, but ambiguous server implementations ignore this.
- **Impact categories**: cache poisoning, session hijacking, WAF/security control bypass, reflected XSS amplification, and SSRF escalation.
- **Mitigation**: Normalize requests at the edge (reject ambiguous messages), prefer HTTP/2 end-to-end (which eliminates the ambiguity), and disable back-end connection reuse.

## Related concepts
[[Content-Length Header]] [[Transfer-Encoding Chunked]] [[Desync Attacks]] [[HTTP Pipeline Attacks]] [[WAF Bypass Techniques]] [[Cache Poisoning]]