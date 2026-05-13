# CI/CD — Continuous Integration and Continuous Delivery

## What it is

In **Bloodborne**, the Hunter's Workshop in the Hunter's Dream is where every weapon gets fortified, every Blood Gem socketed, every transformation tested before you take it back into Yharnam. You don't walk into Central Yharnam swinging an untested Saw Cleaver against the Cleric Beast. You bench it, mod it, test the trick-weapon transformation, then warp it through the lantern into the real fight. Every loop through the Dream is the same: pull resources, refine the build, push it live, see what dies, come back, refine again. That's exactly what CI/CD does — every code change gets built, tested, and pushed through an automated pipeline before it ever touches production.

**Continuous Integration** is the merge-and-test half: every commit to the shared repo triggers an automated build and test suite. **Continuous Delivery** is the package-and-stage half: every passing build is automatically prepared for release. **Continuous Deployment** (the more aggressive cousin) pushes straight to prod with no human in the loop. CompTIA uses CI/CD as the canonical example of standardized, repeatable, automation-suitable workflow under Objective 1.5 — the work humans shouldn't be doing by hand anymore.

## Why it matters

For a SOC analyst, CI/CD is two things at once. First, it's a **production system you have to defend** — pipelines hold secrets, signing keys, and deployment authority into prod. Compromise the pipeline and you compromise everything downstream. SolarWinds was a CI/CD compromise. Second, it's a **model for how SecOps itself should run** — your detection rules, your playbooks, your SOAR workflows should ship through pipelines too. Detection-as-code is just CI/CD applied to Sigma and YARA.

Objective 1.5 puts this squarely on the exam: standardize processes, identify what can be automated, minimize human engagement, integrate tools through APIs and webhooks. CI/CD is the textbook implementation. If you can't explain why repeatable automated workflows beat human toil at 2am, you're going to miss easy points.

## Key facts

### The pipeline stages

| Stage | What happens | Security control |
|---|---|---|
| **Source** | Commit triggers pipeline via webhook | Signed commits, branch protection, MFA on repo |
| **Build** | Compile, package artifact | Reproducible builds, dependency pinning |
| **Test** | Unit, integration, security scans | SAST, secret scanning, license checks |
| **Package** | Container image, signed binary | Image signing (Sigstore, Notary), SBOM generation |
| **Stage** | Deploy to test environment | DAST, IAST, smoke tests |
| **Deploy** | Push to production | Approval gates, canary, blue/green, rollback |

Every stage is automated. Every stage emits logs. Every stage is a place an attacker would love to live.

### Why CompTIA loves CI/CD as the automation example

The Objective 1.5 bullets read like a CI/CD spec sheet:

- **Standardize processes** — every commit goes through the same pipeline. No more "well, Dave deploys differently on Fridays."
- **Repeatable / do not require human interaction** — the pipeline runs the same way at 3am as at noon. Humans approve, they don't execute.
- **Identification of tasks suitable for automation** — build, test, scan, deploy. Anything deterministic and high-frequency.
- **Minimize human engagement** — humans review exceptions, not the happy path.
- **Streamline operations** — one workflow replaces twelve runbooks.

The exam will ask you which of four workflows is "best suited for automation." The answer is always the one that's **repeatable, deterministic, high-frequency, and doesn't need judgment**. Building software fits. "Negotiating with the change board" does not.

### The integration glue — APIs, webhooks, plugins

CI/CD doesn't run in isolation. It's stitched into the rest of the stack through three primitives CompTIA names directly:

- **APIs** — pull-based. Your pipeline asks Jira "is ticket SEC-1247 approved?" before deploying. REST and GraphQL endpoints. Authenticated, rate-limited, versioned.
- **Webhooks** — push-based. GitHub fires a webhook at Jenkins the instant a PR is merged. Event-driven, no polling, low-latency. The pipeline starts because something happened, not because something asked.
- **Plugins** — in-process extensions. Jenkins has 1,800+ of them. Each one is a third-party dependency running with pipeline privileges. Each one is supply-chain risk.

> **CompTIA exam trap:** API vs webhook is a guaranteed question. API = you ask (pull). Webhook = it tells you (push). If the question describes "event-driven notification when X happens," it's a webhook. If it describes "querying for status," it's an API. They will swap the definitions.

### CI/CD as the template for SOAR

This is where the topic stops being a developer concern and becomes yours. **[[SOAR]] (Security Orchestration, Automation, and Response)** is CI/CD logic applied to security operations. Same pattern, different payload:

| CI/CD | SOAR |
|---|---|
| Commit triggers pipeline | Alert triggers playbook |
| Build → Test → Deploy | Enrich → Decide → Act |
| Webhook from GitHub | Webhook from SIEM |
| Deploys code | Deploys response actions |
| Pipeline-as-code (YAML) | Playbook-as-code (YAML/Python) |
| Rolls back failed deploys | Reverts containment if false positive |

