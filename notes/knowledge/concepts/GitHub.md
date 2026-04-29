# GitHub

## What it is
Think of GitHub like a Google Docs revision history for code — every change is tracked, every contributor is logged, and old versions are always recoverable. Precisely, GitHub is a cloud-based platform built on Git that provides version control, collaborative development workflows, and code hosting for software projects.

## Why it matters
In 2022, attackers used automated bots to scan GitHub repositories within seconds of accidental credential commits — harvesting AWS keys, API tokens, and database passwords before developers could revoke them. This "secret sprawl" attack vector is so prevalent that GitHub now offers built-in **secret scanning** that alerts repository owners when credentials matching known patterns are pushed. Defenders must also audit public forks, since sensitive data accidentally committed to a private repo can persist in public forks even after deletion.

## Key facts
- **Exposed secrets are a top attack surface**: hardcoded credentials in public repos are harvested within minutes by automated scanners (e.g., TruffleHog, GitLeaks)
- **Supply chain risk**: compromised GitHub Actions workflows or third-party Actions can inject malicious code into CI/CD pipelines — relevant to SolarWinds-style attacks
- **Branch protection rules** are a key defense control — requiring signed commits and pull request reviews before merging to `main`
- **GitHub Advanced Security** includes Dependabot (vulnerable dependency alerts), code scanning (SAST), and secret scanning — directly relevant to CySA+ tooling knowledge
- Deleted commits are **not immediately purged** from Git history; `git filter-repo` or BFG Repo Cleaner are required to truly remove sensitive data from history

## Related concepts
[[Version Control Security]] [[CI/CD Pipeline Security]] [[Secret Management]] [[Supply Chain Attacks]] [[SAST]]