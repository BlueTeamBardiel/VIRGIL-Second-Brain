# ingest/

Eight scripts that put new material into the vault. Two run nightly on cron. Six run when you tell them to. Output lands in `~/VIRGIL/notes/` under the subdirectory that matches the source — CVEs into `cve/`, daily feed digests into `feeds/`, cert material into `knowledge/<cert>/`, ad-hoc captures wherever you point them.

For the architectural shape — three layers, what passes through the gate, what stays local — see [ARCHITECTURE.md §8](../ARCHITECTURE.md#8-the-pipelines). This file is the script-by-script reference.

## What's here

| Script | Trigger | What it does | Output |
|---|---|---|---|
| `rss-ingest.py` | cron 06:00 daily | Pulls the 22 feeds in `FEEDS.md`, synthesizes a daily digest. | `notes/feeds/YYYY-MM-DD.md` |
| `cve-ingest.py` | cron 07:00 daily (`--recent`) | Pulls recent NVD CVEs, writes one Feynman-style note per CVE. | `notes/cve/CVE-YYYY-NNNNN.md` |
| `triage-inbox.sh` | cron 08:00 Monday | Asks the LLM whether each `notes/inbox/` item should merge, stay, or archive. | Moves/merges files in place |
| `wikilink-ingest.sh` | cron 23:30 daily | Inserts `[[wikilinks]]` where note titles match across the vault. | Edits in place |
| `orphan-detect.sh` | called by `weekly-rollup.sh` | Finds notes with zero inbound and zero outbound links. | Lines in weekly digest |
| `url-ingest.sh` | manual / `virgil-url` | Fetches a URL, writes a Feynman-style summary to the vault. | `notes/knowledge/<routed>/<slug>.md` |
| `pdf-ingest.sh` | manual / `virgil-pdf` | Extracts a local PDF, summarizes it into vault notes. | `notes/knowledge/<routed>/<slug>.md` |
| `cert-ingest.sh` | manual / `virgil-cert-ingest` | Ingests your own cert study material (PDF/URL/text) into a cert track. | `notes/knowledge/<cert>/<slug>.md` |

The cron entries above are installed by `scripts/install.sh` if you accept the crontab prompt. Disable any one with `crontab -e` — delete the line, save. Nothing else needs to change.

## Two backends

Every script that calls an LLM routes through `hooks/llm_client.py`. That client respects `VIRGIL_BACKEND` in your `.env`:

- `ollama` — local inference at `http://localhost:11434`. Nothing leaves your machine.
- `anthropic` — Anthropic API. Requires `ANTHROPIC_API_KEY`.

Swap backends by editing `.env`. No script changes needed.

## A note on the manual ingest helpers

`url-ingest.sh`, `pdf-ingest.sh`, and `cert-ingest.sh` produce derivative content from sources you point them at. The output is rewritten in Feynman style per `soul.md` — it is not a verbatim copy of the source. That said: if the source is copyrighted, the derivative is too. Use these for personal study. Don't push the output to a public repo without confirming the source license permits it.

## Where output lands

```
~/VIRGIL/notes/
├── knowledge/
│   ├── ccna/             ← cert-ingest --cert "CCNA"
│   ├── security-plus/    ← cert-ingest --cert "Security+"
│   ├── netplus/          ← cert-ingest --cert "Network+"
│   ├── aplus/            ← cert-ingest --cert "A+"
│   ├── cysa/             ← cert-ingest --cert "CySA+"
│   └── <routed>/         ← url-ingest, pdf-ingest (LLM picks the subdir)
├── feeds/                ← rss-ingest (one digest per day)
├── cve/                  ← cve-ingest (one note per CVE)
└── inbox/                ← drop notes here; triage-inbox files them weekly
```

The `notes/knowledge/cve/` directory shipped with the public repo is separate — it's the 239 curated starter CVEs. Your nightly runtime CVE feed lives at `notes/cve/`. See `notes/knowledge/cve/README.md`.

## Logs

Each script writes to `~/VIRGIL/logs/<script-name>.log` when it runs from cron. Tail those if a job goes silent.

## Adding your own

Each script is self-contained — read one before you write another. The pattern is: pull source data, call `hooks/llm_client.py` for synthesis, write the result into a vault subdirectory. The `cron` jobs use the same pattern as the manual helpers; the only difference is who triggers them.

If you fork and want a different ingest source (a different vendor's threat feed, a different vulnerability database, a different note format), copy the closest existing script and edit. `cve-ingest.py` is the cleanest reference for the "API → per-item note" pattern; `rss-ingest.py` is the cleanest for the "many items → one synthesized digest" pattern.
