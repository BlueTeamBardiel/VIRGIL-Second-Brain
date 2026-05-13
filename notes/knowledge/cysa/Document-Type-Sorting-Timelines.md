# Document-Type Sorting & Timelines

## What it is

In **FIFA Ultimate Team**, when you're hunting a chemistry problem on a squad that should be working, you don't stare at all 23 players at once. You sort. Goalkeepers in one bucket, defenders in another, attackers in a third — then you check links, positions, loyalty, and the timestamp on when each card was added to the club. The Transfer History tab shows you, in order, every player bought, sold, traded, or quick-sold. You scrub that list to figure out *when* the squad broke. That's exactly what document-type sorting and timeline analysis do during forensic triage — bucket the evidence by type, then line every artifact up against a clock to reconstruct the sequence of events.

**Plain English:** When you image a suspect drive or pull a mailbox, you don't read it linearly. You group files by what they are (Office docs, PDFs, emails, archives, executables), then you build a master timeline — every create, modify, access, and delete timestamp stitched together — so you can say "at 02:14:07, the user opened this PDF; at 02:14:51, this RAR was created; at 02:15:30, it left via Outlook."

**Technical definition:** Document-type sorting is the forensic practice of partitioning acquired data by file format or category to focus analysis on relevant artifact classes. Timeline analysis is the correlation of filesystem and application metadata (MACB times — Modified, Accessed, Changed, Born) across those artifacts, combined with log evidence, to reconstruct the chronological sequence of an incident. Together they support the **Detection and Analysis** and **Post-incident** phases of the NIST SP 800-61 incident response lifecycle.

## Why it matters

Domain 3.0 — specifically Objective **CS0-003 3.2** — expects you to perform incident response activities including evidence acquisition, scope determination, impact assessment, and data/log analysis. The exam wants you to know that you can't determine **scope** or **impact** without a timeline, and you can't build a credible timeline without sorting evidence by type and validating the integrity of each artifact you pull from.

Real-world stakes: insider-threat cases live or die on timeline. An employee who claims they never accessed a customer database is undone by a single `lnk` file with a timestamp matching a `7z` archive creation, matching an outbound SMTP event in the mail gateway log. Without sorting and timelining, that evidence sits in 400 GB of noise. With it, you have a courtroom-ready narrative.

## Key facts

### Sorting by file type

The first move after acquisition is partitioning by category. Forensic tools (Autopsy, FTK, X-Ways, EnCase) do this automatically using **file signature analysis** (magic bytes) rather than extensions, because the first thing a guilty user does is rename `payload.exe` to `vacation.jpg`.

| Category | Common formats | Why it matters in IR |
|---|---|---|
| **Office documents** | `.docx` `.xlsx` `.pptx` `.doc` `.xls` | Macro-based malware, embedded objects, document metadata (author, last-modified-by, revision) |
| **PDFs** | `.pdf` | JavaScript payloads, embedded files, phishing lures, exfil format of choice |
| **Emails** | `.pst` `.ost` `.msg` `.eml` `.mbox` | Initial access vector, exfil channel, communication evidence |
| **Archives** | `.zip` `.rar` `.7z` `.tar` `.gz` | Staging containers — attackers compress before exfil; insiders zip before USB |
| **Executables & scripts** | `.exe` `.dll` `.ps1` `.bat` `.vbs` `.js` | Malware, living-off-the-land binaries (LOLBins), persistence |
| **Browser artifacts** | History DB, cache, cookies | Web-based exfil, C2 over HTTPS, credential theft |
| **System artifacts** | Registry hives, event logs, prefetch, `$MFT` | Execution evidence, persistence keys, account activity |

Sort first. Read second. *An L1 who tries to triage by opening files in the order they appear in Explorer will be there until retirement.*

### Timeline analysis — the MACB times

Every NTFS file has four timestamps. CompTIA loves this.

- **M — Modified:** content last changed
- **A — Accessed:** file last opened/read (often disabled on modern Windows for performance — know this)
- **C — Changed (MFT entry modified):** metadata last changed (permissions, attributes)
- **B — Born (Created):** file first created on this volume

The combination tells a story. A file with **Born > Modified** is a copy operation (the file was created here after being modified somewhere else). A file with **Accessed = Born** and no further activity is one that was dropped but never opened. **Timestomping** — attackers rewriting MACB times to evade detection — shows up as inconsistent precision (NTFS native timestamps have 100-nanosecond resolution; tampered ones often end in clean zeros).

### Building the super-timeline

Real timeline analysis isn't just MACB. It's a **super-timeline** — filesystem events merged with log evidence into one ordered stream. Tools like Plaso (`log2timeline`) pull from dozens of sources:

- Filesystem MACB times
- Windows Event Logs (Security, System, Application, PowerShell, Sysmon)
- Registry transaction logs and last-write times
- Prefetch (execution evidence with run count and last-execute time)
- Browser history and download records
- USN journal (`$UsnJrnl`) — every filesystem change, even short-lived ones
- LNK files (shortcuts auto-created when files are opened)
- Jump lists, Shellbags (folder access evidence)
- Email server logs, proxy logs, DNS logs, EDR telemetry

You merge these into a single CSV/JSON sorted by timestamp. Then you pivot around the **pivot event** — the first known-bad indicator — and walk outward in both directions. *The pivot is the alert that woke you up. The timeline is everything around it that explains why.*

### Validating data integrity

