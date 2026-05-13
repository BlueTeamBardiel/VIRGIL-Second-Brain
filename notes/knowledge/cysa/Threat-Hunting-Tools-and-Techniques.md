# Threat Hunting Tools and Techniques

## What it is

In **Factorio**, you don't wait for biters to chew through your wall to know you have a problem. You walk the perimeter at dusk with a submachine gun, eyes on the pollution cloud, looking for chunks where the spawners have crept closer than your last patrol. You drop a few radar stations in dead space just to *see what's out there*. You leave a half-built outpost with one turret on it — not because you need the iron, but because if something is hunting your base, it'll hit the soft target first and your alarms will tell you where the swarm is coming from. That's exactly what threat hunting is — proactive, hypothesis-driven adversary discovery before the alert ever fires.

In CS0-003 language: **threat hunting** is the discipline of proactively searching through networks, endpoints, and logs to detect threats that have evaded existing security controls. Unlike detection-and-monitoring (reactive — wait for the SIEM rule to fire), hunting starts with a hypothesis ("if an attacker is living off the land in our environment, I'd expect to see encoded PowerShell spawning from Office processes") and goes looking for evidence. **Active defense** is the broader umbrella: deception, fake targets, traffic manipulation, and instrumented bait designed to surface adversaries who think they're being quiet.

## Why it matters

The dwell-time problem is the entire reason this domain exists. Industry reporting on APTs consistently shows median dwell — time from initial compromise to detection — measured in weeks for well-resourced organizations and months for everyone else. Your SIEM rules catch what you told them to catch. Threat hunting is how you find what you *didn't* think to write a rule for.

CompTIA tests this under **Objective 1.4** (threat-intelligence and threat-hunting concepts). They want you to know the difference between threat *intelligence* (the inputs — feeds, IoCs, TTPs from outside) and threat *hunting* (the activity — using those inputs plus your own data to chase the adversary inside your perimeter). Expect questions on hunting methodology, honeypots vs honeynets vs darknets, and the operational difference between active and passive defense.

Career-wise: hunting is the bridge from L1 alert-monkey to L2/L3 analyst. Anyone can close tickets. Hunters generate detections that didn't exist before they showed up.

## Key facts

### Threat hunting methodology

Hunting is **hypothesis-driven**. You don't wander the logs hoping something jumps out — you state a specific adversary behavior, define what evidence would prove it, and query for that evidence.

| Phase | What happens |
|---|---|
| **Trigger** | New TTP from threat intel, IoC from an ISAC, crown-jewel asset risk review, or anomaly spotted casually |
| **Hypothesis** | "Adversary X uses technique Y; we'd see Z in our telemetry" |
| **Collection** | Pull from SIEM, EDR, NetFlow, DNS logs, identity logs — whatever proves or disproves Z |
| **Analysis** | Pivot, correlate, stack-rank rare events, look for outliers |
| **Outcome** | One of three: confirmed compromise → IR; no evidence → close hunt, document; new detection logic → write SIEM rule so this hunt becomes automatic next time |

The third outcome is the whole point. *A hunt that doesn't become a detection rule is a hunt you'll have to run again next quarter.*

### Focus areas — where to hunt

You can't hunt everywhere at once. CompTIA expects you to prioritize:

- **Business-critical assets** — domain controllers, code-signing servers, finance systems, ERP, customer PII stores. The crown jewels.
- **Configurations and misconfigurations** — drift from baseline, unexpected admin group membership, disabled logging, new local accounts, GPO changes.
- **Isolated networks** — OT/ICS, air-gapped segments, dev environments. They're isolated because they're fragile or sensitive, which means they're also the worst-monitored.
- **Internal sources and processes** — service accounts behaving oddly, scheduled tasks no one created, scripts running from %TEMP%, signed binaries in user-writable paths.

### Active defense — the deception arsenal

Active defense doesn't mean hack-back. It means making your environment hostile to reconnaissance and lateral movement. Three tools CompTIA tests by name:

**Honeypots**
- A single intentionally vulnerable system, instrumented for observation
- Has no legitimate business function — therefore *any* interaction is suspicious by definition
- Low false-positive rate is the entire selling point
- Examples: a fake "fileserver-backup-OLD" SMB share with juicy filenames; a SQL server with weak creds that only logs connections; a SSH daemon that records every keystroke
- **Low-interaction**: emulates services, cheap, easy, but obvious to skilled attackers
- **High-interaction**: real OS, real services, expensive, requires babysitting, but catches sophisticated TTPs

**Honeynets**
- A network of honeypots — multiple decoys wired together to look like a real subnet
- Lets you observe **lateral movement** behavior, not just initial probe
- Watch how the adversary moves from the fake web server to the fake DB to the fake DC — gold for TTP collection

**Darknets**
- Unused but monitored IP space inside your network
- Nothing should ever talk to or from these addresses
- Any packet hitting a darknet IP is, by definition, either misconfiguration or recon
- Cheap to deploy, brutally effective at catching internal scanners

