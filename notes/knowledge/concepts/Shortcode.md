# shortcode

## What it is
Like a vending machine button that triggers a complex dispensing sequence behind the panel, a shortcode is a small placeholder tag (e.g., `[gallery id="5"]`) that a CMS or web platform expands into full HTML or server-side functionality at render time. In WordPress and similar platforms, shortcodes are macro-like tokens processed by registered handler functions before page output is sent to the browser.

## Why it matters
Shortcode vulnerabilities have repeatedly enabled stored Cross-Site Scripting (XSS) and privilege escalation in WordPress plugins. In CVE-2022-21661 (WordPress core), improper sanitization of shortcode attributes allowed attackers to inject malicious SQL via the `[wp_query]` shortcode, leading to SQL injection even for low-privileged users — demonstrating that shortcode parsers are an underappreciated attack surface on millions of sites.

## Key facts
- Shortcodes that accept user-supplied attributes without proper sanitization/escaping are a direct path to **Stored XSS** or **SQL Injection**
- WordPress's `do_shortcode()` function processes nested shortcodes, meaning a bypass in an outer tag can expose vulnerable inner handlers
- **Subscriber-level shortcode execution** is a common misconfiguration — low-privilege users triggering privileged functionality (broken access control)
- Shortcode handlers registered with `add_shortcode()` should always use `esc_html()`, `esc_attr()`, and `$wpdb->prepare()` on attribute inputs
- Penetration testers enumerate active shortcodes by probing post content and checking plugin source for `add_shortcode()` registrations — part of CMS-specific attack surface mapping

## Related concepts
[[Cross-Site Scripting (XSS)]] [[SQL Injection]] [[CMS Security]] [[Input Validation]] [[Privilege Escalation]]