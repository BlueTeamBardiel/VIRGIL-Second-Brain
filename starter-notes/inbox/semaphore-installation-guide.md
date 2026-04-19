# Semaphore Installation Guide

[[Semaphore UI]] is an open-source automation platform. This guide covers multiple installation methods for deploying Semaphore across different environments and operating systems.

## Installation Methods

### Package Manager
Install via native package managers ([[apt]] for Debian/Ubuntu, [[dnf]] for RHEL-based systems). Best for Linux servers with system service integration.

### [[Docker]]
Run as a container using [[Docker]] or [[Docker Compose]]. Ideal for sandboxed environments, CI/CD pipelines, and infrastructure-as-code workflows.

### Binary File
Download precompiled binaries from the releases page. Supports [[Linux]], [[macOS]], and [[Windows]] (via [[WSL]]). Great for manual installation or custom workflows.

### [[Kubernetes]] (Helm Chart)
Deploy to Kubernetes clusters using [[Helm]]. Production-grade, scalable infrastructure with easy configuration and upgrades via Helm values.

### Cloud Deployment
Guidance for deploying to cloud platforms using VMs, containers, or managed Kubernetes services.

## Additional Python Packages

Some [[Ansible]] modules and roles require additional Python packages. Create a `requirements.txt` file and mount it at `/etc/semaphore/requirements.txt` in the container.

Example for [[Docker Compose]]:
```yaml
volumes:
  - /path/to/requirements.txt:/etc/semaphore/requirements.txt
```

Packages are installed automatically when the container starts. Reference: [Pip Requirements File Format](https://pip.pypa.io/en/latest/reference/requirements-file-format/)

## Tags

#semaphore #installation #automation #devops #infrastructure

---
_Ingested: [[2026-04-15]] 20:54 | Source: https://docs.semaphoreui.com/administration-guide/installation_
