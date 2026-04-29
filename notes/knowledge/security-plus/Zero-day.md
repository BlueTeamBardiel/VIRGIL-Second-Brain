---
domain: "threat intelligence"
tags: [zero-day, vulnerability, exploit, attack, malware, threat-intelligence]
---
# Zero-day

A **zero-day** (also written **0-day**) is a [[vulnerability]] in software, hardware, or firmware that is unknown to the vendor or maintainer — meaning **zero days** have elapsed since the developer became aware of the flaw. Because no patch exists at the time of discovery or exploitation, zero-days represent some of the most dangerous attack primitives available, enabling [[threat actors]] to operate without conventional [[patch management]] defenses stopping them.

---

## Overview

The term "zero-day" can refer to three related but distinct concepts: the **vulnerability** itself (a previously unknown flaw), the **exploit** (functional code that takes advantage of the flaw), and the **attack** (the active use of that exploit against a target). Security professionals use context to distinguish these, but exam questions — particularly on the [[CompTIA Security+ SY0-701]] — may use the terms interchangeably or test your ability to identify which stage is being described.

Zero-days exist because software complexity outpaces the ability of developers and [[static analysis]] tools to discover every flaw before release. Modern applications contain millions of lines of code, third-party libraries, and intricate interactions with the operating system kernel, networking stack, and hardware. Fuzzing, code review, and automated scanning can only surface a fraction of latent bugs. Adversaries — including nation-state actors, cybercriminal organizations, and independent researchers — actively hunt for these undiscovered flaws.

The economic ecosystem around zero-days is well-established and controversial. Legitimate markets exist through **bug bounty programs** (e.g., HackerOne, Bugcrowd), where researchers sell vulnerabilities to the affected vendor. Gray-market brokers like **Zerodium** publicly publish payout tables — offering up to $2.5 million USD for a full iOS zero-click [[remote code execution]] chain as of recent years. Black-market exchanges on dark web forums sell exploits to criminal operators. Government agencies — notably the NSA, GCHQ, and equivalents worldwide — maintain classified zero-day stockpiles for offensive [[cyber operations]].

Notable historical examples illustrate the real-world impact. **Stuxnet** (discovered 2010) used four simultaneous Windows zero-days to target Siemens PLCs at Iranian nuclear enrichment facilities — a landmark case of zero-days enabling [[industrial control system (ICS)]] sabotage. **EternalBlue** (MS17-010), allegedly developed by the NSA and leaked by the Shadow Brokers in 2017, exploited an SMBv1 flaw and was weaponized in the devastating [[WannaCry]] and [[NotPetya]] ransomware campaigns. **Log4Shell** (CVE-2021-44228) exploited a JNDI injection flaw in the ubiquitous Apache Log4j library, affecting millions of systems globally within hours of public disclosure.

The **vulnerability lifecycle** describes the path from introduction of a flaw to its eventual remediation. A zero-day sits in the window between introduction and vendor awareness. Once the vendor learns of the flaw (through their own research, responsible disclosure, or observation of in-the-wild exploitation), the clock starts on patch development — but the exploit may still be "zero-day effective" until patches are deployed at scale by administrators.

---

## How It Works

Understanding how a zero-day operates requires examining each phase of the lifecycle, from discovery through weaponization and delivery.

### Phase 1 – Discovery and Research

A researcher or attacker identifies an abnormal behavior in a target application. Common discovery methods include:

- **Fuzzing**: Automated tools like AFL++ or libFuzzer send malformed or random inputs to a target application, monitoring for crashes, hangs, or unexpected behavior indicative of memory corruption.
- **Manual code auditing**: Reviewing source code (or decompiled binaries via Ghidra, IDA Pro) for classic vulnerability patterns: unchecked `strcpy()`, integer overflows, use-after-free, format string bugs.
- **Differential analysis**: Comparing patched and unpatched binaries to reverse-engineer what a patch fixed — sometimes revealing the nature of a vulnerability before public disclosure.
- **Dynamic analysis**: Running applications in debuggers like WinDbg or GDB with sanitizers (AddressSanitizer, MemorySanitizer) enabled to catch runtime memory errors.

```bash
# AFL++ fuzzing a target binary
afl-fuzz -i input_corpus/ -o findings/ -- ./target_binary @@

# GDB with PEDA for crash analysis
gdb -q ./target_binary
(gdb) run < crash_input
(gdb) bt full       # full backtrace to identify faulting function
```

### Phase 2 – Exploit Development

Once a vulnerability is confirmed, the attacker develops reliable exploit code. For a classic **stack buffer overflow**:

1. Identify the exact offset to the return address using pattern generation (`msf-pattern_create`, `cyclic` from pwntools).
2. Determine exploitability: can the return address be controlled? Does [[DEP/NX]] or [[ASLR]] prevent straightforward shellcode execution?
3. Build [[ROP chains]] (Return-Oriented Programming) to bypass DEP on modern systems.
4. Test reliability across multiple OS versions and patch levels.

