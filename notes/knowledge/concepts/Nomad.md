# Nomad

## What it is
Like a temp worker who carries their own tools and plugs into any office's network without needing permanent credentials, Nomad is HashiCorp's open-source workload orchestrator that schedules and manages containers, VMs, and applications across distributed infrastructure. Unlike Kubernetes, it operates as a single binary and supports non-containerized workloads, making it highly flexible but also a broader attack surface.

## Why it matters
In August 2022, the Nomad bridge protocol (a cross-chain cryptocurrency bridge, distinct from HashiCorp's tool but sharing the name) suffered a $190M exploit due to a message verification flaw that allowed any user to spoof valid transactions — attackers copied the original exploit transaction and simply swapped destination addresses. For the orchestrator side, misconfigured Nomad ACLs in cloud environments have exposed the management API without authentication, allowing attackers to deploy malicious workloads across entire clusters, achieving container escape and lateral movement at scale.

## Key facts
- Nomad uses an **ACL token system** with default anonymous access; if ACLs are not bootstrapped, the entire cluster is unauthenticated and world-accessible
- The Nomad HTTP API runs on **port 4646** by default — exposure to the internet without authentication is a critical misconfiguration
- Nomad integrates with **Vault** for secrets management; a compromised Nomad agent can potentially inherit Vault tokens from running jobs
- Workload identity in Nomad uses **task-level tokens** — privilege escalation is possible if a low-privilege job can access the Nomad API from within the cluster
- The 2022 Nomad bridge crypto exploit demonstrated **replay attack** mechanics: lack of proper message uniqueness validation (no nonce enforcement) allowed mass fund drainage

## Related concepts
[[Container Orchestration Security]] [[Lateral Movement]] [[API Security]] [[Secrets Management]] [[Replay Attack]]