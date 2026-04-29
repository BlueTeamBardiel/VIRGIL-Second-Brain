# Load balancing

## What it is
Like a traffic cop at a busy intersection routing cars across multiple lanes so no single lane gridlocks, a load balancer distributes incoming network traffic across multiple servers to prevent any one server from becoming overwhelmed. It operates at Layer 4 (transport) or Layer 7 (application) of the OSI model, using algorithms like round-robin, least-connections, or IP hash to direct requests.

## Why it matters
Load balancers are a primary defense against volumetric Distributed Denial-of-Service (DDoS) attacks — by spreading malicious traffic across many backend servers, no single target gets saturated. However, load balancers themselves become high-value targets; compromising one can allow an attacker to redirect traffic to a malicious server, intercept sessions, or cause widespread service disruption. SSL/TLS termination at the load balancer also creates a chokepoint where unencrypted traffic may be briefly exposed internally.

## Key facts
- **SSL/TLS termination** at the load balancer decrypts traffic before forwarding it to backend servers — traffic between the balancer and backend may be unencrypted unless re-encryption is configured
- **Session persistence (sticky sessions)** ties a user to a specific backend server using cookies or IP affinity — can create uneven load and single points of failure
- **Health checks** continuously probe backend servers and automatically remove unresponsive nodes from the pool, supporting availability (the "A" in the CIA triad)
- **Layer 7 load balancing** can make routing decisions based on HTTP content (URL paths, headers), enabling application-aware traffic management and basic WAF-like filtering
- Load balancers support **high availability (HA)** configurations where two balancers run in active/passive or active/active pairs to eliminate themselves as a single point of failure

## Related concepts
[[DDoS Mitigation]] [[SSL TLS Termination]] [[High Availability]] [[Session Hijacking]] [[Network Address Translation]]