# BeEF

## What it is
Think of BeEF as a remote control that hijacks a browser the moment a victim visits a booby-trapped webpage — the attacker's console suddenly sees a live "hooked" session they can command. BeEF (Browser Exploitation Framework) is an open-source penetration testing tool that focuses exclusively on web browser vulnerabilities, allowing an attacker to execute JavaScript-based commands on a victim's browser via a persistent hook.

## Why it matters
During a red team engagement, a tester embeds a single line of BeEF's hook.js into a reflected XSS payload on a vulnerable internal web app. Once an employee visits the page, the tester gains persistent control of that browser session — able to steal cookies, capture keystrokes, redirect the user to phishing pages, and enumerate the internal network, all without ever touching the operating system directly.

## Key facts
- BeEF operates by injecting a small JavaScript file (`hook.js`) into a target browser, which phones home to the BeEF Command & Control (C2) server via continuous HTTP polling
- It exploits the **same-origin policy boundary** within the browser, making it a client-side attack vector rather than a server-side one
- BeEF integrates with **Metasploit**, allowing browser hooks to pivot into full OS-level exploitation if a matching browser exploit exists
- Common modules include: clipboard theft, webcam access (with user-permission bypass tricks), network discovery via browser-side port scanning, and social engineering popups
- BeEF attacks are heavily associated with **Cross-Site Scripting (XSS)** — XSS is the delivery mechanism; BeEF is the post-exploitation framework that rides on it

## Related concepts
[[Cross-Site Scripting (XSS)]] [[Metasploit]] [[Command and Control (C2)]] [[Session Hijacking]] [[Client-Side Attacks]]