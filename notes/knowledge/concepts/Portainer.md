# Portainer

## What it is
Think of Portainer like a cockpit dashboard for a fleet of aircraft — instead of managing each plane individually through raw controls, a pilot sees everything in one glass panel. Portainer is a lightweight, open-source web-based GUI for managing Docker and Kubernetes environments, allowing administrators to deploy containers, manage images, volumes, and networks without using the CLI directly.

## Why it matters
In 2020 and beyond, exposed Portainer instances with default or no credentials became a popular attack vector — threat actors scanned for port 9000, logged into unauthenticated dashboards, and deployed cryptomining containers or reverse shells with full Docker socket access. Because Portainer runs with elevated privileges to control the Docker daemon, a compromised instance effectively hands an attacker root-level container orchestration on the host.

## Key facts
- Portainer listens on **TCP port 9000** (HTTP) and **9443** (HTTPS) by default; these ports in scan results indicate a container management interface
- Exposes the **Docker socket** (`/var/run/docker.sock`) — if an attacker controls Portainer, they can mount host filesystems and escape container isolation entirely
- Default installation historically shipped with **no authentication enabled** for the first 5 minutes after deployment, creating an exploitation window
- Supports **role-based access control (RBAC)** in its Business Edition, critical for enforcing least privilege in container environments
- Classified as a **management plane** exposure risk — lateral movement from a compromised Portainer instance can affect every container across a swarm or cluster

## Related concepts
[[Docker Security]] [[Container Escape]] [[Exposed Management Interfaces]] [[Least Privilege]] [[Attack Surface Reduction]]