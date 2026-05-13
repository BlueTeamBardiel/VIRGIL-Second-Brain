# Combining IoCs

## What it is

In **Tears of the Kingdom**, a single Gloom Hand sticking out of the floor is creepy but survivable — you can run. Five Gloom Hands in a courtyard with the sky going dark and the music shifting means Phantom Ganon is about to spawn and you are about to have a very bad time. No single hand was the threat. The pattern of hands, the lighting change, the audio cue, and the location together told you exactly what was coming.

That's exactly what combining IoCs does — one indicator is noise, but the right indicators stacked together are a confirmed intrusion in progress.

**Combining indicators of compromise** is the analytical practice of correlating multiple low-confidence signals — log events, network flows, threat intel hits, endpoint telemetry — into a high-confidence determination that a host, account, or environment is compromised. It is the core analytical move of the **Detection and Analysis** phase of the incident response lifecycle (NIST SP 800-61). The single IoC tells you what to look at. The combination tells you what to do.

## Why it matters

Every individual IoC has a false-positive rate. A PowerShell execution is not malicious. A connection to a Russian IP is not malicious — your CDN might route through one. A failed login is not malicious. An admin account creation is not malicious. Each one of those, alone, fires hundreds of times a week in a mid-sized enterprise. If you escalate every one, the SOC drowns. If you escalate none, you miss the breach.

The skill the CySA+ tests — and the skill that separates an L1 analyst from someone who can actually run an incident — is reading the **constellation**, not the star. CompTIA Objective 3.2 puts this squarely inside incident response: you correlate to decide **scope, impact, containment, and eradication strategy.** Get the correlation wrong, you either contain the wrong host (operational damage, no security win) or you contain one host while the adversary still owns three others (the intrusion continues under your nose).

This is also where threat intelligence stops being a PDF nobody reads and starts being an operational input. A threat intel report saying "APT-Whatever uses `rundll32.exe` with `comsvcs.dll` to dump LSASS" is useless on its own. Combined with EDR telemetry showing exactly that command line on a domain controller at 02:47, it's a confirmed match against a named adversary's TTP. Same data, completely different decision.

## Key facts

### The correlation stack

Effective IoC correlation pulls from at least four sources. The more you stack, the higher your confidence.

| Source | What it gives you | Example IoC |
|---|---|---|
| **[[Threat intelligence]] feeds** | Known-bad indicators with context (actor, campaign, TTP) | IP `185.225.x.x` flagged as Cobalt Strike C2 |
| **Endpoint logs ([[EDR]]/[[XDR]])** | Process trees, command lines, file writes, registry changes | `powershell.exe -nop -w hidden -enc <base64>` on FINANCE-07 |
| **Network data ([[NetFlow]], [[PCAP]], DNS logs)** | Connection metadata, beaconing patterns, DNS queries | 60-second-interval beacons from FINANCE-07 to that flagged IP |
| **[[SIEM]] / log aggregation** | Cross-source correlation, time alignment, historical pivot | Same user account logged into FINANCE-07 and three other hosts within 20 min |
| **Identity logs ([[Active Directory]], IdP)** | Authentication events, group changes, token issuance | Service account `svc-backup` used interactively for the first time ever |

No single row in that table is a conviction. Two or three of them, time-aligned, on the same host or account, is.

### Single IoC vs combined IoC — the confidence shift

```
Single IoC:                        Combined IoCs:
- 1 PowerShell encoded command     - PowerShell encoded command
- low confidence                   - + outbound beacon to known C2
- triage ticket                    - + LSASS access by non-system process
- 80% false positive               - + service account interactive logon
                                   = HIGH confidence intrusion
                                   = declare incident, contain now
```

The job is not to find IoCs. The job is to find **clusters of IoCs that share a host, an account, a time window, or a process lineage.**

### Pivoting — the analyst's actual workflow

Correlation is not magic; it is **pivoting**. You start with one indicator and pivot across data sources until the picture either resolves into "benign, document and close" or "compromise, escalate."

A real pivot chain:

1. **Alert:** SIEM rule fires on encoded PowerShell from host `FINANCE-07`.
2. **Pivot to EDR:** Pull the full process tree. Parent is `winword.exe`. Word should not be spawning PowerShell. Confidence rises.
3. **Pivot to email gateway:** `winword.exe` was opened from an attachment in an email received 14 minutes ago from a lookalike domain. Confidence rises.
4. **Pivot to network logs:** Host has made three outbound connections to an IP that hits on a [[STIX]]/[[TAXII]] feed as Qakbot infrastructure. Confidence is now high.
5. **Pivot to AD logs:** That host's logged-in user authenticated to two file servers in the last 8 minutes. **Now you have scope.**
6. **Pivot to those file servers:** Are there beacons? New scheduled tasks? Lateral movement evidence?

Every pivot is a question. Every answer either raises confidence or kills the hypothesis.

### Scope, impact, and the IR decisions correlation drives

Once you've combined IoCs into a confirmed incident, correlation directly produces the answers IR leadership demands:

