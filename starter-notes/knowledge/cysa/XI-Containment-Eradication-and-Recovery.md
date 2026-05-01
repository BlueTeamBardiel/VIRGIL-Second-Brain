---
tags: [knowledge, cysa, security-analyst]
created: 2026-04-30
cert: CySA+
source: rewritten
---

# XI. Containment, Eradication, and Recovery

**The three-phase battle plan for stopping attackers, cleaning up their mess, and getting back to business safely.**

---

## Overview

Once you've confirmed an incident is real, you shift from detective mode to action mode—this is where containment, eradication, and recovery come in. A security analyst must master this phase because the decisions you make here directly determine whether the organization loses $10,000 or $10 million, whether evidence holds up in court, and whether the attacker comes back next month. This section aligns with [[NIST SP 800-61]] frameworks and reflects real-world tradeoffs between stopping damage, preserving evidence, and keeping the business running.

---

## Key Concepts

### Containment Strategy

**Analogy**: Containment is like creating a quarantine zone around a patient with an infectious disease—you're not curing them yet, just making sure they don't infect the whole hospital while you figure out what's wrong.

**Definition**: The immediate action phase where you limit the scope and impact of an active incident by isolating affected systems, blocking attack vectors, and preventing lateral movement—all while keeping evidence intact and business operations somewhat functional.

**Core Principle**: You must constantly balance three competing needs:
- **Security** (stop the spread)
- **Business continuity** (keep systems running)
- **Evidence preservation** (keep it forensically clean)

There is no universally "right" containment choice—only the best judgment call for your specific situation.

| Containment Method | Speed | Evidence Impact | Business Impact | When to Use |
|---|---|---|---|---|
| [[Network Segmentation]] | Fast | Minimal | Low-Medium | Lateral movement risk |
| [[Isolation (VLAN Quarantine)]] | Fast | Minimal | Medium | Suspected compromise |
| [[Disconnection/Removal]] | Immediate | Highest | High | Active exfiltration |
| Firewall Rules | Very Fast | Minimal | Low | Block specific traffic |

---

### Network Segmentation (Proactive vs. Reactive)

**Analogy**: Think of network segmentation like separating your kitchen from your living room with a door and lock. Before a fire (proactive), the door protects your living room stuff. During a fire (reactive), you can slam it shut and add extra bolts.

**Definition**: The practice of dividing your network into controlled zones or subnets to limit where an attacker can move if they breach one system.

**Proactive Segmentation** — Built before incidents happen
- [[VLANs]], [[Firewalls]], [[Access Control Lists (ACLs)]]
- Enforces the principle of least privilege at the network level
- Slows attackers down even if they get in

**Reactive Segmentation** — Created during active incidents
- **Quarantine VLAN**: Compromised systems moved to isolated network zone
- Allows monitoring and analysis without infecting clean systems
- Buys time for evidence collection and forensics

---

### Isolation vs. Disconnection

**Analogy**: Isolation is like putting a suspect in a holding cell where you can still watch them through a camera and talk to them. Disconnection is dragging them out of the building entirely.

**Definition**: 
- **Isolation**: Logically restricting a system's network access while keeping it powered and observable
- **Disconnection**: Completely removing a system from the network (physical unplugging or firewall blackhole)

| Aspect | Isolation | Disconnection |
|---|---|---|
| Attacker visibility | Can still see/monitor | Blind them immediately |
| Live analysis possible | Yes | No |
| Evidence preservation | Good | Excellent |
| Business impact | Medium | High |
| Risk of persistence | Higher | Lower |

**Critical tradeoff**: Over-isolation can destroy [[volatile evidence]] (RAM, active network connections) and may alert the attacker that you've detected them.

---

### Root Cause Analysis (RCA)

**Analogy**: RCA is like investigating why a car crashed—not just who was driving it, but whether the brakes failed, the road was icy, or the driver was texting. You need to find the *why*, not just the *who*.

**Definition**: The systematic investigation to identify the underlying reason(s) an incident occurred, focusing on control failures and weaknesses that enabled the attack.

**Why this matters for eradication**: You can't truly fix a breach until you understand how the attacker got in. Otherwise, you're just cleaning up while leaving the front door unlocked.

**RCA vs. Attacker Attribution**
- RCA = Why did our controls fail?
- Attribution = Who is this person/group?
- RCA is operationally critical; attribution is optional (and often a management/law enforcement decision)

---

### Eradication

**Analogy**: If containment is putting out the fire, eradication is removing every smoldering ember, burnt material, and smell—ensuring the fire can't restart.

**Definition**: The systematic removal of all traces of attacker activity: malware, backdoors, persistence mechanisms, compromised credentials, and any other artifacts that could allow the attacker to return.

**Key principle**: [[Assume Breach]]—treat every compromised system as completely untrustworthy.

**Common eradication artifacts targeted**:
- Malware and rootkits
- [[Backdoors]] and [[Webshells]]
- Stolen or changed credentials
- Suspicious scheduled tasks or services
- Unauthorized user accounts
- Modified system files or configurations

---

### Remediation and Reimaging

**Analogy**: Cleaning a compromised system by removing malware is like trying to get rid of bed bugs by vacuuming—you might get most of them, but there could be eggs hidden somewhere you can't see.

**Definition**: The process of repairing systems after an incident, with the safest approach being complete rebuilding from a known-good baseline rather than attempting surgical malware removal.

**Rebuild vs. Repair**:
- **Rebuild (preferred)**: Wipe system → restore from clean backup → re-harden
- **Repair (risky)**: Scan and remove malware → hope nothing was missed

