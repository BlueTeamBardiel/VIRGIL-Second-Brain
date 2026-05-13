# Zero Day Attacks

## What it is

The patch came out Tuesday. The exploit hit production Monday. That's the entire problem in one sentence.

A **zero-day** is a vulnerability the vendor doesn't know about yet — or knows about but hasn't patched. The "zero" is the number of days defenders have had to fix it. Attackers found the bug first, weaponized it, and started using it before anyone on the defending side had a chance to write a signature, push an update, or even know the hole existed.

Technical definition: a zero-day exploit targets a previously undisclosed vulnerability in software, firmware, or hardware for which no patch exists at the time of attack. Once the vendor learns of it and ships a fix, the clock starts and it becomes an **n-day** vulnerability — still dangerous against unpatched systems, but no longer a zero-day. The window between disclosure and patched deployment across the fleet is where most real-world damage happens.

The body metaphor: it's an infection the immune system has never seen. No antibodies. No signature in the antivirus database. The pathogen walks past every checkpoint because nothing recognizes it as hostile yet.

## Why it matters

Zero-days are the single attack class where "patch your systems" — the answer to almost every other vulnerability — doesn't help you, because the patch doesn't exist yet. Every other item on the 220-1202 Objective 2.5 list has a known fix. Zero-days don't.

This matters on the exam (220-1202 2.5) and matters more in your career. The 2020 SolarWinds Orion compromise, the 2021 Log4Shell vulnerability, the 2023 MOVEit Transfer breach — all zero-days, all caused billions in damage, all hit organizations whose patch hygiene was otherwise fine. The defense isn't patching faster (you can't patch what doesn't exist). The defense is **layered**: assume compromise, detect behavior not signatures, segment your network, and have a tested incident response plan.

For helpdesk and junior IT, the practical reality: you won't discover zero-days. You'll be the person who reads the urgent email at 8 AM saying "patch everything running [X] by end of day" and has to figure out the inventory, the maintenance window, and the user communication. That's the job.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Zero-days live across the whole stack: OS kernel bugs (privilege escalation), browser exploits (drive-by downloads), application bugs (Log4Shell, Exchange ProxyLogon), firmware bugs (UEFI rootkits, baseboard management controller exploits), and hardware bugs (Spectre, Meltdown). The lifecycle has three phases: **discovery** (researcher or attacker finds the bug), **weaponization** (working exploit code), and **disclosure** — which splits into *responsible disclosure* (told to vendor, patch shipped, then public) or *full disclosure* (dropped publicly, sometimes with the exploit attached). A zero-day used quietly by a nation-state for two years before discovery is the worst case — long dwell time, deep compromise, no detection. The market reflects this: a working iOS remote code execution zero-day sells for $2M+ on legitimate broker markets. That price tag tells you who's buying and what they intend to do with it.

**Beat 2 — Feynman example via gaming/personal build.**

**The Steam download:** You install a game from Steam. Steam is signed, trusted, antivirus whitelisted. The game ships with a vulnerable third-party library nobody flagged because nobody knew it was vulnerable. *Trusted source ≠ safe code.*

**The browser tab:** You leave Chrome open with 40 tabs. One ad network gets compromised, serves a malicious payload that exploits an unpatched V8 JavaScript engine bug. Your machine is compromised before you tab back. *You did nothing wrong. The exploit ran anyway.*

**The Discord link:** A friend's account gets hijacked. They DM you a "look at this clip" link. The link exploits a browser bug Google patched three weeks ago — but you put off the Chrome restart because it'd close your tabs. *Once the patch ships, you're the zero-day for anyone who hasn't applied it.*

**The kicker:** Your antivirus didn't fire. Your firewall didn't block it. Both work on signatures and known-bad behavior. The exploit was new. *Signature-based defense has a floor it cannot go below — the day a signature gets written.* This is why behavioral detection (EDR) exists.

**Beat 3 — Bridge from gaming to enterprise.** Same three scenarios, enterprise scale: the trusted Steam download becomes a **supply chain attack** — your vendor's software update server gets compromised and pushes signed malicious updates to thousands of customers (SolarWinds). The 40 browser tabs become **5,000 employee endpoints**, each with its own outdated browsers, plugins, and PDF readers — a single user clicking a phishing link in Outlook triggers an exploit chain that lands SYSTEM on a corporate workstation. The unpatched Discord link becomes **an unpatched Exchange server facing the internet** because the maintenance window keeps getting bumped — and now ransomware operators have a foothold in your mail infrastructure. Same vulnerability physics. Different blast radius. Different career-ending phone call at 3 AM.

**Beat 4 — The point.** Zero-days are not preventable by any single control. They're managed by **defense in depth**: patch fast when patches exist (shrink the n-day window), segment networks (limit lateral movement when something gets in), monitor behavior (catch exploits that signatures miss), back up religiously (recover when prevention fails), and assume breach. Get this into your bones — perimeter thinking is dead. *You will be compromised. The question is how fast you detect it and how small you can keep the blast.*

## Key facts

### Consumer vs. enterprise defense posture

