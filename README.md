# VIRGIL

*A self-building knowledge base for people learning cybersecurity the hard way.*

![Version](https://img.shields.io/badge/version-v1.1.0-blue) ![Platform Linux](https://img.shields.io/badge/platform-Linux-informational) ![Platform macOS](https://img.shields.io/badge/platform-macOS-informational) ![Platform Windows WSL2](https://img.shields.io/badge/platform-Windows%20WSL2-informational) ![License MIT](https://img.shields.io/badge/license-MIT-green)

**VIRGIL is an Obsidian vault + automation system** that ingests threat intel, CVEs, and study material daily — and uses local or cloud AI to turn it into a knowledge graph you actually remember.

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/BlueTeamBardiel/VIRGIL-Second-Brain/main/scripts/install.sh)
```

No API key required. Runs on your own hardware via [Ollama](https://ollama.com). Twenty-minute setup.

![VIRGIL knowledge graph](assets/virgil-graph.gif)

---

## I. Who This Is For

You're studying for a cert. Or building a homelab. Or trying to absorb threat intel that drops faster than you can process it.

The advice online is everywhere and contradictory. Every roadmap has an affiliate link. The subreddit post with 3,000 upvotes was written by someone hired in a completely different market. You're studying in the gaps between applications, and nothing is sticking — because there's no system holding it together.

That's a structural problem, not a personal one. VIRGIL is what fixes it.

Built during exactly this grind — not by someone who packaged lessons into a course after making it — but live, under pressure, while studying for CySA+, running a homelab, and navigating a tough job market. You don't have to build it from scratch. Use what's here.

---

## II. The Grind

Job hunting in IT is slow. You apply, wait, hear nothing. Apply again. The advice says keep going — and it's right, even when it's not helpful.

The structural problem isn't willpower. It's that there's nothing connecting your work. You study for a week, take a break, come back and half of it is gone. You apply to a dozen jobs, get one response, then forget what you studied while you were prepping for a different role. Knowledge evaporates because nothing is holding it.

VIRGIL is what holds it. Your session notes feed into a nightly AI distillation. Your CVE ingest connects to ATT&CK techniques which connect to NIST controls which connect to the lab config where you saw it live. The graph compounds. You don't start from zero every time you sit down.

---

## III. The Impostor

Everyone in this field feels it — the sense that everyone else understood something you didn't quite catch. That feeling doesn't mean you're wrong for being here. It means you're being honest about what you don't know yet. The people who never feel it are the ones you should worry about.

What actually builds confidence: pattern recognition through repetition and review. Not a different personality type. Not more hours of video content. Repetition, feedback, and a system that shows you what you know and what you don't.

VIRGIL handles the system part.

---

## IV. VIRGIL

*Nel mezzo del cammin di nostra vita — midway through the journey of our life, I came to myself in a dark wood, for the straight way was lost.*

Dante wrote that in 1308. Virgil — the Roman poet — was sent to guide him through what came next. Not to skip it. Not to make it comfortable. To make it survivable. To show him the structure of what he was walking through so he could stop being afraid of the wrong things.

This project is named for him. The field is the dark wood. VIRGIL is the guide.

---

## V. What VIRGIL Actually Is

An Obsidian-based knowledge system built for people learning cybersecurity and IT without a map.

- **Daily session logs** — capture what you actually did, not what you planned to do
- **Memory system** — nightly AI distillation of logs into permanent facts and lessons; work accumulates instead of evaporating
- **Automated ingestion** — 22+ threat intel feeds every morning, NVD CVE feed daily
- **Study tools** — Feynman-style sessions for CySA+, CCNA, Security+; they push back and find the gaps
- **Local AI inference** — runs on your hardware via Ollama, with cloud fallback when needed

After six months of real use: not 500 disconnected files, but a knowledge graph — CVEs linked to ATT&CK techniques linked to NIST controls linked to the lab config where you saw it in practice.

Technical setup and full configuration: [`GETTING-STARTED.md`](GETTING-STARTED.md)

---

## VI. What VIRGIL Does for You

Guides you. Teaches you. Pushes back when you're wrong.

If you're explaining a concept incorrectly, it says so. If you think you've mastered something and there's a gap, it asks the follow-up question that exposes it. Teaching method is Feynman-style: if you can't explain it in plain English to someone who's never heard of it, you don't understand it yet.

It tracks what you know and what you don't. Links your notes. Shows you the shape of what you've built over time.

It does not congratulate you for showing up. The work is the work. VIRGIL is how you make it compound.

---

## Get Started

**What you need:**
- Linux, macOS, or Windows (via WSL2)
- Python 3.9+
- [Obsidian](https://obsidian.md) (free)
- Anthropic API key — optional (local inference via Ollama works without one)

**Quick install:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/BlueTeamBardiel/VIRGIL-Second-Brain/main/scripts/install.sh)
```

The installer handles vault structure, dependency checks, crontab, and a live CVE demo. Full guide: [GETTING-STARTED.md](GETTING-STARTED.md)

---

*"I have come to lead you to the other shore; into eternal darkness; into fire and into ice."*
*— Virgil, Inferno Canto III*

The path is real. It is not comfortable, and it does not get easier. You get more capable — which is a different thing.
