# Nikto

## What it is
Like a health inspector who memorizes every known restaurant violation and checks each one systematically, Nikto is an open-source web server scanner that probes servers against a database of thousands of known vulnerabilities, misconfigurations, and outdated software. It automates the tedious task of checking for dangerous defaults, exposed admin pages, and insecure HTTP headers.

## Why it matters
During a penetration test, a security team running Nikto against a client's web server discovers that the server still exposes `/phpMyAdmin` with default credentials and returns the Apache version in response headers — information an attacker could use to target a specific CVE. Catching these findings in a sanctioned test prevents the attacker from getting there first.

## Key facts
- Nikto checks against **6,700+ potentially dangerous files/programs** and flags version-specific vulnerabilities using its built-in OSVDB/CVE database
- It is **not stealthy** — Nikto generates significant log noise and is easily detected by IDS/IPS; it prioritizes thoroughness over evasion
- Common flags: `-h` specifies the target host, `-p` specifies port, `-ssl` forces SSL scanning, `-Tuning` filters test categories
- Nikto checks for **dangerous HTTP methods** (e.g., PUT, DELETE), outdated server software, missing security headers (X-Frame-Options, Content-Security-Policy), and default credentials
- Outputs can be saved in multiple formats (HTML, CSV, XML) for reporting; it integrates with **Metasploit** for extended exploitation workflows

## Related concepts
[[Web Application Scanning]] [[Burp Suite]] [[OWASP Top 10]] [[Nmap]] [[Vulnerability Assessment]]