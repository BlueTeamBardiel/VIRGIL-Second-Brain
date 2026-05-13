# Cloud Assessment Tools

## What it is

In **Helldivers 2**, before you drop on a planet you stare at the tactical map and pick your stratagems — Eagle airstrikes, the autocannon, the orbital railcannon. You don't know what bug nest or Automaton fabricator you'll hit until you're on the ground, but the loadout you brought is the loadout you fight with. Pick wrong and you're calling Reinforce on cooldown for forty minutes. The cloud is the same drop. You can't kick down the door of someone else's hypervisor — AWS, Azure, GCP own the metal — so the only assessment that matters is whether *your* configuration inside that environment is going to get you killed. Cloud assessment tools are your pre-drop loadout check: they don't shoot the bugs, they tell you that you forgot to bring an anti-tank stratagem to a Bile Titan planet.

That's exactly what cloud assessment tools do — they audit your cloud tenant's **configuration posture**, not the underlying infrastructure.

**Technical definition:** Cloud assessment tools are automated auditors that enumerate cloud account configurations (IAM, storage, network, logging, encryption) and compare them against benchmarks ([[CIS Benchmarks]], [[PCI DSS]], [[ISO 27001]], cloud-provider best practices) to identify **misconfigurations** and identity overexposure. They operate via cloud provider APIs using read (and sometimes write, for exploit tools) permissions, and they live in the shared-responsibility seam: the cloud provider secures the cloud, you secure what's *in* the cloud, and these tools tell you whether you actually did.

## Why it matters

Cloud breaches are almost never zero-day kernel exploits against AWS. They are public S3 buckets, IAM roles with `*:*` permissions, root accounts without MFA, security groups open to 0.0.0.0/0 on port 3389, and forgotten access keys checked into a public GitHub repo. Capital One. Imperva. Twitch. The breach reports read like the same incident copy-pasted with the company name swapped.

For CySA+ (**Objective 2.1**), the exam wants you to know that traditional vulnerability scanners — Nessus, Qualys, OpenVAS — aren't built for cloud-native assessment. They scan hosts. They don't know what an IAM policy is. CompTIA will test you on tool *purpose* (audit vs. exploit), tool *target* (AWS vs. multi-cloud), and the shared-responsibility line.

## Key facts

### The three tools you must know

| Tool | Target | Purpose | Auth model |
|---|---|---|---|
| **Prowler** | AWS (primary), Azure/GCP (added support) | Configuration audit against CIS, PCI DSS, HIPAA, GDPR, ISO 27001 | Read-only IAM role / access keys |
| **Scout Suite** | Multi-cloud (AWS, Azure, GCP, Oracle, Alibaba) | Multi-cloud posture audit, HTML report output | Read-only credentials |
| **Pacu** | AWS | **Offensive** — exploitation framework for AWS, the Metasploit of cloud | Credentials you've already obtained (red team) |

Two of these are blue team. One is red team. CompTIA will mix them.

### Prowler — the workhorse

Prowler is an open-source AWS auditor written in Python that runs hundreds of checks across IAM, S3, EC2, RDS, CloudTrail, KMS, and more. It's not a vulnerability scanner — it doesn't fire exploits. It calls the AWS API with read permissions and asks questions like:

- Is the root account MFA-enabled?
- Are CloudTrail logs encrypted and going to a centralized bucket?
- Does the IAM password policy require rotation, length, complexity?
- Are S3 buckets public?
- Are there access keys older than 90 days?
- Are security groups allowing 0.0.0.0/0 on sensitive ports?

Output is **PASS / FAIL / INFO**, organized into **scored** and **non-scored** findings — language straight out of the CIS Benchmark format.

> **CompTIA exam trap:** Prowler is an **audit** tool, not an exploitation tool. If the question describes "enumerating IAM misconfigurations and producing a compliance report against CIS benchmarks," it's Prowler or Scout Suite. If the question describes "pivoting through stolen AWS keys to escalate privilege," it's Pacu. The verbs matter.

### Scout Suite — the multi-cloud equivalent

Where Prowler is AWS-first, Scout Suite is built for shops running multi-cloud. Same idea: read-only credentials, API enumeration, configuration audit. The output is a self-contained HTML report you can open in a browser and click through findings by severity. Auditors love it because it's portable evidence.

If the exam says "the org runs workloads in AWS, Azure, and GCP and wants a single posture assessment," Scout Suite is the answer.

### Pacu — the red team's toy

Pacu is the offensive counterpart. Built by Rhino Security Labs, it's modular like Metasploit: load a module (`iam__enum_permissions`, `s3__bucket_finder`, `lambda__backdoor_new_users`), point it at compromised AWS credentials, and it enumerates, escalates, persists, and exfiltrates. As a SOC analyst you won't run it, but you will see its artifacts in CloudTrail — anomalous API calls, role assumptions you didn't authorize, IAM policy changes at 2am.

*The first time I saw Pacu in a tabletop, I realized our CloudTrail alerting was tuned for "failed login" and completely silent on "successful API enumeration from a new IP." Pacu walked through it like a ghost.*

