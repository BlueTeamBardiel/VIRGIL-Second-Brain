# IoT Security

## What it is
Imagine millions of vending machines connected to the internet, each running a tiny computer — but no one ever changes the default lock combination. IoT security is the practice of protecting internet-connected physical devices (sensors, cameras, thermostats, medical devices) that typically lack traditional OS hardening, patching mechanisms, or user interfaces. These devices expand the attack surface dramatically because they operate at the intersection of digital networks and physical environments.

## Why it matters
In 2016, the Mirai botnet compromised ~600,000 IoT devices — primarily home routers and IP cameras — by scanning for devices still using factory-default credentials (admin/admin, root/1234). These hijacked devices launched a DDoS attack that took down DNS provider Dyn, knocking Twitter, Netflix, and Reddit offline for hours. A simple credential change policy would have prevented most of the compromise.

## Key facts
- **Default credentials** are the #1 IoT attack vector — devices ship with published default passwords that users never change; always change them during provisioning
- IoT devices often run **embedded Linux or RTOS** with no patch delivery mechanism, leaving known CVEs permanently unpatched
- **Network segmentation** (placing IoT devices on isolated VLANs) is the primary compensating control when patching is impossible
- The **OWASP IoT Top 10** includes weak passwords, insecure network services, lack of secure update mechanisms, and use of outdated components
- Under **NIST SP 800-213**, federal agencies must ensure IoT devices support basic cybersecurity management, identity, and data protection capabilities before deployment

## Related concepts
[[Default Credentials]] [[Network Segmentation]] [[Botnet]] [[Firmware Analysis]] [[Attack Surface Management]]