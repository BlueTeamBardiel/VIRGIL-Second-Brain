# File Analysis

## What it is

In **Forza Horizon**, when you tune a car, you don't trust the dealer paint job — you pop the hood, run the dyno, check the power curve, look at the gear ratios, weigh the chassis. A car that *looks* like a stock Civic but puts down 800hp on the dyno is not a stock Civic. The badge on the trunk lies. The numbers on the bench don't.

That's exactly what file analysis does — you treat every suspicious file as a car with a fake badge, and you run it across every bench you own until the real specs come out.

**Technical definition:** File analysis is the structured examination of a file's metadata, hash, structure, embedded strings, and runtime behavior to determine whether it is malicious, what it does, and how it relates to known threats. CySA+ scope is **static and basic dynamic** — hashes, strings, headers, signature checks, and sandbox detonation. It does not require reverse engineering at the disassembler level, but the exam expects you to know what artifacts each technique surfaces and which artifact answers which question.

## Why it matters

File analysis is the bridge between "the EDR flagged something" and "we know what we're dealing with." Without it, every alert is a coin flip — quarantine and pray, or ignore and pray. With it, you can say *this is Cobalt Strike beacon stage 2, here's the C2, here's the IoC set, push to SIEM, hunt enterprise-wide.*

**Exam relevance:** Objective **CS0-003 1.2** — analyzing indicators of potentially malicious activity. File analysis sits at the host-related and application-related intersection: unauthorized software, malicious processes, abnormal OS process behavior, registry changes, file system changes. CompTIA expects you to recognize what each tool *tells you* and what it *doesn't*.

**Career relevance:** Every L1 SOC analyst will, within their first month, drag a suspicious attachment into a sandbox or paste a hash into VirusTotal. Every L2 will do it ten times a day. The faster you can move from "weird file" to "known badness or unknown badness," the faster the IR clock starts ticking on the right target.

## Key facts

### The static analysis stack

Static analysis = examining the file **without executing it**. Safe, fast, scriptable. First pass on every suspicious sample.

| Technique | What it surfaces | Tool examples |
|---|---|---|
| **Hashing** | Unique fingerprint for reputation lookup | `sha256sum`, `Get-FileHash`, CertUtil |
| **Strings analysis** | Embedded URLs, IPs, registry keys, error messages, function names | `strings`, FLOSS, PEStudio |
| **File header / magic bytes** | True file type regardless of extension | `file`, HxD, PEStudio |
| **PE / ELF structure** | Imports, exports, sections, entropy, compile timestamp | PEStudio, PE-bear, `readelf` |
| **Signature check** | Authenticode validity, signer identity | `sigcheck`, `signtool` |
| **AV / YARA scan** | Pattern match against known families | ClamAV, YARA rules, VirusTotal |

### Hashing — the receipt

A hash is a fixed-length one-way fingerprint. Same input → same hash, every time, on every machine. Change one bit → entirely different hash (avalanche effect).

| Algorithm | Length | CySA+ status |
|---|---|---|
| **MD5** | 128-bit | Broken (collisions), still seen in legacy IoC feeds |
| **SHA-1** | 160-bit | Deprecated, still in some threat intel |
| **SHA-256** | 256-bit | **Current standard** — use this |

**What hashing answers:** Is this exact file known? Paste into VirusTotal, MISP, internal IoC store. Hit → known sample, pivot to family + TTPs. Miss → unknown, keep analyzing.

**What hashing does NOT answer:** Is this file *related to* a known sample? Attackers recompile, pack, or change one byte and the SHA-256 changes completely. That's why we have **fuzzy hashes** (ssdeep, TLSH, imphash) — they compare *similarity*, not identity.

> **CompTIA exam trap:** Hashes prove **integrity**, not authorship and not safety. A clean SHA-256 match against a known-good baseline means the file is unmodified — it does NOT mean the file is trustworthy. Signed != safe (signing certs get stolen). Unsigned != malicious (most internal scripts are unsigned).

### Strings — the cheat sheet inside the binary

Run `strings` on a binary and you get every printable ASCII or Unicode sequence ≥ a threshold. Malware authors hate this because their code leaks:

- **URLs and IPs** — C2 callback addresses, [[Beaconing]] destinations
- **Registry paths** — `HKLM\Software\Microsoft\Windows\CurrentVersion\Run` (persistence)
- **Filesystem paths** — `%APPDATA%\<random>\<name>.exe` (drop locations)
- **API names** — `VirtualAllocEx`, `WriteProcessMemory`, `CreateRemoteThread` (process injection)
- **Strings unique to the malware family** — mutex names, debug strings, attacker handles
- **Encoded blobs** — Base64, hex, XOR'd payloads waiting to be decoded

If strings comes back almost empty, the file is **packed or encrypted**. That's itself a strong IoC — legitimate software is rarely packed; commodity malware almost always is.

### Packing, obfuscation, and what they tell you

Packing compresses or encrypts the real payload and wraps it in a small unpacker stub. UPX, Themida, VMProtect, custom packers. On disk: high entropy, few readable strings, suspicious section names (`UPX0`, `.vmp0`). On execution: the stub unpacks the real malware into memory and jumps to it.

**Entropy** is the giveaway. Normal compiled code: ~5.5–6.5 bits/byte. Packed/encrypted: >7.0. PEStudio and PE-bear surface this automatically.

*A packed binary is not proof of malice, but it is proof you need to detonate it before you trust it.*

### Dynamic analysis — the dyno run

Static tells you what the file *might* do. Dynamic tells you what it *actually does.* Run it in an isolated sandbox (Cuckoo, Any.Run, Joe Sandbox, Hybrid Analysis) and watch:

- **Process tree** — what it spawns, what it injects into. Word spawning powershell.exe spawning rundll32.exe is a story you already know the ending of.
- **File system changes** — new files dropped, existing files modified, shadow copies deleted (ransomware tell)
- **Registry changes** — Run keys, service entries, AppInit_DLLs, Image File Execution Options
- **Network behavior** — DNS queries, [[C2 Traffic]], [[Beaconing]] intervals, exfil destinations
- **Scheduled tasks created** — persistence via `schtasks` or COM
- **New accounts created** — `net user /add`, persistence via local admin
- **API calls** — process injection, credential access, defense evasion

This is where the CompTIA 1.2 indicator list lights up in real time. Every one of those bullets — unauthorized scheduled tasks, registry changes, unexpected outbound, malicious processes, new accounts — is a row in your sandbox report.

### Mapping file analysis to CompTIA 1.2 indicators

| Indicator category | What file analysis reveals |
|---|---|
| **Unauthorized software** | Hash miss against approved baseline; unsigned PE in user-writable path |
| **Malicious processes** | Sandbox process tree; injection APIs in imports |
| **Abnormal OS process behavior** | Office spawning shells; lolbins (rundll32, regsvr32, mshta) with weird args |
| **Registry changes / anomalies** | Run keys, service installs, IFEO debugger hijacks |
| **File system changes** | Drops in %TEMP%, %APPDATA%, %PROGRAMDATA%; shadow copy deletion |
| **Unauthorized scheduled tasks** | `schtasks /create` in sandbox or strings |
| **Unexpected outbound / beaconing** | C2 URLs in strings; periodic callbacks in sandbox PCAP |
| **Introduction of new accounts** | `net user` strings; AD modification APIs |
| **Data exfiltration** | Outbound HTTPS POST to non-business destinations; archive creation before transfer |
| **Obfuscated links** | Base64/hex strings, URL shorteners in extracted IoCs |

### The workflow in practice

1. **Isolate.** Move the sample to an analysis VM or a sandbox tenancy. Never double-click on your workstation. Never.
2. **Hash and look up.** SHA-256 → VirusTotal, MISP, internal threat intel. Known? Pull family report and pivot. Unknown? Continue.
3. **Identify the real file type.** Magic bytes, not extension. `invoice.pdf.exe` is a PE. `setup.exe` with a ZIP header is a self-extracting archive.
4. **Pull strings.** Skim for URLs, IPs, registry keys, API names. Note anything family-distinctive.
5. **Check signing.** Authenticode valid? Signer reputable? Recently issued cert is a yellow flag.
6. **Detonate.** Sandbox with network simulation. Capture process tree, file/registry diffs, PCAP.
7. **Extract IoCs.** Hashes, IPs, domains, mutexes, file paths, registry keys. Push to SIEM and EDR for enterprise hunt.
8. **Document.** Sample ID, source, analyst, timestamp, verdict, IoC set. This is the chain that holds up in IR review and, if it goes that far, court.

### CompTIA exam traps

> **CompTIA exam trap:** "Which tool gives you the fastest reputation check on an unknown executable?" The answer they want is **hashing + threat intel lookup** (VirusTotal, MISP) — not antivirus, not sandbox, not strings. AV gives signature match; sandbox takes minutes; strings needs interpretation. Hash + reputation is seconds.

> **CompTIA exam trap:** Static vs dynamic. Static analysis = file **at rest**. Dynamic = file **executing**. CompTIA will describe an activity (e.g., "analyst extracts URLs from binary without running it") and ask which category. Extraction without execution = static. Sandbox detonation = dynamic.

> **CompTIA exam trap:** A file is unsigned. A file's signature has expired. A file is signed by a revoked cert. These are three different findings with three different verdicts. Unsigned = unknown trust. Expired = was once trusted, signer didn't renew. Revoked = signer or CA pulled trust — treat as hostile until proven otherwise.

## SOC reality

- The 3am alert is rarely "malware confirmed." It's *"EDR flagged a hash with low prevalence executing from %APPDATA%."* Your job is to get from that sentence to a verdict in under 30 minutes. Hash lookup is the first move, every time.
- **L1 action:** acknowledge the alert, capture the hash and full file path, check VirusTotal and internal IoC store, check if the file is signed, check parent process. If anything looks bad, escalate — do not detonate on your workstation, do not run `strings` on a production share without a copy.
- **The IR lead will ask:** "What's the hash? Is it known? How many hosts? What's the parent process? Is there network activity?" Have those five answers ready before you escalate. Show up with the dossier, not the question.
- **Never tell leadership "it's clean" because VirusTotal had zero hits.** Zero hits means *no AV vendor has signatured it yet* — which is exactly what a fresh, targeted payload looks like. Low prevalence + zero detections + executing from a user-writable path is a *worse* signal than 30/70 detections, not better.
- **Handoff:** L1 confirms suspicious → L2 runs full static + sandbox detonation → IR team extracts IoCs → threat intel pushes enterprise hunt → SOC engineering writes detections. The file analysis you did at hour zero feeds every downstream step.

## Related concepts

[[Hashing]] · [[Strings Analysis]] · [[Sandboxing]] · [[Malware Analysis]] · [[Static vs Dynamic Analysis]] · [[YARA Rules]] · [[Indicators of Compromise]] · [[Beaconing]] · [[C2 Traffic]] · [[Process Injection]] · [[Persistence Mechanisms]] · [[EDR]] · [[VirusTotal]] · [[MISP]] · [[Chain of Custody]] · [[Threat Intelligence]]

*Source: VIRGIL knowledge base — 2026-05-11*