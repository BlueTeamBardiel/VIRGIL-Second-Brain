# Azure Active Directory

## What it is
Think of Azure AD like a bouncer at a massive cloud nightclub — it checks your ID (identity), decides which VIP rooms (resources) you're allowed into, and keeps a log of everyone who walked through the door. Precisely, Azure Active Directory is Microsoft's cloud-based Identity and Access Management (IAM) service that handles authentication and authorization for Microsoft 365, Azure resources, and thousands of third-party SaaS applications.

## Why it matters
In the 2020 SolarWinds attack, threat actors forged SAML tokens to impersonate users within Azure AD environments — bypassing MFA entirely — because they had compromised token-signing certificates. This attack exposed how Azure AD federation trust, if misconfigured or compromised, can give attackers persistent, privileged access across an entire organization without a single stolen password.

## Key facts
- Azure AD uses **OAuth 2.0** and **OpenID Connect** for authorization and authentication respectively, not Kerberos (unlike on-premises AD)
- **Conditional Access Policies** enforce context-aware controls: block login from untrusted locations, require MFA for privileged roles, or restrict legacy authentication protocols
- **Privileged Identity Management (PIM)** provides just-in-time elevation for admin roles, reducing standing privilege exposure
- Azure AD logs are stored in **Sign-in Logs** and **Audit Logs**, both critical for CySA+ threat hunting and SIEM integration
- **Hybrid Azure AD Join** bridges on-premises Active Directory with Azure AD, but misconfigured sync (via Azure AD Connect) is a common lateral movement path attackers exploit

## Related concepts
[[Identity and Access Management]] [[Multi-Factor Authentication]] [[OAuth 2.0]] [[SAML]] [[Privileged Access Management]]