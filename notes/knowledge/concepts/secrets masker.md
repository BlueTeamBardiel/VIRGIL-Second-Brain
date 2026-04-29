# secrets masker

## What it is
Like a censor blacking out classified words in a declassified document, a secrets masker intercepts output streams and automatically redacts sensitive strings before they appear in logs, terminals, or CI/CD pipelines. Precisely defined: it is a tool or library function that scans text output for patterns matching secrets (API keys, passwords, tokens) and replaces them with placeholder characters such as `***` or `[REDACTED]`.

## Why it matters
In 2020, numerous organizations suffered credential exposure when GitHub Actions workflows accidentally echoed AWS secret keys to publicly visible build logs. A secrets masker integrated into the CI/CD runner would have detected the key pattern and suppressed it before it ever reached the log file, preventing attackers from harvesting live credentials from public repositories.

## Key facts
- Secrets maskers operate on **pattern matching** (regex) and **known-value suppression** — they can redact a string they've been told is secret even if it doesn't match a known pattern
- They are a **compensating control**, not a substitute for proper secrets management (e.g., vaults); they reduce blast radius when secrets leak into output
- GitHub Actions, GitLab CI, and Jenkins all have native secrets masking — any variable marked as "secret/masked" is automatically suppressed from job logs
- **Partial exposure risk**: if a secret is split across two log lines or URL-encoded, naive maskers may fail to redact it — a known bypass technique
- Masking is **not encryption** — the secret exists unmasked in memory; masking only affects rendered output

## Related concepts
[[secrets management]] [[CI/CD pipeline security]] [[credential exposure]] [[data loss prevention]] [[environment variables]]