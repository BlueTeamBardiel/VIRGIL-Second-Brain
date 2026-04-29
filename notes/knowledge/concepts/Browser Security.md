# Browser Security

## What it is
Think of your browser as a postal clerk who opens letters from strangers and executes whatever instructions are inside — browser security is the set of rules that stops those letters from stealing your wallet. Precisely, browser security encompasses the policies, mechanisms, and configurations that isolate web content, authenticate sites, and prevent malicious code from accessing system resources or other origins.

## Why it matters
In 2021, attackers exploited a Chrome zero-day (CVE-2021-21166) in the Web Audio API to escape the browser sandbox entirely, gaining code execution on victims' machines simply by luring them to a malicious page. This illustrates why sandbox integrity and rapid patching are non-negotiable — the browser is the single most-attacked application surface for end users.

## Key facts
- **Same-Origin Policy (SOP)** prevents scripts on `attacker.com` from reading responses from `bank.com` — it's the foundational browser isolation mechanism
- **Content Security Policy (CSP)** is an HTTP response header that whitelists allowed script sources, directly mitigating Cross-Site Scripting (XSS) attacks
- **HSTS (HTTP Strict Transport Security)** forces browsers to only connect via HTTPS for a declared period, defeating SSL stripping attacks
- **Browser sandboxing** isolates renderer processes from the OS; a sandbox escape is a critical vulnerability class that chains to full system compromise
- **Certificate Transparency (CT)** requires CAs to log all issued TLS certificates publicly, allowing detection of misissued certs used in MITM attacks

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Same-Origin Policy]] [[TLS/SSL]] [[Content Security Policy]] [[Sandbox Escape]]