# source code repositories

## What it is
Think of a source code repository like a Google Docs revision history for software — every change, by every developer, with timestamps and author attribution, stretching back to the project's first line. Precisely, it is a version-controlled storage system (e.g., Git, SVN) that tracks all changes to a codebase over time. Platforms like GitHub, GitLab, and Bitbucket host these repositories, often making them publicly accessible.

## Why it matters
In 2022, a developer accidentally committed AWS secret keys into a public GitHub repository; automated credential-scanning bots found and exploited those keys within minutes to spin up cryptocurrency mining infrastructure. This illustrates why repositories are high-value attack surfaces — hardcoded secrets, API keys, and internal architecture details are routinely exposed through careless commits. Defenders use tools like **truffleHog** and **git-secrets** to scan commit histories for sensitive strings before or after accidental exposure.

## Key facts
- **Commit history never forgets**: deleting a file does not purge it from git history — secrets remain accessible via `git log` unless history is actively rewritten with tools like `git filter-branch` or BFG Repo Cleaner.
- **Public vs. private misconfiguration** is a common finding in penetration tests — developers accidentally set repositories to public, exposing internal tooling and credentials.
- **Supply chain attacks** (e.g., SolarWinds) often begin by compromising a source repository to inject malicious code into a legitimate build pipeline.
- **Branch protection rules** and **signed commits** (GPG signing) are key controls to prevent unauthorized code changes and ensure integrity.
- **SAST (Static Application Security Testing)** tools are frequently integrated directly into repositories via CI/CD pipelines to catch vulnerabilities at commit time.

## Related concepts
[[secrets management]] [[supply chain attacks]] [[CI/CD pipeline security]] [[static application security testing]] [[credential exposure]]