# Docker Images

## What it is
Think of a Docker image like a frozen recipe card plus all the pre-measured ingredients sealed in a bag — every cook who opens it gets the exact same dish, every time. Precisely, a Docker image is a read-only, layered filesystem template containing an application, its dependencies, and configuration, used to instantiate Docker containers. Images are built from sequential instructions in a `Dockerfile` and stored in registries like Docker Hub.

## Why it matters
Attackers routinely poison public Docker images on Docker Hub — a tactic called a **supply chain attack** — embedding cryptominers or reverse shells that activate when developers pull and run the image. In 2018, the `docker-volume-plugin` image on Docker Hub was found to contain a cryptocurrency miner, silently compromising thousands of developer machines. Defenders counter this by enforcing image signing with **Docker Content Trust (DCT)** and scanning images with tools like Trivy or Clair before deployment.

## Key facts
- Docker images are **immutable and layered**; each `Dockerfile` instruction creates a new read-only layer, enabling efficient caching and diffing.
- The **attack surface** includes: malicious base images, secrets baked into image layers (e.g., hardcoded API keys), and outdated packages in abandoned images.
- `docker history <image>` can reveal **exposed secrets** committed in earlier build layers, even if deleted in a later step — a common misconfiguration.
- Image **digests** (SHA256 hashes) provide integrity verification; pulling by tag alone (`latest`) is insecure because tags are mutable and can be reassigned.
- CySA+ expects familiarity with **container image scanning** as a DevSecOps control within CI/CD pipelines to catch vulnerabilities pre-deployment.

## Related concepts
[[Docker Containers]] [[Supply Chain Attacks]] [[Container Security]] [[Software Composition Analysis]] [[Least Privilege]]