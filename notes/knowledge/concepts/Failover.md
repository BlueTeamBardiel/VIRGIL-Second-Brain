# Failover

## What it is
Like a hospital generator that kicks on the instant the power grid fails — no doctor flips a switch, it just *happens* — failover is the automatic transfer of workload from a failed primary system to a standby backup system. It is a high-availability mechanism designed to maintain service continuity with minimal or zero downtime when a primary component becomes unavailable.

## Why it matters
During a DDoS attack that overwhelms a primary web server, a properly configured failover system automatically routes traffic to a secondary server in a different data center, keeping the service alive. Without failover, the same attack achieves its goal: total service disruption. Attackers sometimes deliberately trigger failover to land traffic on a less-hardened backup system, making secondary systems equally important to harden.

## Key facts
- **RTO (Recovery Time Objective)** defines the maximum acceptable downtime; failover systems are designed to meet it — often measured in seconds for hot standby configurations
- **Hot standby** = fully synchronized and instantly active; **warm standby** = partially synced, needs minutes to activate; **cold standby** = offline, may take hours
- Failover can be **automatic** (triggered by heartbeat signal loss) or **manual** (requires human intervention) — automatic is faster but risks false-positive triggering
- **Geographic failover** (active-passive across regions) protects against site-level disasters like power outages or physical attacks
- Failover clusters use a **heartbeat network** — a private link between nodes — to detect primary failure; compromising this link can cause *split-brain* conditions where both nodes believe they are primary

## Related concepts
[[High Availability]] [[Redundancy]] [[Business Continuity Planning]] [[Recovery Time Objective]] [[Load Balancing]]