### Where cloud assessment fits in the broader scanning taxonomy

- **Credentialed vs. non-credentialed:** Always **credentialed** — the API won't talk to you without auth.
- **Agent vs. agentless:** **Agentless**. Queries the control plane, no software on EC2.
- **Active vs. passive:** **Active** API calls, but read-only — low impact. Pacu's exploit modules are aggressively active.
- **Static vs. dynamic:** Closer to **static** — inspects configuration state, not runtime behavior. Compare to a [[DAST]] tool that fuzzes a running web app.
- **Asset discovery:** Cloud assessment *is* asset discovery — half the value is finding the EC2 instance, S3 bucket, or Lambda function nobody documented.

### What gets checked — the high-value misconfigurations

- **Public S3 buckets** — bucket ACL or policy allowing `AllUsers` or `AuthenticatedUsers`
- **IAM over-privilege** — `*:*`, `iam:PassRole` to anything, AdministratorAccess on service roles
- **Root account hygiene** — MFA, no access keys, alerting on root login
- **Logging gaps** — CloudTrail disabled, not multi-region, not log-file-validated
- **Unencrypted data at rest** — EBS, RDS, S3 without default encryption
- **Network exposure** — security groups open to the internet on RDP/SSH/SQL
- **Stale credentials** — access keys older than 90 days, unused users
- **Public AMIs / snapshots** — accidental sharing of disk images containing secrets

### Frameworks the tools map against

| Framework | Relevance |
|---|---|
| **[[CIS Benchmarks]]** | Default ruleset for almost every cloud auditor |
| **[[PCI DSS]]** | Mandatory if you process card data — Prowler has a PCI mode |
| **[[ISO 27001]]** | Common audit driver for enterprise |
| **HIPAA** | Applies if you touch PHI in cloud |
| **GDPR** | Triggers data-residency and encryption checks |

### Special considerations — what cloud assessment **does not** cover

- **OT / ICS / SCADA** — [[operational technology]] environments are not what cloud assessment tools are built for. You don't run Prowler against a power-grid PLC. OT scanning needs passive, fingerprint-only tools (Claroty, Nozomi, Dragos) because actively probing a PLC can crash a turbine.
- **Web application logic flaws** — Prowler won't find XSS or SQL injection. That's [[OWASP ZAP]], [[Burp Suite]], or a proper [[DAST]] scan.
- **Vulnerable software on EC2** — patch-level CVEs on the OS need a traditional scanner ([[Nessus]], [[Qualys]]) or AWS Inspector with an agent.

> **CompTIA exam trap:** If the scenario describes "scanning a SCADA controller in a water-treatment facility," **passive fingerprinting** is the answer — never an active scan, never a cloud tool. ICS/OT systems can crash from a port scan.

### Scheduling and operational concerns

- **Performance:** API calls are rate-limited. A full Prowler run on a large AWS account can take 30+ minutes and may trip rate-limit alarms.
- **Sensitivity tagging:** A public S3 bucket holding marketing images is a low; the same misconfiguration on a bucket holding PHI is a P1.
- **Segmentation:** Run separate scans per AWS account / Azure subscription / GCP project. Don't dump findings into one report — context is lost.
- **Frequency:** PCI DSS requires quarterly. Modern direction is continuous (AWS Security Hub, Azure Defender, Prowler in CI/CD) — not quarterly by a human.

## SOC reality

- The alert that matters is not "Prowler ran" — it's **"Prowler finding count increased by 40 since yesterday's baseline."** A drift dashboard, not a raw report.
- L1 triage on a new finding: confirm the resource still exists, confirm it's actually exposed (sometimes a higher-level deny policy blocks what the finding flags), assign to the cloud team via Jira.
- What the CISO asks after a public-bucket incident: "How long was it public, what was in it, who accessed it, and why didn't our continuous scan catch it before the researcher emailed us?" The answer to the last one is almost always "we ran the scan quarterly and the bucket was created on day 7 of the quarter."
- Never promise "the cloud is hardened." Configuration drifts constantly — developers spin up resources hourly. The right framing is "we have continuous posture monitoring and our finding-count trend is downward."
- Escalation path: L1 confirms finding → cloud engineering remediates → L2 verifies fix in next scan → if data exposure suspected, IR + legal + privacy get pulled in for the breach-notification clock (GDPR 72h, state laws vary).

*The cloud doesn't get breached. Your IAM policy gets breached. Scan the loadout before you drop.*

## Related concepts

[[CIS Benchmarks]] · [[PCI DSS]] · [[ISO 27001]] · [[IAM]] · [[Shared Responsibility Model]] · [[CloudTrail]] · [[AWS Security Hub]] · [[Nessus]] · [[OWASP ZAP]] · [[DAST]] · [[Vulnerability Scanning Methods]] · [[Credentialed Scanning]] · [[Agent vs Agentless]] · [[Operational Technology]] · [[SCADA]] · [[Asset Discovery]]

*Source: VIRGIL knowledge base — 2026-05-11*