| Layer | Home build | Enterprise |
|---|---|---|
| Patch cadence | Windows Update, auto | Patch management (WSUS, Intune, SCCM), tested in rings |
| Endpoint protection | Defender / consumer AV | EDR/XDR with behavioral detection |
| Network segmentation | Single flat LAN | VLANs, micro-segmentation, zero trust |
| Detection | None, really | SIEM, SOC, threat hunting |
| Response | Reinstall Windows | Incident response team, forensics, legal |
| Threat intelligence | Reddit posts | CISA alerts, ISAC feeds, vendor advisories |

The home model assumes "if it gets bad, I nuke and reinstall." The enterprise model can't — there's customer data, compliance, downtime cost, legal exposure. *Different stakes drive different controls.*

### The zero-day kill chain

1. **Reconnaissance** — attacker identifies target software/version
2. **Weaponization** — exploit code built around the unknown bug
3. **Delivery** — phishing email, malicious website, compromised supply chain
4. **Exploitation** — the zero-day fires, code executes
5. **Installation** — persistence mechanism (registry, scheduled task, service)
6. **Command and control** — beacon to attacker infrastructure
7. **Actions on objectives** — data exfil, ransomware deployment, lateral movement

You can't break the chain at step 4 (that's the zero-day itself). You break it at 3 (email filtering, web filtering), 5 (EDR catching persistence), 6 (DNS filtering, network egress monitoring), or 7 (segmentation, DLP). *Every layer you skip is a layer the attacker doesn't have to defeat.*

### Detection — what actually works

- **Behavioral EDR**: doesn't care about signatures. Watches for "powershell.exe spawning rundll32.exe spawning a reverse shell" — pattern is suspicious regardless of which CVE got you there
- **Network anomaly detection**: workstation in accounting suddenly talking to a Ukrainian IP on port 443? Worth a look
- **Endpoint logging + SIEM**: catch the *aftermath* of exploitation — new local admin account, scheduled task added, unusual process tree
- **Threat intelligence feeds**: CISA Known Exploited Vulnerabilities (KEV) catalog tells you which CVEs are being weaponized *right now* and gives federal agencies hard deadlines to patch

### Famous zero-days (know the patterns)

- **Stuxnet (2010)** — four Windows zero-days chained together to attack Iranian centrifuges. Nation-state tier.
- **Heartbleed (2014)** — OpenSSL memory disclosure bug, exposed private keys across half the internet. Library bug, massive blast radius.
- **EternalBlue (2017)** — NSA-developed SMB exploit, leaked, weaponized into WannaCry and NotPetya. Patched in MS17-010 but unpatched systems got destroyed.
- **Log4Shell (2021)** — JNDI injection in Log4j, trivially exploitable, embedded in thousands of Java applications. The "patch everything by Sunday" event of the decade.
- **MOVEit (2023)** — SQL injection zero-day in a file transfer product, used by Cl0p ransomware to hit hundreds of organizations.

The common thread: small bug, huge attack surface, fast weaponization. *The bug doesn't have to be sophisticated. It has to be unpatched and reachable.*

### CompTIA exam traps

> **CompTIA exam trap:** "The patch fixes the zero-day." After the patch ships, it's no longer a zero-day — it's an n-day vulnerability. Unpatched systems are still vulnerable, but the term changes. CompTIA may test this distinction.

> **CompTIA exam trap:** Zero-day vs unpatched system. A *zero-day* has no patch available. An *unpatched system* has a patch available but it hasn't been applied. Different problems, different fixes (you can fix unpatched systems immediately — you can't fix a zero-day until the vendor ships).

> **CompTIA exam trap:** Antivirus stops zero-days. Signature-based AV cannot stop a true zero-day — there's no signature yet. Behavioral/heuristic detection (modern EDR) has a chance. If a question asks what stops zero-days, the answer is layered defense and behavioral detection, not "install antivirus."

## Helpdesk reality

- **"My antivirus is on, why did I get hit?"** — Because antivirus catches known threats. Zero-days are by definition unknown at the time of attack. The fact that AV didn't fire doesn't mean AV is broken; it means the threat was new. Explain it plainly. Don't promise AV will catch everything.
- **The emergency patch email at 7 AM** — When CISA or your vendor drops an "exploited in the wild" advisory, this jumps the ticket queue. Identify affected systems first (inventory), then communicate downtime, then patch. Don't skip inventory — patching what you don't know you have is impossible.
- **"Can you guarantee we won't get breached?"** — No. Anyone who says yes is lying or selling something. Frame the conversation around *reducing risk* and *recovering quickly*, not eliminating risk.
- **The user who refuses to restart for updates** — This is how unpatched-becomes-exploited. Document the refusal, escalate to their manager if needed, and make sure the policy backs you up. Polite persistence, not personal frustration.
- **Don't paste suspicious files into unapproved AI tools.** If a user sends a screenshot of a weird process or popup and you're not sure what it is, use your company-approved tool (Copilot, internal model). Pasting a live malware sample into a consumer chatbot is a data leak.

## Related concepts

[[Phishing]] · [[Supply Chain Attacks]] · [[Patch Management]] · [[EDR and Antivirus]] · [[Incident Response]] · [[Vulnerability Scanning]] · [[Unpatched Systems]] · [[End of Life Systems]] · [[Defense in Depth]]

*Source: VIRGIL knowledge base — 2026-05-11*