```python
# Simple pwntools skeleton for local exploit development
from pwn import *

binary = ELF('./vulnerable_app')
rop = ROP(binary)
rop.call(binary.plt['system'], [next(binary.search(b'/bin/sh\x00'))])

payload = b'A' * 72          # padding to RIP overwrite offset
payload += p64(rop.chain())  # ROP chain

p = process('./vulnerable_app')
p.sendline(payload)
p.interactive()
```

### Phase 3 – Weaponization and Delivery

The raw exploit is packaged into a **weaponized payload** — often combined with [[malware]] for persistence, [[C2 (Command and Control)]] callback, or lateral movement capabilities. Delivery vectors include:

- **Spear-phishing emails** with malicious Office documents exploiting parser vulnerabilities (e.g., CVE-2017-11882, Equation Editor flaw).
- **Drive-by downloads**: Malicious websites serving browser or plugin exploits (historically common with Flash, Java, PDF readers).
- **Supply chain compromise**: Embedding exploit code into trusted software update mechanisms.
- **Network-level exploitation**: Directly sending crafted packets to vulnerable services (e.g., EternalBlue targeting TCP port 445).

```
# EternalBlue conceptual flow (MS17-010)
Attacker → TCP:445 (SMBv1) → Negotiate Protocol Request
                            → Session Setup with malformed Transaction2 request
                            → Heap spray / buffer overflow in srv.sys
                            → Kernel-level RCE → DoublePulsar backdoor injected
                            → Meterpreter shell returned
```

### Phase 4 – Post-Exploitation

With code execution achieved, attackers typically establish persistence, escalate privileges, and move laterally — often using secondary tools that are not zero-days to avoid burning the initial exploit unnecessarily. The zero-day access is often reserved for high-value initial compromise only.

---

## Key Concepts

- **Zero-day vulnerability**: A software flaw **unknown to the vendor** at the time of discovery or exploitation; no CVE has been assigned and no patch is available.
- **Zero-day exploit**: **Functional attack code** that reliably leverages a zero-day vulnerability to achieve a defined outcome (RCE, privilege escalation, information disclosure, etc.).
- **Zero-day attack (in-the-wild / ITW)**: The **active use** of a zero-day exploit against real targets; once observed ITW, threat intelligence teams often race to reverse-engineer the payload and notify vendors.
- **Vulnerability Window**: The period between when a flaw is **introduced** into code and when it is **fully patched** across all affected deployments; for zero-days this includes both the undetected phase and the post-disclosure patch lag.
- **N-day vulnerability**: A vulnerability that has been **publicly disclosed** (assigned a CVE) but for which many systems remain unpatched; attackers frequently use n-days because they are easier to acquire than true zero-days while still being highly effective.
- **Bug Bounty / Responsible Disclosure**: A formal or informal process by which a researcher **reports a vulnerability privately** to the vendor before public disclosure, allowing time to develop and distribute a patch without enabling widespread exploitation.
- **Exploit broker**: A third-party organization (e.g., Zerodium, Crowdfense) that **purchases zero-day exploits** from researchers and resells them, typically to government agencies or law enforcement — raising significant ethical and legal debates.
- **Patch Tuesday / Emergency Patch**: Microsoft's scheduled monthly patch cycle (second Tuesday) and the out-of-band emergency equivalent used when an **actively exploited zero-day requires immediate remediation** outside the normal cycle.

---

## Exam Relevance

The CompTIA Security+ SY0-701 exam tests zero-day concepts primarily under **Domain 2.0 (Threats, Vulnerabilities, and Mitigations)** and **Domain 4.0 (Security Operations)**. Key exam patterns to recognize:

**Common question patterns:**

