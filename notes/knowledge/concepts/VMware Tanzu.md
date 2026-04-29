# VMware Tanzu

## What it is
Think of VMware Tanzu like a universal shipping dock that accepts containers from any vessel and routes them to any warehouse — it's a platform for building, running, and managing Kubernetes-based containerized applications across multiple clouds and on-premises infrastructure. Tanzu abstracts the complexity of container orchestration, giving enterprises a single control plane to deploy and secure workloads at scale.

## Why it matters
In 2021, researchers discovered that misconfigured Tanzu Application Service environments exposed internal environment variables — including database credentials and API keys — through unsecured `/env` actuator endpoints inherited from Spring Boot. An attacker scanning for exposed management endpoints could harvest these secrets and pivot laterally into backend systems, databases, or cloud provider accounts. Properly locking down actuator endpoints and enforcing network segmentation are critical defensive controls in Tanzu deployments.

## Key facts
- Tanzu integrates with **VMware NSX** for micro-segmentation, enforcing zero-trust network policies between Kubernetes pods
- **Tanzu Mission Control (TMC)** provides centralized policy enforcement — including RBAC and admission control — across multiple Kubernetes clusters
- Container images deployed via Tanzu should be scanned using integrated tools like **Carbon Black Container** or third-party registries to catch vulnerable base images before deployment
- Supply chain security is a key Tanzu concern — **Tanzu Build Service** uses Buildpacks to automatically patch OS-level dependencies in container images without developer intervention
- Misconfigurations in **Kubernetes RBAC within Tanzu** can grant over-privileged service accounts, a common attack vector leading to cluster takeover

## Related concepts
[[Kubernetes Security]] [[Container Security]] [[Zero Trust Architecture]]