# LFI — Local File Inclusion

## What it is

In **NBA 2K**, the MyPlayer build menu lets you load saved jumpshot animations by filename — "JumpShot_Curry_2023." You pick from a dropdown, the game pulls the file from `/animations/jumpshots/` and your player swings into it. Now imagine the dev never validated that dropdown. You type `../../../profiles/admin_save.dat` into the field and the game cheerfully loads someone else's MyCareer save, VC balance and all. The animation loader doesn't care what file you asked for — it only cares that you asked. That's LFI.

**Plain English:** the web app takes user input and uses it as part of a file path on the server. If the app doesn't sanitize the input, the attacker walks the directory tree and reads files the app was never supposed to expose — `/etc/passwd`, application config with database creds, SSH keys, session files. In some configurations, LFI escalates to remote code execution.

**Technical:** Local File Inclusion is an injection-class web vulnerability where an application includes a file on the server using a path constructed wholly or partly from user-controlled input. The "local" means the file resides on the same server as the application — distinguishing it from [[RFI]] (Remote File Inclusion), where the included file is fetched from an attacker-controlled URL. LFI commonly appears in PHP applications using `include()`, `require()`, `include_once()`, or `file_get_contents()` against unsanitized `$_GET` or `$_POST` parameters, but the class exists in any language: Python `open()`, Java `FileInputStream`, ASP.NET `Server.MapPath`, Node `fs.readFile`. Maps to **OWASP Top 10 A03:2021 — Injection** and overlaps **A01:2021 — Broken Access Control**.

## Why it matters

LFI is one of the highest-yield bugs an attacker can find. A single unvalidated parameter on an obscure page turns into:

