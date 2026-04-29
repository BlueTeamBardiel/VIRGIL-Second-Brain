# IT/Security Job Search Strategy
> Apply smarter, not harder. The 200-application spray-and-pray doesn't work.

The IT job market rewards specificity. A targeted application with a tailored resume beats 50 generic ones. This note covers LinkedIn strategy, resume optimization, scam detection, and the specific ways to present homelab and certification work to hiring managers.

---

## LinkedIn Search Strategy

### The 100+ Applicant Rule
When a job posting shows **100+ applicants**, you're competing against a pile that an ATS (applicant tracking system) will filter before a human reads it. Your resume needs to be nearly perfect to surface. Unless you're a strong match (80%+ of required skills), move on.

**Better target:** Jobs with **under 50 applicants**, ideally under 25. These get more human attention and you can stand out on merit rather than keyword optimization.

### Filter for Recent Postings
Always filter by **"Past 24 hours"** or **"Past week"** first. Why:
- Hiring managers check new applications frequently in the first 24-48 hours
- Applications pile up exponentially after a job goes viral or gets shared
- Early applicants get a longer look before decision fatigue sets in

**Workflow:** Every morning, search "IT Support" or "SOC Analyst" → filter Last 24 hours → quick-apply to strong matches. 10 targeted applications per day beats 100 generic ones.

### Search Terms that Work
For help desk → security transition:
- `SOC Analyst tier 1`, `Tier 1 SOC`, `Security Analyst entry level`
- `IT Support Security`, `Help Desk Security focus`
- `Junior Security Analyst`, `Associate Security Analyst`
- `Desktop Support` (feeds into security)
- `NOC Analyst` (network operations — adjacent path)
- Add: `CySA+`, `Security+`, `CompTIA` to filter for cert-friendly employers

---

## Red Flags: Scam Job Listings

Scam jobs are rampant in IT/security. Most target people desperately job hunting. Learn to spot them fast.

**Hard stops — don't apply:**
- Salary dramatically above market for the role level (e.g., "$8,000/month work from home, no experience")
- Asks for SSN, bank account, or personal ID before interview
- "Processing fee" or "background check fee" you pay
- Vague company name — Googling returns nothing or a 1-page site made yesterday
- Job description is 3 sentences of buzzwords with no actual responsibilities
- Email domain doesn't match company name (hiring@gmail.com for a supposed Fortune 500)
- LinkedIn company page has fewer than 10 followers and was created this month

**Yellow flags — investigate before applying:**
- "Work from home, set your own hours" with unclear company structure
- No phone number, physical address, or real people named anywhere
- Recruiter has 0 connections on LinkedIn and account created recently
- Job was posted and reposted 10+ times with minor changes

**Legitimate red flags (not scams but bad jobs):**
- "Must be available 24/7" for a Tier 1 role → poor management
- No mention of on-call rotation in an ops role → they'll spring it on you
- "Competitive salary" with no range → usually below market
- Three-stage interview + take-home project for a help desk role → disorganized or time-wasting

---

## LinkedIn Premium / LinkedIn Gold

**Not worth it for most job seekers.** Here's why:
- **InMail rarely works.** Recruiters get dozens of InMails. Most get ignored or auto-declined.
- **"Who viewed your profile" is a vanity feature.** Knowing a recruiter glanced at your profile doesn't help you get an interview.
- **The job search features are marginal.** LinkedIn shows you roughly the same jobs on free tier.
- **$40–60/month is real money** that's better spent on a TryHackMe subscription, a CySA+ voucher, or lab hardware.

**When it might be worth it:** 3-month trial if you're actively networking in a niche field and cold-messaging specific people. Even then, most professionals respond to well-crafted free connection requests better than InMails.

---

## Resume Tips for IT/Security

### Lead with a Skills Section
ATS systems scan for keywords before a human reads the resume. Put your skills near the top:

