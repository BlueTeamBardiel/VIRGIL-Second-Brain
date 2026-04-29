# SCIM

## What it is
Think of SCIM as a universal remote control for user accounts — instead of manually programming each device separately, one signal updates them all at once. System for Cross-domain Identity Management (SCIM) is an open standard protocol (RFC 7642-7644) that automates the provisioning and deprovisioning of user identities across multiple systems and cloud applications using REST APIs and JSON.

## Why it matters
When an employee is terminated, failing to rapidly deprovision their accounts across dozens of SaaS applications is a critical security gap — former employees have exploited this window to exfiltrate data or cause damage. SCIM closes this gap by allowing the HR system or Identity Provider (IdP) to push a single "delete user" event that cascades automatically to Salesforce, GitHub, Slack, and every other integrated application within seconds, dramatically shrinking the attack surface of orphaned accounts.

## Key facts
- SCIM operates over HTTPS using RESTful APIs; resources are expressed in JSON or XML, with `/Users` and `/Groups` as the core endpoints
- SCIM 2.0 (RFC 7644) is the current standard; it defines standard operations: Create, Read, Update, Delete, and Search (CRUDS) on identity objects
- SCIM works *alongside* SSO (e.g., SAML/OIDC) — SSO handles authentication, SCIM handles lifecycle management (provisioning/deprovisioning)
- A misconfigured SCIM endpoint without proper OAuth 2.0 Bearer Token authentication can expose the entire user directory to unauthenticated enumeration
- SCIM is commonly paired with identity providers like Okta, Azure AD, and Ping Identity to enforce the principle of least privilege at scale

## Related concepts
[[Identity Provider (IdP)]] [[OAuth 2.0]] [[SAML]] [[Single Sign-On (SSO)]] [[Privileged Access Management]]