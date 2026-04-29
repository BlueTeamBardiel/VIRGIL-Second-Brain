# Load Balancer

## What it is
Like a traffic cop at a busy intersection routing cars across multiple lanes so no single lane gridlocks, a load balancer distributes incoming network requests across multiple backend servers to prevent any one server from becoming overwhelmed. It operates at Layer 4 (transport) or Layer 7 (application) of the OSI model and can be hardware-based, software-based, or cloud-native.

## Why it matters
Load balancers are both a DDoS mitigation tool and an attack surface. During a volumetric DDoS attack, a load balancer can absorb and distribute traffic across scaled infrastructure, keeping services alive — but misconfigured load balancers can leak internal server IPs through HTTP headers (like `X-Forwarded-For`), exposing the real backend topology to an attacker who bypasses perimeter defenses by targeting origin servers directly.

## Key facts
- **Layer 4 vs Layer 7**: L4 balancers route based on IP/TCP without inspecting content; L7 balancers can route based on URLs, cookies, or HTTP headers — making them smarter but more complex to secure.
- **Session persistence (sticky sessions)**: Some load balancers bind a user to a specific backend server using cookies or source IP, which can undermine security if an attacker hijacks that session token.
- **Health checks**: Load balancers continuously probe backend servers; a compromised server that still passes health checks remains in rotation and continues serving malicious responses.
- **SSL termination**: Many load balancers decrypt HTTPS traffic at the edge, creating an unencrypted segment between the balancer and backend servers — a blind spot if internal traffic isn't re-encrypted.
- **Single point of failure risk**: Without redundancy (active-active or active-passive failover), the load balancer itself becomes the chokepoint an attacker targets for maximum impact.

## Related concepts
[[DDoS Mitigation]] [[Reverse Proxy]] [[SSL/TLS Inspection]] [[Session Hijacking]] [[Network Architecture]]