# ASVS

## What it is  
Imagine a construction company building a skyscraper with a checklist that guarantees every structural element meets fire, wind, and seismic codes. The **Application Security Verification Standard (ASVS)** is OWASP’s equivalent checklist for web applications, defining levels of security assurance and a set of controls that must be met to prove an app is resilient against common attack vectors.  

## Why it matters  
When a banking web portal was found vulnerable to a SQL injection that exposed millions of account numbers, the remediation cost included a full ASVS assessment to ensure all injection points were hardened, the authentication flow met Level 2 controls, and the session management met Level 3. Without the ASVS framework, the bank would have had to patch each bug ad‑hoc, risking residual weaknesses.  

## Key facts  
- **Three security levels** (Level 1: basic, Level 2: medium, Level 3: high) map controls to the maturity of the application.  
- Controls cover **identity, session, data, infrastructure, and code**; each must be documented and tested.  
- ASVS includes **technical test cases** (e.g., “Verify that all error messages are generic”) to aid penetration testers.  
- The standard is **freely available** and regularly updated by the OWASP community, ensuring alignment with emerging threats.  

## Related concepts  
[[OWASP]] [[ISO 27001]] [[Secure Coding]] [[Threat Modeling]]