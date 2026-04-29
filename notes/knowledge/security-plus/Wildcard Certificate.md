# Wildcard Certificate

## What it is
Like a master key that opens every room on a floor rather than one specific room, a wildcard certificate is a single TLS/SSL certificate that secures an entire domain level using an asterisk (*) as a placeholder. Issued for a pattern like `*.example.com`, it authenticates any single subdomain — `mail.example.com`, `shop.example.com` — under that parent domain without requiring individual certificates for each.

## Why it matters
In 2017, attackers who compromised a single server holding a wildcard certificate for a major organization were able to perform man-in-the-middle attacks across *all* subdomains simultaneously — one private key breach, entire domain surface exposed. This is the core wildcard tradeoff: operational convenience versus a dramatically amplified blast radius if the private key is stolen or the certificate is misused.

## Key facts
- The asterisk matches **only one level** of subdomain — `*.example.com` does NOT cover `sub.sub.example.com`
- A single compromised wildcard private key invalidates the security of every subdomain using that certificate
- Wildcard certificates **cannot** be issued for the top-level domain itself (e.g., `*.com` is forbidden by CA/Browser Forum rules)
- Certificate Transparency (CT) logs make wildcard certs visible to attackers performing reconnaissance — they reveal the domain structure
- From a Security+ perspective, wildcard certificates fall under **certificate management risk** and are relevant to topics of **key compromise** and **improper certificate use**
- Wildcard certs are typically **Domain Validated (DV)** or **Organization Validated (OV)** — Extended Validation (EV) wildcards are not permitted

## Related concepts
[[Public Key Infrastructure]] [[Certificate Authority]] [[TLS Handshake]] [[Certificate Transparency]] [[Man-in-the-Middle Attack]]