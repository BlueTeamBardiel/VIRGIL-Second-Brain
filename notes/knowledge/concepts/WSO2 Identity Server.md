# WSO2 Identity Server

## What it is
Think of it as a bouncer with a master list — one checkpoint that decides who gets into every club on the street. WSO2 Identity Server is an open-source Identity and Access Management (IAM) platform that centralizes authentication, authorization, and identity federation across applications and services. It implements protocols like OAuth 2.0, OpenID Connect, SAML 2.0, and SCIM to enable Single Sign-On (SSO) and user lifecycle management.

## Why it matters
In 2022, CVE-2022-29464 exposed a critical unauthenticated file upload vulnerability in WSO2 products (CVSS 9.8), allowing remote code execution without any credentials. Threat actors — including APT groups — actively exploited this flaw to drop webshells on internet-facing identity servers, effectively compromising the master key to an organization's entire application ecosystem. Because IAM systems sit at the authentication chokepoint, a single unpatched instance can cascade into full enterprise compromise.

## Key facts
- **CVE-2022-29464** is one of the most critical WSO2 vulnerabilities — unrestricted file upload leading to RCE, actively exploited in the wild by nation-state actors.
- WSO2 Identity Server supports **SAML 2.0, OAuth 2.0, OpenID Connect, WS-Federation, and SCIM 2.0** — making it a multi-protocol IAM hub.
- It enables **Identity Federation**, allowing external identity providers (Google, Azure AD) to authenticate users via trust relationships.
- Runs on **port 9443 by default** (HTTPS management console) — a fingerprint useful in both pentesting reconnaissance and defender asset inventory.
- As an open-source IAM platform, misconfigurations like **exposed management consoles** or **default credentials** are common real-world attack surfaces.

## Related concepts
[[Single Sign-On (SSO)]] [[OAuth 2.0]] [[SAML Authentication]] [[Remote Code Execution]] [[Identity Federation]]