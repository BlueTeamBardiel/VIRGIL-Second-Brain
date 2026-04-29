# Application Layer

## What it is
Think of it as the front desk of a hotel — it's the only part guests ever interact with directly, even though floors of infrastructure hum invisibly below. The Application Layer (OSI Layer 7) is the topmost layer of the OSI model, responsible for providing network services directly to end-user applications like browsers, email clients, and DNS resolvers. It defines the protocols (HTTP, FTP, SMTP, DNS) that applications use to communicate, not the apps themselves.

## Why it matters
Layer 7 DDoS attacks exploit the Application Layer by sending legitimate-looking HTTP requests to exhaust web server resources — unlike volumetric attacks that flood bandwidth, these are surgical strikes that can take down a site with far fewer packets. A single botnet sending thousands of HTTPS GET requests to a login page can overwhelm authentication logic while bypassing traditional firewall rules that only inspect packet headers. Web Application Firewalls (WAFs) exist specifically to defend at this layer by inspecting request content, not just addresses.

## Key facts
- **OSI Layer 7** — the layer closest to the end user; protocols here include HTTP/S, DNS, SMTP, FTP, LDAP, and SNMP
- **Layer 7 DDoS attacks** are harder to mitigate than volumetric attacks because malicious traffic is structurally indistinguishable from legitimate traffic
- **DNS operates at Layer 7**, making DNS poisoning and DNS tunneling application-layer attack vectors
- **WAFs (Web Application Firewalls)** inspect Layer 7 payloads and are a primary defense control for web-facing applications
- **SQL injection and XSS** are application-layer attacks — the vulnerability lives in how the application processes user-supplied data, not in lower-layer protocols

## Related concepts
[[OSI Model]] [[Web Application Firewall]] [[DDoS Attack]] [[DNS Poisoning]] [[SQL Injection]]