A SOAR playbook for a phishing report: ingest the report, **enrich** the URL through VirusTotal API, **enrich** the sender through your threat-intel platform, **combine** feeds from MISP and a commercial provider, check if any user clicked via proxy logs, and if positive — auto-quarantine the message across all mailboxes, disable the clicker's session, open a ticket. Humans get pinged for the final approval on the containment action. Everything else is machines.

That's the "orchestrating threat intelligence data," "data enrichment," and "threat feed combination" language straight out of Objective 1.5.

### Single pane of glass

The phrase CompTIA wants you to know. **Single pane of glass** = one console that aggregates signal from every tool — SIEM, EDR, vulnerability scanner, ticketing, threat intel, CI/CD pipeline status. Analysts don't tab between fourteen browser windows; they work one queue.

It's an aspiration more than a reality. Every vendor claims to be the single pane. They never are. But the goal — reducing context-switching cost — is real and the exam treats it as a stated benefit of orchestration platforms.

### Securing the pipeline itself

Pipelines are juicy targets. They hold:

- **Deployment credentials** to production
- **Signing keys** that downstream consumers trust
- **Cloud IAM roles** with broad blast radius
- **Source code** including unreleased vulnerabilities

The defender checklist:

- **Least privilege on runners** — build agents shouldn't have prod database creds
- **Ephemeral runners** — spin up clean, destroy after each job; no persistence for attackers
- **Secret management** — pull from a vault at runtime, never commit to repo
- **Branch protection** — require reviews, signed commits, status checks before merge
- **Pipeline-as-code reviewed like app code** — the Jenkinsfile or `.github/workflows/*.yml` is code; treat it that way
- **SBOM and dependency scanning** — know every transitive dependency you're shipping
- **Artifact signing** — Sigstore, cosign — so downstream can verify what you built

> **CompTIA exam trap:** "Repeatable" does NOT mean "ungoverned." Automation doesn't remove the need for approval gates — it removes the need for humans to *execute*. A pipeline can be fully automated and still require human approval before the prod deploy step. CompTIA will offer you "fully automate with no human approval" as a wrong answer to a question about CI/CD best practice. Pick the option with the human-on-the-loop for high-impact stages.

### Team coordination

Objective 1.5 specifically names "team coordination to manage and facilitate automation." Translation: automation is a team sport. Security writes the SAST rules, dev writes the build steps, ops writes the deploy steps, SOC writes the SOAR playbooks. If those four teams don't talk, you get:

- Security tools that block legitimate builds (false positives in the CI gate)
- Pipelines that bypass security checks because they were "slowing things down"
- SOAR playbooks that take containment actions the business never approved
- Plugins added without review that exfiltrate build artifacts

This is the **DevSecOps** seam. The exam doesn't use that word in 1.5, but it's the underlying concept.

## SOC reality

- **Pipeline alerts you'll actually see**: unexpected runner spawn outside business hours, secrets committed to public repo (GitGuardian/TruffleHog fire), unusual outbound from a build agent (data exfil or crypto mining), new plugin installed on Jenkins without a change ticket, signed artifact with a hash that doesn't match the build log.
- **The 3am call**: "our deploy pipeline pushed something weird to prod and now the EDR is screaming on 400 endpoints." Your job — figure out if the build was compromised, if the source was compromised, or if a developer pushed legitimately bad code. The pipeline logs are your replay file. Pull them first.
- **What the CISO asks**: "Can the pipeline itself sign code we don't approve? Who has merge rights to main? When did we last rotate the deploy tokens?" If you can't answer in under a minute, you have a gap.
- **What never to promise**: that your SOAR playbook will handle every phishing report. It won't. The novel ones — the ones that matter — will still need an analyst. Auto-containment on a false positive can take down a VIP's mailbox during a board meeting. *Automation amplifies whatever judgment you put into it, including the bad judgment.*
- **The handoff**: pipeline compromise is an IR-team event, not L1. The blast radius — every artifact ever built on that runner is now suspect — is too large for queue triage. Escalate immediately, preserve runner state, freeze deploys.

*The Hunter's Workshop only works because every weapon goes through the same bench. Skip the bench once because you're in a hurry, and the Cleric Beast eats you. Skip the pipeline once because the deploy is "urgent," and you ship the vulnerability to every customer at machine speed.*

## Related concepts

[[SOAR]] · [[SIEM]] · [[Automation and orchestration]] · [[API security]] · [[Webhooks]] · [[Threat intelligence platforms]] · [[Data enrichment]] · [[Single pane of glass]] · [[DevSecOps]] · [[Supply chain attack]] · [[SAST]] · [[DAST]] · [[SBOM]] · [[Secrets management]] · [[Detection as code]]

*Source: VIRGIL knowledge base — 2026-05-11*