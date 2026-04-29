# Traefik

## What it is
Think of Traefik as a smart airport traffic controller that reads each plane's tail number and routes it to the correct gate — automatically updating its routing table whenever a new plane joins the fleet. Precisely, Traefik is a cloud-native reverse proxy and load balancer that dynamically discovers backend services (via Docker, Kubernetes, etc.) and automatically configures routing rules without manual restarts. It sits at the network edge, terminating external connections and forwarding traffic to appropriate internal services.

## Why it matters
In a 2023 misconfiguration pattern, organizations running Traefik with the dashboard exposed on a public interface (default port 8080, no authentication) allowed attackers to enumerate all internal microservices, their routes, and backend IP addresses — essentially handing over a complete internal network map. Defenders must enforce dashboard authentication middleware and restrict exposure to internal networks only, since Traefik's visibility into service topology makes it a high-value reconnaissance target.

## Key facts
- Traefik's **dashboard** is unauthenticated by default; failing to add BasicAuth or OAuth2 middleware is a critical misconfiguration
- Traefik automatically provisions **TLS certificates via Let's Encrypt (ACME protocol)**, making it relevant to certificate management and PKI attack surfaces
- **EntryPoints** define listening ports; **Routers** match traffic by rules (Host, Path, Headers); **Middlewares** transform or gate requests — understanding this pipeline is key to identifying security bypass opportunities
- Traefik exposes **metrics and API endpoints** (`/api/rawdata`) that can leak service topology if not access-controlled
- As a **reverse proxy**, Traefik is part of the defense-in-depth architecture but also a **single point of failure/compromise** — a compromised Traefik instance can intercept all proxied traffic, including decrypted TLS sessions

## Related concepts
[[Reverse Proxy]] [[Load Balancer]] [[TLS Termination]] [[API Gateway]] [[Kubernetes Ingress]]