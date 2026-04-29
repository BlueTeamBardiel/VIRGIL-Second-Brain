# git

## What it is
Think of git like a time machine for code — every change is photographed, labeled, and stored so you can rewind to any moment in history. Precisely, git is a distributed version control system (DVCS) that tracks changes to files across a project, allowing multiple contributors to collaborate while maintaining a complete, cryptographically chained history of every modification.

## Why it matters
Developers routinely accidentally commit secrets — API keys, passwords, private certificates — into public GitHub repositories, where automated scanners (like truffleHog or GitGuardian) harvest them within seconds. Attackers who find a leaked AWS key in a public repo's commit history can spin up thousands of cloud instances for cryptomining before the developer even notices. Even after deletion, the secret persists in git history unless the repo is explicitly purged using tools like `git filter-branch` or BFG Repo-Cleaner.

## Key facts
- **`.git` directory exposure**: If a web server misconfiguration exposes the `.git` folder, attackers can reconstruct the entire source code and extract secrets using tools like `git-dumper`
- **Commit history is permanent by default** — deleting a file in a new commit does NOT remove it from previous commits; secrets survive until history is rewritten
- **Signed commits** use GPG keys to verify author identity, protecting against supply chain attacks where an attacker impersonates a trusted developer
- **Branch protection rules** in platforms like GitHub can enforce code review and prevent direct pushes to `main`, reducing insider threat and accidental exposure risk
- **CI/CD pipeline integration** means a compromised git repository can trigger malicious build pipelines, making it a critical attack surface in software supply chain attacks

## Related concepts
[[Supply Chain Attack]] [[Secrets Management]] [[CI/CD Security]] [[Code Repository Security]]