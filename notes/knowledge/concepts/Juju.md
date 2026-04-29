# Juju

## What it is
Like a universal remote control that can command any smart device in your house regardless of brand, Juju is a model-driven operations platform that deploys, configures, and manages software applications across cloud environments using reusable blueprints called "charms." It abstracts infrastructure complexity, allowing operators to define application relationships and lifecycle events declaratively rather than through manual configuration.

## Why it matters
In 2021, misconfigured Juju deployments in large-scale OpenStack environments exposed management APIs to the internet because operators trusted default charm configurations without reviewing network exposure settings. An attacker discovering an unauthenticated Juju controller could execute arbitrary commands across every machine in the managed infrastructure — turning one misconfiguration into a full enterprise compromise.

## Key facts
- Juju uses a **controller** node as the central command authority; compromising the controller grants remote execution capability across all managed "units" (deployed application instances)
- **Charms** are the deployment scripts/bundles — supply chain attacks targeting charm repositories (Charmhub) could inject malicious code into thousands of deployments simultaneously
- Juju communicates over **port 17070** by default; this port exposed publicly is a significant attack indicator
- Access control uses **macaroon-based authentication** tokens, which are bearer tokens — theft enables full impersonation without credentials
- Juju models (environments) often have **overly permissive cloud credentials** attached, meaning a Juju breach frequently cascades into full cloud account takeover (privilege escalation path)

## Related concepts
[[Infrastructure as Code Security]] [[Supply Chain Attack]] [[Privilege Escalation]] [[Cloud Misconfiguration]] [[API Security]]