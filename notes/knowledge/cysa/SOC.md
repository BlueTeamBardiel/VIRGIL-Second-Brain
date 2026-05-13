# SOC — Security Operations Center

## What it is

In **Dark Souls**, the bonfire at Firelink Shrine is where everything routes back to. You light it, you rest at it, you spend humanity at it, and from there you can see the whole shape of the world — the path to the Undead Burg, the elevator to the parish, the stairs down to New Londo. When something goes wrong out in the world, you fall back to the bonfire. When you don't know what killed you, you respawn there and study the run. That's the Security Operations Center. The bonfire of the enterprise — central, persistent, the place where the analysts sit and watch every corridor of the kingdom at once, ready to send help when the gargoyles start moving on the bridge.

A **Security Operations Center** is the centralized function — people, process, and technology — responsible for continuous monitoring, detection, analysis, and response across an organization's IT estate. It ingests telemetry from endpoints, network, identity, cloud, and applications; correlates it; triages alerts; investigates incidents; and coordinates response. The SOC is not a product. It's a capability stitched together from a SIEM, an EDR/XDR, identity logs, network sensors, threat intel feeds, ticketing, playbooks, and humans who know what "normal" looks like at 3am.

CS0-003 Objective 1.1 frames the SOC as the operational consumer of system and network architecture — meaning you cannot defend what you cannot see, and you cannot see what isn't logged, segmented, time-synced, and identity-controlled.

## Why it matters

The SOC is the job. CySA+ is structured around what a SOC analyst does every day: ingest logs, tune detections, triage alerts, escalate incidents, coordinate response, report to leadership. Every other domain — vulnerability management, incident response, threat intel — feeds into or out of the SOC.

Architecturally, the SOC's effectiveness is bounded by visibility. A SOC sitting on an unsegmented flat network with no PKI, no MFA, no time sync, and `WARN`-only logs is a watchtower with a blindfold. CompTIA tests this directly: they will hand you a scenario where an incident was missed, and the right answer is almost always "the architecture didn't give the SOC the telemetry it needed."

## Key facts

### What flows into the SOC

| Source | What it gives you | Why the SOC needs it |
|---|---|---|
| **Endpoints** ([[EDR]]/[[XDR]]) | Process trees, file writes, registry changes, network connections | Detect malware, lateral movement, persistence |
| **Network sensors** ([[NetFlow]], [[IDS]]/[[IPS]], [[NDR]]) | Flow records, packet captures, signature hits | Detect [[C2]] beaconing, exfil, anomalous east-west traffic |
| **Identity** ([[Active Directory]], [[IdP]], [[IAM]]) | Auth events, privilege grants, MFA challenges | Detect [[credential stuffing]], [[Kerberoasting]], impossible travel |
| **Cloud** ([[CloudTrail]], Azure Activity, GCP Audit) | API calls, IAM changes, resource creation | Detect cloud-native attack paths, shadow IT |
| **Applications** | App logs, WAF logs, DB audit | Detect [[SQL injection]], [[XSS]], business logic abuse |
| **Threat intel** ([[STIX]]/[[TAXII]], OSINT, ISAC feeds) | IoCs, TTPs, adversary profiles | Pivot from "weird thing" to "known APT" |

All of this lands in the [[SIEM]], which correlates it. Without a SIEM the SOC is reading thirty dashboards instead of one query.

### Architectural prerequisites for a SOC to function

**[[Log ingestion]] and [[logging levels]].** You ship logs centrally — syslog, Windows Event Forwarding, agent-based shippers. Logging levels (`DEBUG`, `INFO`, `WARN`, `ERROR`, `CRITICAL`) decide signal-to-noise. Too verbose, the SIEM bill detonates and the analyst drowns. Too quiet, the breach happens in the silence between events.

**[[Time synchronization]] ([[NTP]]).** Every log source synced to a common time authority. If your domain controller's clock is 47 seconds off from your firewall's, [[forensic timeline]] reconstruction becomes guesswork. Kerberos breaks at 5 minutes of skew. *Time sync is not glamorous and it is not optional.*

