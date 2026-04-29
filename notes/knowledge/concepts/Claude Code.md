# Claude Code

## What it is
Like giving a master locksmith an AI apprentice that can read blueprints, write instructions, and operate tools — but the apprentice lives entirely inside your terminal. Claude Code is an agentic command-line AI assistant developed by Anthropic that autonomously reads codebases, writes and edits files, executes shell commands, and interacts with external services to complete multi-step software engineering tasks.

## Why it matters
When a developer grants Claude Code broad filesystem and shell permissions without restriction, an attacker who crafts a malicious prompt embedded in a repository's README or source file could trigger **prompt injection** — causing the agent to exfiltrate secrets, modify CI/CD pipelines, or create backdoors autonomously. Defenders must apply least-privilege principles to agentic AI tools just as they would to any privileged service account.

## Key facts
- Claude Code operates with **agentic autonomy**, meaning it can chain tool calls (file reads, bash execution, web requests) without human approval for each step — expanding the attack surface compared to passive AI assistants
- **Prompt injection** is the primary threat vector: malicious instructions hidden in files, web pages, or API responses can hijack the agent's actions
- Anthropic designed Claude Code with **permission gating** — users can configure approval requirements for destructive actions like file deletion or outbound network calls
- Like a privileged service account, Claude Code should follow **least-privilege access control**: restrict filesystem scope, avoid running as root, and sandbox network access
- Agentic AI tools introduce a new class of risk called **indirect prompt injection**, distinct from classic injection attacks, where the payload arrives through data the agent retrieves rather than direct user input

## Related concepts
[[Prompt Injection]] [[Least Privilege]] [[Supply Chain Attack]] [[Agentic AI Security]] [[CI/CD Pipeline Security]]