Other active-defense moves: **traffic slowing** (tarpitting — make the attacker's scan take 400x longer), **fake targets** (decoy credentials in memory that trip an alert when used, decoy files with canary tokens that beacon home when opened), and **breadcrumbs** (planted artifacts that lead an attacker into instrumented territory).

### Threat intel inputs that fuel hunts

Hunting without intel is wandering. The intel sources CompTIA cares about:

| Source type | Examples | Trade-off |
|---|---|---|
| **Open source (OSINT)** | Blogs/forums, social media, GitHub, vendor research posts | Free, broad, noisy, often dated |
| **Closed source** | Vendor reports requiring NDA, ISAC member-only briefings | Curated, higher quality, restricted |
| **Paid feeds** | Commercial threat intel platforms | Timely, formatted (STIX/TAXII), expensive |
| **Government bulletins** | CISA alerts, FBI Flash, NCSC advisories | Authoritative, sometimes slow, sometimes vague |
| **CERT / CSIRT** | US-CERT, regional CERTs, sector CSIRTs | Coordinated, trustworthy, post-incident heavy |
| **Information sharing orgs** | ISACs (FS-ISAC, H-ISAC, E-ISAC), ISAOs | Peer-sourced, sector-specific, requires reciprocity |
| **Deep/dark web** | Underground forums, leak sites, ransomware blogs | Early warning on stolen data, leaked creds, exploit sales |
| **Internal sources** | Your own past incidents, IR reports, prior hunt outputs | Highest relevance — it's literally about your environment |

### Evaluating intel — the four qualities

Before you act on a feed item, weigh it on four axes:

- **Timeliness** — is this hot, or is it from a 2019 incident?
- **Relevancy** — does this actor/TTP/IoC apply to your sector, your stack, your geography?
- **Accuracy** — has the source been right before? False positives burn analyst hours and credibility
- **Confidence level** — what's the source's own stated confidence? STIX expresses this explicitly; treat low-confidence indicators as hunting leads, not blocking rules

### Threat actors worth hunting for

Hunts are shaped by the adversary you expect. CompTIA lists these:

- **Nation-state** — APTs, well-resourced, patient, custom tooling, long dwell. Hunt for low-and-slow beaconing, supply-chain implants, credential abuse.
- **Organized crime** — ransomware crews, financially motivated, fast. Hunt for living-off-the-land binaries, Cobalt Strike, rapid lateral movement, backup deletion.
- **Hacktivists** — ideology-driven, often opportunistic. Hunt for web defacement attempts, DDoS recon, leaked-credential reuse.
- **Insider threat** — intentional (data theft, sabotage) or unintentional (clicked the link, plugged in the USB). Hunt user behavior anomalies, off-hours access to atypical data, mass file copies to removable media or cloud.
- **Script kiddie** — low skill, public tools. Noisy. Your existing detections probably catch them; if they don't, fix the detections.
- **Supply chain** — adversary compromises your vendor to reach you. Hunt for unexpected outbound from build servers, code-signing anomalies, unusual update behavior.

### CompTIA exam traps

> **CompTIA exam trap:** Threat hunting is **proactive**; detection and monitoring is **reactive**. If the question says "the analyst received an alert and investigated," that's monitoring/IR, not hunting. Hunting starts with a *hypothesis*, not an alert.

> **CompTIA exam trap:** A honeypot is one system. A honeynet is a network of honeypots. A darknet is unused-but-monitored IP space (no services, just listening). They are not interchangeable. The exam will offer all three as distractors.

> **CompTIA exam trap:** Threat *intelligence* is the input (feeds, reports, IoCs from outside). Threat *hunting* is the activity (using that intel plus internal data to find adversaries). CompTIA loves to swap the two in question stems.

> **CompTIA exam trap:** Active defense ≠ offensive security ≠ hack-back. Active defense is deception and friction *inside your own perimeter*. Hack-back (attacking the attacker's infrastructure) is illegal in most jurisdictions and is not what CompTIA means by "active defense."

> **CompTIA exam trap:** A successful hunt that finds nothing is still a successful hunt. The deliverables are (1) reduced uncertainty about a hypothesis and (2) a new detection rule. "We found no evidence of TTP X" is a valid outcome — write it up.

## SOC reality

- The hunt ticket at 9am Monday isn't a fire. It's a hypothesis written by the L3 lead based on a CISA bulletin from Friday: "Threat group X is exploiting CVE-Y; hunt for post-exploitation behavior Z in our environment by EOW." You scope the data, write the queries, and report findings. *The deliverable is a written hunt report — confirmed/not confirmed, queries used, new detections proposed. Verbal "yeah we checked" gets you fired the day there's an incident you missed.*
- The CISO never asks "did you hunt?" They ask "are we exposed to the thing on the news?" Hunting is how you answer that honestly instead of guessing.
- Honeypots in production are a political fight. You will explain seven times that the fake fileserver is *intentionally* vulnerable and *no*, it does not need to pass the vulnerability scan. Get sign-off in writing.
- Every hunt that finds something turns into an IR ticket and a meeting where someone asks "how long has this been here?" The answer is almost always "longer than we'd like." *Don't promise a dwell-time number until forensics finishes — initial estimates are wrong by an order of magnitude in both directions.*
- L1 doesn't hunt. L2 sometimes hunts. L3 and the dedicated hunt team always hunt. If your SOC has no one whose job title or charter explicitly includes hunting, you don't have hunting — you have wishful thinking.

## Related concepts

[[Threat Intelligence]] · [[Indicators of Compromise]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]] · [[Advanced Persistent Threat]] · [[Detection and Monitoring]] · [[SIEM]] · [[EDR]] · [[Incident Response Lifecycle]] · [[STIX and TAXII]] · [[ISAC and ISAO]] · [[Insider Threat]] · [[Supply Chain Risk]] · [[Vulnerability Management]]

*Source: VIRGIL knowledge base — 2026-05-11*