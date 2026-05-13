# Security Vulnerabilities

## What it is

The CVE feed drops Tuesday morning. Three critical bugs in the firmware your shop runs on 800 endpoints. The vendor patch ships Friday. Between Tuesday and Friday, every machine in the building is a known-vulnerable target with a published exploit on GitHub. Welcome to security work.

A **vulnerability** is a weakness — in code, in config, in a person, in a process — that an attacker can use to do something they shouldn't. A **threat** is the actual thing trying to use that weakness: the malware, the phishing email, the guy in a fake delivery uniform walking through the door behind you. Threats exploit vulnerabilities. No vulnerability, no successful attack. No threat actor, no breach — just risk on paper.

The body metaphor works cleanly here. Vulnerabilities are open wounds, weak immune cells, unlocked doors. Threats are the bacteria, viruses, and intruders trying to get in. Patching is wound closure. Antivirus is white blood cells. Firewalls are skin. User training is the conscious decision not to lick a doorknob in a hospital.

## Why it matters

Objective 220-1202 2.5 is dense — CompTIA crammed nearly every named attack and weakness into one bullet list. They will test definitions. Spear phishing vs whaling vs vishing. Brute-force vs dictionary. On-path vs evil twin. Memorize the distinctions or you will lose points you can't afford. More importantly: on the helpdesk, the user calling in panicked about a "weird email from the CEO asking for gift cards" needs you to recognize it instantly as BEC and route it to the security team, not waste 20 minutes troubleshooting Outlook.

## In your build, in the enterprise

**Beat 1 — the technical layer.** Threats divide into roughly four buckets: **code-based** (XSS, SQL injection, zero-days), **network-based** (DoS/DDoS, on-path, evil twin), **social** (phishing and its variants, impersonation, tailgating, shoulder surfing, dumpster diving), and **credential-based** (brute-force, dictionary). Vulnerabilities are the conditions that let those threats land: **unpatched systems**, **EOL software** (no more patches coming, ever), **non-compliant systems** (missed the GPO, drifted from baseline), **unprotected systems** (no AV, no firewall, no EDR), and **BYOD** (personal devices on the corporate network that nobody fully controls). Zero-day is a special case — a vulnerability the vendor doesn't know about yet, so no patch exists. You can't fix what nobody's discovered.

**Beat 2 — your home rig is full of these.** That gaming PC has the full attack surface. *Unpatched Windows because you postponed the reboot through three Tuesday cycles — unpatched system, real vulnerability, exploited weekly in the wild.* The Steam phishing DM from "your friend" who actually got their account stolen last month and is now spamming his list — *social engineering, and your eagerness to help is the weakness.* The "free Discord Nitro" QR code in a sketchy server — *QR phishing, scans straight to a credential harvester before you've read the URL.* That ancient Windows 7 box in the closet running your old Plex library — *EOL system, no security patches since 2020, and it's on your LAN with your file shares.* The router still on default admin/admin because you never changed it — *unprotected system.* The IoT smart bulb from a no-name brand pulling firmware from servers in a jurisdiction you can't pronounce — *supply chain risk in your living room.* *Your home network has the same vulnerability classes the enterprise has. Smaller blast radius, identical mechanics.*

**Beat 3 — same problems, enterprise scale.** Now imagine 800 of those Windows boxes, and one of them belongs to the CFO. The unpatched machine isn't your problem — it's WSUS's, or Intune's, or SCCM's, and there's a compliance dashboard tracking patch lag across the fleet. The phishing DM isn't a Steam scam — it's **spear phishing** (targeted at one person with personal details) or **whaling** (targeted at an executive) or **BEC** (the attacker impersonates the CFO and emails accounts payable to wire $400k to a "new vendor"). The QR code isn't on Discord — it's taped to a parking meter in the company lot, harvesting Microsoft 365 credentials from anyone who scans. The EOL box isn't your old Plex server — it's a production ERP running on Server 2012 that the business "can't afford to migrate." BYOD isn't your kid's iPad — it's 1,200 personal phones with corporate email, some jailbroken, some running unknown apps. *Same vulnerability classes. Different blast radius — and the breach lands on the front page.*

**Beat 4 — the point.** The fundamental question never changes: *what's exposed, what's protecting it, and who's trying to get in?* You ask it about your home router. You ask it about the corporate firewall. You ask it about the AD service account with a 12-year-old password. Asset inventory + patch state + threat model. Get this question into your bones — it's the entire security profession in one sentence.

## Key facts

### The threats — what's trying to get in

