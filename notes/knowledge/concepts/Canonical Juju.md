# Canonical Juju

## What it is
Think of it like a universal remote control for cloud services — one interface that programs any TV brand without caring about the underlying manufacturer. Canonical Juju is an open-source application modeling and orchestration tool developed by Canonical (makers of Ubuntu) that deploys, configures, and scales cloud workloads across AWS, Azure, GCP, bare metal, and Kubernetes using reusable packages called "charms." It abstracts infrastructure complexity so operators define *what* they want deployed, not *how* each environment handles it.

## Why it matters
In a DevSecOps pipeline, misconfigured charm deployments can introduce supply chain risks — a malicious or outdated charm pulled from Charmhub could silently deploy services with weak default credentials, open ports, or disabled TLS. An attacker with write access to a Juju controller (the central management node) effectively has lateral movement capability across every cloud environment that controller manages, making controller credential protection a high-value target.

## Key facts
- **Juju Controller** is the nerve center — compromise it and an attacker can redeploy, reconfigure, or destroy all managed workloads across multiple clouds simultaneously
- **Charms** are the deployment packages; they live on Charmhub and can be community-authored, creating a software supply chain trust problem similar to npm or PyPI packages
- Juju uses **RBAC (Role-Based Access Control)** for user permissions — misconfigured roles can grant excessive privileges to non-admin users
- Communication between Juju agents and the controller uses **TLS with mutual authentication**; expired or self-signed certificates weaken this trust boundary
- Relevant to **CIS Benchmarks** compliance — Juju deployments of Kubernetes (Charmed Kubernetes) are a common enterprise target requiring hardened charm configurations

## Related concepts
[[Infrastructure as Code Security]] [[Supply Chain Attacks]] [[Cloud Orchestration Misconfigurations]] [[RBAC]] [[Kubernetes Security]]