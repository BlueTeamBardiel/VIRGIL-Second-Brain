# Spring Security

## What it is
Think of Spring Security as a multi-layered security checkpoint at an airport — it handles who you are (authentication), what gates you can access (authorization), and actively blocks known smuggling techniques (CSRF, session fixation). It is a powerful, highly customizable Java framework that provides authentication, authorization, and protection against common web exploits for applications built on the Spring ecosystem.

## Why it matters
In 2022, a misconfigured Spring Security setup contributed to widespread exposure during the Spring4Shell (CVE-2022-22965) incident — attackers exploited improper input validation and weak security filters to achieve Remote Code Execution on unpatched Spring MVC applications. Proper Spring Security hardening, including strict request filtering and disabling unnecessary endpoints (like Spring Actuator), would have significantly narrowed the attack surface.

## Key facts
- Spring Security applies security as a **filter chain** — requests pass through ordered `SecurityFilterChain` beans before reaching application logic, making bypass possible if filters are misconfigured or ordered incorrectly.
- **CSRF protection is enabled by default** in Spring Security for state-changing HTTP methods (POST, PUT, DELETE); explicitly disabling it for REST APIs is common but must be done deliberately.
- Supports **method-level security** via annotations like `@PreAuthorize` and `@Secured`, enabling fine-grained role-based access control (RBAC) directly in business logic.
- **Password encoding is mandatory** — storing plaintext passwords is prevented by requiring a `PasswordEncoder` bean (BCrypt is the recommended default).
- Spring Security integrates natively with **OAuth2 and OpenID Connect**, enabling delegation to identity providers (IdPs) like Okta or Keycloak for modern authentication flows.

## Related concepts
[[Authentication vs Authorization]] [[CSRF (Cross-Site Request Forgery)]] [[OAuth2]] [[RBAC (Role-Based Access Control)]] [[Session Fixation]]