| Threat | What it is | The tell |
|---|---|---|
| **Phishing** | Generic mass email asking for credentials or a click | "Dear customer" — no name, urgency, bad grammar |
| **Spear phishing** | Targeted phish with personal details (your name, manager, recent project) | Feels eerily specific |
| **Whaling** | Spear phish aimed at executives | CFO/CEO is the target |
| **BEC** | Attacker impersonates an executive to get money or data moved | "I'm in a meeting, can't talk, wire this immediately" |
| **Vishing** | Phishing by voice — phone call | "This is IT, I need your password to fix your account" |
| **Smishing** | Phishing by SMS | "USPS package undeliverable, click here" |
| **QR code phishing (quishing)** | Malicious QR sticker or image leading to credential harvester | QR code anywhere it doesn't belong |
| **DoS** | One source floods a target offline | One IP, huge traffic |
| **DDoS** | Many sources flood a target offline (botnet) | Thousands of IPs, geographically spread |
| **On-path (MitM)** | Attacker sits between you and the server, reads/modifies traffic | Cert warnings, weird redirects |
| **Evil twin** | Rogue Wi-Fi AP impersonating a legitimate one | Two "Starbucks WiFi" SSIDs, one is the trap |
| **XSS** | Malicious script injected into a webpage, runs in victim's browser | Stored or reflected, executes in your session |
| **SQL injection** | Malicious SQL in a form field, hits the database directly | `' OR 1=1 --` is the classic |
| **Zero-day** | Exploits a vulnerability the vendor doesn't know exists | No patch available, by definition |
| **Supply chain attack** | Compromise a vendor/component upstream to hit everyone downstream | SolarWinds, the canonical example |
| **Brute-force** | Try every possible password | Slow, noisy, lockouts trigger |
| **Dictionary** | Try a wordlist of likely passwords | Faster than brute-force, catches lazy passwords |
| **Insider threat** | Authorized user does damage (intentional or accidental) | Hardest to detect — they have legitimate access |
| **Impersonation** | Pretending to be someone with authority | "I'm from corporate IT, let me in the server room" |
| **Tailgating** | Walking through a secure door behind an authorized person | "Hey, can you hold that?" with hands full of coffee |
| **Shoulder surfing** | Reading someone's screen or keyboard over their shoulder | Airport lounge, open laptop, sensitive data |
| **Dumpster diving** | Physically going through trash for sensitive info | Printed credentials, org charts, vendor invoices |
| **Spoofing** | Faking an identity — email address, IP, MAC, caller ID | The "from" field lies |

### The vulnerabilities — why attacks land

| Vulnerability | What it means | The fix |
|---|---|---|
| **Unpatched systems** | Known CVEs, no patch applied | Patch management (WSUS, Intune, SCCM) |
| **EOL software** | Past vendor support, no more patches coming | Upgrade, isolate, or replace |
| **Non-compliant systems** | Drifted from security baseline (missed GPO, disabled AV) | Compliance scanning, auto-remediation |
| **Unprotected systems** | Missing AV, missing firewall, missing EDR | Deploy and enforce via MDM/GPO |
| **BYOD** | Personal devices on corporate resources, limited control | MDM enrollment, conditional access, network segmentation |
| **Weak credentials** | Default passwords, reused passwords, short passwords | Password policy + MFA, kill defaults on day one |

### CompTIA exam traps

> **Phishing vs spear phishing vs whaling.** Phishing = mass, generic. Spear = targeted at one person with personal details. Whaling = spear phishing where the target is an executive. If the question names a CEO/CFO/exec by role, the answer is whaling. If it says "an employee in accounting received an email referencing her recent project," that's spear phishing.

> **Vishing vs smishing.** Vishing = voice (phone call). Smishing = SMS (text). CompTIA will mix these up in answer choices specifically to trip you.

> **DoS vs DDoS.** DoS is one source. DDoS is many sources (distributed — that's what the second D stands for). If the question mentions a botnet, it's DDoS.

> **Brute-force vs dictionary.** Brute-force tries every possible combination (a, b, c... aa, ab...). Dictionary tries a list of likely passwords (password123, summer2025, qwerty). Dictionary is faster but only catches predictable passwords.

> **Evil twin vs on-path.** Evil twin is specifically a rogue *wireless access point* impersonating a legitimate SSID. On-path is the broader category of "attacker sits between you and your destination." All evil twins enable on-path attacks, but not all on-path attacks involve evil twins.

> **Zero-day means no patch exists.** If the question says "the vendor released a patch last week and the customer didn't apply it," that's an unpatched system vulnerability, NOT a zero-day. Zero-day = vendor doesn't know, no fix available yet.

> **Tailgating vs impersonation.** Tailgating is a physical follow-through-the-door move. Impersonation is claiming to be someone you're not (could be in person, on the phone, via email). They overlap — an attacker can impersonate a delivery driver AND tailgate — but CompTIA tests them as distinct concepts.

## Helpdesk reality

- User forwards an email: "Is this real? It says my mailbox is full." Look at the sender domain (not the display name — the actual address). Look at the link target (hover, don't click). If it's not from your tenant or a known vendor, it's phishing. Report it through the report button — most M365 tenants have one — and tell the user "good catch, that's the right instinct, always ask."
- A panicked call from accounts payable: "The CEO emailed me to wire $50,000 to a new vendor and he said it's urgent." Stop everything. This is BEC. The right answer is *never* "let me check the email headers" — it's "do not send the wire, call the CEO on his known phone number to verify, and I'm looping in the security team right now."
- "My password isn't working." Could be benign (caps lock, expired) or could be account compromise (someone changed it). Check the audit log before you reset. If the last password change came from an IP in Belarus at 3 AM, that's not a forgotten password — that's an incident.
- "Someone called and said they were from IT and needed my password to fix my account." That's vishing. IT never needs your password. Document the call, report to security, and use it as a teaching moment without making the user feel stupid — they called you, that's the win.
- "I scanned a QR code in the parking lot and now my email is acting weird." Treat as compromised credentials. Force password reset, revoke active sessions, check for inbox rules the attacker may have added (auto-forward to external addresses is the classic persistence trick), and escalate.

## Related concepts

[[Malware Types]] · [[Social Engineering Defense]] · [[Patch Management]] · [[MFA and Authentication]] · [[Endpoint Protection]] · [[Email Security and Anti-Phishing]] · [[Acceptable Use Policy]] · [[Incident Response Basics]] · [[BYOD and MDM]]

*Source: VIRGIL knowledge base — 2026-05-11*