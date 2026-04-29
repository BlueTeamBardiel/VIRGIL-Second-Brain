# Microsoft Entra ID

## What it is
Think of it as the bouncer at a massive cloud nightclub — it checks every ID, enforces the guest list, and decides what VIP sections each person can enter. Microsoft Entra ID (formerly Azure Active Directory) is a cloud-based Identity and Access Management (IAM) service that handles authentication and authorization for Microsoft 365, Azure resources, and thousands of third-party applications via federation protocols like SAML and OAuth 2.0.

## Why it matters
In 2023, the Storm-0558 threat actor forged authentication tokens to access Microsoft Exchange Online accounts belonging to U.S. government agencies — exploiting weaknesses in how Entra ID validated signing keys. This attack highlighted that compromising the identity plane in a cloud IAM system can bypass every downstream security control, making Entra ID a crown-jewel target for nation-state actors and ransomware operators alike.

## Key facts
- Entra ID supports **Conditional Access policies** that enforce MFA, device compliance, or location-based restrictions before granting tokens — a primary defense against credential stuffing
- **Privileged Identity Management (PIM)** provides just-in-time elevation for admin roles, reducing standing privilege exposure (relevant to least-privilege principles tested on CySA+)
- Uses **OpenID Connect** (built on OAuth 2.0) for modern authentication and **Kerberos/NTLM** is *not* used by default — unlike on-premises Active Directory
- **Hybrid Identity** via Azure AD Connect syncs on-prem AD accounts to the cloud, meaning a compromised on-prem account can pivot to cloud resources (and vice versa)
- Entra ID logs feed into **Microsoft Sentinel** (SIEM) and generate sign-in risk scores through **Identity Protection**, enabling automated response to anomalous logins

## Related concepts
[[Identity and Access Management]] [[OAuth 2.0]] [[Conditional Access]] [[Privileged Identity Management]] [[Zero Trust Architecture]]