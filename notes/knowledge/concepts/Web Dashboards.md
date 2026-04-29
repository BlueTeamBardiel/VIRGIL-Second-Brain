# Web Dashboards

## What it is
Like a cockpit instrument panel that lets a pilot see altitude, fuel, and speed at a glance, a web dashboard is a browser-based interface that aggregates and visualizes data — logs, metrics, alerts — from underlying systems in real time. Technically, it is a web application layer sitting atop APIs or databases, rendering dynamic content through HTML/CSS/JavaScript frameworks.

## Why it matters
In 2021, attackers exploited exposed Kibana dashboards (part of the ELK Stack) with no authentication configured, gaining read/write access to terabytes of internal log data — including credentials stored in plaintext logs. This is a classic misconfiguration attack: a powerful monitoring tool deployed with default or absent access controls becomes a high-value pivot point for lateral movement.

## Key facts
- Web dashboards (Grafana, Kibana, Splunk Web, pfSense GUI) are frequent targets because they aggregate sensitive data and are often internet-facing without MFA
- Default credentials (admin/admin, admin/changeme) remain the #1 initial access vector for exposed dashboards — directly relevant to CySA+ misconfiguration scenarios
- Broken Access Control (OWASP A01:2021) commonly manifests in dashboards as horizontal privilege escalation — one user accessing another user's data via manipulated URL parameters
- Dashboards exposing debug endpoints (e.g., `/api/status`, `/metrics`) can leak version info, internal IPs, and service topology useful for reconnaissance
- Hardening controls include: enforcing HTTPS, implementing RBAC, disabling anonymous access, placing dashboards behind a VPN or reverse proxy, and enabling audit logging

## Related concepts
[[Broken Access Control]] [[Misconfiguration]] [[Security Information and Event Management (SIEM)]] [[Reconnaissance]] [[Principle of Least Privilege]]