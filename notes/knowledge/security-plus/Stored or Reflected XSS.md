# Stored or Reflected XSS

## What it is
Think of a bulletin board where someone pins a fake "Emergency Exit" sign that redirects everyone who reads it — versus a prankster who hands you a flyer that only tricks *you* when you read it. Stored XSS permanently injects malicious script into a server-side database (affecting every user who loads that page), while Reflected XSS embeds the payload in a crafted URL that executes only when the victim clicks it and the server echoes it back unsanitized.

## Why it matters
In 2018, British Airways suffered a Stored XSS-style attack where malicious JavaScript was injected into their payment page, silently skimming credit card data from ~500,000 customers in real time. A single unvalidated input field became the entry point for mass credential harvesting — illustrating why output encoding is non-negotiable.

## Key facts
- **Stored XSS** persists in databases, comment fields, or logs — payload fires automatically for every victim who views the content; higher severity rating.
- **Reflected XSS** requires social engineering to deliver a malicious link; payload is not stored and only executes once per victim click.
- Both attack types execute in the **victim's browser**, allowing session cookie theft, keylogging, or DOM manipulation under the victim's trusted origin.
- Primary defense: **output encoding** (e.g., HTML entity encoding `<` → `&lt;`) and **Content Security Policy (CSP)** headers to block inline script execution.
- The `HttpOnly` cookie flag prevents JavaScript from reading session cookies, limiting the damage of a successful XSS exploit.
- On Security+/CySA+: XSS is classified as an **injection attack** targeting the **client side**, distinct from SQLi which targets the server/database.

## Related concepts
[[Cross-Site Request Forgery (CSRF)]] [[Content Security Policy (CSP)]] [[Input Validation and Output Encoding]]