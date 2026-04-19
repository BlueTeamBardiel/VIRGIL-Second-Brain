# Burp Suite Getting Started

Burp Suite is the world's leading web penetration testing toolkit. This guide covers installation, basic workflow, and vulnerability testing methodologies for Professional and Community Edition users.

## Quick Start Steps

1. **System Requirements** - Verify your system meets Burp Suite prerequisites
2. **Download and Install** - Get the latest version from the official downloads page
3. **Intercepting HTTP Traffic** - Configure and use [[Burp Proxy]] to intercept requests
4. **Modifying Requests** - Edit intercepted HTTP requests in real-time
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
- **Identifying High-Risk Functionality** - Focus on sensitive operations
- **HTTP Methods Analysis** - Check for supported and vulnerable HTTP verbs
- **Hidden Inputs** - Discover non-obvious form fields and parameters
- **Opaque Data Analysis** - Decode and analyze tokens, session identifiers, etc.

### Vulnerability Testing

**Authentication Testing**
- Username enumeration
- Password brute-forcing and [[credential stuffing]]
- Login bypass techniques

**Session Management**
- Session token analysis and [[JWT]] validation
- Session timeout determination
- [[CSRF]] proof-of-concept generation
- Authenticated session maintenance

**Access Control Testing**
- [[Privilege escalation]] testing
- Horizontal access control bypasses
- [[IDOR]] (Insecure Direct Object Reference) identification
- Parameter-based access control flaws

**Input Validation Testing**
- Client-side control bypass
- [[SQL Injection]] detection
- [[Cross-Site Scripting (XSS)]]
  - Reflected XSS via [[DOM Invader]]
  - Stored XSS
  - Blind XSS
  - XSS filter enumeration and bypass
- [[OS command injection]]
- [[Client-side prototype pollution]]

## Key Tools & Features

- [[Burp Scanner]] - Automated web vulnerability scanner
- [[Burp Proxy]] - Intercept and modify HTTP/HTTPS traffic
- [[DOM Invader]] - Test for DOM-based XSS vulnerabilities
- Custom scan checks and [[BApp Store]] extensions
- [[Bambdas]] - Custom scripting language for Burp

## Resources

- Support Center - Expert help and documentation
- User Forum - Community Q&A
- Training materials - Official Burp Suite courses
- Product comparison - Professional vs Enterprise Edition features

## Tags

#burp-suite #web-security #penetration-testing #vulnerability-assessment #offensive-security

---
_Ingested: 2026-04-15 20:23 | Source: https://portswigger.net/burp/documentation/desktop/getting-started_
