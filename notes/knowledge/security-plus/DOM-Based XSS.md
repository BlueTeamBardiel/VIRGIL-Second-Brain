# DOM-Based XSS

## What it is
Like a forger who sneaks counterfeit bills into a cash register *after* the bank already approved the transaction, DOM-Based XSS injects malicious scripts into a page entirely on the client side — the server never sees the attack and therefore can't log or block it. It occurs when JavaScript reads attacker-controlled data (like `window.location.hash` or `document.URL`) and writes it unsafely into the DOM using sinks like `innerHTML` or `eval()`, executing arbitrary code in the victim's browser.

## Why it matters
In 2014, researchers discovered that high-traffic sites using URL fragment identifiers (`#`) to drive client-side routing were vulnerable: an attacker could craft a link like `https://bank.com/#<img src=x onerror=stealCookies()>` and share it via phishing. Because the fragment never reaches the server, WAFs and server-side logs showed zero evidence of the attack while session tokens were silently exfiltrated.

## Key facts
- **Source → Sink model**: Dangerous data flows from a *source* (e.g., `location.hash`, `document.referrer`) to a *sink* (e.g., `innerHTML`, `document.write()`, `eval()`) — understanding this chain is essential for identifying DOM XSS.
- Unlike Reflected or Stored XSS, the malicious payload **never touches the server**, making server-side defenses (input validation, WAFs) largely ineffective.
- The primary defense is **using safe DOM APIs**: `textContent` instead of `innerHTML`, and avoiding `eval()` with untrusted data.
- **Content Security Policy (CSP)** can mitigate DOM XSS by restricting inline script execution, but improper configuration (`unsafe-inline`) nullifies this protection.
- DOM XSS is classified under **CWE-79** (Improper Neutralization of Input During Web Page Generation) and is consistently listed in the OWASP Top 10 under Injection.

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Content Security Policy]] [[Reflected XSS]] [[JavaScript Sinks and Sources]] [[OWASP Top 10]]