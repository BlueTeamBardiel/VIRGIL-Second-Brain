# Validation & Accuracy

## What it is

In **Overwatch**, the killcam shows you exactly how you died — but it lies. Watch a killcam where Widowmaker headshots you through a wall and you'll swear she's cheating. Pull the actual replay, scrub frame-by-frame from her POV, and you see she pre-aimed the common angle, you peeked at the predictable timing, and the "wallhack" was your own bad positioning. The killcam is a *first-pass alert*. The replay is *validation*. One tells you something happened; the other tells you what actually happened and whether your reaction should be "report cheater" or "stop peeking that corner."

That's exactly what validation and accuracy do in vulnerability management — the scanner's output is the killcam, and you do not file the report until you've watched the replay.

**Plain English:** vulnerability scanners are noisy. Some findings are real, some are wrong, some are real-but-irrelevant. Validation is the work of separating those three buckets before you spend remediation budget or wake up an asset owner.

**Technical:** validation and accuracy is the process of confirming scanner output against ground truth — manual verification, credentialed rescans, log correlation, and exploit testing — to classify findings as **true positive**, **false positive**, **true negative**, or **false negative**, and to tune the scanning program so the signal-to-noise ratio is high enough that remediation teams trust the report.

## Why it matters

CS0-003 Objective 2.1 puts validation right next to scanning methods because CompTIA knows the dirty truth of vulnerability management: **a scan report nobody trusts is worse than no scan at all.** If your Patch Tuesday queue has 12,000 findings and 40% are false positives, your sysadmins will start ignoring the whole feed. Then the one CVE that actually matters dies in the noise.

Career stakes: a CySA+ analyst's reputation is built on findings that hold up. Flag a false positive to the database team and they remember it for a year. Miss a false negative on an internet-facing asset and you might be writing the breach post-mortem.

Exam stakes: CompTIA tests the *vocabulary* (true/false positive/negative), the *methods* (credentialed rescan, manual exploit, log correlation), and the *tradeoffs* (active vs passive, agent vs agentless, internal vs external — each has accuracy implications).

## Key facts

### The four-cell truth table

| | Vuln actually exists | Vuln does not exist |
|---|---|---|
| **Scanner says vuln** | True positive (good) | False positive (noise) |
| **Scanner says clean** | False negative (dangerous) | True negative (good) |

**False positive** wastes analyst time and erodes trust. **False negative** is the one that gets you breached. CompTIA treats false negatives as the more dangerous failure mode — and so should you.

### Why scanners get it wrong

- **Banner grabbing without verification.** The scanner sees Apache 2.4.49 in the HTTP header and flags CVE-2021-41773. But the admin backported the patch and didn't update the banner string. False positive.
- **Uncredentialed guessing.** Without login, the scanner infers vulns from version strings and probe responses. Inference is not proof.
- **Missing context.** Scanner flags an SMBv1 vuln on a host where SMBv1 is firewalled off and reachable from nowhere. Technically true, operationally false.
- **Compensating controls invisible to the scan.** WAF in front of the app blocks the exploit path. Scanner doesn't know.
- **Plugin staleness or signature drift.** New CVE published, plugin not yet released — false negative until the next feed update.

### Validation methods (rank-ordered by confidence)

1. **Manual exploitation / proof-of-concept** — highest confidence. Run the actual exploit in a controlled way against the target. If it works, the finding is real. This is where pentest skills overlap with CySA+ work.
2. **Credentialed rescan.** [[Credentialed vs Non-credentialed Scanning]] is the single biggest accuracy lever in the program. Credentialed scans authenticate to the host, read the registry / package manager / config files directly, and stop guessing. Run an uncredentialed scan, then a credentialed rescan — the delta tells you which findings were inference and which are confirmed.
3. **Log correlation.** Pull SIEM data for the asset. Does the WAF log show the exploit path is blocked? Does the EDR log show the vulnerable service was never actually loaded? Correlation lets you contextualize the finding without touching the asset.
4. **Configuration review.** Read the actual config — sshd_config, web.config, registry hive — and compare against the vuln conditions. The CVE may require a specific setting the host doesn't have.
5. **Asset context lookup.** Pull the CMDB. Is this host even production? Is it externally reachable? Does it process regulated data? Context doesn't change whether the vuln is real — it changes whether the finding matters.

### Scanning choices that affect accuracy

| Choice | Higher accuracy | Lower accuracy |
|---|---|---|
| Credentials | [[Credentialed Scanning]] | Uncredentialed |
| Probing | [[Active Scanning]] | [[Passive Scanning]] |
| Coverage | [[Agent-based Scanning|Agent-based]] (always on) | Agentless (point-in-time) |
| Position | Internal (sees more) | External (sees what attacker sees) |
| Engine type | [[Dynamic Application Security Testing\|DAST]] for runtime, [[SAST]] for code | Either alone misses what the other catches |

None of these are universally "right." External uncredentialed scans are **less accurate** for inventorying your own vulns, but they're the **only accurate** view of what an unauthenticated attacker sees. Run both. The delta is the intelligence.

### Special considerations — where accuracy gets dangerous

Some asset classes don't tolerate aggressive scanning. Accuracy here means *not breaking the thing you're measuring*.

