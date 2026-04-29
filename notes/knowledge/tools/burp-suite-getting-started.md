# Burp Suite Getting Started

Burp Suite is the world's leading web penetration testing toolkit. This guide covers installation, basic workflow, and vulnerability testing methodologies for Professional and Community Edition users.

## Quick Start Steps

1. **System Requirements** - Verify your system meets Burp Suite prerequisites
2. **Download and Install** - Get the latest version from the official downloads page
3. **Intercepting HTTP Traffic** - Configure and use [[Burp Proxy]] to intercept requests
4. **Modifying Requests** - Edit intercepted HTTP requests in real‑time
5. **Setting Target Scope** - Define the scope of your penetration test
6. **Reissuing Requests** - Resend modified or historical requests
7. **Running Scans** - Execute automated vulnerability scans (Professional only)
8. **Generating Reports** - Create findings reports (Professional only)

## Testing Workflow

### Reconnaissance & Mapping
- **Mapping the Attack Surface** - Document visible endpoints and functionality
- **Content Discovery** - Automated and manual discovery of hidden content
- **Hostname Discovery** - Identify associated domains and subdomains

### Analysis & Evaluation
- **Scoping Effort** - Prioritize audit work based on risk and complexity
- **Identifying High‑Risk Functionality** - Focus on sensitive operations
- **HTTP Methods Analysis** - Check for supported and vulnerable HTTP verbs
- **Hidden Inputs** - Discover non‑obvious form fields and parameters
- **Opaque Data Analysis** - Decode and analyze tokens, session identifiers, etc.

### Vulnerability Testing

**Authentication Testing**
- Username enumeration
- Password brute‑forcing and [[credential stuffing]]
- Login bypass techniques

**Session Management**
- Session token analysis and [[JWT]] validation
- Session timeout determination
- [[CSRF]] proof‑of‑concept generation
- Authenticated session maintenance

**Access Control Testing**
- [[Privilege escalation]] testing
- Horizontal access control bypasses
- [[IDOR]] (Insecure Direct Object Reference) identification
- Parameter‑based access control flaws

**Input Validation Testing**
- Client‑side control bypass
- [[SQL Injection]] detection
- [[Cross‑Site Scripting (XSS)]]
  - Reflected XSS via [[DOM Invader]]
  - Stored XSS
  - Blind XSS
  - XSS filter enumeration and bypass
- [[OS command injection]]
- [[Client‑side prototype pollution]]

## Key Tools & Features

- [[Burp Scanner]] - Automated web vulnerability scanner
- [[Burp Proxy]] - Intercept and modify HTTP/HTTPS traffic
- [[DOM Invader]] - Test for DOM‑based XSS vulnerabilities
- Custom scan checks and [[BApp Store]] extensions
- [[Bambdas]] - Custom scripting language for Burp

## Resources

- Support Center - Expert help and documentation
- User Forum - Community Q&A
- Training materials - Official Burp Suite courses
- Product comparison - Professional vs Enterprise Edition features

## What Is It? (Feynman Version)

Imagine a Swiss‑army knife for web traffic. Instead of cutting or opening cans, it captures, examines, and edits HTTP/HTTPS messages as they travel between your browser and the target web server. Burp Suite is that knife, but it can also automatically scan for common web flaws and produce structured reports.

## Why Does It Exist?

Before Burp, testers had to juggle separate tools: a proxy like fiddler for interception, a separate scanner for vulnerabilities, and manual scripting for custom checks. Each tool had its own interface, learning curve, and data exchange format. Burp bundles these functions, letting a tester focus on strategy instead of tool‑switching. It solves the problem of fragmented workflows and inconsistent data, which previously slowed audits and increased the chance of missing critical issues.

## How It Works (Under The Hood)

1. **Proxy Engine** – Burp runs a local HTTP/HTTPS proxy on `127.0.0.1:8080`. Browser traffic is redirected here. Burp inserts its own TLS certificates (via a CA) to decrypt HTTPS, then forwards the request to the target server.
2. **Request/Response Tree** – Each intercepted message is stored in a hierarchical tree. The tool parses the HTTP headers and body, enabling field‑by‑field editing and dynamic parameterization.
3. **Scanning Module** – When a scan is launched, Burp generates a list of target URLs from the scope. It sends requests, applies automated payloads, and monitors responses for error patterns, content changes, or HTTP status codes indicating vulnerabilities.
4. **Extensions** – The BApp Store hosts plug‑ins that add new scanners, spiders, or integration points. These plug‑ins are loaded into the same process, sharing the same data structures.
5. **Report Generation** – Collected findings are aggregated, scored, and rendered as HTML or XML reports, optionally exporting to formats like PDF or CSV.

## What Breaks When It Goes Wrong?

When a proxy fails to forward a request, the tester sees a blank or delayed page—often misinterpreted as a network outage. A misconfigured scope can let Burp scan external sites, causing accidental DoS on third‑party services. In the worst case, a malicious payload introduced via the tool can be delivered to a production server if the tester forgets to switch to a staging environment, leading to data loss, legal liability, or reputational damage.

## Lab Relevance

- **Setup** – Install Burp on a host with a clean OS image. Configure your browser to use `127.0.0.1:8080` and install Burp’s CA certificate so HTTPS traffic is decrypted.
- **Target** – Deploy a deliberately vulnerable application such as OWASP WebGoat or DVWA inside the same lab network.
- **Practice** – Intercept a login request, modify the username to an invalid value, and re‑issue the request to see how the application responds. Use the scanner to discover hidden pages, and observe how the findings appear in the scan results window.
- **Watch for** – TLS handshake failures (certificate not trusted), scope mis‑settings (Burp scanning `example.com` when only `test.local` is intended), and the impact of re‑issuing requests that trigger destructive actions (e.g., a delete endpoint).

## Tags

#burp-suite #web-security #penetration-testing #vulnerability-assessment #offensive-security

_Ingested: 2026-04-15 20:23 | Source: https://portswigger.net/burp/documentation/desktop/getting-started_

<!-- preserved: [[Client-side prototype pollution]] -->
<!-- preserved: [[Cross-Site Scripting (XSS)]] -->