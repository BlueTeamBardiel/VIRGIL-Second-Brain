```markdown
---
domain: "offensive-security"
tags: [attack, web-security, owasp, lfi, vulnerability, appsec]
---
# directory traversal

**Directory traversal** — also called **path traversal** or the **dot-dot-slash attack** — is a web application vulnerability that allows an attacker to read (or in some cases write) files outside the directory the application intended to expose. By injecting sequences such as `../` into a filename parameter, the attacker escapes the **web root** or application sandbox and reaches arbitrary paths on the host filesystem. It is closely related to [[local file inclusion]] (LFI), is catalogued as **CWE-22**, and falls under the [[OWASP Top 10]] category A01:2021 – Broken Access Control.

---

## Overview

Directory traversal exists because many applications treat user-supplied strings as fragments of a filesystem path without validating that the resulting path remains inside an authorized base directory. Operating systems resolve path components lexically: each `..` pops one level off the current path, so a parameter like `?file=../../../../etc/passwd` walks from the application's working directory up to the filesystem root and back down into `/etc`. The operating system — not the application — performs the final path resolution, and by then the application's intent has already been subverted.

The bug class dates back to the earliest days of multi-user systems. A canonical early example is the 2000 **Unicode Directory Traversal** vulnerability in Microsoft IIS 4.0/5.0 (CVE-2000-0884), where overlong UTF-8 encodings of `..\` (e.g., `%c0%af`) bypassed the server's canonicalization check and allowed remote command execution via `cmd.exe`. The Nimda and Code Blue worms weaponized this flaw across hundreds of thousands of hosts within days. Two decades later, the same root cause reappeared in **Apache HTTPD 2.4.49/2.4.50** (CVE-2021-41773 and CVE-2021-42013), which mishandled URL-encoded dots and re-introduced remote file read and RCE on mod_cgi-enabled servers, with exploitation observed within 48 hours of public disclosure.

Directory traversal is primarily a **confidentiality** attack — attackers exfiltrate configuration files, credentials, private keys, and source code — but it is frequently a stepping stone to **integrity** and **availability** compromises. Once an attacker reads `/etc/shadow`, an application's `.env` file, AWS instance-metadata tokens, or SSH private keys, they can pivot to authentication bypass, lateral movement, or full system compromise. If the vulnerable parameter is used in a file inclusion or write context, traversal escalates into [[local file inclusion]] or arbitrary file write, both of which can lead to [[remote code execution]].

The vulnerability is not limited to HTTP. Any protocol or application that maps untrusted input to a filesystem path is susceptible: FTP servers, archive extractors (the **Zip Slip** family, e.g., CVE-2018-1002200), TFTP, SMB, document converters, CI/CD artifact handlers, and mobile content providers all carry versions of the same flaw. **Zip Slip** — traversal via crafted archive entry names like `../../etc/cron.d/pwn` — affected hundreds of popular libraries including Apache Commons Compress, SharpCompress, and Python's `tarfile`. The same logical defect, different transport.

Because the root cause is insufficient **input canonicalization and validation**, directory traversal sits at the intersection of [[input validation]], [[access control]], and [[secure coding]] concerns, and is a staple topic in [[OWASP]] guidance, the [[Security+]] SY0-701 exam, and offensive certifications such as OSCP and eWPT.

---

## How It Works

A vulnerable endpoint typically accepts a filename or path fragment from the user and concatenates it directly into a filesystem call. In PHP:

```php
<?php
// VULNERABLE — no validation, no canonicalization
$page = $_GET['page'];
include("/var/www/app/pages/" . $page);
?>
```

A benign request is `GET /index.php?page=about.html`, resolving to `/var/www/app/pages/about.html`. An attacker sends:

```
GET /index.php?page=../../../../etc/passwd HTTP/1.1
Host: target.local
```

The OS resolves `/var/www/app/pages/../../../../etc/passwd` → `/etc/passwd`, and the server returns its contents. The four `../` sequences each pop one directory level: `pages` → `app` → `www` → `var` → `/`, then descend into `etc/passwd`.

### Common Payload Variations

Naive input filters that block the literal string `../` are routinely bypassed using encoding, repetition, and OS quirks:

| Payload | Bypass Technique |
|---|---|
| `../../../etc/passwd` | No filter at all |
| `..\..\..\windows\win.ini` | Windows backslash separator |
| `%2e%2e%2f%2e%2e%2fetc/passwd` | URL encoding of `../` |
| `%252e%252e%252f` | Double URL encoding (proxy + app each decode once) |
| `..%c0%af..%c0%af` | Overlong UTF-8 (classic IIS vulnerability) |
| `....//....//etc/passwd` | Strips single `../` but leaves `..//` which OS still resolves |
| `..%2f..%2f..%2fetc/passwd%00.jpg` | Null-byte truncation to defeat extension checks (PHP < 5.3.4) |
| `/etc/passwd` | Absolute path — bypasses `join()` in Python, Java, Node |
| `php://filter/convert.base64-encode/resource=../config.php` | PHP stream wrapper — read+encode source of any file |