**[[Network segmentation]].** VLANs, microsegmentation, DMZ, jump hosts. Segmentation gives the SOC chokepoints to monitor and break-glass moments to isolate. A flat network means the ransomware reaches payroll from the receptionist's laptop in 90 seconds.

**[[Zero trust]] architecture.** Never trust, always verify. Every request authenticated and authorized regardless of source network. The SOC's life gets easier because every access decision is logged and policy-driven instead of "you're inside the perimeter, you're fine."

**[[PKI]], [[TLS]]/[[SSL]], [[encryption]] in transit and at rest.** PKI underpins MFA, mutual TLS, code signing, S/MIME. SSL is the deprecated name; TLS 1.2/1.3 is what's actually deployed. The SOC cares because TLS inspection (or the absence of it) determines whether you can see inside HTTPS traffic.

**[[IAM]] — [[MFA]], [[SSO]], [[federation]], [[passwordless]], [[PAM]].** Identity is the new perimeter. **MFA** stops 99%+ of credential stuffing. **SSO** centralizes auth into one auditable point. **Federation** (SAML, OIDC) extends identity across orgs. **Passwordless** (FIDO2, passkeys) kills phishable secrets. **PAM** (privileged access management) — CyberArk, BeyondTrust, Delinea — vaults, rotates, and session-records admin credentials. Every privileged session goes through PAM or it didn't happen.

**[[System hardening]].** CIS Benchmarks, STIGs, disabled services, removed default accounts, restricted PowerShell. Hardened systems generate less noise and fewer exploit paths.

**[[DLP]] and [[CASB]].** **DLP** inspects data in motion/at rest/in use for [[PII]], [[CHD]] (cardholder data), PHI, IP. **CASB** sits between users and cloud apps to enforce policy, detect shadow IT, and DLP cloud traffic. **[[SASE]]** (secure access service edge) bundles SD-WAN + SWG + CASB + ZTNA + FWaaS into a cloud-delivered edge.

### Infrastructure the SOC monitors

| Model | What it is | SOC implication |
|---|---|---|
| **On-premises** | Owned hardware, owned datacenter | Full telemetry access, you own the logs |
| **Cloud** | IaaS/PaaS/SaaS — AWS, Azure, GCP, Workspace | Shared responsibility — you get the audit API, provider owns the hypervisor |
| **Hybrid** | Mix of on-prem and cloud | Identity federation, log forwarding from cloud to on-prem SIEM (or vice versa) |
| **Virtualization** | Hypervisors (ESXi, Hyper-V) running VMs | VM escape is rare but catastrophic; monitor hypervisor logs |
| **Containerization** | Docker, Kubernetes, OCI runtimes | Ephemeral — logs must ship off the container before it dies |
| **Serverless** | Lambda, Azure Functions, Cloud Run | No host to put an agent on; you live on provider telemetry |
| **[[SDN]]** | Software-defined networking — control plane separated from data plane | Programmable segmentation; centralized policy; controller compromise = full network compromise |

### OS internals the analyst actually touches

**[[Windows Registry]].** Hives at `HKLM`, `HKCU`, etc. Persistence keys CompTIA loves: `Run`, `RunOnce`, `Services`, `Image File Execution Options`. If `regedit` shows a `Run` key pointing at `%APPDATA%\svhost.exe`, the host is owned.

