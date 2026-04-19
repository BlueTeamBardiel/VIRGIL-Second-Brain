# VIRGIL — Cost Analysis: Cloud API vs Local Inference

An honest breakdown of what VIRGIL costs to run, before and after adding local GPU inference.

---

## Before: Full Cloud (Anthropic API Only)

VIRGIL originally ran 16 scripts against the Anthropic API. Estimated daily token consumption:

| Script | Model | Approx input | Approx output | Notes |
|---|---|---|---|---|
| `rss-ingest.py` | Haiku | ~8,000 | ~1,200 | 22 feeds, 24h window |
| `cve-ingest.py` | Haiku | ~12,000 | ~2,500 | ~50 CVEs, each with description + fields |
| `auto-reflect.sh` | Haiku | ~2,000 | ~600 | fills 1-3 session stubs |
| `promote.sh` | Haiku | ~4,000 | ~1,500 | full daily log → memory extraction |
| `weekly-rollup.sh` | Haiku | ~20,000 | ~3,000 | 7 logs + feeds (Sunday only, ~÷7/day) |
| `triage-inbox.sh` | Haiku | ~3,000 | ~800 | Monday only, per inbox note (÷7/day) |
| `wikilink-ingest.sh` | — | — | — | no LLM call; regex only |
| `url-ingest.sh` | Haiku | ~2,000 | ~800 | per-URL; 2-5 URLs/day typical |
| `pdf-ingest.sh` | Haiku | ~6,000 | ~1,500 | per chunk; only on new PDFs |
| Other scripts | Haiku | ~2,000 | ~500 | session hooks, misc |
| **Daily total** | | **~35,000–55,000** | **~9,000–12,000** | |

**Claude Haiku 4.5 pricing** (as of mid-2026):
- Input: $0.80 / MTok
- Output: $4.00 / MTok

```
Daily cost estimate:
  Input:  50,000 tokens × $0.80/MTok  = $0.040
  Output: 10,000 tokens × $4.00/MTok  = $0.040
  ─────────────────────────────────────────────
  Daily total:                          ~$0.08
  Monthly:                              ~$2.40
  Annual:                               ~$29
```

At typical usage this is modest — but it adds friction: every script needs the API key, every invocation waits on network latency, and rate limits become a problem during heavy enrichment runs (the enrichment pipeline alone consumes 2-5M tokens per batch).

**Enrichment pipeline costs** (one-time vault build):
```
  ~2,000 notes × ~1,500 tokens avg = 3M tokens input
  ~2,000 notes × ~600 tokens output = 1.2M tokens output

  Input:  3,000,000 × $0.80/MTok   = $2.40
  Output: 1,200,000 × $4.00/MTok   = $4.80
  ─────────────────────────────────────────
  One enrichment run:               ~$7.20
```

That's per full-vault enrichment. With Opus 4.7 for quality-sensitive notes (attack concepts, algorithms), the per-run cost climbs to $15–25.

---

## After: Local-First with Cloud Fallback

The three-tier LLM stack routes daily automation through local GPU inference first.

### Hardware (one-time costs)

| Component | Where | Cost | Purpose |
|---|---|---|---|
| RX 9070 XT 16GB (or similar) | primary-host | ~$600 | Primary inference GPU, 16GB VRAM |
| RX 6700 XT 12GB (or similar) | backup-node | ~$250 | Backup inference GPU, 12GB VRAM |
| **Total GPU hardware** | | **~$850** | |

Both machines are existing homelab hardware — these costs reflect GPU-only additions. If you're buying from scratch, a used RX 6700 XT runs $180–220 and handles VIRGIL's full pipeline without issue. CPU-only inference works too, just slower.

### Ongoing electricity

| Node | GPU TDP | Hours/day active | Cost/day (at $0.12/kWh) |
|---|---|---|---|
| primary-host | ~200W under load | ~2h inference | ~$0.048 |
| backup-node | ~150W under load | ~0.5h inference | ~$0.009 |
| **Daily electricity** | | | **~$0.057** |

Scripts complete faster locally (no network round-trip), so actual wall-clock GPU time is less than you'd expect. The nightly pipeline runs in under 15 minutes total.

### API costs (residual)

With local inference handling daily automation:
- Enrichment runs (high-quality vault builds): still use Anthropic. ~$7–25 per run, run occasionally.
- Fallback invocations when local stack is down: negligible.
- Claude Code sessions (this interface): separate billing, not VIRGIL automation.

Monthly API spend with local stack: **~$0–5**, down from ~$2.40 for routine automation alone, plus avoidance of enrichment-run costs.

---

## Break-Even

```
  Hardware cost:           $850 (GPU additions)
  Monthly savings:         ~$2.40 automation + variable enrichment savings
  
  Pure automation break-even:   ~29 years  (not the point)
  
  Including enrichment runs:
    At $15/run, 1 run/month:    ~4.7 years
    At $15/run, 4 runs/month:   ~14 months
```

The financial break-even on automation alone is not the argument for local inference. The real arguments are:

1. **Latency.** Local inference has no network round-trip. Scripts complete faster. The nightly pipeline doesn't stall waiting on API responses at 2am.

2. **Rate limits.** The enrichment pipeline processes thousands of notes in a single run. Local inference has no rate limit. Anthropic's API requires careful batching and retry logic.

3. **Offline operation.** The vault works fully when the API is unavailable, the internet is down, or you're on a restricted network.

4. **Privacy.** Daily logs contain notes about your study progress, job applications, and lab configuration. Local inference means that content stays local.

5. **Model control.** You choose which model runs. You can test different models against the same prompt without per-token costs.

The GPU was going to be purchased for the homelab anyway. The inference capability is a byproduct.

---

## Summary Table

| Metric | Cloud only | Local + Cloud fallback |
|---|---|---|
| Daily automation cost | ~$0.08 | ~$0.057 electricity |
| Enrichment run cost | $7–25 per run | $0 (local) |
| Rate limit risk | Yes | No (local tier) |
| Network dependency | Required | Optional |
| Latency per call | 1–3s (API) | 0.5–2s (local GPU) |
| Setup complexity | Low | Medium |
| Privacy | API provider sees data | Local stays local |
