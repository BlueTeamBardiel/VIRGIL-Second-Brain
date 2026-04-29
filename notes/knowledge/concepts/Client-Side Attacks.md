# Client-Side Attacks

## What it is
Like slipping poison into a restaurant's bread basket instead of attacking the kitchen, client-side attacks target the *user's machine* rather than the server. Precisely: they exploit vulnerabilities in software running on the victim's endpoint — browsers, PDF readers, Office applications — to execute malicious code when a user opens or visits attacker-controlled content.

## Why it matters
In Operation Aurora (2010), attackers compromised Google and 30+ other companies by serving a malicious webpage that exploited an Internet Explorer zero-day — employees simply browsed to a link. No firewall rule stopped it because the attack rode legitimate outbound HTTP traffic initiated by the victim's own browser.

## Key facts
- **Drive-by downloads** deliver malware automatically when a user visits a compromised or malicious site, requiring zero clicks beyond navigation
- **Spear phishing with malicious attachments** (e.g., macro-enabled .docx files) is the most common client-side initial access vector in enterprise breaches
- Client-side attacks frequently chain with **privilege escalation** — initial code runs as the user, then exploits a local vulnerability to gain SYSTEM/root
- **Browser exploitation frameworks (BeEF)** hook vulnerable browsers in real-time, allowing attackers to pivot through the victim's authenticated sessions
- Defenses include **application whitelisting**, disabling macros by default, browser sandboxing, and keeping client software patched — patch Tuesday exists largely because of these threats

## Related concepts
[[Drive-By Downloads]] [[Spear Phishing]] [[Cross-Site Scripting (XSS)]] [[Exploit Kits]] [[Social Engineering]]