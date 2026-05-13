# Social Engineering

## What it is

Your network has a firewall, EDR on every endpoint, MFA on every account, patched systems, segmented VLANs. Then Karen in accounting gets an email that says "URGENT: CEO needs gift cards for client meeting, reply ASAP," and she replies. Game over. No CVE involved. No exploit chain. The attacker just asked nicely.

**Social engineering is hacking the human instead of the machine.** It's the entire category of attacks that target trust, urgency, fear, authority, and helpfulness — the wetware running between the keyboard and the chair. The technical exploits in this objective (XSS, SQLi, brute force, on-path) get bundled in because attackers chain them: phish a credential, then use it to pivot into the SQL injection that dumps the database.

The immune system metaphor matters here. Permissions and EDR are the immune system against malware. Against social engineering, the immune system is **the user's skepticism** — and skepticism doesn't ship with a default policy. You have to install it through training, and it gets disabled every time someone's tired, rushed, or scared.

## Why it matters

Verizon's annual breach report has said the same thing for a decade: the human element is involved in roughly three out of four breaches. Phishing is the #1 initial access vector. Ransomware crews don't burn zero-days when a $40 SMS gateway and a convincing pretext gets them domain admin by Tuesday.

CompTIA tests this hard on 220-1202 objective 2.5. You will get scenario questions where you have to name the attack from the description. The distinctions between **phishing / spear phishing / whaling / vishing / smishing** are pure exam meat — same attack, different channel or target, different name. Memorize the matrix.

## In your build, in the enterprise

### Beat 1 — Technical depth

Social engineering attacks split into two buckets the exam cares about:

**Threats (the active attacks):** phishing (mass email), spear phishing (targeted email), whaling (targeting C-suite), vishing (voice/phone), smishing (SMS), QR code phishing aka quishing, business email compromise (BEC — compromised or spoofed exec account asking for wire transfer), impersonation, tailgating, shoulder surfing, dumpster diving, evil twin (rogue AP mimicking a real SSID), supply chain attacks (compromise the vendor, ride the trust into the target).

**Technical attacks the exam bundles in this objective:** XSS (inject script into a trusted site), SQL injection (inject SQL into a form field), on-path / man-in-the-middle, brute force (try every password), dictionary attack (try every word from a list), DoS / DDoS, zero-day (exploit before patch exists), spoofing (forge sender/IP/MAC).

**Vulnerabilities (the conditions that make it work):** non-compliant systems, unpatched systems, EOL software, unprotected systems (no AV, no firewall), insider threat, BYOD without policy.

The pattern: attackers exploit the **vulnerability** (an unpatched system, a trusting user) using a **threat** (a phishing email, an exploit kit). Same playbook, different combos.

### Beat 2 — Feynman, gaming PC build

You posted in r/buildapc asking for help with a no-POST issue. Someone DMs you offering a "free RMA tool from MSI" — link to an .exe. *That's phishing. The trust signal is the subreddit context.*

You're at a LAN, plug into the venue Wi-Fi called "LAN_Event_5G." Latency is terrible. Turns out the real SSID was "LAN_Event_5GHz" and someone parked a Pineapple in the parking lot capturing your Steam session. *That's an evil twin. You authenticated to the wrong AP because the name was close enough.*

Your Discord pops a message from "Steam Support" saying your account is flagged, click here to verify. The link is `steamcommunlty.com`. *That's a homoglyph phish — l swapped for I, your eyes skip right over it.*

Stream chat asks you to scan a QR code for "free skins." It opens a fake Steam login on mobile where the address bar is half-hidden. *That's quishing. QR codes bypass the "hover to check the URL" instinct entirely because there's nothing to hover.*

Someone shoulder-surfs your password at the LAN while you log into Battle.net at the snack table. *Shoulder surfing. The oldest attack in the book, still works in 2026.*

### Beat 3 — Bridge from gaming to enterprise

Same attacks, enterprise stakes:

