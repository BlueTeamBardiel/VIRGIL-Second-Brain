# Spyware and Bloatware

## What it is

In Need for Speed, you boot up the game and before you can even hit a checkpoint, your dashboard is plastered with sponsor decals, a Burger King ad pops up mid-race, and the EA launcher quietly installs Origin, a telemetry agent, and three "recommended" friends you never asked for. That's exactly what spyware and bloatware do — unwanted software that either watches you or wastes your resources, riding shotgun whether you invited it or not.

**Spyware** is malicious software that covertly collects user activity, credentials, or system data and exfiltrates it to a third party. **Bloatware** is pre-installed or bundled software that consumes resources without the user's intent, often shipped by OEMs or piggybacked on legitimate installers.

## Why it matters

Spyware leads directly to credential theft, session hijacking, and regulatory violations under HIPAA, GDPR, and PCI DSS — losing keystrokes means losing customers. Bloatware enlarges the attack surface (every unpatched OEM utility is a candidate for privilege escalation, see Superfish on Lenovo, 2015) and degrades performance enough to drive shadow IT. The SY0-701 trap on Objective 2.4: candidates confuse **spyware** (covert surveillance) with **adware** (overt ad delivery) and miss that **bloatware is not inherently malicious** — it's unwanted, not hostile, but still a vulnerability multiplier.

## Key facts

### Spyware mechanics

- **Delivery vectors**: [[trojan]] bundles, [[drive-by download]], [[malicious browser extensions]], [[phishing]] attachments, supply-chain implants.
- **Subtypes**:
  - **[[Keylogger]]** — records keystrokes; hardware or software variants.
  - **[[Tracking cookie]]** — cross-site behavioral profiling (lower severity).
  - **[[Infostealer]]** — RedLine, Raccoon, Vidar; harvests browser-stored credentials, crypto wallets, session tokens.
  - **[[Stalkerware]]** — consumer-grade surveillance (FlexiSpy, mSpy).
- **Persistence**: registry Run keys, scheduled tasks, browser helper objects (BHOs), [[rootkit]] cloaking.
- **Exfiltration**: HTTPS to C2, DNS tunneling, Telegram/Discord webhooks.

### Bloatware mechanics

- **Sources**: OEM pre-installs (Dell SupportAssist, HP utilities), bundled installers (PUP — **Potentially Unwanted Program**), browser toolbars, trialware.
- **Risks**: unpatched vulnerabilities (Superfish injected a self-signed root CA enabling [[on-path attack]]), telemetry leakage, resource consumption, expanded attack surface.
- **Not always malicious** — distinguishing factor for the exam.

### Spyware vs. Bloatware vs. Adware

| Trait | Spyware | Bloatware | Adware |
|---|---|---|---|
| Intent | Covert surveillance | Unwanted utility | Ad revenue |
| Visibility | Hidden | Visible, annoying | Visible |
| Data exfil | Yes | Sometimes (telemetry) | Limited |
| Malicious by default | Yes | No | Borderline |
| Typical source | Attacker | OEM / bundled installer | Free software |

### Defenses

- **[[Endpoint Detection and Response]] (EDR)** — behavioral detection of keylogging APIs (`SetWindowsHookEx`), credential access patterns.
- **[[Anti-malware]]** with PUP detection enabled (off by default in many products — exam favorite).
- **[[Application allowlisting]]** — Windows Defender Application Control, AppLocker.
- **OS hardening**: debloat scripts, Windows **Fresh Start** / **Reset this PC**, enterprise images stripped of OEM software.
- **[[Browser hardening]]**: extension allowlists via group policy, disable third-party cookies.
- **[[User awareness training]]** — custom installer paths, decline bundled offers.
- **[[MDM]]** for mobile to block sideloaded surveillance apps.
- **Network controls**: [[DNS filtering]], egress monitoring for known C2.

### Exam-relevant indicators

- Unexplained outbound traffic to unfamiliar domains.
- High CPU/disk from unknown processes.
- Browser homepage/search engine hijacked.
- New toolbars, certificates, or root CAs.
- Battery drain on mobile (stalkerware tell).

## Related concepts

[[Malware]] · [[Trojan]] · [[Keylogger]] · [[Rootkit]] · [[Potentially Unwanted Program]] · [[Adware]] · [[Endpoint Detection and Response]] · [[Application allowlisting]] · [[Supply chain attack]] · [[Phishing]]

---
*Source: VIRGIL knowledge base — 2026-05-08*