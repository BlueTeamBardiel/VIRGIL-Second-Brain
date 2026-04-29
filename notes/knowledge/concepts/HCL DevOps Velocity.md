# HCL DevOps Velocity

## What it is
Think of it as an air traffic control tower for software pipelines — it doesn't fly the planes, but it coordinates every takeoff, landing, and delay across dozens of runways simultaneously. HCL DevOps Velocity is a value stream management platform that aggregates data from CI/CD tools (Jenkins, GitHub, Jira, ServiceNow) to provide end-to-end visibility into software delivery pipelines, enabling teams to measure and accelerate the flow of work from code commit to production deployment.

## Why it matters
In a supply chain attack scenario, an adversary who compromises a CI/CD orchestration layer gains the ability to inject malicious code into automated deployment pipelines that touch every downstream application. Because Velocity integrates with dozens of toolchains under a single pane of glass, a misconfigured API token or overprivileged service account within Velocity could give an attacker lateral movement across the entire software factory — exactly the attack surface exploited in the SolarWinds-style build pipeline compromises.

## Key facts
- Velocity uses **release gates** — automated policy checkpoints that can block deployments failing security scans, making it a potential enforcement point for DevSecOps controls
- Integrates via **plugins and REST APIs**, meaning exposed API keys represent a critical credential exposure risk requiring secrets management (HashiCorp Vault, etc.)
- Collects **DORA metrics** (Deployment Frequency, Lead Time, MTTR, Change Failure Rate) — understanding these is increasingly relevant to CySA+ risk measurement objectives
- Runs as a **containerized application** (Docker/Kubernetes), so container escape vulnerabilities and misconfigured RBAC are primary attack vectors
- Supports **LDAP/SSO integration** — misconfigurations here can lead to privilege escalation across the entire DevOps toolchain

## Related concepts
[[CI/CD Pipeline Security]] [[Supply Chain Attack]] [[Secrets Management]] [[DevSecOps]] [[RBAC]]