# Burp Collaborator

## What it is
Like setting up a fake PO box and watching to see who sends mail to it, Burp Collaborator is an out-of-band interaction server that detects when a target application makes DNS lookups, HTTP requests, or SMTP connections to a uniquely generated external domain. It is a feature of Burp Suite Professional that enables testers to discover blind vulnerabilities — flaws that produce no visible response in the application itself but still trigger backend network activity.

## Why it matters
Blind Server-Side Request Forgery (SSRF) is notoriously difficult to confirm: the server makes an internal request, but the attacker sees nothing in the HTTP response. By injecting a Collaborator payload URL into a parameter, a tester can confirm exploitation when the Collaborator server logs an incoming DNS query from the target's backend — proving the server fetched that URL even though the application returned a blank page.

## Key facts
- Collaborator generates unique, time-limited subdomains (e.g., `a1b2c3.burpcollaborator.net`) to attribute interactions back to specific payloads
- Detects four interaction types: **DNS**, **HTTP**, **HTTPS**, and **SMTP** — useful for finding different vulnerability classes
- Burp Collaborator Client polls the Collaborator server periodically and displays captured interactions within Burp Suite's UI
- A self-hosted Collaborator server can be deployed for assessments on air-gapped or restricted networks where external DNS is blocked
- Commonly used to detect **blind SQLi**, **blind SSRF**, **blind XXE**, **log4shell (CVE-2021-44228)**, and **SSTI** that produce no direct output

## Related concepts
[[Server-Side Request Forgery]] [[Out-of-Band Data Exfiltration]] [[Blind SQL Injection]] [[XXE Injection]] [[Burp Suite]]