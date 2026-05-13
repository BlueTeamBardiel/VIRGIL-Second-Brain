# RDP — Remote Desktop Protocol

## What it is

In **Demon's Souls**, the Old Monk fight in 3-3 doesn't summon a scripted boss — it pulls in another player as the Old Monk, controlling a Black Phantom inside *your* world with full access to your fog gate, your geometry, your healing window. You're not fighting an NPC. You're fighting a real human who is *logged into your instance*. That's exactly what RDP does — a remote user gets an interactive session inside your machine, mouse and keyboard and clipboard, indistinguishable from someone sitting at the console.

Plain English: RDP lets you control a Windows desktop over the network as if you were sitting at it. Microsoft's proprietary protocol, built into every Windows box since the late 90s, listens on **TCP/UDP 3389** by default.

Technical: Remote Desktop Protocol is Microsoft's stack for delivering a graphical session, input redirection, drive/clipboard/printer redirection, and audio over a single multiplexed channel. It rides on TLS in modern versions and supports **Network Level Authentication (NLA)** to force credential validation before a session is allocated. RDP is built into Windows (`mstsc.exe` is the client, `TermService` is the server) and is the single most abused legitimate admin protocol on the internet.

## Why it matters

RDP is the **number one initial access and lateral movement vector** in ransomware intrusions. Conti, LockBit, BlackCat, Ryuk — every major ransomware family has RDP brute-force or stolen-RDP-credential playbooks. It's used by sysadmins legitimately every day, so disabling it isn't an option and detecting abuse means separating signal from a sea of legitimate noise.

CySA+ Objective 1.3 covers RDP under common techniques, abnormal account activity, command and control, and [[Log analysis and correlation]]. You'll see RDP questions framed as: *"An analyst sees 3389 traffic from a workstation to a domain controller at 2am — what is the most likely concern?"* The answer is always [[Lateral movement]], never "legitimate maintenance."

## Key facts

### Protocol mechanics

| Property | Value |
|---|---|
| Port | TCP/UDP 3389 |
| Client | `mstsc.exe` (Microsoft Terminal Services Client) |
| Server service | TermService / `svchost.exe` hosting `termsrv.dll` |
| Auth modes | NLA (pre-auth via CredSSP), Standard RDP Security, TLS |
| Session log source | Security log + `Microsoft-Windows-TerminalServices-*` operational logs |
| Credential exposure | Uses **CredSSP** — can be relayed if downgraded or misconfigured |

### Where RDP shows up in the kill chain

- **Initial access** — exposed 3389 on the internet, brute forced or hit with leaked creds from infostealer logs (RedLine, Raccoon, Lumma dump RDP creds).
- **Lateral movement** — attacker pivots from a foothold to a domain controller or jump box using stolen creds. T1021.001 in [[MITRE ATT&CK]].
- **Persistence** — attacker enables RDP on a previously-disabled host, adds themselves to Remote Desktop Users group.
- **Command and control** — rare, but RDP-over-HTTPS (RD Gateway, port 443) can be tunneled out to attacker infrastructure for hands-on-keyboard sessions that bypass network egress filtering.

### Logs that matter

| Event ID | Source | Meaning |
|---|---|---|
| 4624 (Type 10) | Security | Successful RDP logon (RemoteInteractive) |
| 4625 | Security | Failed logon — brute force pattern |
| 4778 / 4779 | Security | Session reconnect / disconnect |
| 1149 | TerminalServices-RemoteConnectionManager | User authenticated to RDP service (pre-logon) |
| 21 / 22 / 25 | TerminalServices-LocalSessionManager | Session logon / shell start / reconnect |
| 1024 / 1102 | TerminalServices-RDPClient | *Outbound* RDP from a host — gold for lateral movement detection |

The Event ID 1149 is the one CompTIA-style questions love because it fires **before** Security 4624 — meaning you see the connection attempt even if NLA rejected the credentials.

### Detection patterns

**Brute force from the internet:**
- Hundreds of 4625s from a single source against multiple accounts.
- Logon Type 10 in 4625 (RemoteInteractive) — distinguishes RDP brute from SMB/network brute.
- [[Pattern recognition]] target: failure rate per source IP per minute. Tune your [[SIEM]] rule to ignore the helpdesk subnet.

**Lateral movement (the dangerous one):**
- 4624 Type 10 *between* internal hosts, especially workstation-to-workstation or workstation-to-DC.
- Outbound RDP from a host that has no admin function (HR laptop reaching out to a file server on 3389 — why?).
- Event 1024 on the source host paired with 4624 on the destination. Correlate these in your SIEM and you've got [[User behavior analysis]] for free.

**Abnormal account activity:**
- Service account logging in via RDP — service accounts should never have interactive sessions. If `svc_backup` opens an RDP session, that's compromise until proven otherwise.
- [[Impossible travel]] — same account RDPs into hosts in two geographies within minutes. Tie session source IPs to geo data in your [[SIEM]].
- After-hours RDP from an account whose owner is on PTO.

### Network indicators

