# Vikunja

## What it is
Think of Vikunja like a private sticky-note wall in a locked room — instead of trusting Trello or Asana with your team's sensitive project data, you spin up your own task management server on infrastructure you control. Vikunja is an open-source, self-hosted task and project management application (similar to Todoist or Jira) written in Go, designed to run entirely within an organization's own environment.

## Why it matters
Organizations handling sensitive data — healthcare, finance, legal — increasingly self-host tools like Vikunja to avoid exposing project metadata (task names, assignees, deadlines, attachments) to third-party SaaS vendors, reducing supply-chain and data-residency risk. However, self-hosting introduces its own attack surface: a misconfigured Vikunja instance exposed publicly without authentication hardening becomes a target for credential stuffing or unauthorized data exfiltration of internal project intelligence.

## Key facts
- Vikunja uses JWT (JSON Web Tokens) for API authentication — misconfigured token expiration or weak signing secrets are a direct vulnerability vector
- Supports LDAP/OIDC integration, meaning a compromised identity provider can cascade into full Vikunja access (federated identity risk)
- Default installations may expose the API and frontend on port 3456; failure to place behind a reverse proxy with TLS creates plaintext credential exposure
- Self-hosted SaaS tools like Vikunja fall under the organization's own patch management responsibility — unpatched CVEs won't be fixed automatically by a vendor
- Data stored locally means backup security becomes critical — unencrypted database backups containing task data represent a confidentiality risk

## Related concepts
[[Self-Hosted Applications]] [[JWT Authentication]] [[LDAP Integration]] [[Supply Chain Risk]] [[OIDC]]