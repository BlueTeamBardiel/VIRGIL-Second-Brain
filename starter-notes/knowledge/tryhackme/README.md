# TryHackMe
> Guided, hands-on cybersecurity training in a browser — the fastest path from help desk to security analyst.

TryHackMe (THM) is the best place to start if you have zero security experience. Every exercise runs in a browser — no local VM setup required. You get pre-configured attack/defense environments and guided paths that tell you exactly what to learn next. For someone transitioning from IT support, this is the on-ramp.

---

## THM vs HackTheBox — Pick the Right One First

| | TryHackMe | HackTheBox |
|---|---|---|
| **Target audience** | Beginners to intermediate | Intermediate to advanced |
| **Guidance** | Step-by-step rooms with hints | Minimal — figure it out yourself |
| **Environment** | Browser-based, always available | Download VPN config, connect locally |
| **Learning paths** | Structured curriculum | Challenge-based, community writeups |
| **Difficulty** | Lower barrier, gradual ramp | Jumps fast |

**Rule:** Do THM first. Get through Pre-Security and SOC Level 1. Then move to HackTheBox for unguided practice. Trying HTB too early burns people out.

---

## Recommended Learning Order

### 1. Pre-Security (Free, ~40 hours)
**What you learn:** Networking basics, Linux fundamentals, web technologies  
**Why first:** The absolute foundation. You cannot understand attacks without understanding what's being attacked. This path explains:
- How the internet actually works (DNS, HTTP, routing)
- Basic Linux commands and navigation
- How websites are built (HTML, JavaScript, databases)

**Estimated time:** 2–4 weeks at an hour per day.

### 2. Cybersecurity 101 (Free/Paid)
**What you learn:** Core security concepts — CIA triad, encryption, authentication, common attack types  
**Why second:** Bridges "how things work" to "how they get attacked." Builds vocabulary for certifications.

### 3. SOC Level 1 (Paid, ~40-60 hours)
**Most relevant path for the help desk → security career move.**

This path teaches exactly what Tier 1 SOC analysts do daily:
- Log analysis (SIEM fundamentals with [[Splunk]] and Elastic)
- Network traffic analysis
- Digital forensics basics
- Incident response procedures
- Phishing email analysis
- Threat intelligence

The skills map almost directly to [[CySA+]] exam content. If you're prepping for CySA+, run this path concurrently with your study.

**Modules include:** Cyber Defence Frameworks, Cyber Threat Intelligence, Network Security and Traffic Analysis, SIEM, Digital Forensics, Incident Response.

### 4. Jr Penetration Tester (Paid, ~60-80 hours)
Do this after completing SOC Level 1. Offensive security gives you a better mental model for defense — you stop guessing what attackers do and start knowing.

Covers: web app attacks, [[Metasploit]], [[Burp Suite]], network exploitation, privilege escalation.

---

## How to Use THM for Cert Prep

### Security+ (SY0-701) mapping
THM doesn't have an official Security+ path, but these rooms cover major domains:
- **Threats, Attacks, Vulnerabilities** → Jr Penetration Tester path, individual rooms on OWASP Top 10, phishing
- **Architecture & Design** → Network Fundamentals rooms
- **Implementation** → Linux Fundamentals, Windows Fundamentals
- **Identity & Access Management** → AD basics rooms
- **Governance** → SOC Level 1 (incident response)

Run Professor Messer's [[Security+]] videos alongside specific THM rooms. THM gives you hands-on practice for what Messer explains conceptually.

### CySA+ (CS0-003) mapping
SOC Level 1 path covers roughly 60% of CySA+ content:
- Threat and Vulnerability Management → CVE/CVSS rooms, vulnerability scanning
- Software and Systems Security → SIEM rooms
- Security Operations and Monitoring → Network traffic analysis, log analysis
- Incident Response → IR path rooms
- Compliance and Assessment → partial coverage

The remaining 40% (identity infrastructure, compliance frameworks) needs dedicated study outside THM.

---

## Free vs Paid

**Free tier includes:**
- All rooms marked "Free"
- Pre-Security path (entirely free)
- Limited daily machine access
- No certificate of completion

**Paid ($14/month or ~$100/year):**
- All rooms including premium
- SOC Level 1 (required for the full path)
- Jr Penetration Tester
- Completion certificates
- No daily machine limits

**Is paid worth it?** Yes, if you're serious. $14/month for the SOC Level 1 path alone is absurdly cheap compared to bootcamps. Do 1-2 hours per day for 3 months and you'll have more hands-on hours than most new analysts. Cancel when you finish the paths you came for.

**What to do on free tier:** Complete Pre-Security and Cybersecurity 101 entirely. Search for individual free rooms matching your current study topic. Build the habit before paying.

---

## Putting THM on Your Resume

### What actually impresses hiring managers:
- **Specific paths completed:** "Completed TryHackMe SOC Level 1 path" — not just "used TryHackMe"
- **Room count + percentile:** "Top X% globally, Y+ rooms completed" (shown on your profile)
- **Specific skills demonstrated:** "Completed hands-on labs in SIEM analysis, network traffic analysis, and digital forensics using Splunk and Wireshark"

### What doesn't impress:
- "Used TryHackMe" with no specifics
- Listing it without a completion date or room count
- Listing it alongside 20 other platforms you barely touched

### Resume bullet template:
```
TryHackMe — Cybersecurity Training Platform
• Completed SOC Level 1 learning path (~60 hours) covering SIEM, threat 
  intelligence, network analysis, and incident response
• Top X% global ranking with Y+ rooms completed
• Applied skills include: Splunk, Wireshark, Metasploit, Burp Suite
```

---

## Practical Tips

- **Do rooms in path order.** Skipping ahead and getting stuck kills momentum.
- **Read every hint before using it.** Try for 20 minutes, then read the hint, then try again.
- **Take notes as you go.** The content disappears when you close the room. A note per major room = free study material.
- **Join the THM Discord.** Active community, no spoilers policy on current rooms, good for getting unstuck.
- **Free rooms expire.** Not all free rooms stay free. If you're on free tier, check your queue.

---

## Tags
`[[TryHackMe]]` `[[CySA+]]` `[[Security+]]` `[[SOC]]` `[[Incident Response]]` `[[Help Desk]]` `[[Splunk]]` `[[Wireshark]]`
