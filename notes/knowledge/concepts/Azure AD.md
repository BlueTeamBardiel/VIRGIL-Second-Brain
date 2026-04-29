# Azure AD

## What it is
Think of it as a bouncer with a master list for every Microsoft cloud service — instead of checking a local guest list at each door, every app calls the same bouncer to verify who you are. Azure Active Directory (Azure AD) is Microsoft's cloud-based Identity and Access Management (IAM) service that handles authentication and authorization for Microsoft 365, Azure resources, and thousands of third-party SaaS applications using protocols like OAuth 2.0, SAML, and OpenID Connect.

## Why it matters
In the 2020 SolarWinds attack, threat actors forged SAML tokens (a technique called "Golden SAML") to impersonate any user in victim organizations' Azure AD environments — bypassing MFA entirely because the forged token was already trusted. Defenders counter this by enabling Azure AD Identity Protection, which uses risk-based conditional access to flag anomalous sign-in behavior like impossible travel or unfamiliar locations.

## Key facts
- Azure AD is **not** the same as on-premises Active Directory Domain Services (AD DS) — it uses flat structure and REST APIs, not Kerberos/LDAP/Group Policy
- **Conditional Access Policies** enforce context-aware controls: block sign-in if device is unmanaged, location is untrusted, or risk score is elevated
- **Privileged Identity Management (PIM)** provides just-in-time elevation for admin roles, reducing standing privilege exposure
- Azure AD **tenant** is the dedicated instance an organization owns; a compromised Global Administrator can read all users, groups, and app registrations across the entire tenant
- **Seamless SSO** via hybrid join allows on-prem AD users to authenticate to cloud apps without re-entering credentials — misconfigured hybrid environments create lateral movement paths from on-prem to cloud

## Related concepts
[[Single Sign-On]] [[OAuth 2.0]] [[Conditional Access]] [[SAML]] [[Privileged Identity Management]] [[Zero Trust Architecture]]