# Git hooks

## What it is
Like a security guard who checks your badge *before* you enter the building rather than after, Git hooks are scripts that automatically fire at specific points in the Git workflow. Precisely: they are executable scripts stored in `.git/hooks/` that trigger on events like `pre-commit`, `post-merge`, or `pre-push`, allowing automated actions to run before or after Git operations complete.

## Why it matters
Attackers who compromise a developer's machine or a shared repository can plant malicious Git hooks to silently exfiltrate code, inject backdoors into commits, or steal credentials on every `git pull`. In the 2022 supply chain attack landscape, malicious `post-checkout` hooks were identified as a vector for establishing persistence on developer workstations, since hooks run with the permissions of the user executing the Git command — no elevation required.

## Key facts
- Hook scripts live in `.git/hooks/` and are **not tracked by version control by default**, meaning they won't appear in `git diff` or `git log`, making them stealthy persistence mechanisms.
- A `pre-commit` hook can enforce defensive controls: secret scanning (e.g., blocking AWS keys), linting, and SAST tool execution before bad code ever reaches the remote repository.
- Hooks must be **executable** (`chmod +x`) to run; non-executable hook files are silently ignored — a common misconfiguration defenders exploit to disable malicious hooks quickly.
- The `post-merge` hook fires after every `git pull`, making it a prime target for attackers embedding persistent malware in a cloned repository.
- Organizations can enforce centralized hooks using `core.hooksPath` in Git config, pointing to a controlled, auditable directory outside `.git/`.

## Related concepts
[[Supply Chain Attacks]] [[Persistence Mechanisms]] [[Secrets Management]] [[Static Application Security Testing]] [[Least Privilege]]