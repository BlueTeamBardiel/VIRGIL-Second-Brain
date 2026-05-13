# Login and Rights Usage Anomalies

## What it is

In **Tekken**, every character has a movelist — Heihachi's Electric Wind God Fist, Kazuya's Mishima crouch-dash, Steve's peekaboo stance. When you watch a high-rank match and suddenly see Heihachi pull off a King chain grab, something's wrong. The inputs don't belong to the character. Either someone swapped controllers, or the account got handed off, or you're watching a replay that was tampered with. Same player tag, wrong movelist.

That's exactly what a login and rights usage anomaly is — the account is the character, the behavior is the movelist, and when the movelist doesn't match the character, you stop the match.

**Technical definition:** Login and rights usage anomalies are deviations from a user's established authentication and authorization baseline — unusual login times, impossible geographic locations, atypical resource access, or privilege use outside the user's role. They are behavioral [[Indicators of Compromise]] surfaced through [[UEBA]] (User and Entity Behavior Analytics), SIEM correlation rules, and identity provider telemetry. Under CompTIA CS0-003 Objective 3.2, they sit in **Detection and Analysis** as the trigger for an [[Incident Response Lifecycle]] engagement.

## Why it matters

Credential abuse is the #1 entry vector in the [[Verizon DBIR]] year after year. The attacker doesn't need a zero-day if they have a working username and password — they just log in. The firewall sees an authorized session. The EDR sees a signed binary running as a domain user. Nothing alerts on the network layer because nothing is technically wrong on the network layer. The only signal you have is **the account is behaving wrong**.

For the CySA+ exam, this maps directly to Objective 3.2 (incident response activities) and feeds Objective 1.3 (analyzing indicators of malicious activity). CompTIA tests this as both a detection scenario ("which alert indicates compromise?") and a response scenario ("what is the first containment step?").

For the SOC, this is the bread-and-butter ticket. You'll triage more "impossible travel" alerts in your first month than any other anomaly type, and most of them will be VPNs, corporate proxies, or someone's phone connected to airport Wi-Fi while their laptop's home on the LAN. The skill is separating the noise from the one ticket where Kazuya is actually throwing Steve's punches.

## Key facts

### The four anomaly classes

| Class | Example | Why it matters |
|---|---|---|
| **Time-based** | Domain admin logs in at 03:14 local on a Sunday | Attackers work in their timezone, not yours |
| **Geographic** | NYC login at 09:00, Lagos login at 09:47 | "Impossible travel" — physics says no |
| **Behavioral / role-based** | Accounts payable user opens 400 files in `\\fileserver\engineering` | Access pattern doesn't match job function |
| **Rights / privilege** | Standard user account suddenly invokes `runas` and hits domain controllers | Privilege escalation or token theft in progress |

### Time-based anomalies

The baseline is the user's normal working window — 08:00 to 18:00 local, Monday through Friday, with occasional Saturday spikes for the on-call rotation. Anything outside that window is a deviation, not automatically malicious. Look for:

- **Off-hours authentication** to sensitive systems (DCs, jump hosts, source control)
- **First-time authentication** at an unusual hour for an account that's been around 3+ years
- **Bursts** — 40 logins in 90 seconds is a brute force or a script, not a human

Time-based detection generates false positives. Salespeople travel. Engineers fix things at 2am. The compensating control is **enrichment**: cross-reference with the ticketing system, the change calendar, the on-call schedule. If there's no ticket, no change, and no page, the off-hours login is real.

### Geographic anomalies — "impossible travel"

The classic detection: user authenticates from City A, then from City B, and the time between the two logins is shorter than the fastest commercial flight between them. Azure AD calls this "atypical travel." Okta calls it "suspicious activity." Same logic.

> **CompTIA exam trap:** Impossible travel does **not** confirm compromise — it confirms two sessions exist from two locations. The user could be on a VPN, a mobile hotspot routed through a different region, a cloud workspace, or a corporate proxy that egresses from a different country. The right first move is **investigate**, not **disable account**. CompTIA loves to test whether you jump straight to containment without analysis.

VPN usage is the single biggest false-positive driver. If your workforce uses a global VPN concentrator, every user looks like they're in Virginia or Frankfurt regardless of where they actually are. Tune around this by baselining the VPN egress IPs as "home" and flagging only logins that come from outside the VPN fleet.

### Behavioral and role-based anomalies

This is where [[UEBA]] earns its license cost. The platform builds a per-user baseline of:

- Which file shares they touch
- Which applications they launch
- Which endpoints they authenticate to
- Which peers they communicate with

Deviation from baseline generates a risk score. The HR analyst suddenly enumerating Active Directory with `net group "Domain Admins"` is a behavioral anomaly even if the time and location are normal. The account is doing things the human never does.

### Rights usage anomalies

Privilege use, not just privilege existence. The user **has** local admin on their laptop — fine, that's the baseline. The user **used** local admin to install a tool that spawned `powershell.exe -nop -w hidden -enc <base64>` — that's the anomaly.

Watch for:

- **Privilege escalation events** (Windows Event ID 4672 — special privileges assigned to new logon)
- **Token manipulation** (4624 logon type 9 with explicit credentials)
- **Service account interactive logon** (service accounts should never log on interactively — if one does, someone's pivoting)
- **Dormant account reactivation** (account hasn't authenticated in 180 days, then suddenly does)

### Detection sources

| Source | What it gives you |
|---|---|
| **Windows Security log** | 4624 (logon), 4625 (failed logon), 4672 (privileged logon), 4768/4769 (Kerberos TGT/TGS) |
| **Azure AD / Entra ID sign-in logs** | Sign-in risk, conditional access result, MFA state |
| **VPN concentrator logs** | Tunnel start, source IP, assigned IP, user |
| **[[SIEM]] correlation** | Cross-source rules — VPN says NYC, AzureAD says Lagos, same minute |
| **[[UEBA]]** | Risk score deltas over rolling 30-day baseline |
| **IdP / SSO logs** | Okta, Ping, Duo — every federated app access |

### The CompTIA IR lifecycle on a confirmed credential anomaly

1. **Preparation** — UEBA baselines built, playbook written, IdP integration with SIEM tested, MFA enforced.
2. **Detection and Analysis** — impossible travel alert fires. Analyst pulls sign-in logs, VPN logs, recent password reset events, MFA challenges. **Scope**: which accounts, which assets, which data. **Impact**: was anything accessed?
3. **Containment, Eradication, and Recovery** — disable account or force re-authentication (containment via [[Isolation]]). Revoke active sessions and refresh tokens. Reset credentials. If a host is implicated, isolate it from the network. Re-image if persistence is suspected ([[Re-imaging]]). Restore access through a clean credential issuance flow.
4. **Post-incident Activity** — root cause (phishing? credential stuffing? infostealer on personal device?), lessons learned, tune the detection so the next one fires faster.

### Evidence handling

When the anomaly escalates to a confirmed incident, the logs become evidence. Treat them accordingly:

- **Evidence acquisition** — pull sign-in logs, VPN logs, endpoint EDR telemetry, mailbox audit logs **before** they age out of hot storage. Cloud providers default to 30–90 day retention. Don't wait.
- **Chain of custody** — every transfer of evidence gets logged. Who pulled the export, when, hash of the file, who received it. Break the chain, lose the case.
- **Validating data integrity** — hash every artifact (SHA-256) at acquisition. Re-hash before any analysis hand-off. Document the hash in the case file.
- **Preservation** — issue a [[Legal Hold]] on the affected user's mailbox and OneDrive immediately if HR, legal, or law enforcement involvement is plausible. Legal hold suspends retention deletion.
- **Compensating controls** — if you can't immediately reset the credential (executive on a stage, won't answer the phone), apply compensating controls: conditional access policy forcing MFA on every action, geo-block at the IdP, session timeout reduced to 5 minutes.

### CompTIA exam traps

> **CompTIA exam trap:** "Impossible travel" + VPN. If the scenario mentions corporate VPN, the answer is almost certainly **investigate / correlate with VPN logs**, not disable. CompTIA tests whether you understand VPN egress points create false geographic signals.

> **CompTIA exam trap:** Off-hours login alone is not compromise. Off-hours + privilege escalation + new process tree + connection to external IP is compromise. The exam will give you a single weak indicator and ask if you escalate to IR. Answer: enrich first, then decide.

> **CompTIA exam trap:** Service account interactive logon is **always** abnormal. Service accounts authenticate non-interactively (logon type 5 for services, type 3 for network). An interactive logon (type 2) or RDP (type 10) on a service account means someone is using its credential as a human would — that's lateral movement, not legitimate use.

## SOC reality

- The alert at 3am reads "Risk-based sign-in: high — atypical travel — userprincipalname: [email protected]." Your first move is the IdP console — pull her last 24 hours of sign-ins, MFA prompts (satisfied or skipped?), and the device IDs. If both sessions are from the same enrolled device, it's almost always VPN/proxy. If they're different device IDs, your pulse goes up.
- The L1 acknowledges, enriches, and either closes as benign-VPN with a note in the ticket, or escalates to L2 with the timeline pre-built. The escalation criteria are written down in the playbook — don't freelance them at 3am.
- The IR lead's first three questions: **scope** (how many accounts?), **impact** (what was accessed?), **evidence preserved** (logs exported, hashes recorded?). If you can't answer those in 15 minutes, you don't have a handle on it yet.
- Never tell the CISO "the account is contained" until the session tokens are revoked. Disabling the account in AD does not kill an existing OAuth refresh token in a SaaS app. *I learned this the hard way watching a "contained" attacker exfil another 6GB of SharePoint over a token that was issued before the disable.*
- The handoff: L1 triages and enriches → L2 confirms compromise and scopes → IR team runs containment and coordinates with identity, endpoint, and legal → executive comms if it's a notification-eligible breach under [[GDPR]] / [[CIRCIA]] / state breach laws.

## Related concepts

[[UEBA]] · [[SIEM]] · [[Indicators of Compromise]] · [[Incident Response Lifecycle]] · [[Chain of Custody]] · [[Legal Hold]] · [[Isolation]] · [[Re-imaging]] · [[Compensating Controls]] · [[Conditional Access]] · [[MFA]] · [[Kerberos]] · [[Lateral Movement]] · [[Credential Stuffing]] · [[Phishing]]

*Source: VIRGIL knowledge base — 2026-05-11*