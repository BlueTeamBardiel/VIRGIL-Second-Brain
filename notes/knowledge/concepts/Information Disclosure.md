# information disclosure

## What it is
Like a filing cabinet left open in a lobby where anyone can flip through personnel records, information disclosure occurs when a system unintentionally exposes data to unauthorized parties. Precisely, it is a vulnerability class where an application or service reveals sensitive internal details — error messages, stack traces, version numbers, or user data — to actors who should not have access.

## Why it matters
In 2017, the Equifax breach was partially enabled by verbose Apache Struts error messages that helped attackers map internal system architecture, accelerating their lateral movement. Defenders counter this by configuring web servers to return generic 500 errors rather than full stack traces, and by stripping server header banners that announce software versions to reconnaissance scans.

## Key facts
- **HTTP response headers** like `Server: Apache/2.4.49` directly enable version-targeted exploits; suppressing or spoofing them is a basic hardening step
- Information disclosure is classified under **CWE-200** and appears in the OWASP Top 10 under "Security Misconfiguration" and "Broken Access Control"
- **Directory listing enabled** on a web server is a textbook example — it exposes file structure without any authentication
- Error messages containing **SQL syntax or internal paths** (e.g., `C:\inetpub\wwwroot\`) give attackers a roadmap for further exploitation
- During **reconnaissance**, attackers deliberately trigger errors (404s, 500s, invalid inputs) to harvest disclosed metadata — this is called *error-based fingerprinting*

## Related concepts
[[security misconfiguration]] [[error handling]] [[reconnaissance]] [[verbose error messages]] [[attack surface]]