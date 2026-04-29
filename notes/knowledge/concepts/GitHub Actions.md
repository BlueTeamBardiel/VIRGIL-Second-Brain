# GitHub Actions

## What it is
Think of it like a robot janitor with master keys — it automatically runs tasks whenever someone touches code, with full access to secrets and deployment pipelines. GitHub Actions is a CI/CD automation platform built into GitHub that executes defined workflows (written in YAML) triggered by repository events like pushes, pull requests, or scheduled timers.

## Why it matters
In 2023, attackers compromised the `tj-actions/changed-files` supply chain action, causing thousands of downstream repositories to leak their CI/CD secrets directly into public build logs. This demonstrates how a single poisoned third-party Action can pivot across hundreds of organizations simultaneously — one dependency becomes a master key to every secret stored in those pipelines.

## Key facts
- **Secrets exposure risk**: Workflow files can accidentally echo `${{ secrets.AWS_KEY }}` into logs; misconfigured `pull_request_target` triggers allow forked PRs to access repo secrets they shouldn't touch
- **GITHUB_TOKEN abuse**: Every workflow receives an auto-generated token — if permissions aren't scoped to `read-only`, a compromised workflow can push code, modify releases, or alter branch protections
- **Poisoned pipeline execution (PPE)**: Attackers who can modify `.github/workflows/` YAML gain arbitrary code execution in the CI environment with access to all stored secrets
- **Third-party Actions risk**: Using `uses: some-org/action@main` (floating ref) instead of a pinned SHA commit hash means supply chain updates can silently inject malicious code
- **Self-hosted runner danger**: Self-hosted runners that persist between jobs can be poisoned via environment variable injection, affecting subsequent unrelated builds

## Related concepts
[[CI/CD Pipeline Security]] [[Supply Chain Attack]] [[Secrets Management]] [[Principle of Least Privilege]]