# Directory Traversal

## What it is

In **Tetris**, every piece falls into a 10-wide playfield. The game engine has exactly one job at the boundary: don't let the tetromino exist outside the well. Push a J-piece against the left wall and the rotation system clamps it — the kick table refuses to let blocks land at column -1. The well has walls. The walls are non-negotiable.

Now imagine a Tetris clone where the dev forgot to clamp. You hold left and the piece slides to column -3, -7, -15 — into memory that isn't the playfield. You're writing blocks into the score variable, the high-score table, the next-piece buffer. That's exactly what directory traversal does. The web app has a "playfield" — the document root, usually `/var/www/html` — and a user-supplied filename is the tetromino. If the app doesn't clamp the path, the attacker slides left with `../../../../` and lands the piece in `/etc/passwd`, `/etc/shadow`, the app's own config file, or the AWS credentials sitting in the home directory.

**Technical definition.** Directory traversal (a.k.a. path traversal, dot-dot-slash, CWE-22) is a vulnerability where an application uses user-controlled input to construct a file path without sufficient validation or canonicalization, allowing the attacker to access files outside the intended directory. It's the canonical example of broken input validation in the file-handling context, and it shows up consistently in OWASP Top 10 territory under A01: Broken Access Control.

The fundamental flaw is the same one Tetris solved decades ago: **trust the boundary, validate the boundary, enforce the boundary.** Web apps that build file paths via string concatenation forget the boundary exists.

## Why it matters

Directory traversal is a CySA+ Domain 2.0 staple because it lights up vulnerability scanners constantly and the analyst has to triage it. **Nikto** flags it on legacy CGI endpoints. **Nessus** and **OpenVAS** plugin databases have hundreds of traversal signatures across CMS platforms, appliance UIs, and printer management consoles. **Burp Suite** and **ZAP** automate fuzzing the parameters. **Arachni** crawls and tests every file-handling input. **Metasploit** has working modules for traversal in everything from old Apache Tomcat to vendor-specific NAS firmware.

For exam relevance, CS0-003 Objective 2.2 expects you to read scanner output and know what a path traversal finding means, how to prioritize it, and what the false-positive rate looks like. For job relevance, a traversal that exposes `/etc/passwd` is medium; one that exposes `application.properties` with a database connection string is critical; one that chains into local file inclusion (LFI) → remote code execution is an immediate page-the-IR-lead event.

*The CVSS score doesn't tell you which one you have. The file the attacker can reach does.*

## Key facts

### The mechanics

The attack works by injecting path-traversal sequences into a parameter the app uses to build a file path.

| Payload | Effect |
|---|---|
| `../` | Walk up one directory (Unix/Linux) |
| `..\` | Walk up one directory (Windows) |
| `....//` | Bypass naive single-pass `..` filtering |
| `%2e%2e%2f` | URL-encoded `../` — defeats string-match filters |
| `%252e%252e%252f` | Double URL-encoded — defeats single-decode filters |
| `..%c0%af` | Overlong UTF-8 — historical IIS bypass |
| `/var/www/html/../../etc/passwd` | Absolute path mixed with traversal |

Typical vulnerable code (PHP, but the pattern is language-agnostic):

```php
$file = $_GET['page'];
include('/var/www/pages/' . $file);
```

Attacker request: `?page=../../../../etc/passwd` → server reads `/etc/passwd`.

### Where it lives in scanner output

Scanner findings you'll see in the SOC:

- **Nikto**: "OSVDB-XXXX: /cgi-bin/somefile.cgi?file=../../../../etc/passwd — Path traversal"
- **Nessus**: Plugin ID with title containing "Directory Traversal" or "Path Traversal" — CVSS usually 6.5–8.6 depending on what's reachable
- **OpenVAS**: Similar NVT format with CVE references
- **Burp Suite Scanner**: "File path traversal" with confirmed evidence (the response body containing `root:x:0:0:`)
- **ZAP**: "Path Traversal" alert, usually with the confirmed payload and response snippet
- **Arachni**: "Path Traversal" check with the parameter, payload, and reflected content
- **Nikto** is loud and noisy — high false-positive rate against modern frameworks but excellent at catching legacy appliance UIs

### What the attacker actually targets

The juicy files. Memorize these — CySA+ loves to ask "which file indicates successful traversal?"

**Linux/Unix:**
- `/etc/passwd` — user list (read by anyone; confirms traversal but rarely high-impact alone)
- `/etc/shadow` — password hashes (root-readable; if the app runs as root and you can read this, escalate immediately)
- `/etc/hosts`, `/etc/resolv.conf` — network info
- `/proc/self/environ` — process environment, sometimes contains secrets
- `~/.ssh/id_rsa` — private SSH keys
- `~/.aws/credentials` — AWS access keys
- `/var/log/auth.log`, `/var/log/apache2/access.log` — log files, sometimes chained with log poisoning → RCE
- Application config files: `web.xml`, `application.properties`, `wp-config.php`, `.env`

**Windows:**
- `C:\Windows\System32\drivers\etc\hosts`
- `C:\Windows\win.ini` — historically the canonical "did the traversal work" check
- `C:\inetpub\wwwroot\web.config`
- `C:\Users\<user>\.aws\credentials`

### Variants and chains

**LFI (Local File Inclusion)** — traversal where the app *executes* the file as code, not just reads it. PHP `include()` and `require()` are the classic vectors. Traversal + log poisoning + LFI = remote code execution.

