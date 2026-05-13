# AV — Antivirus

## What it is

In **Smash Bros**, Pikachu has a finite move set. Down-B is Thunder. Side-B is Skull Bash. The game recognizes the input, looks it up in a table, and executes the matching animation. If you mash a button the engine doesn't have a hashed input for — nothing happens. That's exactly what traditional **antivirus** does: it watches files and processes, hashes them against a signature table, and if the hash matches a known-bad move, it triggers the block animation.

The problem is the same one competitive Smash players exploit: if your input isn't in the move list — a custom move, a frame-perfect tech, a mod — the engine has no answer. Polymorphic malware, packed binaries, and living-off-the-land scripts are the same idea. Unknown input, no animation, the attack lands clean.

**Antivirus (AV)** is endpoint software that detects, blocks, and quarantines malicious files using primarily signature-based detection (file hashes, byte patterns, YARA rules) with secondary heuristic and behavioral checks. It's the oldest endpoint control still in production. It's necessary. It's not sufficient. Modern AV is bundled into **[[EPP]]** (Endpoint Protection Platform) and surrounded by **[[EDR]]** (Endpoint Detection and Response) precisely because signatures alone don't catch what attackers do today.

## Why it matters

Every endpoint in your fleet runs AV. Every alert ticket that says "Defender quarantined `mimikatz.exe`" came from AV. Every false positive that nuked a developer's compiled binary at 4pm on a Friday came from AV. The CySA+ exam (Objective **1.3**) tests AV as a detection tool alongside **[[Sandboxing]]**, **[[Hashing]]**, **[[VirusTotal]]**, **[[Strings]]**, and the rest of the static/dynamic analysis toolkit. You need to know what AV catches, what it misses, and how it fits in the bigger detection stack.

Career-wise: L1 SOC analysts spend the first six months triaging AV alerts. If you can't read an AV verdict, pivot to **[[VirusTotal]]**, and decide "real detection vs PUA noise" in 90 seconds, you can't hold the seat.

## Key facts

### Detection methods

| Method | How it works | What it catches | What it misses |
|---|---|---|---|
| **Signature-based** | Hash or byte-pattern match against a vendor database | Known malware families, known samples | Anything new, anything packed, anything obfuscated |
| **Heuristic** | Static analysis — looks for suspicious code structures (e.g., decoder stubs, suspicious API imports) | Variants of known families, lightly obfuscated samples | Novel techniques, legitimate tools (high FP rate) |
| **Behavioral** | Runtime — watches what the process does (file writes, registry edits, child process spawns) | Fileless malware, LOLBins, ransomware behavior | Slow-burn implants, beacon-only C2 |
| **Cloud lookup** | Sends file hash or metadata to vendor cloud for real-time verdict | Recently-seen samples not yet in local sigs | Air-gapped hosts, vendor outages |
| **Machine learning** | Trained classifier on file features (PE headers, entropy, imports) | Variants and unseen samples that look like training data | Adversarial samples crafted to evade the model |

Modern AV stacks all five. Signature is still the cheapest and fastest, so it runs first.

### Signature databases and hashing

AV signatures are typically **[[Hashing|hashes]]** — MD5, SHA-1, SHA-256 — of known-bad files. When a file lands on disk, the AV engine computes its hash, compares against the local sig DB, and verdict in milliseconds. This is why **[[Hashing]]** matters so hard in this domain: every IoC feed, every threat intel report, every malware sample on **[[VirusTotal]]** is keyed by hash.

Beyond simple file hashes, AV uses **fuzzy hashing** (ssdeep, TLSH) to catch variants where one byte changed, and **YARA rules** — pattern-matching DSL that hunts for strings, byte sequences, and structural features inside files. YARA is the language threat hunters write custom signatures in.

### What AV cannot catch

- **Fileless malware** — payload lives in memory, never touches disk. AV that only scans files on write has nothing to scan.
- **LOLBins** (Living Off the Land Binaries) — `powershell.exe`, `wmic.exe`, `certutil.exe`, `rundll32.exe`. These are signed Microsoft binaries. AV won't block them.
- **Packed/obfuscated samples** — same malicious code, different hash. Signature misses every time until the sample is unpacked by a sandbox or analyst.
- **Insider threats and credential abuse** — no malicious file, just a valid user doing valid-looking things.
- **Supply chain compromise** — the file is signed, trusted, and from a vendor you whitelisted.

This is why **[[EDR]]** exists. EDR watches process telemetry, command lines, parent/child relationships — the *behavior* AV can't see from the file alone.

### AV in the bigger detection stack

| Layer | Tool | What it sees |
|---|---|---|
| File on disk | **AV** | Hash, signature match |
| Process behavior | **[[EDR]]** | Command line, parent process, child spawns, API calls |
| Network traffic | **[[IDS]] / [[IPS]] / [[NDR]]** | C2 beacons, DNS exfil, lateral movement |
| Log correlation | **[[SIEM]]** | Cross-source pattern (AV alert + auth failure + new admin account) |
| Detonation | **[[Sandboxing]]** (Cuckoo, Joe Sandbox) | Full runtime behavior of suspicious file |
| Reputation | **[[VirusTotal]]**, **[[AbuseIPDB]]** | What the world has seen this hash/IP doing |

AV is one layer. Treat it as a smoke detector — useful, but you don't call it a fire suppression system.

### Triaging an AV alert

When `WinDefend` fires on an endpoint:

1. **Read the verdict.** Is it a real family (`Emotet`, `Cobalt Strike`, `Mimikatz`) or generic (`Heur.Suspicious`, `Trojan.GenericKD.123456`)? Generic verdicts have higher FP rates.
2. **Get the hash.** SHA-256 is the lingua franca. Pivot to **[[VirusTotal]]**.
3. **Check detection ratio on VT.** 1/70 vendors = probably FP or fresh sample. 55/70 = real.
4. **Pull file context from EDR.** What process wrote the file? What user? What was the command line? Where did the file come from (browser download, email attachment, lateral copy)?
5. **Check for related activity.** SIEM query: same host, same user, last 24 hours — auth events, network connections, other alerts. **[[Log analysis|Log correlation]]** is where AV alerts become incidents.
6. **Verify quarantine.** Did the AV actually contain the file, or did it just alert? Some configs are detect-only.
7. **Determine blast radius.** Same hash on other endpoints? Same C2 IP in NetFlow? This is the IR escalation pivot.

*An AV alert is a starting point, not an answer. The file got blocked — the question is why it was there in the first place.*

### CompTIA exam traps

> **CompTIA exam trap:** AV vs EDR vs XDR. AV is signature/heuristic on files. EDR adds process behavior, threat hunting, and response actions on endpoints. XDR extends EDR across endpoint + network + email + identity. If the question says "behavioral analysis of process trees" → EDR, not AV. If it says "block known malware by signature" → AV.

> **CompTIA exam trap:** "AV stopped the attack." CompTIA loves to bait you with this. If the scenario describes fileless PowerShell, AV is the wrong answer. AV scans files. No file, no scan. The right answer is EDR, behavioral analysis, or script block logging.

> **CompTIA exam trap:** False positive vs false negative. False positive = AV flagged something benign (developer's compiled binary, custom admin script). False negative = AV missed real malware. Tuning AV is a tradeoff — tighter heuristics catch more, but also FP more. Know which way the dial moves.

> **CompTIA exam trap:** Quarantine vs delete vs allow. Quarantine isolates the file in an encrypted vault — recoverable for analysis. Delete is permanent. CompTIA will ask which preserves evidence. Quarantine.

### AV and email analysis

Mail gateways run AV against attachments. They also check **[[SPF]]** (Sender Policy Framework), **[[DKIM]]** (DomainKeys Identified Mail), and **[[DMARC]]** (Domain-based Message Authentication, Reporting, and Conformance) on **[[Email analysis|email headers]]** to fight impersonation. AV alone on an attachment is the bottom of the email stack — most modern phishing uses **[[Embedded links]]** to credential harvesters, not attached malware. The link goes to a clean domain, AV has nothing to scan, the user types their password into a fake Microsoft 365 page. That's the campaign that owns most orgs in 2026, not the `.docm` attachment.

### Integration points the exam tests

- **[[VirusTotal]]** — hash lookup, 70+ AV engines polled at once. The pivot every analyst makes after an AV hit.
- **[[Sandboxing]]** (**[[Cuckoo Sandbox]]**, **[[Joe Sandbox]]**) — detonate the file in an isolated VM, watch what it does. Catches what AV missed.
- **[[Strings]]** — static extraction of human-readable text from a binary. URLs, IPs, registry keys, error messages. Fast triage before sandbox detonation.
- **[[SIEM]]** correlation — AV alert + 4625 (failed logon) + new scheduled task on same host = real incident.
- **[[SOAR]]** — auto-quarantine the host, auto-pull the file for analysis, auto-create the ticket. The L1 alert becomes a one-click response.

## SOC reality

- **The 3am alert.** Defender pops "Trojan:Win64/Meterpreter quarantined" on a finance laptop. Your first move is the SHA-256 → VT → 62/70 detections → real. Second move: EDR timeline. Who's the parent process? `winword.exe`. Macro-laden document. Now you check email — did this hit other inboxes? This is when L1 wakes L2.
- **The 80% noise problem.** Most AV alerts are PUA (potentially unwanted apps) — Chrome extensions, cracked software on a contractor laptop, the eternal `WinRAR` keygen. The discipline is *not* numbing out on the 80% and missing the 20% that's real.
- **The CISO question.** "Did AV stop it?" The honest answer is rarely yes — AV blocked *a* file, but the campaign that delivered it is still running, the user still clicked the link, and the C2 beacon may already be talking. Never tell leadership "AV got it" until you've checked network egress.
- **The detect-only config trap.** Some orgs run AV in detect-only on servers to avoid breaking production. The alert fires, the file is *not* quarantined, and unless someone reads the alert in time, the malware executes. Always verify quarantine status before you stand down.
- **Handoff to IR.** L1 triages, L2 confirms scope, IR takes over when more than one host or the file is a known C2 implant family. Document the hash, the source, the affected user, the time, the quarantine status. Chain of custody starts at the first ticket.

## Related concepts

[[EDR]] · [[EPP]] · [[XDR]] · [[VirusTotal]] · [[Sandboxing]] · [[Cuckoo Sandbox]] · [[Joe Sandbox]] · [[Hashing]] · [[Strings]] · [[YARA]] · [[SIEM]] · [[SOAR]] · [[IoC]] · [[Email analysis]] · [[SPF]] · [[DKIM]] · [[DMARC]] · [[AbuseIPDB]] · [[Log analysis]] · [[File analysis]]

*Source: VIRGIL knowledge base — 2026-05-11*