- Scenario: "A user received a phishing email with a PDF attachment. The AV did not flag it, and the system was compromised despite being fully patched. What type of attack occurred?" → **Zero-day exploit** (signatures couldn't detect it; fully patched means no known vulnerability was available).
- Distinguishing zero-day from **advanced persistent threat (APT)**: APTs *use* zero-days but are a broader category; a zero-day is a *tool*, an APT is a *threat actor category*.
- Zero-day vs. vulnerability vs. exploit: Know the definitions precisely — an exam may describe symptoms and ask you to classify the stage.

**Gotchas:**

- "Fully patched system was still compromised" is the classic zero-day indicator on exams — patching cannot stop what vendors don't yet know about.
- Do not confuse **zero-day** with **zero-trust** — these are entirely unrelated concepts that appear together in exam vocabularies.
- The term **threat intelligence** is heavily associated with zero-day detection and sharing (via [[ISAC]]s, [[MISP]], or [[STIX/TAXII]]) — expect questions linking the two.
- **Virtual patching** via [[WAF]] or [[IPS]] rules is a valid compensating control when vendor patches aren't yet available — a common correct answer in remediation scenario questions.

---

## Security Implications

Zero-days represent the apex of the **offensive capability pyramid** because they bypass the foundational assumption of reactive security: that known vulnerabilities will be patched. This creates systemic risk across entire industries when widely-deployed software carries a latent flaw.

**Key CVEs and incidents:**

| CVE | Year | Software | Impact |
|-----|------|----------|--------|
| CVE-2021-44228 (Log4Shell) | 2021 | Apache Log4j | JNDI injection → RCE; affected millions of Java apps |
| CVE-2017-0144 (EternalBlue) | 2017 | Windows SMBv1 | Wormable RCE; used in WannaCry/NotPetya |
| CVE-2014-6271 (Shellshock) | 2014 | GNU Bash | Environment variable injection → RCE in web servers |
| CVE-2021-26855 (ProxyLogon) | 2021 | Microsoft Exchange | Pre-auth SSRF → RCE; exploited by Hafnium APT |
| CVE-2023-23397 | 2023 | Microsoft Outlook | Zero-click NTLM credential theft |

**Attack surface considerations:**

- **Browser engines** (WebKit, V8/Blink, Gecko) are historically high-value zero-day targets due to ubiquity and sandboxed but reachable attack surface.
- **Kernel vulnerabilities** in Windows and Linux are particularly dangerous because exploitation grants **ring-0 privilege** — bypassing all application-layer controls.
- **OT/ICS systems** are increasingly targeted with zero-days because update cycles are extremely slow and patching may require production downtime.
- **Detection difficulty**: Traditional signature-based [[antivirus]] and [[IDS]] are largely blind to zero-day exploits. Detection relies on behavioral anomalies — unusual process spawning, memory injection patterns, unexpected network callbacks, or [[EDR]] telemetry showing abnormal API call sequences.

---

## Defensive Measures

Because no patch exists for a true zero-day, defense must rely on **reducing attack surface, behavioral detection, and compensating controls**:

**1. Attack Surface Reduction**
- Disable unused services and protocols (e.g., SMBv1 should be disabled on all modern Windows systems: `Set-SmbServerConfiguration -EnableSMB1Protocol $false`).
- Apply the [[principle of least privilege]] — limit which users and processes have elevated access; a zero-day in an unprivileged context is far less impactful.
- Remove or restrict high-risk software (Flash, legacy Java, unneeded browser plugins).

**2. Exploit Mitigations (OS-level)**
- Enable **ASLR** (Address Space Layout Randomization): randomizes memory addresses, making exploitation less reliable.
- Enable **DEP/NX** (Data Execution Prevention / No-Execute): prevents shellcode execution from data segments.
- Enable **Control Flow Guard (CFG)** on Windows and **CET (Control-flow Enforcement Technology)** on modern Intel CPUs.
- Use **sandboxed application containers** (e.g., Firejail, AppArmor, SELinux profiles) to contain exploit impact.

```bash
# Verify ASLR on Linux
cat /proc/sys/kernel/randomize_va_space
# 2 = full randomization (desired)

# Enable full ASLR persistently
echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
sysctl -p
```

**3. Behavioral Detection and EDR**
- Deploy [[EDR]] solutions (CrowdStrike Falcon, Microsoft Defender for Endpoint, SentinelOne) that monitor process behavior, memory anomalies, and lateral movement rather than relying on signatures.
- Implement **process creation logging** via Sysmon (Event ID 1) and forward to a [[SIEM]]:
```xml
<!-- Sysmon config snippet: log all process creations -->
<ProcessCreate onmatch="exclude">
  <!-- Exclusions here -->
</ProcessCreate>
```

**4. Network-Level Controls**
- **Virtual patching**: Deploy [[IPS]] or [[WAF]] rules to block known exploit patterns even before an official patch is released. Tools: Snort, Suricata, ModSecurity.
- **Network segmentation**: Prevent lateral movement post-exploitation using [[VLANs]], micro-segmentation, and [[zero-trust network access (ZTNA)]].
- **DNS filtering** and [[proxy]] inspection to detect C2 callback attempts following exploitation.

**5. Threat Intelligence Integration**
- Subscribe to [[ISAC]] feeds relevant to your sector.
- Ingest [[MISP]] or commercial threat intel feeds into your SIEM for IOC correlation.
- Monitor for anomalous behavior patterns described in [[MITRE ATT&CK]] framework mappings (Initial Access → Exploit Public-Facing Application: T1190).

**6. Incident Response Preparedness**
- Maintain tested [[incident response plan]] procedures specifically for zero-day scenarios.
- Establish a **communication plan** with vendors (designated PSIRT contacts) for rapid notification and patch acquisition.

---

## Lab / Hands-On

These exercises build practical intuition for zero-day mechanics in a **controlled, isolated lab environment only**.

### Exercise 1 – Exploit Development Fundamentals (Buffer Overflow on Vulnerable VM)
Use the intentionally vulnerable **Protostar** or **pwn.college** environments:

```bash
# Install pwntools
pip3 install pwntools

# Basic buffer overflow offset discovery
python3 -c "from pwn import *; print(cyclic(200))" | ./vulnerable_binary
# Record the value in RSP/EIP at crash, then:
python3 -c "from pwn import *; print(cyclic_find(0x61616178))"
```

### Exercise 2 – Fuzzing with AFL++
```bash
# Install AFL++ on Kali/Ubuntu
apt install afl++

# Compile target with AFL instrumentation
CC=afl-clang-fast ./configure && make

#