**RFI (Remote File Inclusion)** — the app includes a URL the attacker controls. Rarer now; requires `allow_url_include` on in PHP.

**Zip Slip** — traversal via filenames inside an archive the app extracts (`../../etc/cron.d/evil` inside a tarball). Hit Spring Framework, multiple Apache projects, vendor backup tools. Scanners often miss it because it requires file upload + extraction logic.

**Path traversal in APIs** — file-download endpoints in REST APIs: `GET /api/v1/documents?file=invoice.pdf` → `?file=../../../../etc/passwd`. Modern apps, modern bug, same primitive.

### Defenses (what the remediation ticket should say)

The fix is canonicalization plus allowlisting:

1. **Resolve the path** — call the language's canonical-path function (`realpath()` in PHP/C, `Path.getCanonicalPath()` in Java, `os.path.realpath()` in Python).
2. **Verify the resolved path starts with the intended base directory.** If `realpath($base . $userInput)` doesn't begin with `$base`, reject.
3. **Allowlist filenames** when possible — map user input to a controlled set of identifiers (`?page=about` → lookup table → `/var/www/pages/about.html`), never raw filename.
4. **Reject traversal sequences** as defense-in-depth, but never as the only control — encoding bypasses defeat blacklists.
5. **Run the web app as a low-privilege user with a chroot/container boundary.** If traversal happens, the blast radius is the container, not the host.
6. **WAF rules** (ModSecurity, AWS WAF, Cloudflare) catch the obvious payloads — useful but bypassable, never the primary control.

### CompTIA exam traps

> **CompTIA exam trap:** Directory traversal vs LFI vs RFI. Traversal *reads* arbitrary files. LFI *executes* a local file as code (typically PHP). RFI executes a *remote* attacker-hosted file. CompTIA will give you a scenario where the response body contains `root:x:0:0:` — that's traversal, not LFI. If the scenario says "the included file ran arbitrary PHP" — that's LFI.

> **CompTIA exam trap:** Scanner finding prioritization. A directory traversal finding with CVSS 7.5 against an internet-facing app reading `/etc/passwd` is *not* automatically higher priority than a CVSS 6.5 traversal reading the app's own `application.properties` with database creds. The CVSS base score doesn't know what file is reachable. Read the scanner evidence, don't just sort by score.

> **CompTIA exam trap:** Nikto false positives. Nikto flags traversal on hundreds of historical CGI paths that may not even exist on the target. A Nikto traversal finding requires manual validation — replay the request, look at the actual response. Don't open a P1 ticket on a Nikto finding without confirming the response body contains the file contents.

### Tool quick-reference for the exam

| Tool | Role in traversal workflow |
|---|---|
| **Nmap** | Discover the web service exists (`-sV`, `--script http-enum`) |
| **Nikto** | Surface-level web vuln scanner — high noise, finds traversal on legacy paths |
| **Nessus / OpenVAS** | Authenticated/unauthenticated scanning, plugin-based traversal detection |
| **Burp Suite** | Manual + automated testing, proxy intercept, parameter fuzzing |
| **ZAP** | Open-source Burp equivalent, automated active scan includes traversal |
| **Arachni** | Web app DAST framework, modular checks including path traversal |
| **Metasploit** | Working exploit modules for known traversal CVEs |
| **GDB / Immunity** | Not for traversal — binary debuggers, used for native exploit dev |
| **Maltego / Recon-ng** | OSINT — find the target, not exploit it |
| **Scout Suite / Prowler / Pacu** | Cloud posture — Pacu can exploit IAM misconfigs that traversal-leaked AWS creds enable |

## SOC reality

- **The alert at 3am.** WAF fires on `%2e%2e%2f` in a URL parameter against the customer portal. L1 pulls the full request, looks at the response code. 200 with file contents in the body = real. 403 or 404 = WAF blocked or path doesn't resolve. Bad analysts close 403s without checking if the WAF rule was new — sometimes the WAF is the only thing standing between you and CVE-of-the-week.
- **L1's first move.** Pull all requests from that source IP for the last 24 hours. Traversal rarely comes alone — it's reconnaissance for the next step. Look for successful 200s on traversal-shaped URLs *before* the WAF rule fired.
- **What the IR lead asks.** "What file did they reach, and what's in it?" If the answer is `/etc/passwd`, scope is "they confirmed the bug." If the answer is `application.properties` with prod DB creds, the next call is to rotate those credentials and audit DB access logs going back to when the vuln was introduced.
- **What never to promise.** "The WAF caught it" — the WAF caught *the payloads it knew about*. Encoded variants, double-encoded variants, and creative filename tricks routinely bypass off-the-shelf WAF rules. The fix is in the application code.
- **The handoff.** Confirmed exploitable traversal on a production app → IR ticket → app team gets an emergency change window → temporary WAF rule as compensating control while the canonicalization fix is written, code-reviewed, and deployed. Never the WAF as the permanent answer.

## Related concepts

[[OWASP Top 10]] · [[Local File Inclusion]] · [[Input Validation]] · [[Web Application Scanners]] · [[Burp Suite]] · [[Nikto]] · [[CVSS]] · [[Vulnerability Prioritization]] · [[Broken Access Control]] · [[WAF]] · [[Defense in Depth]]

*Source: VIRGIL knowledge base — 2026-05-11*