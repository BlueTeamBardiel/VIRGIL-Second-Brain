# Business Email Compromise

## What it is

The CFO emails accounting at 4:47 PM on a Friday: "I'm boarding a flight, need you to wire $84,000 to this vendor before EOD, here's the routing info, don't loop legal in — time-sensitive." The email looks normal. The signature block matches. The writing style matches. Accounting wires the money. Monday morning the real CFO has no idea what they're talking about.

That's **Business Email Compromise** — BEC. A targeted social engineering attack where the attacker either spoofs or actually takes over a legitimate business email account (executive, vendor, HR, finance) and uses the trust attached to that identity to trick someone into wiring money, sending W-2s, or changing direct-deposit routing.

Technically: BEC is a subcategory of spear phishing that targets the business process rather than the technology. No malware required. No exploit chain. The vulnerability is the chain of command and the human at the keyboard.

The FBI's Internet Crime Complaint Center logs BEC as the single most expensive cybercrime by dollar loss — billions annually. Ransomware gets the headlines; BEC gets the money.

## Why it matters

CompTIA 220-1202 Objective 2.5 lumps BEC in with phishing, vishing, smishing, whaling, and spear phishing — all variants of the same root attack pattern: **abuse trust, bypass technology, get the human to do the thing**. The exam will hand you a scenario ("the CEO emails accounting requesting an urgent wire transfer") and expect you to name it correctly. BEC, whaling, and spear phishing overlap heavily, and the distinctions matter for the exam.

Career-wise: as a helpdesk tech, you are the early-warning system. Users will forward you weird emails asking "is this real?" Your answer determines whether the company loses $84,000. You also handle the aftermath — the compromised mailbox, the forwarding rule the attacker set, the MFA reset, the password reset, the conversation with the user about why their account got popped in the first place.

## At home, at work

**Beat 1 — the anatomy.** BEC has five flavors CompTIA cares about: **CEO fraud** (impersonating an executive to pressure a subordinate), **invoice fraud** (impersonating a known vendor to redirect payment to attacker-controlled accounts), **account compromise** (the attacker actually owns a legitimate mailbox — no spoofing, real account), **attorney impersonation** (fake legal pressure, "confidential acquisition"), and **W-2/data theft** (HR gets an email "from the CEO" asking for all employee W-2s for tax season).

The technical mechanisms behind the email itself: **display-name spoofing** (From shows "Jane CEO" but the actual address is `jane.ceo@gmaiI.com` with a capital I), **lookalike domains** (`company-corp.com` vs the real `companycorp.com`), **reply-to manipulation** (From shows the real exec, Reply-To routes to the attacker), and **full account takeover** (credential phishing → MFA bypass → attacker logs into the real mailbox, sets a hidden forwarding rule, watches conversations for weeks, strikes during a real invoice cycle). The last one is the worst because **every email genuinely comes from the real account.** SPF, DKIM, and DMARC all pass. The headers are clean. Nothing to detect at the protocol layer.

**Beat 2 — the homelab scenario.** You run a small Discord-organized LAN gaming group. Twelve regulars, a shared Google Workspace for tournament scheduling, a Stripe account for prize pool donations.

**The setup:** One of your regulars reuses passwords. They got popped in a credential dump two years ago. Their Workspace password is the same one from that dump. Attacker logs in, sees the group's prize-pool flow, sets up a forwarding rule that quietly sends a copy of every inbound email to a Proton address, and waits.

**The strike:** Tournament weekend. Donations are flowing. Attacker emails the treasurer from the compromised account: *"Hey, Stripe is being weird with payouts, can you Venmo this weekend's pool to @notarealhandle and I'll reconcile Monday?"* Tone matches. Timing matches the real cadence of the group. Treasurer Venmos $1,400. Gone.

*The vulnerability wasn't your network. It was a reused password from 2024 and a forwarding rule nobody audits.*

**The detection moment:** Monday, the real account holder mentions they never sent that email. You pull the audit log, find the forwarding rule, find the foreign-country login from a residential VPN exit. *By the time you find the trail, the money has been through three mules and a crypto exchange.*

**The fix:** MFA on every account, mandatory. Audit forwarding rules quarterly. Out-of-band verification for any payment change — *call the person on a known number, don't reply to the email.*

**Beat 3 — bridge from gaming group to enterprise.** Same attack, different zeros. The LAN group lost $1,400 because one person reused a password and nobody audited forwarding rules. An enterprise loses $840,000 the same way: vendor email gets compromised, attacker watches the invoice cycle for six weeks, learns the format, learns the contact names, then sends a perfectly-formatted invoice with new banking details two days before the real invoice arrives. Accounts payable pays it. The real vendor calls three weeks later asking where their money is.

The controls scale up but the principle is identical: **MFA everywhere, audit forwarding/delegation rules, out-of-band verification for financial changes, train users to recognize urgency + secrecy + unusual channel as the attack signature.**

**Beat 4 — the point.** BEC is not a technology problem with a technology answer. SPF, DKIM, and DMARC stop spoofing but not account takeover. Email filters stop bulk phishing but not a single targeted message from a legitimate compromised account. The defense is **process discipline**: callback verification, segregation of duties on payment changes, and user training that treats urgency as the suspicious signal — not the legitimizing one. *Real executives understand process. Attackers need you to skip it.*

## Key facts

### BEC variants CompTIA expects you to name

