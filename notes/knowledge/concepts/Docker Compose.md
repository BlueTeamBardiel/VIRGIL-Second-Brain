# Docker Compose

## What it is
Like a stage director's script that tells every actor exactly when to enter, what to say, and how to interact — Docker Compose is a YAML-based orchestration tool that defines and runs multi-container Docker applications from a single configuration file (`docker-compose.yml`). Instead of manually launching each container with separate `docker run` commands, Compose spins up an entire service stack (web server, database, cache) with one command: `docker-compose up`.

## Why it matters
A misconfigured `docker-compose.yml` that exposes database ports (e.g., `ports: "5432:5432"`) to the host network rather than restricting them to internal container networks has led to real breaches — attackers scanning for exposed PostgreSQL or Redis instances can authenticate with default credentials and exfiltrate data. Security analysts auditing containerized environments must review Compose files specifically for exposed ports, privileged containers, and volume mounts that map sensitive host directories into containers.

## Key facts
- Compose files use **three key sections**: `services` (container definitions), `networks` (isolation controls), and `volumes` (persistent storage mappings)
- The `privileged: true` flag in a Compose service grants the container near-root access to the host kernel — a critical misconfiguration to flag during container security audits
- **Environment variables** in Compose files (e.g., `POSTGRES_PASSWORD=admin`) are a common credential exposure vector; `.env` files should be excluded via `.gitignore`
- Docker Compose creates a **default bridge network** shared by all services in the file — services can resolve each other by service name, but this also means a compromised container can reach all sibling services
- Compose V2 integrates directly into the Docker CLI (`docker compose` vs. the legacy `docker-compose` binary), relevant for recognizing tooling in incident timelines

## Related concepts
[[Containerization]] [[Docker Security]] [[Infrastructure as Code]] [[Least Privilege]] [[Network Segmentation]]