- **Home:** phishing tries to steal your Steam account. **Enterprise:** spear phishing crafts an email referencing your actual manager's name (from LinkedIn) asking you to "review the attached PO." Attachment is a malicious macro. Foothold on the corporate network.
- **Home:** evil twin captures your gaming session. **Enterprise:** evil twin in the office lobby named "CompanyName-Guest" captures employee credentials when they auto-connect from previous visits.
- **Home:** someone shoulder-surfs your Battle.net password. **Enterprise:** someone shoulder-surfs the receptionist typing the front-desk PC password, then tailgates through the badge door behind a delivery driver and walks straight to an unlocked workstation.
- **Home:** a scam call asks for your Apple ID. **Enterprise:** vishing call to the helpdesk: "Hi, this is Mark from the Dallas office, I'm locked out and my flight boards in 20 minutes, can you reset my password?" Helpdesk resets it. Attacker now has Mark's account.

The **vulnerability** axis scales too. At home you have one unpatched router. Enterprise has thousands of endpoints, BYOD phones connecting to corporate Wi-Fi, EOL Windows Server 2012 boxes still running a legacy app nobody will touch, contractors with VPN access, and a third-party HVAC vendor with credentials into the network (ask Target circa 2013 how that goes).

### Beat 4 — The point

**Same fundamental attacks, different targets, different blast radius.** Phishing your Steam account costs you a weekend and an email to support. Phishing your CFO costs the company $40 million in a fake wire transfer. The technique is identical — fake urgency, fake authority, a link or an attachment. The defense is identical too: verify out-of-band, slow down, treat urgency as the red flag itself. Get this instinct into your bones. *You'll be the one teaching it at every job for the rest of your career.*

## Key facts

### The phishing family — memorize this matrix

| Attack | Channel | Target | Tell |
|---|---|---|---|
| **Phishing** | Email | Mass / spray | Generic greeting, urgency, bad grammar |
| **Spear phishing** | Email | Specific person | References real names, projects, context |
| **Whaling** | Email | C-suite / executives | Looks like board comms, legal notices, wire requests |
| **Vishing** | Voice / phone | Varies | Caller ID spoofed, urgency, "verify your identity" |
| **Smishing** | SMS | Mass or targeted | Short link, package delivery, bank alert |
| **Quishing** | QR code | Anyone who scans | QR in email, on a flyer, on a parking meter sticker |
| **BEC** | Email (compromised/spoofed exec) | Finance / AP staff | Wire transfer requests, gift card requests, "I'm in a meeting, just do it" |

### Physical and proximity attacks

- **Tailgating / piggybacking** — walking through a badge door behind an authorized person. Mitigation: mantraps, security awareness, "challenge unfamiliar faces" culture.
- **Shoulder surfing** — watching credentials over someone's shoulder. Mitigation: privacy screens, awareness, don't say passwords aloud.
- **Dumpster diving** — pulling sensitive docs out of the trash. Mitigation: shredders, secure disposal bins, document retention policy.
- **Impersonation** — pretending to be IT, a vendor, a delivery driver. Mitigation: visitor badges, escort policy, callback verification.
- **Evil twin** — rogue AP with same/similar SSID as a legit network. Mitigation: 802.1X, certificate-based Wi-Fi auth, don't auto-connect to open networks.

### Technical attacks bundled in this objective

- **XSS (Cross-Site Scripting)** — attacker injects JavaScript into a legit website (forum comment, search field). Victim's browser runs it as if it came from the trusted site. Steals cookies, sessions.
- **SQL Injection (SQLi)** — attacker types SQL into a form field that gets concatenated into a database query. Classic payload: `' OR 1=1 --`. Dumps databases.
- **On-path attack (formerly MITM)** — attacker sits between two parties, reads/modifies traffic. Evil twin is one way to get there. Defense: TLS everywhere, certificate pinning.
- **Brute force** — try every possible password. Defense: account lockout, MFA, long passwords.
- **Dictionary attack** — try common passwords / words. Defense: same as brute force, plus banned-password lists.
- **DoS / DDoS** — flood a service until it falls over. DDoS uses many sources (botnet). Defense: rate limiting, scrubbing services (Cloudflare, Akamai).
- **Zero-day** — exploit for a vulnerability with no patch yet. Defense: defense in depth, EDR behavioral detection, fast patching once disclosed.
- **Spoofing** — forging identity (email sender, IP, MAC, caller ID, ARP). Defense: SPF/DKIM/DMARC for email, port security for MAC, 802.1X.