| Variant | Who's impersonated | Target | Goal |
|---|---|---|---|
| CEO fraud / whaling | Executive (CEO, CFO) | Subordinate with authority | Wire transfer |
| Invoice fraud | Known vendor | Accounts payable | Redirect payment to attacker account |
| Account compromise | Nobody — real account | Anyone in the email chain | Varies; usually financial |
| Attorney impersonation | Outside counsel | Executive or finance | Urgent confidential payment |
| W-2 / data theft | Executive | HR or payroll | Bulk employee tax data |

### BEC vs. its cousins (exam-critical distinctions)

| Attack | What it is |
|---|---|
| **Phishing** | Bulk, untargeted, "Dear Customer" — net cast wide |
| **Spear phishing** | Targeted at a specific person or small group, personalized |
| **Whaling** | Spear phishing aimed at a high-value target (C-suite) |
| **BEC** | Spear phishing/whaling aimed at a business process, usually financial, often using a compromised or spoofed business account |
| **Vishing** | Voice phishing — phone call, often paired with BEC ("I just emailed you, did you get it?") |
| **Smishing** | SMS phishing — text message |
| **Pretexting** | The fabricated story underlying any of the above |

### CompTIA exam traps

> **CompTIA exam trap:** BEC vs. whaling. Whaling is defined by the *target* (a whale — senior executive). BEC is defined by the *method and goal* (compromise a business email account or impersonate one, to manipulate a business process). They overlap constantly. If the scenario says "the CEO is the target of the phishing email" → whaling. If the scenario says "the CEO's account is being used to phish accounting" → BEC. Read who is being attacked vs. who is being impersonated.

> **CompTIA exam trap:** BEC vs. spear phishing. All BEC is spear phishing; not all spear phishing is BEC. If the scenario specifically mentions wire transfer, invoice redirection, payroll change, or W-2 request → answer BEC. If it's targeted credential theft against a specific user → spear phishing.

> **CompTIA exam trap:** BEC does not require malware. CompTIA loves to test this. If the scenario says "no malicious attachments, no links, just a convincing email asking for a wire transfer" — that's still an attack, and the answer is BEC. The lack of technical payload is the point.

### Indicators a user should report

- Urgency + secrecy combined ("don't loop in legal, I need this before close")
- Unusual channel for a normal request (CEO emailing accounting directly instead of through the CFO)
- Last-minute change to known payment details
- Sender's display name matches a known person but the email address is off by one character
- Reply-To address differs from the From address
- Email sent at an unusual hour for the supposed sender
- Slight tonal drift — phrases the real person wouldn't use, or excessive politeness from someone normally terse

### Controls — consumer vs enterprise

**At home / small group:**
- MFA on every email account (Google, Microsoft, Proton — whatever)
- Unique passwords via a password manager
- Audit forwarding rules in Gmail/Outlook quarterly — `Settings → Forwarding and POP/IMAP`
- Verify payment changes on a known phone number, not via email reply
- Use Venmo/Zelle confirmation prompts as a forced "stop and think" moment

**In the enterprise:**
- **SPF, DKIM, DMARC** — block external spoofing of your domain (DMARC with `p=reject` is the goal)
- **External-sender banners** — every email from outside the org tagged visually
- **Lookalike-domain monitoring** — services that register and alert on typosquats of your domain
- **MFA on all mailboxes, phishing-resistant (FIDO2 / hardware tokens) for executives and finance**
- **Conditional access** — block legacy auth, geofence logins, require compliant device
- **Mailbox audit logging** — detect new forwarding rules, new delegations, foreign logins
- **Segregation of duties** — no single person can both initiate and approve a wire transfer
- **Callback verification policy** — any payment change requires a phone call to a number on file (not a number provided in the email)
- **User training** — recurring, scenario-based, with simulated BEC campaigns
- **EDR + mailbox forensics** — for the post-incident "how long were they in, what did they see, what rules did they set"

## Helpdesk reality

- **"Is this email real?"** — your most common BEC-adjacent ticket. Check the full From header (not just display name), check Reply-To, check the domain character-by-character, hover links without clicking. If anything is off, treat as malicious, report through the phish-report button, escalate to security.
- **"I think I clicked something / replied to something."** — immediate response: reset password, force sign-out of all sessions, revoke active tokens, check for new forwarding/delegation rules, check sent items for messages the user didn't send, enable or re-enroll MFA. Then notify security. Speed matters — attackers move within hours.
- **"Finance got an email from the CEO asking for a wire transfer."** — stop the wire. Call the CEO on a known number. Do not reply to the email. Do not call any number in the email. This is the scenario where being wrong costs the company a year of someone's salary.
- **Never promise email filters catch everything.** They catch bulk phishing well. They catch targeted BEC poorly. The legitimate-compromised-account version is undetectable at the email layer — the headers are clean.
- **Document the incident even if nothing was lost.** Near-misses are the data security uses to tune training and controls. The ticket where accounting almost wired $84k but called the CFO first is more valuable than the ticket where nothing happened at all.

## Related concepts

[[Phishing]] · [[Spear Phishing]] · [[Whaling]] · [[Vishing]] · [[Smishing]] · [[Impersonation]] · [[Spoofing]] · [[Multi-Factor Authentication]] · [[SPF DKIM DMARC]] · [[Insider Threat]] · [[Social Engineering Fundamentals]] · [[Incident Response]]

*Source: VIRGIL knowledge base — 2026-05-11*