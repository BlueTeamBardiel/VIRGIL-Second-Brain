# Fortinet FortiSOAR SSRF Advisory FG-IR-26-103

## What it is
Imagine a corrupt mail clerk inside a secure building who, when handed an envelope, secretly re-addresses it to internal offices that outsiders could never reach directly — that's SSRF. FG-IR-26-103 is a Server-Side Request Forgery vulnerability in Fortinet FortiSOAR where an authenticated attacker can manipulate the server into making unauthorized HTTP requests to internal network resources on behalf of the FortiSOAR application.

## Why it matters
An attacker who has compromised low-privilege FortiSOAR credentials could exploit this flaw to probe and interact with internal services — cloud metadata endpoints (e.g., `169.254.169.254`), adjacent security tools, or internal APIs — that are otherwise firewalled from the internet. This effectively turns the FortiSOAR SOAR platform, a trusted security orchestration hub, into a pivot point against the very infrastructure it is meant to protect.

## Key facts
- **CVE assigned under FG-IR-26-103**; classified as an SSRF vulnerability affecting Fortinet FortiSOAR
- **Authentication required** — the vulnerability is post-authentication, meaning an attacker needs valid credentials first (reducing but not eliminating risk)
- **SSRF impact** typically includes internal port scanning, cloud metadata credential theft, and bypassing network segmentation controls
- **Affected component**: FortiSOAR's web-based interface/API layer that processes user-supplied URLs or resource locators without sufficient validation
- **Mitigation**: Apply Fortinet's official patch, restrict FortiSOAR outbound network access via egress filtering, and enforce principle of least privilege on accounts

## Related concepts
[[Server-Side Request Forgery (SSRF)]] [[Cloud Metadata Endpoint Abuse]] [[Security Orchestration Automation and Response (SOAR)]] [[Egress Filtering]] [[Privilege Escalation via Lateral Movement]]