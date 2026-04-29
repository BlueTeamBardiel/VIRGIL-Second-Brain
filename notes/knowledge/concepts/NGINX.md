# nginx

## What it is
Think of nginx like a skilled traffic cop standing at a busy intersection — it decides which cars (requests) go to which street (backend server), handles the rush hour crowd efficiently, and can turn away troublemakers at the gate. Precisely, nginx is an open-source, high-performance web server and reverse proxy that handles HTTP/HTTPS traffic, load balancing, and SSL termination between clients and backend application servers.

## Why it matters
Attackers frequently target misconfigured nginx instances to exploit path traversal vulnerabilities — a classic example being the "off-by-slash" misconfiguration where `location /api` without a trailing slash allows requests like `/api../secret` to bypass intended access controls. Defenders must audit nginx config files for alias directives, open proxy settings, and exposed status pages (`/nginx_status`) that leak server metrics to unauthenticated users.

## Key facts
- nginx runs as a **reverse proxy**, meaning clients never directly reach backend application servers — it sits in front absorbing and forwarding requests
- **SSL/TLS termination** occurs at nginx, decrypting HTTPS traffic before forwarding plaintext internally — this creates a trust boundary that must be secured with proper internal network controls
- The `server_tokens off` directive hides the nginx version number from HTTP response headers, reducing information disclosure (a CySA+ favorite hardening step)
- nginx configuration files live in `/etc/nginx/nginx.conf` and site-specific files in `/etc/nginx/sites-enabled/` — world-readable misconfigurations can expose internal architecture
- Unlike Apache's process-per-connection model, nginx uses an **event-driven, asynchronous architecture** making it more resistant to slowloris-style denial-of-service attacks

## Related concepts
[[Reverse Proxy]] [[SSL TLS Termination]] [[HTTP Security Headers]] [[Load Balancing]] [[Web Application Firewall]]