**[[File structure]] and configuration file locations.** Linux: `/etc/passwd`, `/etc/shadow`, `/etc/cron.*`, `/var/log/`, `~/.ssh/authorized_keys`. Windows: `C:\Windows\System32\`, `C:\ProgramData\`, scheduled tasks in `\Windows\System32\Tasks\`. Knowing where persistence hides is the job.

**[[System processes]].** On Windows: `svchost.exe`, `lsass.exe`, `explorer.exe`, `services.exe`. Know the parent-child trees. `winword.exe` spawning `powershell.exe` spawning `cmd.exe` is a macro-based intrusion, full stop.

**Hardware architecture.** TPM for key sealing, HSM for key storage, secure boot, measured boot. The SOC consumes attestation events from these.

### CompTIA exam traps

> **CompTIA exam trap:** **SSL vs TLS.** SSL is deprecated (all versions). TLS 1.2 and 1.3 are current. CompTIA will write "SSL/TLS" colloquially in the question but the technically correct protocol name is **TLS**. If an answer says "use SSL 3.0," it's wrong on principle.

> **CompTIA exam trap:** **CASB vs SASE vs SWG.** CASB sits between users and cloud apps for visibility/policy. SWG is a secure web gateway for general web filtering. SASE is the cloud-delivered bundle of SWG + CASB + ZTNA + FWaaS + SD-WAN. CompTIA tests "which control would you deploy to enforce DLP on Box and Salesforce traffic" — answer is CASB, not SASE (SASE *contains* CASB but the specific control is CASB).

> **CompTIA exam trap:** **Containerization vs virtualization.** Containers share the host kernel; VMs have their own. Container escape lands you on the host kernel directly. Don't pick "VM escape" when the scenario describes Docker.

> **CompTIA exam trap:** **Passwordless ≠ no authentication.** Passwordless means no shared secret to phish — FIDO2 hardware key, biometric + device cryptographic attestation. It is still MFA-strong (something you have + something you are). CompTIA will offer "passwordless is single-factor" as a distractor. Wrong.

> **CompTIA exam trap:** **PAM is *Privileged* Access Management, not Pluggable Authentication Modules.** Linux has PAM modules in `/etc/pam.d/`. CySA+ context, PAM almost always means privileged access (CyberArk class of tools). Read the question.

### SOC tiering

| Tier | Role | What they touch |
|---|---|---|
| **Tier 1** | Triage, alert validation, basic enrichment | SIEM queue, ticketing, runbooks |
| **Tier 2** | Investigation, scope determination, escalation | Endpoint forensics, log pivots, threat intel |
| **Tier 3 / IR** | Deep forensics, malware analysis, threat hunting | Memory forensics, reverse engineering, hypothesis-driven hunts |
| **SOC Manager** | Metrics ([[MTTD]], [[MTTR]]), staffing, exec reporting | Dashboards, board decks, vendor management |
| **Engineering** | Detection content, parser tuning, integrations | SIEM rules, SOAR playbooks, log pipelines |

## SOC reality

- **The 3am alert looks like:** SIEM correlation rule "Suspicious PowerShell Execution + Outbound to Rare Destination" firing on `FIN-WS-0473`. Tier 1 acknowledges within SLA (often 15 min), pulls the EDR process tree, checks the destination against threat intel, and either closes as benign (IT admin running a legitimate script) or escalates to Tier 2 within the next 15.
- **First action is never "isolate the host."** First action is *acknowledge, gather context, decide*. Yanking a CFO's laptop off the network at 3am because of a false positive is a career event. So is *not* yanking it when it's real.
- **The IR lead asks three things every time:** scope ("how many hosts?"), impact ("what data, what privilege?"), evidence ("are we preserving artifacts before we re-image?"). Have answers ready before you call.
- **Never tell leadership "we've contained it" until you actually have.** Containment claims that fall apart 6 hours later destroy SOC credibility for years. Say "we've isolated the known-affected hosts and are scoping further" — accurate, defensible, doesn't overcommit.
- **80% of the queue is noise.** The job is tuning so the 20% that matters surfaces fast. A SOC that doesn't tune drowns. A SOC that over-tunes misses the breach. *The art of the job is calibrating that threshold and re-calibrating it every quarter.*

## Related concepts

[[SIEM]] · [[EDR]] · [[XDR]] · [[SOAR]] · [[Incident Response]] · [[Threat Intelligence]] · [[MTTD]] · [[MTTR]] · [[Zero Trust]] · [[PAM]] · [[IAM]] · [[MFA]] · [[SSO]] · [[Federation]] · [[CASB]] · [[SASE]] · [[DLP]] · [[Network Segmentation]] · [[PKI]] · [[TLS]] · [[NTP]] · [[Log Ingestion]] · [[SDN]] · [[Windows Registry]] · [[System Hardening]]

*Source: VIRGIL knowledge base — 2026-05-11*