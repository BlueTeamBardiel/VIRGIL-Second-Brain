# langflow

## What it is
Like a drag-and-drop circuit board for AI pipelines, Langflow is a visual, low-code development platform that lets you assemble LLM-powered applications by connecting components — models, memory, APIs, data sources — as nodes in a flow diagram. It is built on top of LangChain and exposes a REST API, making it easy to deploy agentic AI workflows without writing extensive code.

## Why it matters
In 2024, CVE-2024-37393 and the critical **CVE-2025-3248** (CVSS 9.8) revealed that Langflow's `/api/v1/validate/code` endpoint allowed unauthenticated remote code execution by passing arbitrary Python directly to an `exec()` call — no login required. Attackers could fully compromise any internet-exposed Langflow instance, gaining shell access to the underlying server and any secrets (API keys, database credentials) stored in the environment.

## Key facts
- **CVE-2025-3248** is a pre-authentication RCE vulnerability in Langflow versions before 1.3.0, scoring a 9.8 CVSS — patched by restricting unauthenticated API access and sanitizing code execution endpoints.
- Langflow runs as a web service (default port **7860**), often deployed internally on cloud VMs or containers, making exposed instances a high-value target in cloud attack surface reviews.
- The root cause pattern — passing user-supplied input to `exec()` or `eval()` — is a classic **Insecure Deserialization / Code Injection** weakness (CWE-94).
- Threat intelligence firms observed the Langflow RCE being actively exploited in the wild within days of public PoC release, underscoring the risk of unpatched AI tooling.
- Defensive mitigations include: requiring authentication on all API endpoints, network-level access controls (firewall rules, VPN), and scanning container images for known CVEs before deployment.

## Related concepts
[[Remote Code Execution]] [[Injection Attacks]] [[API Security]] [[CVE Vulnerability Management]] [[Supply Chain Security]]