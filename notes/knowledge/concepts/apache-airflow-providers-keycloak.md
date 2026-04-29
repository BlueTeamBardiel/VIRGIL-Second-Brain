# apache-airflow-providers-keycloak

## What it is
Think of it as a bouncer at a club who checks IDs issued by a specific authority (Keycloak) before letting anyone into Apache Airflow's VIP data pipeline area. `apache-airflow-providers-keycloak` is an Apache Airflow provider package that integrates Keycloak as an external identity and access management (IAM) system, enabling Airflow to delegate authentication and authorization to a centralized Keycloak server via OAuth 2.0/OIDC protocols.

## Why it matters
In enterprise data pipeline environments, Airflow DAGs often have access to sensitive credentials for databases, cloud storage, and APIs — making the authentication layer a high-value target. An attacker who compromises a misconfigured Keycloak realm (e.g., weak client secrets, overly permissive token scopes, or disabled PKCE) could forge tokens accepted by Airflow, gaining unauthorized execution of arbitrary pipeline code. Centralizing identity in Keycloak also means a single misconfiguration propagates across every integrated service simultaneously.

## Key facts
- Uses **OAuth 2.0 / OpenID Connect (OIDC)** for authentication, meaning Airflow validates JWT tokens issued and signed by Keycloak rather than managing passwords locally
- Keycloak **client secrets** stored in Airflow connections must be protected — exposure allows token generation as any configured client
- Supports **role-based access control (RBAC)** by mapping Keycloak realm/client roles to Airflow roles, centralizing privilege assignment
- Token expiry and **refresh token handling** are critical: improperly configured short-lived tokens can cause pipeline failures, while long-lived tokens increase exposure windows
- Provider packages like this are community-maintained and may lag Keycloak version updates, creating **known vulnerability windows** between patch releases

## Related concepts
[[OAuth 2.0]] [[OpenID Connect]] [[Identity and Access Management]] [[JWT Security]] [[Federated Identity]]