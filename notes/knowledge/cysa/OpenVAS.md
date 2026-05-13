# OpenVAS — Open Vulnerability Assessment Scanner

## What it is

In **Mario**, when you enter a castle level, you're scanning every block from below with a head-bonk — most are solid bricks, some drop coins, a few hide a 1-Up or a power-up, and the occasional one is a Hidden Block you'd never know about unless you walked under the right pixel and jumped. That methodical, room-by-room "hit every brick and log what came out" is exactly what a vulnerability scanner does to your network. OpenVAS is the free, open-source one — the green-shell version of Nessus.

Plain English: OpenVAS is a network vulnerability scanner. You point it at a range of IPs, it probes every service it finds, compares what it sees against a feed of known vulnerability tests, and hands back a prioritized report of what's broken.

Technical: **OpenVAS** (Open Vulnerability Assessment Scanner) is the scanning engine inside the **Greenbone Vulnerability Management (GVM)** framework. It uses **NASL** (Nessus Attack Scripting Language) plugins distributed via the **Greenbone Community Feed**. The scanner performs host discovery, port enumeration, service fingerprinting, and runs **NVTs** (Network Vulnerability Tests) — currently north of 100,000 — against discovered services. Results map to **CVE**, **CVSS**, and **CPE** identifiers. It supports both **unauthenticated** (network-perspective) and **authenticated/credentialed** (logged-in-perspective) scans. OpenVAS itself was forked from the last open Nessus release in 2005 when Tenable went closed-source.

## Why it matters

CySA+ Objective **2.2** is the entire "read this scan output and tell me what to do" skill set, and OpenVAS is one of the named tools you must recognize in scan output, screenshots, and report excerpts. In the field, OpenVAS is what every shop without a Tenable license actually runs — homelabs, MSSPs on a budget, internal red teams doing pre-engagement recon, compliance scanning for small businesses, and pretty much every CTF/HTB lab environment you'll ever touch.

The skill the exam tests isn't "can you install it." It's: given a Greenbone report showing five Highs and a Medium, can you tell which is a false positive, which is exploitable, which needs a credentialed re-scan, and which the change board will push back on? That's [[Vulnerability Management]] in practice.

## Key facts

### Architecture

| Component | Job |
|---|---|
| **OpenVAS Scanner (`openvas`)** | The scanning engine that executes NVTs against targets |
| **GVMd** (Greenbone Vulnerability Manager daemon) | The brain — manages tasks, targets, configs, report storage |
| **GSA** (Greenbone Security Assistant) | The web UI on port 9392 (HTTPS) |
| **GMP** (Greenbone Management Protocol) | API for automation; replaces the old OMP |
| **Notus Scanner** | Newer component for package-version vulnerability checks on Linux hosts |
| **Greenbone Community Feed** | The NVT signature feed — daily updates |

The scanner doesn't know anything inherently. Its intelligence is the **feed**. A scan run with a 3-month-old feed will miss every CVE published since. *Feed freshness is the silent killer of scanner accuracy — the report looks clean because the scanner never learned what to look for.*

### Scan types

- **Discovery scan** — Just host/port enumeration. Fast. No vulnerability checks. Used to inventory the environment before a full scan.
- **Full and fast** — Default. Uses only NVTs flagged as reliable and quick. Good 80% answer.
- **Full and very deep** — Runs more aggressive checks including ones with higher false-positive rates. Loud on the network.
- **Full and very deep ultimate** — Adds checks that can crash services. *Never run this in production unless you have a change window and the app owner's blessing in writing.*
- **System discovery** — OS fingerprinting only.
- **Host discovery** — Ping/ARP sweep only.

### Authenticated vs unauthenticated

| Mode | What it sees | What it misses |
|---|---|---|
| **Unauthenticated** | Network-exposed services, banner versions, exploitable network bugs | Local privilege escalation, missing patches not exposed via network, config issues |
| **Authenticated** (credentialed) | Installed package versions, registry settings, local CVEs, weak file permissions, kernel vulns | Nothing meaningful — depth wins |

OpenVAS supports **SSH credentials** (Linux/Unix), **SMB credentials** (Windows), **ESXi credentials**, and **SNMP**. Credentialed scans return 3–5x more findings on average. CompTIA expects you to know this difference cold.

> **CompTIA exam trap:** Unauthenticated scan finds 4 Highs. Authenticated scan of the same host finds 47. The right answer is *the authenticated scan is more accurate* — not *the unauthenticated scan had false negatives*. Both are technically true; CompTIA wants you to recognize credentialed scans give depth that network-view scans physically cannot.

### Report output — what you actually read

OpenVAS reports each finding with:

- **Severity**: a CVSS-derived score and a label (Log, Low, Medium, High, Critical). Default uses **CVSS v3** when available, falls back to v2.
- **QoD** (Quality of Detection) — 0–100%. How confident the scanner is the finding is real. **`remote_vul` = 99%**, **`registry` = 80%**, **`general_note` = 1%**. *This is the single most important number on the report and most analysts ignore it.*
- **NVT OID** — the unique ID of the test that fired (e.g., `1.3.6.1.4.1.25623.1.0.117086`)
- **CVE references** — sometimes one, sometimes ten, sometimes none (config issues often have no CVE)
- **Solution type** — `VendorFix`, `Mitigation`, `WillNotFix`, `NoneAvailable`, `Workaround`