[[Wireshark]] / [[Packet capture]] view of RDP:
- TLS handshake on 3389 (or 443 if RD Gateway).
- `Cookie: mstshash=<username>` in the initial X.224 Connection Request — **the username is sent in cleartext before TLS** in legacy modes. Pre-NLA RDP leaks the attempted username on the wire. Your IDS can extract this and flag brute force without decrypting anything.
- Long-lived flows with bidirectional traffic, characteristic mouse-movement byte patterns. Beaconing tools occasionally mimic RDP timing to blend in.

### BlueKeep and friends

**CVE-2019-0708 (BlueKeep)** is the wormable pre-auth RCE in RDP on Windows 7 / Server 2008 R2. CompTIA still references it as the canonical "patch your RDP" cautionary tale. Followed by **DejaBlue** (CVE-2019-1181/1182) on newer Windows versions. Anyone with legacy systems and 3389 exposed is one Metasploit module away from a bad week.

### Hardening RDP

- **Never expose 3389 to the public internet.** Put it behind a VPN, a [[Zero Trust]] broker, or RD Gateway with MFA. The number of organizations still RDP'd to the internet in 2026 is the reason ransomware actuarial tables exist.
- **Enforce NLA.** Pre-auth means unauthenticated attackers can't even reach the RDP stack — mitigates whole classes of memory-corruption CVEs.
- **Account lockout policy** — 5 attempts, 30 minute lockout. Stops password spray cold.
- **Network segmentation** — RDP should only be allowed from jump boxes to servers, never workstation-to-workstation. The flat network is the ransomware operator's playground.
- **MFA on RDP** — Duo, Azure MFA, smart cards. The single most effective control.
- **Restrict Remote Desktop Users group** membership. Audit it monthly. Add a [[SOAR]] playbook that alerts on group membership changes.
- **Log forwarding** — TerminalServices logs are local-only by default. Forward via WEF or your [[EDR]] agent or you're forensically blind.

### CompTIA exam traps

> **CompTIA exam trap:** When a question describes "RDP traffic from a workstation to a domain controller," the answer is [[Lateral movement]] — not "remote administration." CompTIA frames legitimate admin as coming *from* a jump box, not from a user workstation. Read the source of the traffic before you pick.

> **CompTIA exam trap:** Logon Type matters. **Type 10 = RemoteInteractive (RDP).** Type 3 = Network (SMB, share access). Type 2 = Interactive (at console). A question that says "Type 3 logons from an unusual source" is asking about SMB/lateral movement, not RDP. Don't conflate them.

> **CompTIA exam trap:** RDP defaults to **3389**, but RD Gateway tunnels it over **443**. If a question describes RDP-over-443 to an external host, that's [[Command and control]] via legitimate-protocol tunneling, not "normal HTTPS."

## SOC reality

- **The 3am alert:** "RDP_Bruteforce_Threshold_Exceeded — 847 failed logons from 185.220.x.x against the primary DC in 10 minutes." L1's first move: confirm the source is external, check if the targeted accounts exist, block the source IP at the perimeter firewall, escalate to L2 if any of the targeted accounts are privileged. Don't wait for the brute to succeed before you block — the [[Mean time to detect|MTTD]] you brag about means nothing if [[Mean time to respond|MTTR]] is six hours.

- **The dangerous quiet alert:** "Successful RDP logon — `admin_jsmith` from 10.40.12.88 to the secondary DC at 02:14." No failures preceding it. That's not brute force — that's a valid credential being used. Either Jane Smith is doing maintenance she forgot to ticket, or someone has her password. Call her. If she's asleep, you have an incident.

- **The CISO question:** "Is RDP exposed anywhere we don't know about?" Run a [[Shodan]] query on your public IP space monthly. Run an internal Nmap sweep on 3389 quarterly. The answer "no" is only credible if you have evidence. *"We don't think so"* is a career-limiting sentence in a post-breach interview.

- **The handoff:** L1 confirms RDP brute → blocks source IP, documents in ticket. L2 confirms successful RDP logon to a sensitive host → pulls 4624 details, kicks the session, forces password reset, hands to IR. IR pulls [[EDR]] process tree on the destination host to see what the attacker did *after* the logon. Legal gets called if PII or PHI was on the box.

- **Never promise:** "We blocked the brute force, we're safe." Brute force is the noise; the real intrusion is the one successful credential you didn't catch six weeks ago that's been quietly logging in from a residential proxy. *The alert that fires is the one tuned for; the alert that doesn't fire is the one that owns you.*

## Related concepts

[[Lateral movement]] · [[MITRE ATT&CK]] · [[Log analysis and correlation]] · [[SIEM]] · [[EDR]] · [[Impossible travel]] · [[User behavior analysis]] · [[Pattern recognition]] · [[Command and control]] · [[Abnormal account activity]] · [[Wireshark]] · [[Packet capture]] · [[SOAR]] · [[Zero Trust]] · [[Cyber Kill Chain]] · [[Brute force attack]]

*Source: VIRGIL knowledge base — 2026-05-11*