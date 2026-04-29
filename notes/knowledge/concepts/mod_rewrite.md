# mod_rewrite

## What it is
Think of it as a traffic cop standing at the entrance of a highway, redirecting cars based on license plate patterns before they ever reach their destination. mod_rewrite is an Apache HTTP Server module that uses rule-based regex matching to rewrite incoming URLs on the fly — transparently transforming what a client requests into what the server actually processes.

## Why it matters
Attackers exploit misconfigured mod_rewrite rules to bypass authentication or access controls — for example, a poorly written RewriteRule might allow path traversal sequences like `../` to slip through, enabling directory traversal attacks or exposing restricted content. Defensively, security teams use mod_rewrite to enforce HTTPS redirects, block requests containing known malicious patterns (SQLi strings, null bytes), and canonicalize URLs to prevent cache poisoning.

## Key facts
- mod_rewrite operates via `.htaccess` files or the main Apache config (`httpd.conf`), with `.htaccess` being the higher-risk location because it can be modified per-directory without server restarts
- The `RewriteRule` directive uses PCRE (Perl-Compatible Regular Expressions); overly permissive patterns (e.g., `.*`) can create open redirect vulnerabilities
- Open redirects via mod_rewrite are a common phishing vector — a trusted domain's URL silently redirects victims to a malicious site
- The flag `[R=301]` creates a permanent redirect; misconfigured flags can expose internal server paths or bypass WAF rules
- Disabling mod_rewrite's `AllowOverride` in production limits attack surface by preventing `.htaccess` override abuse

## Related concepts
[[Directory Traversal]] [[Open Redirect]] [[Web Application Firewall]] [[htaccess Security]] [[URL Canonicalization]]