Sorting and timelining mean nothing if the underlying evidence is tampered. Integrity validation is mandatory at every step:

- **Hash on acquisition.** Compute MD5 + SHA-256 of the disk image, the memory capture, the mailbox export. Record in the evidence log.
- **Re-hash before analysis.** Match the acquisition hash. If it differs, the evidence is invalid — stop, document, escalate.
- **Work on copies.** Never analyze the original. Hash the working copy too.
- **Write blockers** (hardware or software) during acquisition prevent the OS from touching the source. CompTIA tests this.

Hash mismatch = chain of custody is broken = the timeline you built is inadmissible.

### Chain of custody and preservation

Every artifact in the timeline must trace back to a logged transfer. The chain-of-custody form records: who acquired it, when, from what asset, with what tool, what hash, who handled it next, when they handed it back. **One missing transfer can break the case in court.** This includes the analyst sorting the documents — your name goes on the form when you check the evidence out of the locker.

**Legal hold** is the formal directive (usually from counsel) that suspends normal data retention/deletion policies because litigation is anticipated or active. When legal hold is issued, the mailboxes, file shares, and endpoints in scope are preserved untouched. Your sorting and timelining happen on the preserved copy, not the live system.

### CompTIA exam traps

> **CompTIA exam trap — MACB and the Accessed timestamp:** Modern Windows (Vista+) disables last-access-time updates by default for performance. CompTIA will give you a scenario where the Accessed time "proves" a file wasn't opened. Wrong — the Accessed time may simply not be updating. Cross-reference with Prefetch, LNK files, ShellBags, or `$UsnJrnl`.

> **CompTIA exam trap — file type vs file extension:** A question describing a `.jpg` that "behaves like an executable" is testing whether you know forensic tools sort by **magic bytes** (file signature), not extension. The answer is signature analysis, not "the user mislabeled the file."

> **CompTIA exam trap — order of operations:** When asked what you do FIRST with acquired evidence, the answer is **hash and preserve**, not "open it in your forensic tool." Integrity validation comes before analysis. Every time.

> **CompTIA exam trap — legal hold vs chain of custody vs preservation:** These are distinct. **Preservation** is the technical act of preventing alteration (write blockers, bit-for-bit images). **Chain of custody** is the documented handling trail. **Legal hold** is the legal directive that triggers preservation. CompTIA will mix the definitions.

### Where sorting/timelining fits in the IR lifecycle

| Phase | What sorting/timelining does |
|---|---|
| **Preparation** | Tooling in place (Plaso, Autopsy), evidence locker, COC forms, hash baselines for known-good binaries |
| **Detection and Analysis** | Pivot from the IoC, build the super-timeline, determine **scope** (which assets, which users, which data) and **impact** (what was accessed, modified, exfiltrated) |
| **Containment, Eradication, Recovery** | Timeline drives **isolation** decisions (which hosts go on the VLAN of shame), **remediation** scope (which accounts to reset, which creds to rotate), and identifies what needs **re-imaging** vs what gets **compensating controls** (host firewall rules, EDR custom block, app-allowlist tightening) until full remediation lands |
| **Post-incident** | Timeline is the spine of the root-cause analysis and the lessons-learned report. The timeline IS the story you tell leadership. |

### Insider-threat specifics

Insider cases are where timeline analysis earns its keep. The pattern:

1. **HR or DLP fires the trigger** — resignation submitted, USB inserted, abnormal SharePoint download volume, cloud-sync activity at 2am
2. **Preserve the endpoint and mailbox** under legal hold before the user is told anything
3. **Sort by type** — focus on Office docs, PDFs, archives (`.zip`/`.7z` are the staging giveaway), and email
4. **Timeline the staging window** — files created/copied to a single folder, then archived, then emailed/uploaded/USB-copied
5. **Correlate with badge access, VPN logs, cloud audit logs** — physical and network presence at the right times

The archive creation timestamp + the outbound email timestamp + the matching file hash inside the archive = the case.

## SOC reality

- At 3am the alert says "user X downloaded 4 GB from SharePoint in 12 minutes." Your first move isn't to call the user — it's to preserve their endpoint and mailbox, hash everything, and start sorting by file type to figure out *what* the 4 GB was.
- The IR lead's first three questions are always **scope, impact, evidence preserved?** Sorting + timeline answers all three. Don't show up to the bridge call without at least a partial timeline pivoted on the pivot event.
- Never tell leadership "we've contained it" before the timeline closes. Containment means you know every host that was touched, and you only know that from the timeline. *"We've isolated the known-affected hosts and the timeline is still expanding"* is the honest answer.
- L1 acknowledges the alert and preserves the asset. L2 builds the initial sort and timeline. IR/forensics owns the super-timeline and the chain-of-custody documentation. Legal owns the hold directive. Don't skip levels.
- When the timeline contradicts the user's statement, you don't argue with the user — you hand the timeline to HR or counsel. Your job is the evidence, not the interrogation.

## Related concepts

[[Chain of Custody]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Data Integrity Validation]] · [[Order of Volatility]] · [[Write Blockers]] · [[MACB Timestamps]] · [[Super-Timeline Analysis]] · [[Indicators of Compromise]] · [[Scope and Impact Determination]] · [[Containment Strategies]] · [[Re-imaging]] · [[Compensating Controls]] · [[Insider Threat]] · [[NIST SP 800-61]]

*Source: VIRGIL knowledge base — 2026-05-11*