- **[[Scope]]** — which hosts, accounts, network segments are involved? You can only answer this if you've correlated indicators across the environment, not just on the source host.
- **[[Impact]]** — what data, systems, or business processes are at risk? Correlation tells you whether the compromised host touched the crown-jewel database or just sat idle.
- **[[Isolation]] decisions** — network-isolate which hosts, disable which accounts, block which IPs at the perimeter. Wrong scope, wrong isolation.
- **[[Containment]] vs [[Eradication]]** — can you isolate and observe, or do you need to re-image now? Depends on what the combined picture says about persistence mechanisms.
- **[[Compensating controls]]** — if you can't eradicate immediately (legacy system, business-critical, change-window blocked), what offsets do you put in place? Block at firewall, force MFA re-enrollment, increase monitoring.

### Evidence integrity while you correlate

Correlation pulls from logs that will become evidence. Treat them that way from the first minute.

- **[[Evidence acquisition]]** — capture logs to write-once storage or hash them on collection. SIEM exports are evidence; treat them like disk images.
- **[[Chain of custody]]** — every export, every transfer, every analyst who touched the dataset gets logged. CompTIA tests the principle that a single undocumented handoff can void the evidence in court.
- **[[Validating data integrity]]** — SHA-256 hashes on collected logs, PCAPs, memory images. Re-hash on transfer. Mismatch means the evidence is contaminated.
- **[[Preservation]] and [[legal hold]]** — once an incident is declared, retention policies that would normally rotate logs out get suspended. Legal hold is a documented directive that says "do not delete." Missing this is how organizations lose the very logs that prove the breach.

### CompTIA exam traps

> **CompTIA exam trap:** *Confusing single-IoC alerting with combined-IoC analysis.* A SIEM rule firing on one signature is **detection**. Pivoting across four data sources to confirm the intrusion is **analysis**. CompTIA Objective 3.2 separates **Detection and Analysis** for a reason — the exam will give you a scenario with multiple weak signals and ask what an analyst should do next. The answer is almost never "open a ticket and move on" and almost never "immediately re-image." It is "correlate across additional data sources to determine scope and impact."

> **CompTIA exam trap:** *Treating threat intel as proof.* A hit on a threat feed is an **indicator**, not a conviction. Threat feeds have false positives — IPs get reused, infrastructure rotates, sinkholes get listed as malicious. CompTIA will offer "the IP is on a threat feed, declare incident" as a distractor. The correct move is correlate the intel hit with internal telemetry (was there actual traffic? Did it return data? Is there a process tied to it?) before escalating.

> **CompTIA exam trap:** *Skipping preservation while triaging.* If the scenario describes an analyst rebooting a host or running cleanup scripts during initial triage, that is wrong even if it "fixes" the symptom. Volatile memory is lost on reboot. The correct sequence is **preserve → analyze → contain → eradicate**. Re-imaging happens in **Containment, Eradication, and Recovery**, not during Detection and Analysis.

### Remediation and the close-out

After correlation confirms the incident and scope, remediation choices flow directly from what the combined picture revealed:

- **[[Re-imaging]]** — the default eradication for confirmed endpoint compromise. Persistence mechanisms hide in places forensics misses; a wipe-and-rebuild is the only high-confidence cleanup.
- **[[Remediation]] of root cause** — patch the vulnerability, kill the phishing-prone process, disable the abused service account. If you re-image the host but don't fix how they got in, they come back in a week.
- **Compensating controls** during the gap between detection and full remediation — temporary firewall rules, MFA enforcement, segmentation. Real environments rarely let you remediate instantly; compensating controls keep the bleeding stopped.

## SOC reality

- The 3am alert is almost never one screaming red banner. It is three yellow ones on three different dashboards that an attentive analyst notices belong to the same host. Tuning your eye for that pattern is the actual job.
- L1's first move on a suspected combined-IoC pattern is **not** to isolate — it's to open the SIEM, pull the host's last 24 hours, and timeline the events. Isolation without scope is how you contain one host while the adversary owns five.
- The IR lead's first three questions, every time: *What's the scope? What's the impact? Is the evidence preserved?* If you can't answer all three, you go back to correlating before you escalate further.
- Never tell leadership "we've contained it" until you have correlated across the full environment, not just the originating host. Premature all-clears are how careers end. *"Contained on the known-affected hosts, investigation continues for lateral movement"* is the honest phrasing.
- Handoff point: L1 correlates and triages. L2 confirms scope and impact, declares incident. IR team owns containment and eradication. Legal gets looped in at incident declaration for legal hold. Executive comms happen only after scope is bounded — never during active correlation.

## Related concepts

[[Indicators of compromise]] · [[Threat intelligence]] · [[SIEM]] · [[EDR]] · [[NetFlow]] · [[STIX]] · [[TAXII]] · [[Incident response lifecycle]] · [[Scope]] · [[Impact]] · [[Chain of custody]] · [[Legal hold]] · [[Evidence acquisition]] · [[Validating data integrity]] · [[Isolation]] · [[Containment]] · [[Eradication]] · [[Re-imaging]] · [[Compensating controls]] · [[MITRE ATT&CK]] · [[Cyber Kill Chain]] · [[Diamond Model]]

*Source: VIRGIL knowledge base — 2026-05-11*