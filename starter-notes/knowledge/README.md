# Knowledge Base

This directory holds structured notes ingested from PDFs, URLs, and documentation. It's your personal technical reference library — everything you've read, summarized and cross-linked.

## Subdirectories

| Directory | Contents |
|-----------|----------|
| `security/` | Security concepts, frameworks, tools, techniques |
| `networking/` | Networking protocols, configurations, lab notes |
| `nist/` | NIST Special Publications (SP 800-series, FIPS) |

## Ingesting Study Materials

### PDFs

```bash
# Ingest a security whitepaper
virgil-pdf ~/Downloads/SANS-SEC401.pdf security

# Ingest a networking textbook (large — will chunk automatically)
virgil-pdf ~/Downloads/CCNA-Study-Guide.pdf networking

# Ingest a NIST publication (uses exam-optimized framing)
virgil-nist ~/Downloads/NIST-SP-800-53r5.pdf
```

Large PDFs (>80,000 characters extracted) are automatically split into chunks, summarized per-chunk, then synthesized into a single clean note. A 600-page textbook becomes a structured, searchable reference in minutes.

### URLs

```bash
# Ingest a NIST page
virgil-url https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final

# Ingest a blog post or writeup
virgil-url https://example.com/writeup "buffer overflow"

# Ingest MITRE ATT&CK (auto-routes to notes/mitre/)
virgil-url https://attack.mitre.org/techniques/T1055/
```

## Suggested Resources to Ingest

### Free PDFs Worth Ingesting

**NIST Publications** (free at csrc.nist.gov):
- SP 800-61 Rev 2 — Computer Security Incident Handling Guide
- SP 800-53 Rev 5 — Security and Privacy Controls
- SP 800-115 — Technical Guide to Information Security Testing
- SP 800-137 — Information Security Continuous Monitoring

**SANS Reading Room** (free whitepapers at sans.org/reading-room):
- Incident Response papers
- Intrusion Detection papers
- Network security papers

**CompTIA Study Materials**:
- CySA+ Study Guide (official or third-party)
- Security+ exam objectives PDF (free from comptia.org)

**Vendor Documentation**:
- Elastic Security Detection Rules documentation
- Wazuh documentation
- Suricata user guide

## Tags

#knowledge-base #study-materials #pdf-ingest
