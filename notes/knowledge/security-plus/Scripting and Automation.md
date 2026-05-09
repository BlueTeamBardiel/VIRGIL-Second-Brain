# Scripting and Automation

## What it is

In Tomb Raider, Lara doesn't manually shimmy across every ledge — she chains together climbing, jumping, and grappling combos with a single button press, and the game executes the entire sequence flawlessly every time. That's exactly what scripting and automation does — it bundles repetitive technical actions into a single executable command that runs the same way every time, without a human getting bored and skipping a step.

**Scripting and automation** refers to the use of code (PowerShell, Bash, Python) and orchestration platforms to programmatically execute repeatable security and operations tasks — provisioning, configuration, patching, incident response, and policy enforcement — at machine speed and machine consistency.

## Why it matters

A human admin onboarding 200 users will misspell three names, forget to disable two terminated accounts, and grant one wrong group membership. A script does it identically 200 times at 3 a.m. while you sleep. Failure to automate creates **configuration drift**, missed patches, and the kind of stale accounts that become attacker beachheads.

**Exam angle:** SY0-701 Objective **4.7** explicitly lists the *use cases of automation and scripting related to secure operations*. CompTIA's traps tend to be (1) picking the right use case for a scenario — don't confuse **orchestration** with simple **scripting** — and (2) recognizing the *downsides*: technical debt, single point of failure, and complexity. Memorize both the benefits and the costs.

## Key facts

### Use cases CompTIA expects you to know

| Use Case | What it Automates | Why it Matters |
|---|---|---|
| **User provisioning** | Account creation, group membership, mailbox setup | Eliminates [[onboarding]] errors and orphaned accounts |
| **Resource provisioning** | VM, container, storage, network deployment | [[Infrastructure as Code]] — reproducible environments |
| **Guard rails** | Policy enforcement at deploy time | Blocks insecure configs before they hit prod |
| **Security groups** | Firewall rule and IAM group changes | Reduces human typo turning DMZ into open internet |
| **Ticket creation** | Auto-open tickets from SIEM/EDR alerts | Closes the gap between detection and response |
| **Escalation** | Auto-page on-call when SLAs breach | Humans forget; scripts don't |
| **Enabling/disabling services and access** | JIT access, [[offboarding]], [[account lockout]] | Terminated employees lose access in seconds, not days |
| **Continuous integration and testing** | [[CI/CD pipeline]] security scans, [[SAST]]/[[DAST]] | Catches vulns before they ship |
| **Integrations and APIs** | Tool-to-tool [[SOAR]] workflows | Stitches the security stack into one nervous system |

### Benefits (CompTIA loves listing these)

- **Efficiency / time savings** — machines don't take lunch
- **Enforcing baselines** — every system gets the same [[hardening]] treatment
- **Standard infrastructure configurations** — see [[Infrastructure as Code]]
- **Scaling in a secure manner** — 10,000 endpoints managed like 10
- **Employee retention** — engineers quit when forced to do manual toil
- **Reaction time** — automated response in milliseconds vs. minutes
- **Workforce multiplier** — a 5-person team operates like 50

### Other considerations (the downsides — also testable)

- **Complexity** — automation systems become their own attack surface
- **Cost** — orchestration tooling and skilled engineers aren't free
- **Single point of failure** — one bad script pushed everywhere = outage everywhere
- **Technical debt** — scripts written by someone who left two years ago
- **Ongoing supportability** — automation requires its own [[change management]] and version control

### Common languages and tools

| Tool | Domain |
|---|---|
| **PowerShell** | Windows admin, Active Directory |
| **Bash** | Linux/Unix system tasks |
| **Python** | Cross-platform, security tooling, API glue |
| **Ansible / Puppet / Chef / Terraform** | [[Configuration management]] and [[IaC]] |
| **SOAR platforms** (Splunk SOAR, Palo Alto XSOAR) | Security orchestration and incident response |

### Security gotchas

- **Hardcoded credentials** in scripts — use a [[secrets manager]] or [[vault]]
- **Excessive script privileges** — apply [[least privilege]] to service accounts running automation
- **Unsigned scripts** — enforce [[code signing]] (PowerShell `AllSigned` execution policy)
- **Supply chain risk** — scripts pulling modules from public repos can be poisoned

## Related concepts

[[SOAR]] · [[Infrastructure as Code]] · [[CI/CD pipeline]] · [[Configuration management]] · [[Orchestration]] · [[Playbook]] · [[Runbook]] · [[Secrets manager]] · [[Least privilege]] · [[Change management]]

---
*Source: VIRGIL knowledge base — 2026-05-08*