# False Positives and Analyst Verification

## What it is

In **Bloodborne**, the Lecture Building has a corridor where a chandelier-shaped enemy hangs from the ceiling, motionless, blending into the decor. New hunters walk under it, get cratered, reload from the lamp. Veterans learn the room's tell — the chandelier in *this* hallway is a Lesser Amygdala; the chandeliers in the next hallway are just chandeliers. Same silhouette, different threat. You can't axe every chandelier you see or you'll never finish the level. You learn to look up, check the geometry, and confirm before you swing.

That's exactly what false positive triage is — a vulnerability scanner flags something that looks like a chandelier-Amygdala, and your job is to walk under it carefully and verify whether it's a real threat or scenery before you open a change ticket and patch production.

**Technical definition:** A false positive in vulnerability management is a scanner finding that reports a vulnerability which does not actually exist in the target environment — either because the detection signature matched on insufficient evidence, the asset has a compensating control the scanner can't see, the service banner was misread, or the plugin logic was generic enough to flag a non-vulnerable build. **Analyst verification** is the manual process of reproducing the finding, correlating it with system context, and deciding whether to remediate, accept, or close as false positive before it touches a remediation workflow.

## Why it matters

A SOC or vuln management team that doesn't triage false positives loses two ways. First, you waste engineering hours patching things that weren't broken — and worse, you sometimes break them in the patch. Second, you train the business to ignore your tickets, which means when a real critical lands, ops slow-rolls it like every other "scanner noise" item. Credibility is currency. Spend it on real findings.

**CS0-003 Objective 2.2** explicitly tests your ability to analyze output from vulnerability assessment tools — Nessus, OpenVAS, Nmap, Nikto, Burp Suite, ZAP, and cloud tools like Scout Suite and Prowler. CompTIA wants you to recognize that **scanner output is a hypothesis, not a verdict**. The exam will hand you a scan result and ask what an analyst should do next. The answer is almost never "open a P1 ticket." The answer is "validate the finding."

## Key facts

### Why false positives happen

| Cause | What it looks like | Example |
|---|---|---|
| **Generic detection logic** | Plugin matches on version string alone, ignoring backports | Nessus flags Apache 2.4.29 as vulnerable to CVE-X; RHEL has backported the fix into the same version string |
| **Incomplete environmental context** | Scanner doesn't know the host is behind a WAF, segmented, or air-gapped | Nikto reports an exploitable path traversal; the path is blocked at the reverse proxy |
| **Experimental / beta plugins** | New signature with high false-positive rate, often labeled "experimental" in tool docs | OpenVAS NVT marked beta fires on every Linux host in the environment |
| **Legacy signatures** | Old plugin, never deprecated, fires on patterns that haven't existed in years | Nessus flags an SSL/TLS issue on a service that hasn't spoken SSLv3 since 2017 |
| **Banner grabbing without proof** | Tool reads a version banner, never tests behavior | Nmap `-sV` reports "vsftpd 2.3.4 — backdoored"; the banner was spoofed by the admin as a honeypot |
| **Authentication failure during scan** | Credentialed scan fell back to unauthenticated; coverage drops, guesses fill in | Nessus reports "missing patch" on a Windows host because it couldn't read the registry |
| **Web app scanner heuristics** | ZAP/Burp/Arachni flag reflected input as XSS without confirming script execution | Tool sees `<script>` echoed in response; the response has `Content-Type: text/plain` so the browser never parses it |

*Generic scanners are pattern matchers. The pattern is not the vulnerability — the exploitable behavior is the vulnerability.*

### The verification workflow

The order matters. CompTIA tests the order.

1. **Read the full finding** — not just the title. Plugin ID, evidence section, CVE, CVSS vector, what the scanner actually observed. Half of "false positives" are analyst-skim errors.
2. **Check the asset context** — is this host in scope? Is it production, dev, isolated? Does it have a compensating control (WAF, EDR rule, segmentation, network ACL)? Asset inventory and CMDB are your friends here.
3. **Reproduce manually** — this is the core move. If the scanner says "SQL injection on `/login?user=`", you go run the payload yourself in Burp Repeater or `curl`. If it says "missing KB on Windows host," you RDP in and run `Get-HotFix`. **No remediation ticket without reproduction.**
4. **Correlate with logs and configs** — pull WAF logs, EDR telemetry, reverse-proxy configs. The scanner may have been blocked or rate-limited and reported confusingly.
5. **Consult system owners or developers** — they know the service. "Is this endpoint authenticated upstream?" "Is this version backported?" "Did you turn off TLS 1.0 last quarter?" Two minutes of Slack often closes a finding.
6. **Document the decision** — false positive, true positive, risk-accepted, compensating control. Future scans will fire the same alert; future you needs to know why current you closed it.

### Which tools generate which kinds of false positives

