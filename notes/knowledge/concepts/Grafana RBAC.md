# Grafana RBAC

## What it is
Think of it like a museum with different keycards: the janitor can enter every room, curators only their wing, and visitors only the public gallery — nobody wanders where they shouldn't. Grafana Role-Based Access Control (RBAC) is a permission system that restricts what users can see and do within a Grafana instance by assigning fixed or custom roles that define granular access to dashboards, data sources, alerting, and administrative functions. It replaces the older coarse-grained "Viewer/Editor/Admin" model with fine-grained, action-based permissions.

## Why it matters
In 2021, misconfigured Grafana instances exposed sensitive internal metrics — including cloud infrastructure telemetry — to unauthenticated users because default installations had anonymous access enabled and no RBAC enforcement. An attacker reading database query performance dashboards can infer table names, query patterns, and peak usage windows to time SQL injection attacks. Proper RBAC ensures a developer can view application dashboards without touching datasource credentials or user provisioning.

## Key facts
- Grafana RBAC ships three built-in roles: **Viewer**, **Editor**, and **Admin** — plus **Grafana Admin** (server-wide superuser); custom roles require Grafana Enterprise or OSS v9+.
- Permissions follow a **least-privilege model**: roles grant specific *actions* (e.g., `dashboards:read`, `datasources:write`) rather than broad categories.
- **Service accounts** in Grafana use RBAC tokens, replacing API keys — mismanaged tokens with Admin scope are a common lateral movement vector.
- Anonymous access (`auth.anonymous`) bypasses RBAC entirely and is a known misconfiguration caught by security scanners like Shodan.
- RBAC assignments can be scoped to **organizations**, **teams**, or **individual users**, enabling multi-tenant isolation within a single Grafana instance.

## Related concepts
[[Principle of Least Privilege]] [[Service Account Security]] [[Misconfiguration Vulnerabilities]]