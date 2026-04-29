# Cross-Site Scripting Prevention

## What it is
Like a nightclub bouncer who checks every person entering and strips them of weapons before they get inside, XSS prevention intercepts untrusted user input and neutralizes any embedded scripts before the browser can execute them. Cross-Site Scripting (XSS) occurs when an attacker injects malicious client-side scripts into web pages viewed by other users, exploiting the browser's trust in content served from a legitimate site.

## Why it matters
In 2018, British Airways suffered a Magecart attack where attackers injected 22 lines of JavaScript into a payment page, silently harvesting credit card data from ~500,000 customers in real time. A properly implemented Content Security Policy (CSP) and rigorous output encoding would have prevented the injected script from executing or phoning home to the attacker's server.

## Key facts
- **Output encoding** is the primary defense — convert characters like `<`, `>`, and `"` into their HTML entities (`&lt;`, `&gt;`, `&quot;`) so the browser renders them as text, not code
- **Stored XSS** persists in the database and attacks every user who loads the page; **Reflected XSS** is delivered via a crafted URL and hits one victim at a time; **DOM-based XSS** never touches the server
- **Content Security Policy (CSP)** headers instruct the browser to only execute scripts from whitelisted sources, containing damage even if injection occurs
- **HttpOnly cookie flag** prevents JavaScript from reading session cookies, limiting the damage of a successful XSS attack even when prevention fails
- Input validation alone is insufficient — context-aware output encoding (HTML, JavaScript, CSS, URL contexts) is required because the same character is dangerous in different ways depending on placement

## Related concepts
[[Input Validation]] [[Content Security Policy]] [[SQL Injection Prevention]] [[Session Hijacking]] [[OWASP Top Ten]]