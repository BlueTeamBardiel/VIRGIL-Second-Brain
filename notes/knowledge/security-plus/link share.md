# link share

## What it is
Like handing someone a spare key to your apartment instead of adding them to the lease — link sharing grants access to a resource via a URL without requiring formal authentication or account creation. Precisely, link sharing is a mechanism where a unique, often randomized URL grants access to a file, folder, or resource to anyone who possesses that link, bypassing traditional access control lists (ACLs).

## Why it matters
In 2021, researchers discovered that thousands of sensitive documents — medical records, legal filings, financial reports — stored in Google Drive and OneDrive were exposed via "anyone with the link" sharing settings, indexed by search engines or leaked through browser history and referrer headers. An attacker who intercepts or guesses a shared link (especially a weak or predictable one) gains full access without ever authenticating, making link sharing a persistent data exfiltration risk in cloud environments.

## Key facts
- **Confused Deputy Problem**: The server acts as a deputy granting access based solely on link possession, not identity — there is no way to revoke access for a specific individual without rotating the entire link.
- **Referrer Header Leakage**: Shared links embedded in web pages can leak to third-party sites via HTTP Referer headers, silently exposing sensitive resources.
- **Broken Access Control (OWASP A01:2021)**: Misconfigured link sharing is a primary real-world example of broken access control, a top OWASP vulnerability category.
- **Token Entropy Matters**: Secure implementations use 128+ bit random tokens; weak or sequential tokens are vulnerable to enumeration attacks.
- **Audit Logging Gap**: Link-based access often bypasses identity-aware audit logs, leaving no record of *who* accessed a resource — only *that* it was accessed.

## Related concepts
[[Broken Access Control]] [[Cloud Storage Security]] [[Access Control Lists]] [[Insecure Direct Object Reference]] [[Data Loss Prevention]]