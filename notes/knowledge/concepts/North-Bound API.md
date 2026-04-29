# North-Bound API

## What it is
Think of a restaurant where the kitchen (network infrastructure) never talks directly to customers — instead, a head waiter (the controller) takes orders upward to management software that decides the menu. A North-Bound API is the interface on a Software-Defined Networking (SDN) controller that faces *upward* toward management applications, allowing orchestration tools and business software to programmatically configure and query the network. It abstracts the physical infrastructure into software calls, enabling automation at scale.

## Why it matters
In a misconfigured SDN environment, an attacker who compromises an orchestration application gains access to the North-Bound API and can issue commands to reshape the entire network — rerouting traffic, disabling segments, or creating covert tunnels — without touching a single physical switch. This is analogous to hacking the restaurant manager and rewriting every order in the kitchen simultaneously. Securing North-Bound APIs with strong authentication (OAuth, mutual TLS) and strict authorization is critical because they represent centralized control blast radius.

## Key facts
- North-Bound APIs sit between the **SDN application layer** (business logic) and the **SDN control layer** (controller); South-Bound APIs connect the controller *downward* to physical devices via protocols like OpenFlow.
- Common North-Bound API formats include **REST, RESTCONF, and NETCONF** — all HTTP/HTTPS-based and therefore subject to standard web vulnerabilities (broken authentication, IDOR, injection).
- Compromise of a North-Bound API provides **network-wide lateral movement** potential, making it a high-value target in cloud and data center environments.
- Security controls include **API gateways, rate limiting, role-based access control (RBAC), and API key management** — all testable on CySA+.
- SDN's centralized control model trades **resilience for manageability** — a single controller failure or breach can impact the entire managed domain.

## Related concepts
[[Software-Defined Networking (SDN)]] [[API Security]] [[Zero Trust Architecture]]