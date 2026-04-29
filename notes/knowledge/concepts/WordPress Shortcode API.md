# WordPress Shortcode API

## What it is
Think of shortcodes like vending machine buttons — a user presses `[gallery]` and WordPress internally executes a registered PHP function to deliver the output. Precisely, the Shortcode API is a WordPress mechanism that maps bracketed tags (e.g., `[shortcode attr="value"]`) to PHP callback functions, allowing dynamic content rendering inside posts, pages, and widgets.

## Why it matters
Shortcodes become an attack surface when plugins register callbacks without properly sanitizing attributes or escaping output — a classic vector for **Stored XSS**. An attacker with Contributor-level access might submit `[vulnerable_shortcode onclick="alert(document.cookie)"]`, which gets executed for every Administrator who views the post, potentially enabling session hijacking or full site takeover.

## Key facts
- Shortcode attributes are passed as raw strings to PHP callbacks; **no sanitization occurs by default** — the developer must call `sanitize_text_field()` or equivalent manually.
- **Output escaping** must happen at render time using `esc_html()`, `esc_attr()`, or `wp_kses_post()`; omitting this causes reflected or stored XSS.
- Shortcodes can be **executed in unexpected contexts** — widgets, theme customizer fields, and REST API responses may all process shortcode content via `do_shortcode()`.
- The `[embed]` shortcode in particular has historically been abused for **Server-Side Request Forgery (SSRF)** by embedding URLs pointing to internal network resources.
- Malicious plugins can **register shortcodes that execute arbitrary PHP** (via `eval()` wrappers), making plugin vetting critical for WordPress hardening.

## Related concepts
[[Stored Cross-Site Scripting]] [[Server-Side Request Forgery]] [[WordPress Plugin Security]]