### High-Value Read Targets

**Linux/Unix:**
- `/etc/passwd` — user account list (confirm traversal works)
- `/etc/shadow` — hashed passwords (requires root read access)
- `/proc/self/environ` — process environment variables; may contain tokens, API keys
- `/proc/self/cmdline` — command line of the running process
- `/var/log/auth.log` — authentication log; useful for log poisoning leading to LFI→RCE
- `~/.ssh/id_rsa` — SSH private key of the web server user
- `/root/.aws/credentials` — AWS access keys if running on EC2 without IMDSv2

**Windows:**
- `C:\Windows\win.ini` — benign file used to confirm traversal
- `C:\inetpub\wwwroot\web.config` — ASP.NET config, often contains connection strings
- `C:\Windows\System32\drivers\etc\hosts`
- `C:\Windows\repair\SAM`, `C:\Windows\repair\SYSTEM` — offline credential extraction

### Manual Probing (Bash)

```bash
# Probe at increasing traversal depths
for i in 1 2 3 4 5 6 7 8; do
  payload=$(printf '../%.0s' $(seq 1 $i))
  result=$(curl -s "https://target.local/view?file=${payload}etc/passwd")
  echo "$result" | grep -q "root:x:" && echo "[+] Traversal confirmed at depth $i" && break
done
```

### Automated Scanning

```bash
# ffuf with SecLists LFI wordlist
ffuf -u "https://target.local/view?file=FUZZ" \
     -w /usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt \
     -mr "root:x:" \
     -o results.json

# Nuclei with generic LFI templates
nuclei -u https://target.local \
       -t http/vulnerabilities/generic/generic-lfi.yaml \
       -t http/vulnerabilities/generic/path-traversal.yaml

# Burp Suite: Intruder → Sniper, parameter = filename, payload list = "Fuzzing - path traversal"
```

### When Traversal Becomes RCE

If the sink is PHP `include()` rather than `file_get_contents()`, traversal becomes [[local file inclusion]] and can escalate to code execution via:
- **Log poisoning:** Inject PHP into `/var/log/apache2/access.log` via the User-Agent header, then include the log file.
- **PHP filter chain:** `php://filter/convert.base64-encode/resource=index.php` reads source; chaining multiple filters can achieve arbitrary code execution.
- **`/proc/self/environ` injection:** Write payload into environment, then include the proc file (requires the env to be readable).

---

## Key Concepts

- **Canonicalization:** The process of reducing a path to its simplest absolute form by resolving `..`, `.`, symlinks, and encoding sequences. Traversal attacks succeed when validation happens *before* canonicalization — the validated safe string `../etc` decodes to a dangerous path after the check.
- **Web root (DocumentRoot):** The top-level directory the HTTP server is authorized to serve. Traversal is by definition an escape from this boundary into the broader filesystem.
- **Null byte injection:** Legacy PHP (< 5.3.4) and some C-based programs truncate strings at `\x00`, allowing attackers to append `%00.jpg` to a traversal payload and defeat extension whitelists while the null truncates the extension before the file open call.
- **Double decoding:** When a reverse proxy URL-decodes once and the backend decodes again, `%252e%252e%252f` (where `%25` is the encoded `%`) survives the proxy's first decode as `%2e%2e%2f` and becomes `../` only at the backend — the root cause of the 2021 Apache CVE-2021-41773 regression.
- **Absolute path override:** Many path-join APIs — Python `os.path.join()`, Java `Paths.resolve()`, Node.js `path.join()` — discard the base path entirely when the user-supplied segment begins with `/`, making a payload of `/etc/passwd` sufficient without any `../` sequences.
- **Zip Slip:** An archive-based variant where entries inside a `.zip`, `.tar`, `.jar`, or similar archive contain `../` in their stored name. During extraction, the library writes files to paths outside the destination directory, enabling arbitrary file write or overwrite.
- **CWE-22 / CWE-23 / CWE-36:** CWE-22 is the generic *Improper Limitation of a Pathname* parent. CWE-23 covers *relative* path traversal (the `../` case). CWE-36 covers *absolute* path traversal (the direct `/etc/passwd` injection case). All appear in CVE taxonomies and are indexed by NIST NVD.
- **Chroot / Namespace jail:** A kernel-enforced filesystem view where the process's root is rebased to a subdirectory. A true chroot or container mount namespace neutralizes `../` escapes at the OS layer regardless of application-layer flaws, though escapes exist if the jail is misconfigured.