### Vulnerabilities — the conditions attackers love

- **Unpatched systems** — known CVE with available patch, not applied. The #1 cause of breaches that weren't user error.
- **EOL (end-of-life) systems** — vendor no longer issues patches. Windows 7, Server 2012, that medical device running XP. Isolate or replace.
- **Non-compliant systems** — drifted from baseline (disabled AV, missing GPO, unauthorized software). Caught by compliance scanning.
- **Unprotected systems** — missing AV, missing host firewall, no EDR.
- **Insider threat** — employee or contractor with legit access doing illegit things. Hardest to detect because their activity looks normal.
- **BYOD** — personal phone/laptop on corporate network. Unknown patch state, unknown apps, lost device = data breach. Mitigation: MDM, containerization, conditional access.

### CompTIA exam traps

> **CompTIA exam trap:** **Phishing vs spear phishing vs whaling.** Phishing is mass / generic. Spear phishing is targeted at a specific person or small group with personalized details. Whaling is spear phishing aimed at executives. All three are email-based. If the question mentions "the CEO" or "the CFO" — it's whaling. If it mentions a specific named employee — spear phishing. If it's a broad blast — phishing.

> **CompTIA exam trap:** **Vishing vs smishing.** Vishing = Voice (phone call). Smishing = SMS (text). Both are phishing variants — same goals, different channel. Don't overthink it.

> **CompTIA exam trap:** **Tailgating vs piggybacking.** CompTIA sometimes distinguishes: tailgating = unauthorized person follows without the authorized person knowing. Piggybacking = authorized person knowingly holds the door. Most exams treat them as synonyms. Read the scenario carefully.

> **CompTIA exam trap:** **DoS vs DDoS.** DoS = one source. DDoS = many sources (Distributed). If the question mentions a botnet or "thousands of compromised devices," it's DDoS.

> **CompTIA exam trap:** **Zero-day** specifically means no patch exists yet. If a patch is available and just hasn't been applied, that's an unpatched system, not a zero-day.

## Helpdesk reality

- User: "I clicked the link and entered my password but it didn't work, the page just refreshed." Translation: their credentials are now in an attacker's hands. **Immediate response:** force password reset, kill all active sessions, check sign-in logs for unfamiliar IPs, enable MFA if not already on, file an incident ticket. Don't lecture — they already feel stupid.
- User: "Someone called saying they were from IT and needed my password to fix my email." If they gave it: same response as above. If they didn't: praise them, hard. Positive reinforcement of good security behavior is rare and worth doing.
- User: "Is this email real?" — the correct answer is almost always "forward it to the phishing inbox, don't click anything, we'll let you know." Never tell a user "yeah looks fine" based on a glance. You'll be wrong eventually and it'll be the one that mattered.
- Finance staff: "The CEO emailed me to wire $80,000 to a new vendor, is that normal?" **Stop everything.** Verify out-of-band — call the CEO on a known number, walk to their office, anything except replying to the email. BEC fraud has cost companies billions. This is the call you want to get *before* the wire goes out.
- Never promise users that the spam filter catches everything. It doesn't. Tell them the filter is one layer; their judgment is another; reporting suspicious mail is how the filter learns.

## Related concepts

[[Malware]] · [[MFA and Authentication]] · [[Email Security SPF DKIM DMARC]] · [[Security Awareness Training]] · [[Incident Response]] · [[BYOD and MDM]] · [[Patch Management]] · [[Physical Security]] · [[Password Policies]] · [[EDR and Endpoint Security]]

*Source: VIRGIL knowledge base — 2026-05-11*