### QoD ranges and what they mean

| QoD | What it means | Analyst action |
|---|---|---|
| 95–100% | Scanner exploited or directly observed the vuln | Treat as real; remediate |
| 70–94% | Strong inference (registry key, version banner) | Likely real; spot-check before mass remediation |
| 30–69% | Weak inference (vendor advisory, partial match) | Verify manually; high false-positive risk |
| 1–29% | Informational / heuristic | Suppress from prioritization unless context elevates it |

### How OpenVAS sits next to the other named scanners

| Tool | Niche |
|---|---|
| **OpenVAS** | Free, on-prem network vuln scanning; the open default |
| **Nessus** | Commercial, broader plugin coverage, faster releases for new CVEs |
| **Nikto** | Web-server-specific (misconfigs, default files); narrow but deep |
| **Nmap** | Discovery + port/service ID, with NSE scripts for some vuln detection |
| **Burp Suite / ZAP** | Web *application* layer (XSS, SQLi, auth flaws) — different layer entirely |
| **Scout Suite / Prowler / Pacu** | Cloud config posture (AWS/Azure/GCP) — different domain |
| **Metasploit** | Exploits findings; not a scanner, but reads OpenVAS XML to chain |

CompTIA loves to ask which tool you'd use. The answer is almost always **the most specific one** — Nikto for a web server, Prowler for AWS, OpenVAS for a /24 of mixed Linux and Windows.

> **CompTIA exam trap:** A question shows OpenVAS output with a finding marked QoD 30% and severity High. The "obvious" answer is *patch immediately*. The right answer is *validate the finding before remediation* — a 30% QoD on a High is exactly the false-positive shape the exam tests.

### Common false-positive shapes

- **Backported patches on RHEL/CentOS/Debian.** OpenVAS sees `OpenSSH 7.4` and screams about CVE-2018-15473. Red Hat already backported the fix; the version string didn't change. Authenticated scan with package-DB awareness fixes this.
- **Generic banner-grab findings** flagged on services that never speak that banner version.
- **Web server findings** on a reverse proxy where the actual app is elsewhere — the vuln may not be reachable.
- **TLS findings** on internal-only ports — real, but the [[CVSS]] **environmental score** drops sharply when exposure is internal.

### Scan scheduling and impact

OpenVAS scans **eat bandwidth and CPU on the target.** A "Full and very deep" against a small switch can take it offline. Best practices:

- Throttle concurrent NVTs per host (default 4, drop to 1 for fragile gear)
- Use the **Alive Test** setting to control how hosts are probed (ICMP, ARP, TCP-ACK)
- Schedule production scans in maintenance windows
- Exclude **ICS/OT** devices from active scanning — *passive monitoring only on the OT segment, full stop*

## SOC reality

- The L1 analyst doesn't run OpenVAS — the vuln-management team does, on a weekly or monthly cadence. The L1 reads the report when an alert from the SIEM correlates with an unpatched CVE on the affected host.
- The boss asks: *"How many criticals? How old are they? Why aren't they fixed?"* The honest answer is usually some mix of "the patch breaks the app," "the system owner is on PTO," and "change-board pushed it to next quarter." Document this — it's the [[Inhibitors to Remediation]] story you'll tell at the next audit.
- The 3am alert that looks like "OpenVAS scan from 10.x" is almost always your own scanner. Confirm the source IP matches the scanning host before paging anyone. *Authorized vulnerability scans look exactly like reconnaissance to the IDS — every shop with both has had this false-page at least once.*
- Never promise leadership "we have no critical vulns." Promise "we have no known criticals in the last scan, scan coverage is X%, and the scanner feed is current as of Y date." Coverage and feed-age are the honest qualifiers.
- The handoff: vuln-mgmt team owns scan execution and ticketing → system owners own remediation → SOC owns detection of active exploitation of unpatched findings. Three teams, one report.

> **CompTIA exam trap:** Scan output shows a critical finding on a host. The question asks for the *first* step. The right answer is rarely "patch immediately" — it's *validate the finding* or *check whether the host is in scope / exposure path*. CompTIA's IR/VM mindset is always **validate, then act**.

## Related concepts

[[Nessus]] · [[Nmap]] · [[Nikto]] · [[Burp Suite]] · [[Zed Attack Proxy (ZAP)]] · [[Metasploit]] · [[Scout Suite]] · [[Prowler]] · [[Pacu]] · [[CVE]] · [[CVSS]] · [[CPE]] · [[Vulnerability Management]] · [[Credentialed vs Uncredentialed Scans]] · [[False Positives]] · [[Quality of Detection]] · [[Inhibitors to Remediation]] · [[NIST SP 800-115]] · [[Asset Inventory]]

*Source: VIRGIL knowledge base — 2026-05-11*