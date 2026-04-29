# Runners

## What it is
Like a relay race where each runner carries a baton through their leg of the course, a CI/CD runner is an agent that picks up a pipeline job and executes it — carrying code from commit to deployment through its assigned environment. Precisely, runners are lightweight execution environments (physical machines, VMs, or containers) that listen for pipeline tasks from a CI/CD orchestrator (like GitHub Actions or GitLab CI) and run build, test, or deploy scripts on behalf of developers.

## Why it matters
In 2023, attackers compromised a self-hosted GitHub Actions runner at a software firm by injecting a malicious workflow via a pull request — the runner executed the attacker's code with full network access to internal infrastructure, exposing secrets and enabling lateral movement. This attack class is known as a **poisoned pipeline execution (PPE)** and is only possible because runners inherit whatever permissions and network access their host environment has.

## Key facts
- **Self-hosted runners** are high-risk: they persist between jobs, can cache secrets, and often have elevated privileges compared to cloud-hosted runners.
- GitHub-hosted runners are **ephemeral** — spun up fresh per job and destroyed after, limiting persistence but not secrets exposure via logs.
- Runners can be targeted via **script injection** when untrusted user input (e.g., PR branch names) flows into shell commands inside workflow files.
- The principle of **least privilege** demands runners only have access to the secrets and network resources strictly required for their job.
- Malicious `GITHUB_TOKEN` or environment variable exfiltration through a compromised runner is a top CI/CD attack vector recognized in the **CISA/NSA Supply Chain guidance** and OWASP CI/CD Top 10.

## Related concepts
[[CI/CD Pipeline Security]] [[Supply Chain Attacks]] [[Secrets Management]] [[Privilege Escalation]] [[Code Injection]]