# Security Knowledge Notes

Notes on security concepts, tools, frameworks, techniques, and incident response. Populated by `virgil-pdf`, `virgil-url`, and `virgil-nist`.

## Getting Started

```bash
# Ingest a security paper or guide
virgil-pdf ~/Downloads/your-paper.pdf security

# Ingest a web article or blog post
virgil-url https://example.com/security-writeup "topic hint"

# Ingest a NIST publication (optimized framing)
virgil-nist ~/Downloads/NIST-SP-800-61r2.pdf
```

## Suggested Starting Points

You don't need to read everything before you start. Ingest these when you encounter them — let the graph build over time.

**Free resources worth ingesting first:**
- [NIST SP 800-61 Rev 2](https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final) — Incident Response guide, tested on CySA+
- [MITRE ATT&CK](https://attack.mitre.org) — use `virgil-url` on any technique page
- Any SANS reading room paper relevant to your current study topic
- The exam objectives PDF for whatever cert you're chasing (free from comptia.org, cisco.com, etc.)

## What Good Notes Look Like

A useful security note answers three questions:
1. What is this thing, in plain English?
2. How would an attacker use it (or how does it stop one)?
3. Where does this show up on the exam or in the real world?

VIRGIL's enrichment pipeline (when run) fills these in automatically. For notes you write manually, use this as your template.

See `notes/knowledge/README.md` for a full list of suggested resources.

## Tags

#security #knowledge-base
