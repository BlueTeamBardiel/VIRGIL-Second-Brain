# FuelCMS

## What it is
Like a WordPress installation left running on a forgotten server with the admin panel facing the internet, FuelCMS is a lightweight PHP-based Content Management System built on the CodeIgniter framework. It is notable in security contexts primarily because of CVE-2018-16763, a critical Remote Code Execution vulnerability in versions 1.4.1 and earlier that allows unauthenticated attackers to execute arbitrary OS commands through the `fuel/pages/select` endpoint.

## Why it matters
FuelCMS appears constantly in CTF challenges and penetration testing labs (notably TryHackMe and HackTheBox) as a beginner RCE exercise. An attacker can send a crafted GET request with a malicious `filter` parameter — containing PHP code — directly to the web server and receive command output back, achieving full system compromise without any credentials whatsoever.

## Key facts
- **CVE-2018-16763** affects FuelCMS ≤ 1.4.1; CVSS score of 9.8 (Critical) — unauthenticated RCE via the `pages/select` endpoint
- The vulnerability exists because user-supplied input is passed directly to PHP's `eval()` function without sanitization — a classic code injection flaw
- Exploitation is trivially simple: a single crafted GET request like `?filter=1+%7C%7C+php+system('id')` can return OS command output
- Public exploit scripts exist on Exploit-DB (exploit #47138), making this a common script-kiddie and exam scenario
- Remediation requires updating to a patched version; the root cause is improper input validation and unsafe use of `eval()`

## Related concepts
[[Remote Code Execution]] [[Command Injection]] [[CVE Scoring System]]