- **[[Operational Technology]] (OT) / [[SCADA]] / [[ICS]].** Active scans have crashed PLCs. A timing-sensitive industrial controller can fault on a stray TCP probe. Use **passive scanning** (span port, network tap) and vendor-supplied tools. A false negative is better than a refinery shutdown.
- **Critical infrastructure.** Same logic. Schedule windows, coordinate with operations, scan with reduced concurrency.
- **Sensitive / regulated data hosts.** [[PCI DSS]] requires quarterly internal and external scans by an [[Approved Scanning Vendor|ASV]] — and the ASV's accuracy is what you'll be audited against, not yours. Validate before submission.
- **Embedded / IoT.** Limited compute, often crash under aggressive probing. Fingerprint passively.

### Scheduling and performance — the accuracy tax

A scan that runs during business hours at full intensity might be accurate *and* trigger an outage. A scan throttled to 2 threads at 3am might miss assets that are powered off. Accuracy lives between these two failure modes. Tune scan windows, concurrency, and asset groups so the scan completes inside the maintenance window and covers the full inventory.

### Frameworks and baselines that anchor "accurate"

Scanners are only as accurate as the policy they're checking against. Define the baseline first:

- **[[CIS Benchmarks]]** — prescriptive hardening configs per platform. Scanner reports deviations.
- **[[ISO 27000 Series|ISO 27001/27002]]** — control framework; less prescriptive, more programmatic.
- **[[OWASP Top 10]] / [[OWASP ASVS]]** — web app testing scope and depth.
- **[[PCI DSS]]** — mandatory for cardholder data.
- **Vendor STIGs / DISA benchmarks** — government / defense baselines.

The baseline tells the scanner what "vulnerable" *means* in your environment. Without a baseline, every minor config drift becomes a finding and noise wins.

### CompTIA exam traps

> **CompTIA exam trap:** false positive vs false negative — false positives waste *time*, false negatives waste *companies*. If the question asks which is the more dangerous failure mode, it's false negative. If it asks which kills program trust, it's false positive. Read carefully.

> **CompTIA exam trap:** credentialed scans are not "better" in every dimension — they're more *accurate*, but they require credential management, they generate more load, and a compromised scanner account is a privileged foothold. Expect a question that frames credentialed scanning as a risk, not just a benefit.

> **CompTIA exam trap:** passive scanning on OT/SCADA is the correct answer when the scenario mentions industrial controllers, refineries, power grids, or "cannot tolerate disruption." Active scanning on an ICS is the wrong answer almost every time CompTIA writes the question.

> **CompTIA exam trap:** validation is not remediation. Confirming a vuln is real does not fix it. The lifecycle is identify → validate → prioritize → remediate → verify. CompTIA will swap these around.

### Fuzzing, reverse engineering, and the deep end

[[Fuzzing]] and [[Reverse Engineering]] sit beyond standard vulnerability scanning — they're how you validate findings the scanner can't see, or how you find vulns the scanner doesn't have signatures for yet. Fuzzers throw malformed input at an interface and watch for crashes; reverse engineering pulls apart binaries to find logic flaws. CySA+ doesn't expect you to *do* these — it expects you to know they exist as validation methods of last resort and as sources of zero-day findings that won't appear in any scanner's plugin feed.

## SOC reality

- **The 3am ticket says CRITICAL — Log4Shell on prod-app-07.** Before you wake anyone, you check: was the scan credentialed? Is the asset externally reachable? Does the WAF have the mitigation rule? Does the runtime actually load log4j-core? Five minutes of validation saves a 2am call to the on-call engineer who's going to ask all those questions anyway.
- **The L1 analyst's first move on any "critical" finding is to look at the asset record, not the CVE.** A CVSS 9.8 on a decommissioned host in the lab VLAN is not a P1.
- **What the IR lead asks:** "Is this validated, or is this scanner output?" If you can't answer in one sentence, the answer is no.
- **Never tell leadership "the scan is clean."** Tell them "the scan returned no findings against the current plugin set and policy baseline." Those are different statements. False negatives are real, and the second sentence is honest about the limits of the tool.
- **Handoff point:** L1 triages and tags obvious false positives, L2 runs validation (credentialed rescan, log correlation, sometimes manual PoC in a sandbox), L2 hands confirmed findings to the vuln management team for remediation tracking. Disputes go to the vuln manager, not the analyst — your job is to validate, not to argue the CVSS score down with the asset owner.

*A scan that nobody trusts is a scan that nobody acts on. Validation is what makes the report a tool instead of a noise generator.*

## Related concepts

[[Credentialed vs Non-credentialed Scanning]] · [[Active Scanning]] · [[Passive Scanning]] · [[Agent-based Scanning]] · [[Internal vs External Scanning]] · [[CVSS]] · [[False Positive Tuning]] · [[CIS Benchmarks]] · [[OWASP Top 10]] · [[PCI DSS]] · [[ISO 27000 Series]] · [[SCADA]] · [[ICS]] · [[Operational Technology]] · [[Fuzzing]] · [[Reverse Engineering]] · [[SAST]] · [[Dynamic Application Security Testing]] · [[Vulnerability Scanning Methods]] · [[Asset Inventory]]

*Source: VIRGIL knowledge base — 2026-05-11*