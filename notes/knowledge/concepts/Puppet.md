# Puppet

## What it is
Like a stage director who hands every actor the same script and ensures no one improvises, Puppet is a configuration management tool that enforces a declared "desired state" across thousands of servers simultaneously. It uses a client-server model where a Puppet Master pushes configurations written in Puppet DSL to agents running on managed nodes, ensuring every system stays identical and compliant.

## Why it matters
In 2020, attackers compromising a single SolarWinds-style build pipeline demonstrated how configuration management infrastructure is a high-value target — owning the Puppet Master means owning every node it manages. Defenders use Puppet to enforce security baselines (disabling telnet, enforcing SSH key policies, ensuring firewall rules) at scale, making drift detection and remediation automatic rather than manual.

## Key facts
- Puppet uses a **pull model** by default: agents check in with the Puppet Master every 30 minutes to retrieve and apply their catalog
- Configurations are written as **manifests** (.pp files) describing resources in idempotent "desired state" syntax — running them repeatedly produces the same result
- The Puppet Master uses **SSL/PKI certificates** to authenticate agents, making certificate authority compromise a critical attack surface
- Puppet supports **compliance enforcement** mapped to CIS Benchmarks and STIG standards, directly relevant to continuous compliance monitoring (CySA+ domain)
- Compromise of the Puppet Master constitutes a **lateral movement and persistence** mechanism — an attacker can deploy malicious configurations as legitimate "managed state" across the entire fleet

## Related concepts
[[Configuration Management]] [[Infrastructure as Code]] [[Supply Chain Attack]] [[Hardening Baselines]] [[Privileged Access Management]]