**Secure reimaging checklist**:
- Verify backup image is from *before* the compromise
- Confirm root cause is fixed (or attacker will re-compromise)
- Apply all [[Patches and Updates]]
- Re-harden with [[Security Baselines]]
- Reset all credentials associated with system
- Test thoroughly before returning to production

---

### Recovery

**Analogy**: Recovery is the slow process of letting the patient out of the hospital—first to a recovery ward, then home, then back to their normal life, with follow-up checkups to make sure they don't relapse.

**Definition**: The phased process of returning systems and services to normal operations in a controlled manner, with validation that they're truly clean and resilient.

**Recovery phases**:
1. **Staged restoration**: Bring systems back online in planned order (not all at once)
2. **Validation**: Test functionality, performance, and security
3. **Full restoration**: Return to production
4. **Monitoring intensification**: Watch for signs of re-compromise or hidden persistence

---

### Evidence Handling and Chain of Custody

**Analogy**: Chain of custody is like a hospital patient's medical record—every medication, every test, every person who touched it is logged. If a nurse forgets to sign the log, a lawyer can throw out the whole record in court.

**Definition**: The documented record of who handled evidence, when, where, how, and why—critical for ensuring evidence remains admissible in legal proceedings and legally defensible.

**What must be documented**:
- Identity of collector and custodian
- Date, time, and location of collection
- Description of evidence collected
- Storage location and conditions
- Every person who accessed it and when
- Any analysis or testing performed

**Why this matters during response**:
- [[Volatile evidence]] (RAM, network traffic, running processes) disappears over time
- Must be collected *during* or immediately after containment
- Improper handling can make evidence inadmissible in court
- Chain of custody failures undermine the entire investigation

**Common volatile artifacts**:
- System memory (RAM)
- Running processes and open network connections
- System cache
- Temporary files

---

### Compensating Controls

**Analogy**: Compensating controls are like putting a bandage on a wound while you wait for the doctor to arrive. It's not the cure, but it prevents things from getting worse.

**Definition**: Temporary security measures implemented when permanent fixes can't be deployed immediately, designed to reduce risk until proper remediation is complete.

**Examples in practice**:
- Block port 445 at firewall while waiting for patch deployment
- Increase logging on suspected systems while forensics are running
- Require additional authentication for sensitive systems
- Disable remote access until monitoring infrastructure is in place

**Critical detail**: Compensating controls must be **temporary** and **revisited**—they're not permanent solutions. Set a deadline to replace them with proper fixes.

---

## Analyst Relevance

**Real SOC scenario**: It's 2 AM, and your SIEM alerts on lateral movement from a compromised workstation toward your database server. You have about 5 minutes to decide: Do you:

A) **Immediately disconnect** the workstation (fast, stops spread, but destroys live evidence)?  
B) **Move it to quarantine VLAN** (slower, keeps evidence, but attacker might see you and accelerate exfiltration)?  
C) **Just monitor and wait** for forensics (risky—lateral movement is active)?

Your answer depends on what you know in those 5 minutes. Is data actively being exfiltrated? Is the database backup recent? Do you have law enforcement involved? Is this a critical system?

The analyst who has containment strategy in their head makes better decisions under pressure. You're not following a flowchart; you're making a risk-based judgment call that affects the company's bottom line.

---

## Exam Tips

### Question Type 1: Containment Strategy Selection

- *"A critical database server shows signs of compromise. Live data exfiltration to an external IP has been detected. What is the most appropriate immediate containment action?"*
  → **Disconnect the system** (or block at firewall with extreme urgency). Active exfiltration means the attacker is *stealing data right now*—business impact of stopping them exceeds evidence preservation concerns.
  
- **Trick**: Answers mentioning "isolate for monitoring" or "investigate first" will seem logical but miss the urgency of active exfiltration. When data is *leaving your network*, containment speed beats evidence preservation.

- *"An analyst has isolated a compromised system to a quarantine VLAN but can still ping it and monitor processes. What is the primary benefit of this approach vs. disconnection?"*
  → **Enables live forensics and attacker behavior analysis while preventing lateral movement**. You've contained the threat without destroying volatile evidence.

---

### Question Type 2: Root Cause vs. Attribution

- *"During eradication, the analyst focuses on determining which nation-state conducted the attack. Is this appropriate?"*
  → **No—this is attribution, not eradication.** Eradication focuses on *why* controls failed and *how* to remove attacker artifacts. Attribution is a separate investigation, often handled by law enforcement or threat intelligence, and can distract from core recovery.

- **Trick**: Exam may present attribution questions framed as "root cause." Real root cause asks "How did they bypass multi-factor authentication?" not "Who is this attacker?"

---

### Question Type 3: Evidence Handling

- *"A forensic analyst collects memory from a compromised system but fails to document the chain of custody. What is the consequence?"*
  → **Evidence becomes inadmissible in court.** Even technically perfect forensics mean nothing if you can't prove who handled it, when, and why.

- **Trick**: The exam may ask what technical forensics should have been done. Correct answer focuses on *process* (documentation) not just *tools* (memory dump, disk image, etc.).

---

### Question Type 4: Rebuild vs. Repair

- *"An organization chooses to surgically remove malware from a compromised workstation rather than rebuild the image. Which risk is greatest?"*
  → **Hidden persistence mechanisms may remain**, allowing re-compromise. Rootkits and advanced malware hide in places that antivirus scans miss.

- **Trick**: "Save time" and "cost efficiency" will be distractor answers. Exam emphasizes that in incident response, **rebuilding from known-good backup is best practice** even if it takes longer.

---

## Common Mistakes

### Mistake 1: Treating