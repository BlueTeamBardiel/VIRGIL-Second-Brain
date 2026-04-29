# OPA

## What it is
Think of OPA like a courthouse judge who only rules on *policy questions* — you bring it the facts, it tells you what's allowed. Open Policy Agent (OPA) is an open-source, general-purpose policy engine that decouples authorization logic from application code using a declarative language called Rego. It evaluates structured input (JSON) against written policies and returns allow/deny decisions.

## Why it matters
In a Kubernetes environment, a misconfigured cluster once allowed any authenticated user to deploy privileged containers — a classic lateral movement enabler. OPA deployed as an Admission Controller webhook intercepts every API request and enforces policies like "no containers may run as root" or "all images must come from approved registries," blocking the attack before the workload ever starts. Without it, enforcement lives scattered across individual app codebases, making consistent security audits nearly impossible.

## Key facts
- OPA uses **Rego**, a purpose-built declarative query language — policies are written as rules, not imperative code
- Operates as a **sidecar, daemon, or library** — it's query-agnostic and works with Kubernetes, Terraform, microservices, and CI/CD pipelines
- Enforces **Policy-as-Code (PaC)**, meaning policies are version-controlled, reviewable, and testable like software
- OPA's **Gatekeeper** is the Kubernetes-native wrapper that integrates OPA as an Admission Controller using Custom Resource Definitions (CRDs)
- Decisions are **stateless and input-driven** — OPA doesn't store session data; it only evaluates what you send it at query time
- Supports **unit testing of policies** via `opa test` CLI, enabling security policies to go through CI pipelines before deployment

## Related concepts
[[Policy-as-Code]] [[Kubernetes Security]] [[Admission Controllers]] [[Zero Trust Architecture]] [[RBAC]]