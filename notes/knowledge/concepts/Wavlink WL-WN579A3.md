# Wavlink WL-WN579A3

## What it is
Like a deadbolt with the key permanently glued in the lock, this device ships with hardcoded credentials and unauthenticated endpoints baked into its firmware. The Wavlink WL-WN579A3 is a consumer-grade outdoor Wi-Fi range extender/access point that gained infamy for critical unpatched vulnerabilities in its web management interface, including command injection and credential exposure flaws catalogued around 2020-2021.

## Why it matters
Attackers targeting SOHO networks can exploit the device's unauthenticated `set_safety.cgi` and similar endpoints to execute arbitrary OS commands as root without any login — effectively owning the network gateway remotely. This class of device was actively targeted for botnet recruitment (Mirai variants), turning home routers into DDoS launchpads against enterprise infrastructure.

## Key facts
- **CVE-2020-10971 and related CVEs**: Command injection vulnerabilities in the Wavlink web interface allow unauthenticated remote code execution (RCE) via crafted HTTP POST requests.
- **Hardcoded credentials**: Default admin credentials are embedded in firmware and rarely changed by consumers, violating the principle of least privilege.
- **Unauthenticated CGI endpoints**: Several management scripts (`login.cgi`, `set_safety.cgi`) can be accessed without authentication, bypassing the entire login control.
- **No vendor patch released**: Wavlink did not issue firmware fixes, making this a permanent unmitigated risk — a textbook case for EOL/unsupported device policy.
- **Relevant to CySA+/Security+**: Illustrates IoT/SOHO attack surface, improper input validation (OWASP), and the importance of network segmentation for embedded devices.

## Related concepts
[[Command Injection]] [[Hardcoded Credentials]] [[CVE (Common Vulnerabilities and Exposures)]] [[IoT Security]] [[Network Segmentation]]