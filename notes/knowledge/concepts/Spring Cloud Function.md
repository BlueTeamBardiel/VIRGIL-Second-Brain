# Spring Cloud Function

## What it is
Like a universal power adapter that lets any appliance plug into any outlet, Spring Cloud Function lets developers write a single business function and deploy it to AWS Lambda, Azure Functions, or a local server without changing code. It is a Java framework that abstracts cloud-provider-specific function-as-a-service APIs into a unified programming model. The abstraction layer handles routing and invocation, meaning user-supplied input often reaches core execution logic with minimal sanitization.

## Why it matters
CVE-2022-22963 and the related Spring4Shell (CVE-2022-22965) made Spring Cloud Function infamous in 2022 when attackers exploited a **routing expressions injection** vulnerability in the `spring.cloud.function.routing-expression` header. By supplying a crafted SpEL (Spring Expression Language) expression in an HTTP header, unauthenticated remote attackers achieved Remote Code Execution on vulnerable servers — a critical severity (CVSS 9.8) exploit actively used in ransomware campaigns within days of disclosure.

## Key facts
- **CVE-2022-22963**: RCE via malicious SpEL expression in the `spring.cloud.function.routing-expression` HTTP header; affected versions 3.1.6 and 3.2.2 and below.
- The vulnerability is a **server-side expression injection**, a subset of injection attacks tested in CySA+ threat scenarios.
- Fix requires upgrading to Spring Cloud Function **3.1.7+ or 3.2.3+**; no authentication bypass is needed to exploit it.
- Attack surface exists because the framework evaluates user-controlled input using a powerful expression engine (SpEL) without proper sanitization.
- Defenders should monitor HTTP headers — not just body/query parameters — as injection vectors, and enforce WAF rules blocking SpEL syntax patterns like `T(java.lang.Runtime)`.

## Related concepts
[[Remote Code Execution]] [[Server-Side Template Injection]] [[CVE Vulnerability Management]] [[Web Application Firewall]] [[Patch Management]]