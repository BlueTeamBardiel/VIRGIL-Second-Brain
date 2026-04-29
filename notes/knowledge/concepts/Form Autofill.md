# Form Autofill

## What it is
Like a helpful secretary who memorizes your business card and fills out every visitor log automatically — browsers and password managers store previously entered field data (names, addresses, credit cards, credentials) and inject it into matching form fields without requiring re-entry. Autofill is a browser or application feature that populates HTML form fields based on stored user profile data, triggered by field name attributes like `name="email"` or `autocomplete="cc-number"`.

## Why it matters
Attackers embed hidden, off-screen form fields on malicious web pages with legitimate-sounding `autocomplete` attribute values (e.g., `autocomplete="cc-number"`). When a victim visits the page and triggers autofill — sometimes without clicking anything — the browser silently populates those invisible fields, which JavaScript then exfiltrates to an attacker-controlled server. This technique, called **autofill phishing**, has been demonstrated against Chrome and Safari to harvest credit card numbers and addresses without any visible user interaction.

## Key facts
- Browsers honor the `autocomplete` HTML attribute; setting `autocomplete="off"` on sensitive fields is a defensive best practice, though some browsers ignore it.
- Autofill data is typically stored in the browser profile directory (e.g., `Login Data` SQLite file in Chrome) — local access to this file enables credential theft without needing the master password.
- Password managers with autofill (e.g., LastPass, 1Password) can be tricked via **credential stuffing preparation** if they autofill on lookalike domains (e.g., `paypa1.com` vs `paypal.com`).
- The `SameSite` cookie attribute and Content Security Policy do **not** prevent autofill abuse — it requires explicit field-level controls or user awareness.
- NIST SP 800-63B recommends allowing paste and autofill on password fields to encourage use of password managers rather than weak, memorable passwords.

## Related concepts
[[Credential Stuffing]] [[Phishing]] [[Password Manager Security]] [[Browser Storage Security]] [[Cross-Site Scripting (XSS)]]