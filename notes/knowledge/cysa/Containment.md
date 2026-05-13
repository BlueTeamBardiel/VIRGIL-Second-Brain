# Containment

## What it is

In **Final Fantasy**, when the Four Fiends start corrupting the elemental shrines, you don't try to purge the entire world at once. You travel to the Earth Cave first, fight your way down to Lich, and seal the elemental orb *before* moving to the next shrine. The corruption is still spreading elsewhere — but you've stopped it at the source you can reach, and the rest of the world isn't lost while you handle this one. That's exactly what containment does — you put a fence around the fire before you try to put it out.

**Plain English:** containment is the IR phase where you stop the bleeding. You're not fixing the root cause yet, not rebuilding anything, not even fully sure how bad it is. You're just making sure the compromise doesn't reach systems it hasn't touched yet.

**Technical (CS0-003):** Containment is the second sub-phase of NIST SP 800-61's third lifecycle phase — **Containment, Eradication, and Recovery**. Its goal is to limit scope and impact of a confirmed incident while preserving evidence and maintaining business operations to the degree possible. Containment precedes eradication; you isolate before you clean.

## Why it matters

The wrong containment call costs you the case. Pull the plug too early and you lose volatile memory, active C2 sessions, and any chance of attributing the attacker. Wait too long and you watch the ransomware finish encrypting the file server while you're still drafting the change request. CySA+ Objective 3.2 tests this judgment directly — they want you to know that containment is a decision tree under time pressure, not a script.

In the real SOC, containment is also where the analyst stops being an analyst and starts being an operator. You're not just tagging the ticket — you're disabling accounts, pushing firewall rules, killing switch ports. Every action is logged. Every action is reversible only if you wrote it down.

## Key facts

### The three containment postures

| Posture | What it means | When to use |
|---|---|---|
| **Isolation** | System stays powered, kept on a controlled segment, can still talk to IR tooling | You want live forensics, attacker observation, volatile evidence |
| **Segmentation** | Group of systems moved behind tighter controls (quarantine [[VLAN]], stricter ACLs) | Multi-host compromise, lateral movement suspected, partial containment acceptable |
| **Removal** | System fully disconnected — switch port down, NIC disabled, or physically unplugged | Active exfiltration, uncontrolled malware propagation, ransomware mid-encryption |

**Isolation ≠ removal.** This is the trap CompTIA loves. An isolated host can still send telemetry to your [[EDR]] and your [[SIEM]]. A removed host is dark — you've stopped the attacker, and you've also stopped your visibility.

### Containment techniques by layer

- **Network-based** — firewall rule injection, [[VLAN]] reassignment to quarantine segment, [[ACL]] tightening, [[NAC]] policy change, switch port shutdown, DNS sinkhole for known C2 domains
- **Host-based** — [[EDR]] isolation mode (host can only talk to EDR console), kill malicious processes, suspend the VM (preserves memory state), disable network adapter
- **Account-based** — disable the compromised user, force password reset on related accounts, revoke session tokens, kill active Kerberos tickets, disable service accounts the attacker used
- **Application-level** — take the web app offline, disable the vulnerable feature, push WAF rule to block exploit pattern, rotate API keys

You usually run multiple layers at once. A compromised workstation gets EDR isolation *and* the user account disabled *and* the switch port moved to a quarantine VLAN. Defense in depth applies to containment too.

### Proactive vs reactive segmentation

**Proactive** — designed into the network before incidents happen. Production separated from corporate. OT/ICS on its own air-gapped or DMZ'd segment. Domain controllers in a tier-0 enclave. This is hygiene, not response.

**Reactive** — built during an incident. The classic move is spinning up a **quarantine VLAN**: stripped ACLs, no internet egress except to IR tooling, full packet capture enabled. Compromised hosts get dumped there while the team decides what to do with them. Reactive segmentation is slower, messier, and always reveals the proactive segmentation you should have built last quarter.

### NIST containment strategy criteria

NIST SP 800-61 lists six factors the IR lead weighs before picking a containment strategy:

1. Potential damage to and theft of resources
2. Need for evidence preservation
3. Service availability (customers, employees, business operations)
4. Time and resources required to implement
5. Effectiveness of the strategy (partial vs full containment)
6. Duration of the solution (emergency workaround vs weeks-long fix vs permanent)

*There is no correct answer. There is the answer you can defend in the post-incident review.*

### Containment and evidence preservation

Containment runs **in parallel with evidence acquisition**, not after it. Before you reimage, before you yank the cable, you need:

- **Volatile memory capture** — RAM contents, running processes, network connections, loaded modules. Lost the moment power goes.
- **Disk imaging** — full bit-for-bit copy, hashed (MD5 + SHA-256), pulled through a **write blocker** so the source disk is never modified
- **Log preservation** — pull and hash relevant SIEM, firewall, EDR, AD, and application logs to an immutable store
- **Chain of custody** — every handoff documented: who took it, who received it, when, why, hash before, hash after

**Validating data integrity** means re-hashing the evidence at every handoff and confirming the hash matches. If it doesn't, the evidence is no longer admissible. Mismatched hash = case dies.

**Legal hold** — once IR confirms an incident with potential legal implications (breach, insider threat, regulated data), counsel issues a hold notice. From that moment, normal log retention and destruction policies are suspended for affected systems. Don't rotate logs. Don't reimage prematurely. Don't delete the mailbox of the user under investigation. Spoliation of evidence is a separate legal problem on top of the breach.

### Compensating controls during containment

When you can't fully remediate yet — patch isn't out, vendor hasn't responded, business won't allow downtime — you bolt on **compensating controls** to reduce risk while the system stays exposed:

- WAF rule blocking the exploit signature
- Firewall ACL restricting inbound source IPs to known-good ranges
- Stricter authentication (force MFA re-enrollment)
- Tighter monitoring (custom SIEM correlation rule on the affected asset)
- Network segmentation reducing blast radius

Compensating controls are temporary. They show up in the post-incident report with an expiration date and an owner. *A compensating control with no expiration date becomes permanent technical debt by the next audit cycle.*

### Scope and impact — what the IR lead actually asks

Before signing off on a containment strategy, the IR lead needs two answers:

- **Scope** — how many systems, accounts, network segments, data stores are affected? Has lateral movement happened? Are domain admin credentials in play?
- **Impact** — what's the business consequence of the compromise *and* of the containment action? Taking the e-commerce stack offline to contain a webshell might cost more than the webshell.

These two questions drive whether you do partial containment (isolate one host, keep watching) or full containment (segment the whole VLAN, pull the plug on production).

### CompTIA exam traps

> **CompTIA exam trap:** Containment is **not** the first phase of incident response. The lifecycle is Preparation → Detection and Analysis → **Containment, Eradication, and Recovery** → Post-incident Activity. CompTIA will list containment first and ask if it's correct. It isn't. You detect before you contain.

> **CompTIA exam trap:** Isolation, segmentation, and removal are not synonyms. Isolation keeps the system reachable for analysts. Segmentation moves it to a controlled zone with peers. Removal cuts it off entirely. If the question mentions "preserving volatile evidence," the answer is isolation — never removal.

> **CompTIA exam trap:** Re-imaging is **eradication**, not containment. Containment limits spread; eradication removes the threat. If the answer choices include "re-image the host" as a containment action, it's wrong — that's the next phase.

> **CompTIA exam trap:** Legal hold suspends normal data destruction policies. If a question says logs were rotated after an incident was declared, the violation is failure to honor legal hold — even if no court order existed yet. Internal counsel's hold notice is enough.

> **CompTIA exam trap:** Chain of custody breaks the *first* time a transfer goes undocumented, not after multiple gaps. One missing signature can disqualify the evidence.

## SOC reality

- At 2:47am the [[EDR]] fires a high-severity alert: PowerShell spawning from Outlook on a finance workstation, beaconing to a domain registered four hours ago. L1 acknowledges, pulls the host into EDR isolation mode in under three minutes — the host can still talk to the EDR console, nothing else. That's containment, posture one.
- The IR lead's first question on the bridge is never "what's the malware?" It's "**scope and impact** — how many hosts, what accounts, is AD touched, what data is at risk?" If you can't answer scope in fifteen minutes, you don't have detection coverage, you have hope.
- Never tell the CISO "we've contained it" until evidence is preserved, lateral movement is ruled out, and compensating controls are in place. "Contained" is a legal-weight word. *Say "isolated" until you can prove containment in writing.*
- The fight between IR and the business owner is real. IR wants the server down. The business owner wants Q4 revenue. The compensating-control conversation is where containment strategy gets negotiated in real time — and the IR lead has to be ready to lose that argument and document the residual risk.
- Handoff: L1 isolates and triages → L2 confirms scope and pulls volatile evidence → IR team owns containment strategy and legal hold → counsel and executives get briefed once scope and impact are quantified, not before.

## Related concepts

[[Incident Response Lifecycle]] · [[Detection and Analysis]] · [[Eradication]] · [[Recovery]] · [[Chain of Custody]] · [[Evidence Acquisition]] · [[Legal Hold]] · [[Compensating Controls]] · [[VLAN]] · [[EDR]] · [[SIEM]] · [[NAC]] · [[Volatile Memory]] · [[Write Blocker]] · [[NIST SP 800-61]]

*Source: VIRGIL knowledge base — 2026-05-11*