# Insider Threats

## What it is

The guy with the keycard *is* the threat. Not the script kiddie on the other side of the firewall — the contractor you onboarded six weeks ago, the sysadmin who got passed over for promotion, the salesperson who's been talking to a recruiter at a competitor and is about to walk out with the client list.

In plain English: an insider threat is anyone with legitimate access — employees, contractors, vendors, interns — who uses that access to harm the organization. The harm can be deliberate (data theft, sabotage, fraud) or accidental (clicking the phish, emailing the spreadsheet to the wrong "John," leaving the laptop on the train).

Technically: insider threats are a vulnerability category in CompTIA's social engineering domain because the human is the attack surface. Every other control — firewalls, EDR, conditional access, MFA — assumes the threat is outside. Insider threats invert that assumption. The credentials are valid. The access is logged as "normal." The exfiltration looks like a backup job.

The immune system metaphor matters here: insider threats are an autoimmune disease. The body's own defenses can't tell self from non-self, because the threat *is* self.

## Why it matters

CompTIA tests this under **220-1202 Objective 2.5** alongside social engineering, because most insider incidents are either (a) a careless insider falling for a phish, or (b) a malicious insider using social engineering on coworkers to expand access. The two categories blur.

Career-wise: as a helpdesk tech you will witness more insider incidents than external breaches. The user who shoulder-surfed the manager's password. The intern who copied the customer database to a personal Google Drive "to work from home." The terminated employee whose account didn't get disabled fast enough. You will be the first person to notice. Your ticket notes become the evidence.

Real stakes: the Verizon DBIR consistently shows roughly a third of breaches involve internal actors. Insider incidents take longer to detect than external ones (the access looks legitimate) and cost more to remediate (legal, HR, forensics, regulatory notification).

## In your build, in the enterprise

### Beat 1 — Technical depth

Three flavors:

- **Malicious insider** — deliberately steals, sabotages, or sells. Departing employee grabbing customer lists. Sysadmin planting a logic bomb. Contractor selling credentials.
- **Negligent insider** — well-intentioned but careless. Clicks phishing links, reuses passwords, emails sensitive data to personal accounts to work from home, leaves laptops unlocked.
- **Compromised insider** — legitimate user whose credentials got phished or whose endpoint got popped. The attacker is external; the access looks internal. This is the bridge between insider and external threats.

Detection signals: data access outside normal hours, large outbound transfers to personal cloud storage, USB mass-storage events, access to systems outside the user's role, repeated failed logins to systems they don't normally touch, sudden interest in admin documentation, badge access at weird hours. UEBA (user and entity behavior analytics) tools score this. SIEMs alert on it. DLP (data loss prevention) blocks the exfil mid-flight.

### Beat 2 — Feynman example: your homelab and the trusted roommate

You build a homelab. Proxmox host, Plex on a VM, Pi-hole on another, a Windows VM for the games that hate Linux. Your roommate uses your Plex. You gave them the password. They're trusted.

**The malicious version:** Roommate moves out, you forget to rotate the password, they keep streaming for eight months and rack up a copyright strike on your IP. They had legitimate access. You never revoked it. *Offboarding is a security control, not a courtesy.*

**The negligent version:** Roommate writes the Plex password on a sticky note and posts a screenshot of their desk to Instagram. Now strangers are hammering your `*.duckdns.org` endpoint. They didn't mean harm. The harm happened anyway. *Most insider damage is stupidity, not malice.*

**The compromised version:** Roommate's laptop gets infotealer malware. The Plex cookie gets lifted. An attacker uses it to map your internal network, finds your Proxmox web UI on the same VLAN (because you got lazy about segmentation), and now they're poking at your hypervisor. From your logs, it looks like roommate's normal session. *The credential is valid. The user behind it isn't.*

**The kicker:** You can't fix any of this with a better firewall. The firewall is doing its job — it's letting authorized traffic through. The fix is process: rotate credentials when relationships change, segment trust levels, monitor for behavior that doesn't match the user.

### Beat 3 — Bridge to the enterprise

Same scenario, scaled up. Replace "roommate" with "departing employee," "Plex password" with "Salesforce credentials and a synced OneDrive folder," and "copyright strike" with "competitor onboards her with your pipeline data."

In the enterprise, the equivalent of "forgot to change the Plex password" is **failing to disable accounts at termination.** HR fires someone at 2 PM. IT doesn't get the ticket until 5 PM. Between 2 and 5, the ex-employee downloaded the customer database to a personal Dropbox, forwarded six months of email to their Gmail, and deleted their browser history. Every action was performed with valid credentials, against systems they had legitimate access to that morning.

The fix is the same as your homelab, just formalized: **a joiner-mover-leaver process.** When someone joins, access is provisioned to role. When someone changes roles, old access is revoked (not just stacked on top — this is how 15-year employees end up with access to every system in the building). When someone leaves, accounts are disabled the moment HR says "fire them," not after the exit interview.

### Beat 4 — The point

Same fundamental question across every scale: **who has access to what, why, and what happens when that "why" stops being true?** At home you trust your roommate. In a 50-person company you trust the sales team with the CRM. In a Fortune 500 you trust 80,000 people with a constellation of systems. The question doesn't change. The blast radius does.

