# Trufflehog

## What it is
Like a metal detector sweeping a beach for buried coins, TruffleHog scans Git repositories and commit histories searching for high-entropy strings and regex patterns that signal exposed secrets. It is an open-source credential scanning tool that analyzes code repositories — including their entire commit history — to detect accidentally committed secrets such as API keys, passwords, private keys, and tokens.

## Why it matters
A developer at a fintech company accidentally commits an AWS secret access key to a public GitHub repository, then immediately deletes it in the next commit — believing the secret is gone. An attacker (or defender using TruffleHog) runs a historical scan and recovers the credential from the earlier commit, enabling full S3 bucket access and data exfiltration. TruffleHog's ability to traverse the *entire* Git history is precisely what makes it dangerous in attacker hands and essential in defender hands.

## Key facts
- TruffleHog detects secrets using two primary methods: **high-entropy string detection** (random-looking strings like cryptographic keys) and **regex pattern matching** (known formats like AWS `AKIA...` key prefixes)
- It scans **full Git commit history**, not just the current codebase — secrets deleted in later commits are still discoverable
- TruffleHog v3 introduced **verified detectors** that actively test discovered credentials against live APIs to confirm if they are still valid and exploitable
- It supports scanning beyond Git: **S3 buckets, Jira, Slack, filesystems**, and more, making it a broad secrets-discovery platform
- Classified as both a **red team reconnaissance tool** and a **blue team secrets management auditing tool** — context determines its role

## Related concepts
[[Secrets Management]] [[Credential Exposure]] [[Git Repository Security]] [[SAST]] [[Attack Surface Management]]