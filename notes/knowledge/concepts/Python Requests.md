# Python Requests

## What it is
Think of it as a postal service you can program: you hand it an address and a message, it handles the envelope, stamps, routing, and brings back the reply. Python Requests is a third-party HTTP library that abstracts away raw socket connections, letting you send GET, POST, PUT, DELETE, and other HTTP methods with clean, readable Python code.

## Why it matters
Penetration testers and red teamers use Requests to automate credential stuffing attacks — scripting thousands of login attempts against a web application far faster than any manual approach. Defenders encounter it on the other side when analyzing malware samples, since C2 (command-and-control) implants frequently use Requests to beacon out to attacker infrastructure, exfiltrate data, or receive tasking over standard HTTP/S to blend with legitimate traffic.

## Key facts
- `requests.get(url, headers={}, params={})` and `requests.post(url, data={}, json={})` are the two workhorses; understanding the difference between `data=` (form-encoded) and `json=` (JSON body) matters for correctly crafting exploit payloads
- SSL verification is enabled by default (`verify=True`); attackers commonly set `verify=False` in scripts to intercept traffic through a proxy like Burp Suite without certificate errors
- Sessions (`requests.Session()`) persist cookies and headers across multiple requests — critical for maintaining authenticated state during web app testing
- The `proxies` parameter routes traffic through an intercepting proxy: `proxies={"http": "http://127.0.0.1:8080"}` is the standard Burp Suite integration pattern
- Response objects expose `.status_code`, `.text`, `.json()`, and `.headers` — used in automated scripts to detect successful injections, authentication bypass, or error-based information disclosure

## Related concepts
[[HTTP Methods]] [[Credential Stuffing]] [[Command and Control (C2)]] [[Burp Suite]] [[Web Application Enumeration]]