Get this into your bones: every access decision has a half-life. The grant was correct on the day it was made. Eight months later, maybe not. Insider threat programs are the discipline of asking that question over and over, at scale.

## Key facts

### Insider threat types (memorize the three)

| Type | Intent | Example | Primary control |
|---|---|---|---|
| **Malicious** | Deliberate harm | Data theft on departure, sabotage, fraud | Least privilege, DLP, monitoring, fast offboarding |
| **Negligent** | No harmful intent | Phishing victim, lost laptop, wrong-recipient email | Training, MFA, encryption, DLP |
| **Compromised** | None — they're the victim | Credentials phished, endpoint owned | EDR, MFA, conditional access, UEBA |

### Indicators of malicious insider activity

- Access to systems or data outside normal job function
- Activity at unusual hours (3 AM data pulls from sales accounts)
- Large outbound transfers — personal email, cloud storage, USB
- Sudden interest in security controls, logging, or admin tools
- Disgruntlement: passed-over promotion, written warning, public complaints
- Resignation announced but access still wide open
- Badge access to floors or rooms outside their normal pattern
- Disabling endpoint agents, clearing logs, using personal devices on the network

### Controls that actually work

- **Least privilege** — users get only what their role requires. Audit quarterly.
- **Separation of duties** — no single user can both initiate and approve a transaction.
- **Mandatory vacations / job rotation** — fraud schemes break when the perpetrator is forced offline.
- **Joiner-mover-leaver process** — automated, tied to HR systems, not email tickets.
- **DLP** — blocks or alerts on sensitive data leaving via email, web upload, USB.
- **UEBA** — flags behavioral anomalies. Not perfect, but it's how you catch the slow-burn data theft.
- **MFA everywhere** — kills the compromised-insider scenario in most cases.
- **Privileged access management (PAM)** — admin credentials checked out per-session, recorded, rotated.
- **Background checks** — pre-employment screening for sensitive roles.
- **Security awareness training** — addresses the negligent insider, who is statistically your biggest problem.

### At home vs. in the enterprise

| | Home / homelab | Enterprise |
|---|---|---|
| **Access grant** | Verbally tell roommate the Wi-Fi password | Ticketed request, manager approval, role-based provisioning |
| **Offboarding** | "Hey can you forget my Netflix password" | Automated disable at HR termination event, key/badge recovery, exit interview |
| **Monitoring** | None | SIEM, UEBA, DLP, EDR, badge logs |
| **Audit** | You never check | Quarterly access reviews, SOX/HIPAA audits, pen tests |
| **Blast radius** | Your streaming bill | Regulatory fines, lawsuits, breach notification, stock price |

The home version is informal and that's fine — the stakes are low. The enterprise version is formal because the stakes are existential. You are studying A+ to work in the formal version.

### CompTIA exam traps

> **CompTIA exam trap:** Insider threat vs. social engineering — they overlap but aren't the same. Social engineering is a *technique* (manipulation). Insider threat is an *actor category* (someone with legitimate access). A phishing email targeting an employee is social engineering. The employee falling for it and becoming the vector is the insider threat outcome.

> **CompTIA exam trap:** Tailgating, shoulder surfing, dumpster diving — these are external attackers exploiting *physical* weaknesses to *become* insiders or steal what insiders have. They're listed alongside insider threats because the outcome is the same: an outsider gains insider-level access. Tailgating through the badge door at lunch turns an outsider into a temporary insider.

> **CompTIA exam trap:** The strongest control against malicious insiders on the exam is almost always **least privilege** or **separation of duties** — not "antivirus" or "firewall." Insider threats bypass perimeter controls by definition.

## Helpdesk reality

- **"I need access to the shared drive Karen had — I'm covering her role while she's out."** Don't grant it on your authority. Send to her manager for approval. Document. This is how role creep starts.
- **"Can you reset my coworker's password? They asked me to call for them, they're in a meeting."** Never. The person calling is the person who needs to be authenticated. This is the social engineering call you will get, and it will sound completely plausible.
- **A terminated employee's ticket lands in your queue at 4:55 PM Friday: "disable immediately, security incident."** Drop everything. Disable account, revoke tokens, kill active sessions, force MFA re-enrollment on any shared resources. This is the highest-priority ticket type in the queue. Document timestamps to the minute.
- **You notice a user pulling huge volumes from SharePoint at 11 PM on a Saturday.** Don't message them. Don't accuse. Escalate to your security team or manager. Insider investigations are HR and legal territory — your job is to flag, not to interrogate.
- **Never promise an investigation is confidential.** You don't know who needs to know. "I'll get this to the right team" is the honest answer.

## Related concepts

[[Phishing]] · [[Social Engineering]] · [[Tailgating]] · [[Shoulder Surfing]] · [[Dumpster Diving]] · [[Impersonation]] · [[Least Privilege]] · [[Separation of Duties]] · [[Data Loss Prevention DLP]] · [[Offboarding]] · [[MFA]] · [[BYOD]] · [[Privileged Access Management]]

*Source: VIRGIL knowledge base — 2026-05-11*