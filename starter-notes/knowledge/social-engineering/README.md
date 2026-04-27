# Social Engineering — The Attack That Bypasses Every Technical Control
> The help desk is the most targeted attack surface in any organization.

You can have perfect patching, EDR on every endpoint, and MFA everywhere — and still get breached by someone who called the help desk and asked nicely. Social engineering exploits human psychology, not software. It bypasses every technical control because it operates through authorized users doing authorized things. Understanding it is non-negotiable for anyone who answers a phone or resets a password.

---

## Why Help Desk is Targeted

Help desk has the authority to do exactly what attackers need:
- Reset passwords (including for accounts they've locked themselves out of during an attack)
- Unlock accounts (they lock them with failed attempts, then call you to unlock)
- Grant temporary access ("just for today while IT fixes my account")
- Bypass security policies ("my manager approved it, he's unavailable to confirm")
- Add devices ("I got a new laptop, can you set it up?")

Every one of these capabilities is a potential attack vector. The attacker's goal is to find the path of least resistance — and in most organizations, that path goes through a tired help desk technician at the end of a long shift.

---

## Attack Types

### Phishing (Email)
Mass-scale email attack attempting to get credentials, malware downloads, or financial transactions.

**Standard phishing:** Bulk email impersonating banks, Microsoft, payroll services. Millions sent, low success rate per email, devastating at scale.

**Spear phishing:** Targeted email using personalized details — name, role, recent project, colleague's name. Much higher success rate. Requires [[OSINT]] reconnaissance first.

**Whaling:** Spear phishing targeting executives (CFO, CEO). Often combined with BEC (Business Email Compromise) — impersonate the CFO to trick finance into wiring money.

**Clone phishing:** Take a legitimate email the target previously received, replace the link or attachment with a malicious version, resend from a spoofed address. The target recognizes the real email — that's the whole point.

**Indicators in email:**
- Sender domain doesn't match display name: `"Microsoft Support" <support@microsofft-help.com>`
- Generic greeting ("Dear Customer") for a personalized service
- Urgency: "Your account will be suspended in 24 hours"
- Mismatched URLs: hover shows different domain than displayed text
- Unexpected attachments, especially password-protected ones
- Requests to enable macros or click "Enable Content"

---

### Vishing (Phone)
Voice phishing. The attacker calls and impersonates someone with authority or a service provider.

**IT impersonation:** "Hi, this is Alex from the IT security team. We've detected suspicious activity on your account and need to verify your credentials to protect you."

**Vendor impersonation:** "I'm calling from Microsoft Premier Support regarding the security alert we sent last week..."

**Authority pressure:** Use of executive names, urgency, implied consequences for non-compliance. "The CEO needs this done now, his board presentation is in 20 minutes."

**What makes vishing work:**
- Phone calls feel more real than emails
- Social proof: "I already talked to your manager Dave"
- Time pressure: rushed employees make worse decisions
- Caller ID spoofing: can appear to be calling from an internal extension or known number

---

### Smishing (SMS)
Text message phishing. Common vectors: fake package tracking, bank alerts, "verify your account."

Limited use for corporate targeting but increasingly common for initial credential theft that enables subsequent attacks.

---

### Pretexting
Creating a fabricated scenario to extract information or gain access. The "pretext" is the backstory the attacker uses. Every vishing attack involves pretexting.

**Examples:**
- Impersonating a new employee who needs access set up
- Impersonating an auditor who needs to review systems
- Impersonating a vendor doing scheduled maintenance
- Impersonating a senior executive (works best via email, builds authority)

Good pretexts are built from [[OSINT]] — real names of employees, real projects, real vendors gleaned from LinkedIn, company websites, and job postings.

---

### Baiting
Offering something desirable as the vector.

**Physical:** USB drive labeled "Payroll Q4 2025" left in a parking lot or lobby. Curious employees plug it in. Drives can auto-execute malware or capture credentials.

**Digital:** Free software download that bundles malware. "Pirated" software especially.

---

### Tailgating / Piggybacking
Physical security breach — following an authorized person into a restricted area. "Piggybacking" = the authorized person knows and consents. "Tailgating" = they don't.

Defenses: badge-access single-person turnstiles (mantrap), visitor escorts, challenge culture ("excuse me, do you have a badge?").

---

## Real Attack Scenarios

### Scenario 1: The Traveling Executive
**The call:** "Hi, this is [CFO name] — I'm at the airport and my phone died, I had to borrow someone's phone. I'm locked out of my email and I have an urgent board communication that needs to go out in the next 20 minutes. Can you reset my password right now?"

**Why it works:**
- Uses a real name (from LinkedIn or company website)
- Urgency removes thinking time
- Sympathy trigger (traveling, borrowed phone)
- Implied authority from the position
- Reasonable story — executives do travel and lose devices

**What the attacker wants:** Temporary password that lets them read emails, steal credentials to other systems, send internal messages as the CFO, or initiate a wire transfer.

**Red flags:**
- Calling from unknown number (not the exec's cell)
- Can't verify through any secondary channel
- Urgency pressure to skip normal process
- Refuses to use the standard ticketing/verification process

---

### Scenario 2: The Microsoft Support Call
**The call:** "This is Microsoft Technical Support. We've been monitoring your network and detected malicious activity originating from your organization. We need to run a diagnostic tool to identify the compromised machines. Can you allow me to connect remotely or run this tool I'll send you?"

**Why it works:**
- Microsoft is a household name — assumed authority
- Implies existing monitoring relationship
- Technical jargon sounds credible to non-technical recipients
- Offers to "help" — appeals to solving a problem

**Reality:** Microsoft does not proactively monitor individual customer networks or call them. This is always a scam.

**What they want:** Remote access (to install malware/ransomware), payment for "support services," or credentials.

---

### Scenario 3: The Physical Plant
**The pretext:** Person arrives at reception in a high-vis vest and hard hat carrying a tool bag: "I'm here from [HVAC company], I've got a scheduled maintenance visit for the server room. I need to check the cooling system."

**Why it works:**
- Visual props establish identity before any question is asked
- Maintenance visits happen regularly — staff don't always verify schedules
- The person looks like they belong
- Questioning them feels rude or obstructive

**What they want:** Physical access to plant USB devices, photograph security camera positions, install a hardware implant, or access unattended unlocked workstations.

---

## Defense Framework for Help Desk

### The Verification Protocol
**Never reset credentials, grant access, or make account changes based on a phone call alone.**

A caller claiming to be anyone — including the CEO — must be verified through an independent channel before any privileged action is taken.

**Standard verification tiers:**
1. **Self-service:** Users who can verify through their MFA app, recovery email, or manager approval don't need to call
2. **Ticket verification:** Open a ticket in the ITSM system, have the user confirm it from their registered email
3. **Callback verification:** End the call. Call the user back at their number on file — not a number they provide

### The Callback Rule
This is the single most effective defense:
1. Tell the caller you need to verify their identity
2. **Hang up** (or politely end the call)
3. Look up the caller's phone number in the company directory
4. Call that number
5. If the same person answers and still needs help, proceed

An attacker can spoof caller ID but cannot redirect incoming calls to their phone from your corporate directory number.

### What to Say
Scripts reduce hesitation and establish a pattern that doesn't feel personal:

> "I understand you need this done urgently. To protect your account, our policy requires me to verify your identity before making changes. Let me open a ticket and send you a verification link to your email on file, or I can call you back at the number we have in our system. Which would you prefer?"

If they push back:
> "I hear you, and I want to help get this resolved quickly. This verification step is here to protect you — if someone else was trying to change your account, you'd want us to stop them the same way. It only takes a minute."

### Red Flags Checklist
- [ ] Caller cannot verify through any system (email, manager, ticket)
- [ ] Unusually high urgency or emotional pressure
- [ ] Request to bypass normal process "just this once"
- [ ] Claims manager/executive already approved but that person is unreachable
- [ ] Caller provides information about internal systems that shouldn't be public
- [ ] Request involves a financial transaction or data transfer
- [ ] New number, blocked number, or number that doesn't match records
- [ ] Story that keeps changing as you ask questions

### Escalation — When to Involve Security
Escalate immediately if:
- Caller becomes threatening or abusive when verification is requested
- You've verified it's a real employee but the request seems out of character or unusual
- The request involves wire transfers, payroll changes, or external data sharing
- You've already made a change and then realized something was wrong

### Documenting Social Engineering Attempts
Every suspicious call should go in a ticket even if nothing was done. Pattern detection requires data. One suspicious call is an incident. Three suspicious calls in a week targeting the same account is a campaign.

```
Ticket template:
- Date/time of call
- Number called from (if available)
- Claimed identity
- What was requested
- What verification was attempted
- Outcome (access granted / denied / transferred)
- Anything unusual about the interaction
```

---

## Tags
`[[Social Engineering]]` `[[Phishing]]` `[[Incident Response]]` `[[Help Desk]]` `[[OSINT]]` `[[Vishing]]` `[[CySA+]]` `[[Security+]]`