- Source code disclosure (read the app's own PHP/config files — find the database password)
- Credential theft (`/etc/passwd`, then pivot to `/etc/shadow` if the web user has access, SSH `id_rsa` from misconfigured home dirs)
- Session hijacking (read PHP session files in `/tmp` or `/var/lib/php/sessions`, steal a logged-in admin's cookie)
- Log poisoning → RCE (inject PHP into the User-Agent header, then `include` the access log)
- Information for [[lateral movement]] — internal IPs, hostnames, deployment scripts

**Exam relevance — CS0-003 Objective 2.4:** CompTIA tests you on recommending controls. LFI is the canonical example for input validation, allowlisting, and the principle of least privilege on the web user account. Expect to see it bundled with [[directory traversal]], [[RFI]], and [[SSRF]] — these all share the "user input becomes a resource locator" failure mode but defend slightly differently. Know the difference cold.

## Key facts

### Mechanics — how LFI fires

The vulnerable pattern (PHP, because PHP is where LFI lives in the wild):

```php
<?php
  $page = $_GET['page'];
  include("/var/www/pages/" . $page . ".php");
?>
```

Normal request: `index.php?page=about` → includes `/var/www/pages/about.php`. Fine.

Attack request: `index.php?page=../../../../etc/passwd%00`

The `../` sequences walk up the directory tree (directory traversal). The `%00` (null byte) was the classic trick to terminate the string before the `.php` extension was appended — patched in PHP 5.3.4, but legacy systems still bleed. Modern attackers use other tricks: PHP filter wrappers, expect://, data://, php://input.

### Common LFI payloads

| Payload | What it does |
|---|---|
| `../../../../etc/passwd` | Classic Linux user enumeration |
| `....//....//etc/passwd` | Bypasses naive `../` stripping (filter removes one, leaves the other intact) |
| `..%2f..%2f..%2fetc%2fpasswd` | URL-encoded traversal — bypasses string-match filters |
| `..%252f..%252f` | Double URL-encoding — bypasses filters that decode once |
| `php://filter/convert.base64-encode/resource=config` | Reads PHP source as base64 (otherwise it would execute) |
| `php://input` + POST body | Executes PHP from the request body — direct RCE |
| `expect://id` | Executes shell commands if the `expect` extension is loaded |
| `/proc/self/environ` | Reads process environment; inject PHP via User-Agent then include this |
| `C:\Windows\System32\drivers\etc\hosts` | Windows equivalent |

### LFI to RCE — the escalation paths

LFI is dangerous on its own. It becomes catastrophic when chained:

1. **Log poisoning.** Attacker sends a request with PHP code in the User-Agent header. Apache writes it to `/var/log/apache2/access.log`. Attacker then uses LFI to `include` the log file. PHP parses the log, hits the injected code, executes it. Web shell delivered.
2. **Session file poisoning.** PHP stores session data in predictable locations. Attacker controls a session value (e.g., username field accepts `<?php system($_GET['c']); ?>`), then includes the session file via LFI.
3. **`/proc/self/environ`** on Linux — environment variables include `HTTP_USER_AGENT`. Inject, include, execute.
4. **PHP wrappers** — `php://input` lets the attacker put PHP directly in the POST body; the wrapper hands it to the include statement and PHP executes it. No log poisoning needed.
5. **Upload + include.** Attacker uploads an image with PHP embedded in EXIF metadata, then uses LFI to include the image. PHP doesn't care about file extensions — only what's between `<?php ?>` tags.

### LFI vs RFI vs directory traversal — get this right

| Vulnerability | What flows | Key distinguisher |
|---|---|---|
| **Directory traversal** | File *path* manipulation to **read** files outside the intended directory | Attacker reads — no execution |
| **LFI** | File path manipulation where the app **includes/executes** the file | Local file is *processed* (PHP `include`, template render, etc.) |
| **RFI** | App fetches a file from an **attacker-controlled URL** and includes it | Requires `allow_url_include=On` in PHP — rare on modern installs |
| **SSRF** | App makes an HTTP request to an attacker-controlled URL | Different sink — network request, not file include |

Directory traversal reads. LFI reads *and often executes*. RFI is LFI's bigger sibling — pulls the malicious file from across the internet.

### Defenses — what to recommend (this is the exam money)

**Primary — fix the design:**
- **Allowlist input.** Don't sanitize, allowlist. If `page` can only be one of `about|contact|faq`, validate against that exact list before touching the filesystem. Reject anything else with a 400.
- **Don't use user input as a filename, period.** Map a safe identifier to the filename server-side: `$pages = ['about' => 'about.php', 'contact' => 'contact.php']; include $pages[$_GET['page']];`
- **Canonicalize and verify.** Resolve the requested path with `realpath()` (PHP) / `Path.GetFullPath()` (.NET) / `os.path.realpath` (Python), then verify the resolved path starts with the intended base directory.

**Defense in depth:**
- **Disable dangerous PHP settings.** `allow_url_include=Off`, `allow_url_fopen=Off`, restrict `open_basedir` to the web root.
- **Least-privilege web user.** The `www-data` / `apache` / `IIS_IUSRS` account should not be able to read `/etc/shadow`, SSH keys, or arbitrary user homedirs. If LFI fires, it should hit a wall.
- **WAF rules.** Block `../`, encoded traversal sequences, PHP wrapper schemes (`php://`, `expect://`, `data://`). WAFs miss double-encoding and obscure wrappers — they're a speed bump, not a fix.
- **File integrity monitoring** on web roots and log directories — catches log poisoning attempts and uploaded web shells.
- **Disable unused PHP wrappers and extensions** (`expect`, etc.).
- **Patch.** Keep PHP, the framework, and all components current. Most CVEs in this space are old code paths that nobody removed.

### CompTIA exam traps

> **CompTIA exam trap: LFI vs RFI vs directory traversal vs SSRF.** All four involve user input becoming a resource locator. Directory traversal = reading files. LFI = including (executing) local files. RFI = including a remote file via URL. SSRF = making an HTTP request from the server to an attacker-chosen destination (often internal). If the question mentions `http://` or `https://` in the payload, it's RFI or SSRF. If the question mentions `../`, think traversal or LFI. If the file gets *executed* server-side, it's LFI/RFI.

> **CompTIA exam trap: best control for LFI.** The answer is almost always **input validation with an allowlist** — not "use a WAF," not "disable directory listing," not "encrypt the files." WAFs are detective/compensating; allowlisting is the preventive control at the source. CompTIA wants the root-cause fix.

> **CompTIA exam trap: LFI is "just" file reading.** No. LFI commonly chains to RCE via log poisoning, session poisoning, `/proc/self/environ`, or PHP wrappers. A scenario describing "attacker read `/etc/passwd` via parameter manipulation" might be classified as LFI even if RCE wasn't achieved — but the *risk* is RCE-class, not info-disclosure-class.

## SOC reality

- **The alert at 3am.** WAF or web access log throws "directory traversal pattern" or "suspicious URI" on a parameter — something like `?file=../../../../etc/passwd`. L1 opens the access log, checks if the request returned 200 (succeeded) or 403/500 (blocked). 200 with a 2KB response body is the gut-drop moment.
- **L1 first move.** Pull every request from that source IP in the last 24h. Look for the reconnaissance — they didn't guess the parameter, they enumerated it. Check for follow-up requests with PHP wrappers (`php://filter`, `php://input`), log file paths, or session file paths. Those signal escalation attempts.
- **What the IR lead asks.** "Did the response return file contents? Which files? Is the web user able to read sensitive paths? Are there indicators of log poisoning — any User-Agent strings containing `<?php`? Has a web shell been dropped — check `find /var/www -newer <timestamp> -name '*.php'`."
- **What never to promise.** "We blocked it at the WAF." WAFs miss encoded payloads, miss new wrapper techniques, miss requests under TLS that bypass the WAF tier. The only confirmation is reading the actual server-side log and the application's behavior.
- **Handoff.** L1 confirms the indicator → L2 pulls webserver logs and validates whether file contents leaked → IR/app-sec team works with developers to patch the parameter and audit every other file-handling parameter in the app → threat intel checks if the source IP shows up across other tenants or in known scanner ranges.
- **The retro.** Almost always: "the parameter was added two years ago by a contractor and never code-reviewed." LFI lives in forgotten endpoints. The fix is allowlisting, but the *real* fix is SAST in the CI pipeline so the next forgotten endpoint catches itself.

*A WAF that didn't block a request is not proof the request failed. A 200 OK is proof the request succeeded — read the response body before you tell the CISO it's contained.*

## Related concepts

[[RFI]] · [[Directory traversal]] · [[SSRF]] · [[Injection flaws]] · [[Cross-site scripting]] · [[Remote code execution]] · [[Web shell]] · [[Broken access control]] · [[Input validation]] · [[OWASP Top 10]] · [[Log poisoning]] · [[WAF]] · [[Least privilege]] · [[SAST]] · [[Security misconfiguration]]

*Source: VIRGIL knowledge base — 2026-05-11*