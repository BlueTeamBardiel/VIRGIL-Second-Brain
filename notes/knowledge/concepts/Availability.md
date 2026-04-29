# availability

## What it is
Like a 911 emergency line that must answer calls even during a hurricane, availability means authorized users can access systems and data whenever they need them. It is the "A" in the CIA triad, ensuring that services remain operational and accessible to legitimate users without unacceptable delay or interruption.

## Why it matters
In 2016, the Mirai botnet hijacked hundreds of thousands of IoT devices and launched a massive DDoS attack against Dyn DNS, taking down Twitter, Netflix, Reddit, and PayPal for hours. This was a pure availability attack — no data was stolen, no confidentiality was breached, but legitimate users were completely locked out, costing millions in lost revenue and eroding trust.

## Key facts
- **DDoS (Distributed Denial of Service)** is the primary network-layer availability attack; mitigations include rate limiting, traffic scrubbing, and CDN-based absorption
- **RTO (Recovery Time Objective)** and **RPO (Recovery Point Objective)** are the key metrics for measuring availability in disaster recovery planning
- The "five nines" standard (99.999% uptime) allows only ~5.26 minutes of downtime per year and is a common benchmark for critical infrastructure
- **Redundancy**, **failover clusters**, and **load balancing** are the architectural defenses for maintaining high availability
- Ransomware is simultaneously a confidentiality AND availability attack — it denies access to data by encrypting it, making restoration speed critical

## Related concepts
[[CIA Triad]] [[DDoS Attack]] [[Disaster Recovery]] [[Redundancy]] [[Ransomware]]