---

## Exam Relevance

On the **Security+ SY0-701** exam, directory traversal appears under **Domain 2.3 – Common Attack Vectors** and **Domain 2.4 – Application Attacks**. It is tested both as a standalone concept and in scenario-based questions requiring attack identification from log entries.

**Common question patterns:**

- A web server log shows `GET /app?file=../../../../etc/passwd HTTP/1.1` — you are asked to identify the attack type. The answer is **directory traversal / path traversal**. Do not confuse it with SQL injection, XSS, or CSRF.
- Distinguish traversal from **[[local file inclusion]]** (LFI adds execution/inclusion, traversal is read-only access) and from **[[remote file inclusion]]** (RFI pulls a file from an external URL).
- A question presents a filter that strips the string `../` once from input. Is it effective? **No** — an attacker uses `....//` or double-encoding. The exam expects you to know that blocklists alone are insufficient.
- Choosing the best mitigation from a list: the exam prefers **canonicalize-then-validate with an allow-list** over blocklists, WAF rules, or encoding.

**Gotchas to watch for:**

- CompTIA uses "directory traversal" and "path traversal" interchangeably — treat them as synonyms on the exam.
- Do **not** confuse traversal with **directory listing** (autoindex/Options +Indexes misconfiguration that exposes a file browser — a separate issue, no `../` required).
- Traversal is an **input validation** failure, not a patching failure — the correct answer category is usually *secure coding practices* or *input sanitization*, not *patch management*.
- If a question mentions `%2e%2e%2f` or `%252e%252e%252f`, recognize both as traversal payloads using encoding evasion — same attack, different representation.

---

## Security Implications

Directory traversal has driven some of the most impactful disclosures and breaches of the past decade, demonstrating that a simple path manipulation primitive can compromise enterprise infrastructure at scale.

**Notable CVEs and incidents:**

- **CVE-2000-0884 (IIS 4.0/5.0):** Overlong UTF-8 encoding of `../` bypassed path validation; exploited by Nimda and Code Blue worms to achieve RCE on hundreds of thousands of Windows servers.
- **CVE-2019-11510 (Pulse Connect Secure SSL VPN):** Pre-authentication arbitrary file read via `/dana-na/../dana/html5acc/guacamole/` leaked plaintext credentials and session tokens. Exploited in the wild by APT5, REvil, and threat actors behind the 2020 Travelex ransomware incident.
- **CVE-2021-41773 / CVE-2021-42013 (Apache HTTPD 2.4.49/2.4.50):** Path normalization regression allowed traversal beyond the document root. The 2.4.50 patch was bypassed within 24 hours (CVE-2021-42013). Active exploitation confirmed against 100,000+ exposed servers on Shodan. RCE possible with mod_cgi enabled.
- **CVE-2021-40438 (Apache mod_proxy SSRF / path confusion):** Chained with traversal-style logic to redirect requests to internal services.
- **CVE-2023-34362 (Progress MOVEit Transfer):** SQL injection chained with path traversal allowed unauthenticated file read and data exfiltration; Cl0p ransomware gang exploited it against 2,600+ organizations including the US Department of Energy, British Airways, the BBC, and Shell.
- **CVE-2024-4577 (PHP CGI on Windows):** Argument injection via Windows codepage-based path confusion; exploited by TellYouThePass ransomware within days of publication.
- **Zip Slip (2018, Snyk research):** Traversal via crafted archive names affected Apache Commons Compress, Ant, Spring Integration, Plexus Archiver, SharpCompress, Godep, and Python `tarfile` — hundreds of downstream projects.

**Detection signals:**

- WAF/IDS signatures for `../`, `..\`, `%2e%2e%2f`, `%c0%af` in URI parameters or POST bodies. Suricata ET Open rule **2013032** and Snort SID **1122** cover traversal patterns.
- ModSecurity CRS rules **930100** (path traversal attack) and **930110** (double-encoding bypass) provide layered coverage.
- Web server access logs: repeated `4xx` or `200` responses on filename-like parameters, unusually long URI paths, requests containing `passwd`, `shadow`, `win.ini`, `.env`, or `.aws`.
- Host-based: EDR alerts when the web server process UID reads files in `/etc`, `/root`, or `/proc/self/` outside its normal operational baseline.
- [[SIEM]] correlation rule: traversal attempt followed within seconds by an outbound connection from the web server host to a new external IP.

---

## Defensive Measures

1. **Prefer indirect object references.** Map user-supplied IDs (integers, UUIDs) to filenames server-side. Never accept a raw filename