| Tool | Category | Common FP pattern |
|---|---|---|
| **[[Nessus]]** | Vulnerability scanner (commercial) | Version-string-only detection on backported distros; auth fallback inflating "missing patch" findings |
| **[[OpenVAS]]** | Vulnerability scanner (open-source / Greenbone) | Experimental NVTs; older signature lag |
| **[[Nmap]]** | Network scanning and mapping | `-sV` service detection misreads on spoofed banners; OS fingerprint guesses on filtered hosts |
| **[[Nikto]]** | Web server scanner | Noisy by design; flags any "interesting" path without confirming exploitability |
| **[[Burp Suite]]** | Web app scanner / proxy | Active scanner flags reflected XSS where context (JSON, plain text) prevents execution |
| **[[ZAP]]** (Zed Attack Proxy) | Web app scanner (OWASP) | Same reflected-XSS pattern; passive rules fire on theoretical risk |
| **[[Arachni]]** | Web app scanner | Generic SQLi heuristics on apps with custom error handling |
| **[[Metasploit]] (MSF)** | Exploit framework | Auxiliary scanners report "vulnerable" when the actual exploit module fails — version check ≠ exploitability |
| **[[Scout Suite]]** | Cloud config assessment (multi-cloud) | Flags policies as overly permissive without knowing they're scoped by SCP / org policy upstream |
| **[[Prowler]]** | AWS security assessment | CIS benchmark fires on intentional exceptions (e.g., public S3 for a static site by design) |
| **[[Pacu]]** | AWS exploitation framework | Module reports "exploitable" based on enumerated permissions; conditions/MFA gates not evaluated |
| **[[Maltego]]** | OSINT / link analysis | "Findings" are inferences, not vulns — false positive concept doesn't map cleanly, but link weight does |
| **[[Recon-ng]]** | Recon framework | Stale third-party API data; "subdomain exists" findings on long-decommissioned hosts |
| **[[GDB]] / [[Immunity Debugger]]** | Debuggers (binary analysis) | Not scanners — but used during analyst verification to confirm whether a flagged binary issue is actually reachable / exploitable |

*Multipurpose tools like Metasploit and Burp do double duty: they generate findings AND verify them. Use the verify side more than the generate side.*

### CompTIA exam traps

> **CompTIA exam trap:** The scanner reports CVSS 9.8 on a host. The exam asks what you do FIRST. The wrong answer is "patch immediately" or "escalate to IR." The right answer is **validate the finding** — confirm it's not a false positive before consuming remediation cycles. CVSS score does not equal priority until the finding is verified.

> **CompTIA exam trap:** A credentialed scan and an uncredentialed scan return different results on the same host. The exam wants you to recognize that **credentialed scans are more accurate** and the uncredentialed scan's extra findings are likely false positives caused by inference (banner-grabbing, behavior-guessing) rather than direct configuration inspection.

> **CompTIA exam trap:** Watch for "false negative" disguised as false positive. A **false negative** is a real vulnerability the scanner missed — far worse than a false positive. CompTIA will give you a scenario where the analyst closed a finding as FP and the host was later compromised. The answer is "insufficient verification" — the analyst should have reproduced before closing.

> **CompTIA exam trap:** Cloud scanners (Scout Suite, Prowler) flag "public S3 bucket." The right answer depends on context — a static website bucket is *supposed* to be public. The exam wants you to recognize that **compliance benchmark violations are not always vulnerabilities** in business context.

### Documenting the false positive

A closed-as-FP finding needs four fields, minimum:

- **Plugin/rule ID and version** — so when the signature changes, you re-evaluate
- **Evidence of verification** — screenshots, command output, log excerpts proving the test failed to reproduce
- **Compensating controls noted** (if any) — WAF rule, segmentation, EDR detection that mitigates the theoretical risk
- **Review date** — most teams re-validate FP exceptions every 90 days

*"Closed as false positive" with no notes is the same as "closed and forgotten." The next scan will fire it again, the next analyst will reopen it, the cycle never breaks.*

## SOC reality

- At 3am, the Tenable dashboard shows 14,000 findings across the enterprise. The L1's first job is **not** to triage all 14,000 — it's to filter by exploitability + asset criticality + internet-exposed, then start verifying the top 50.
- When the CISO asks "are we vulnerable to [this morning's CVE in the news]?", the wrong answer is "the scanner says yes on 200 hosts." The right answer is "the scanner flagged 200, we verified 12 are actually exploitable, 188 are backported or behind the WAF, remediation is in flight on the 12." Numbers without verification are noise.
- Never tell a system owner "you have a critical vulnerability" based on a scanner result alone. They will lose trust in you the first time you're wrong, and they remember. **Reproduce first, ticket second.**
- The handoff: L1 verifies and tags FP/TP → L2 reviews FP closures weekly → vuln management lead reports trends to the CISO monthly. If your team's FP rate is above ~30%, the scanner is mis-tuned or the credentialed-scan coverage is broken. Fix the tool, don't grind the analysts.
- The dangerous direction is closing a true positive as false. Build the habit: **when in doubt, escalate, don't close.**

## Related concepts

[[Vulnerability Scanning]] · [[Credentialed vs Uncredentialed Scans]] · [[CVSS Scoring]] · [[Nessus]] · [[OpenVAS]] · [[Nmap]] · [[Burp Suite]] · [[ZAP]] · [[Nikto]] · [[Scout Suite]] · [[Prowler]] · [[Compensating Controls]] · [[Risk Acceptance]] · [[Asset Inventory and CMDB]] · [[Web Application Firewall]] · [[Inhibitors to Remediation]] · [[Prioritization of Vulnerabilities]]

*Source: VIRGIL knowledge base — 2026-05-11*