```
TECHNICAL SKILLS
OS: Windows 10/11, Windows Server 2022, Ubuntu/Debian Linux, RHEL
Networking: TCP/IP, DNS, DHCP, VLANs, firewall configuration
Security: SIEM (Splunk, Wazuh), vulnerability scanning (Nessus, OpenVAS), 
          EDR, incident response
Tools: Active Directory, Group Policy, Ansible, Docker, Wireshark, Burp Suite
Certs: CompTIA Security+ (in progress), CySA+ (target Q3 2026)
```

### Quantify Everything
Replace vague claims with numbers. Numbers survive ATS keyword filtering and impress humans.

| Weak | Strong |
|------|--------|
| "Handled help desk tickets" | "Resolved 40-60 tickets daily as primary Tier 1 analyst" |
| "Worked with Active Directory" | "Managed 500+ user AD environment including provisioning, GPO, and password resets" |
| "Set up monitoring" | "Deployed Prometheus + Grafana monitoring stack across 10-node lab environment" |
| "Used Linux" | "Administered Ubuntu/Debian servers via CLI; familiar with systemd, cron, and bash scripting" |

### Certifications Near the Top
If you have CompTIA certs, put them in your name header or a visible section above the fold:

```
MORPHEUS | IT Support | CompTIA Security+ | CySA+ (in progress)
```

### Homelab as Experience
Do not bury your homelab under hobbies. Present it as a project with real deliverables:

```
PERSONAL PROJECTS
COCYTUS Homelab | Lead Architect & Administrator | 2024–Present
• Deployed 10-node mixed OS network running Active Directory, Docker containers, 
  and automated configuration management via Ansible/Semaphore
• Implemented Wazuh SIEM with fleet-wide agent deployment; active monitoring of 
  Windows Event Logs and Linux auth/system logs
• Built automated threat intelligence pipeline ingesting 100+ CVEs and security 
  feeds daily via Python scripts and Anthropic AI summarization
• Deployed Prometheus + Grafana observability stack across all nodes
```

### VIRGIL-Specific Resume Bullet
```
• Built VIRGIL — an AI-powered personal knowledge management system integrating 
  daily CVE feeds, security news synthesis via Claude AI, and automated session 
  logging; 1,000+ structured security notes indexed in Obsidian
```

---

## Cold Apply vs Warm Apply

**Referrals win.** An internal referral gets your resume read by a human 80%+ of the time. A cold application through a job board gets you into an ATS pile.

### Finding Referrals on LinkedIn
1. Find a job posting you want to apply for
2. Look up the company on LinkedIn
3. Search employees: `[Company Name]` → filter by "1st" and "2nd" connections
4. Find someone with `IT`, `Security`, `Hiring`, `HR`, or your target role
5. Send a connection request with a short note:

```
Hi [Name], I'm a help desk tech with [X] years of experience transitioning 
into security. I saw [Company] is hiring for [Role] and would love to learn 
more about the team. Would you be open to a quick chat?
```

**What not to do:** Don't immediately ask for a referral. Build the conversation first. Most people will offer to refer you if the conversation goes well.

### When to Cold Apply
Cold apply when:
- It's a strong skills match (70%+)
- The posting is under 48 hours old
- The company has under 500 employees (less corporate ATS filtering)
- You've customized your resume for this specific role

---

## Follow-Up Etiquette

**After applying:** Wait 5-7 business days. Send one follow-up to the hiring manager or recruiter via LinkedIn:

```
Hi [Name], I applied for the [Role] position on [Date] and wanted to 
reiterate my interest. My background in [X] and [Y] aligns closely with 
the role. Happy to provide any additional information. Thank you for your time.
```

**After an interview:** Follow up within 24 hours with a thank-you note. Mention one specific thing from the conversation. This takes 5 minutes and most candidates don't do it.

**When to move on:** One follow-up, no response after 2 weeks → move on. Two follow-ups total maximum, ever. Persistence past that point looks desperate.

---

## Tags
`[[Job Search]]` `[[TryHackMe]]` `[[CySA+]]` `[[Security+]]` `[[Homelab]]` `[[Active Directory]]` `[[VIRGIL]]` `[[Help Desk]]` `[[LinkedIn]]`